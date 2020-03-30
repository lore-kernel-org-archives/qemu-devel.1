Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B83C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A9220578
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGoJDVIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A9220578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxMX-0007zZ-6w
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jIxLM-0006gj-Sc
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jIxLL-0002kh-Mf
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:32:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29541)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jIxLL-0002iU-DK
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585585974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n1jtwKUuVqMCGn/n5+LPfFcBxkYyIx3H+QhrvG9VjpA=;
 b=ZGoJDVImOqF5m24DJDvNgz/2oI20xAO8hbt7s9V3Y7oMT3hzeu1RWLQVR8K+U3wd9GfwnD
 9oyEy0n3uoR1JpPAtnsaeNnh3MYYjMOHvniBICT3LRsIgf5RBOUMQvfBrGTIb7lvIaR0iK
 zVGprNNV2TzhmSKd7b1q5srNzIRNAYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-ZtOG7iIGOhiG9TNI-8yhIw-1; Mon, 30 Mar 2020 12:32:52 -0400
X-MC-Unique: ZtOG7iIGOhiG9TNI-8yhIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D78BF107ACC4;
 Mon, 30 Mar 2020 16:32:51 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39D5DA7D8;
 Mon, 30 Mar 2020 16:32:50 +0000 (UTC)
Date: Mon, 30 Mar 2020 18:32:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v9 13/14] iotests: Mark verify functions as private
Message-ID: <20200330163248.GI6139@linux.fritz.box>
References: <20200324232103.4195-1-jsnow@redhat.com>
 <20200324232103.4195-14-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200324232103.4195-14-jsnow@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 philmd@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.03.2020 um 00:21 hat John Snow geschrieben:
> Mark the verify functions as "private" with a leading underscore, to
> discourage their use.
>=20
> (Also, make pending patches not yet using the new entry points fail in a
> very obvious way.)
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

While you touch all the function signatures, would you mind adding type
hints? Without them, the hints in execute_setup_common() stay mostly
unused because they can't be checked against callers nor callees.

Kevin


