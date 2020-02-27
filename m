Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4564C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37AC24656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8ZPFAqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37AC24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7KT1-00035A-TT
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j7KPx-00080v-10
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j7KPw-0000QC-2I
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:45:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49210
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j7KPv-0000Py-Up
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582814735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=24JBNwzjLPr/tEesvtmeHtGHbd2jAf8McA3+hTGfBms=;
 b=U8ZPFAqi5Ja2I/WLLqezn8k4U1whdWfC0vL/jm8s16UuRdM3bTY5XciF8EpzY5K6fmIJOf
 BH5jh25ZG2PBQqCV00aqjLDtukTMK4E8bBv6XiSG5kAG4EWtZvrQflZMZ5GEYsPHPlCOQs
 GbF5xCcbGZwi03KjEaIh16TfQ/Mh9IE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-oNhQGIkMOb6dz-uBNDDOGA-1; Thu, 27 Feb 2020 09:45:33 -0500
X-MC-Unique: oNhQGIkMOb6dz-uBNDDOGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2EC4107ACCD;
 Thu, 27 Feb 2020 14:45:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E26119C58;
 Thu, 27 Feb 2020 14:45:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 157C611386A6; Thu, 27 Feb 2020 15:45:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] qapi: Bye-bye Python 2
Date: Thu, 27 Feb 2020 15:45:27 +0100
Message-Id: <20200227144531.24309-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mdroth@linux.vnet.ibm.com, jsnow@redhat.com, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster (4):
  qapi: Inheriting from object is pointless with Python 3, drop
  qapi: Drop conditionals for Python 2
  qapi: Use super() now we have Python 3
  qapi: Brush off some (py)lint

 scripts/qapi/commands.py       |  6 +--
 scripts/qapi/common.py         |  6 +--
 scripts/qapi/error.py          |  4 +-
 scripts/qapi/events.py         |  4 +-
 scripts/qapi/expr.py           |  3 +-
 scripts/qapi/gen.py            | 27 +++++++------
 scripts/qapi/introspect.py     |  6 +--
 scripts/qapi/parser.py         | 20 ++++------
 scripts/qapi/schema.py         | 71 +++++++++++++++++-----------------
 scripts/qapi/source.py         |  4 +-
 scripts/qapi/types.py          |  4 +-
 scripts/qapi/visit.py          |  4 +-
 tests/qapi-schema/test-qapi.py |  6 +--
 13 files changed, 73 insertions(+), 92 deletions(-)

--=20
2.21.1


