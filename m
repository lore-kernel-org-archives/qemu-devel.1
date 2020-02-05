Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2986C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB98A2072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RViwSSYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB98A2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izRVP-0001Cz-07
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 15:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1izRUF-0008AX-CW
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1izRUE-00054w-48
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:41:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32678
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1izRUE-00053E-0l
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580935284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6/WDfE1o/i7lrSQ4UcHEsx/XDtZKIsCkP6QXz1byKcs=;
 b=RViwSSYHli82E+THhvS/8zCaW0YhUl/ooi/Py4TAY0pIkxkuwmCpqfQk2jb5BsgoDgNgH5
 EoexyOPC8ISLajVI+alC1OjfkSZQfz+iFiIUON623OfPmaTOIpRrfGSL9j1slRgkPVUdaB
 q/aKkf+cN5mlwVgEFTieXB1xePFI4DY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-XnTfPSZ-Mem6SUh05jbYmQ-1; Wed, 05 Feb 2020 15:41:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 267918010EF;
 Wed,  5 Feb 2020 20:41:19 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-229.ams2.redhat.com
 [10.36.116.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 032C610013A1;
 Wed,  5 Feb 2020 20:41:16 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] ppc/pnv: fix build dependencies
Date: Wed,  5 Feb 2020 21:41:13 +0100
Message-Id: <20200205204115.555212-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: XnTfPSZ-Mem6SUh05jbYmQ-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Building only POWERNV machine without PSERIES machine
fails because of a couple of reasons:

- qtest uses rtas function only provided by PSERIES,
- the dependency to PCI Express has been added to XIVE_SPAPR
  rather than to POWERNV

Laurent Vivier (2):
  qtest: Fix rtas dependencies
  ppc/pnv: Fix PCI_EXPRESS dependency

 hw/ppc/Kconfig | 6 ++++--
 qtest.c        | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

--=20
2.24.1


