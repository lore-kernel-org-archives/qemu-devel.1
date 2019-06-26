Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B38C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C100208E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C100208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgEAu-0001XR-F5
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 16:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35052)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgE8l-0007py-ON
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgE8j-00012z-QK
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:03:35 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39059)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hgE8h-00010g-Q1; Wed, 26 Jun 2019 16:03:32 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MUXlG-1i6afb2Boe-00QVok; Wed, 26 Jun 2019 22:02:59 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 22:02:52 +0200
Message-Id: <20190626200252.30220-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626200252.30220-1-laurent@vivier.eu>
References: <20190626200252.30220-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cQo9I9915l39aZW5pN7DwI9aoDDmMMA4BAwJgMd9BUnEdo9A8ei
 ciZplMaFL5CA6vtmh0i/yOijbrPPPgBnkUO93gx/XH/47IWYLyJQLsfqTLXY0D29VE6avvr
 +AOS3sYPye/At0RQQQle1AfuOxj8aBeRFPlViRJMj4jkYDrhdIRK03nj3YRES4fNlxLfp+w
 IQFtatYWUFqnjw6Nv+W0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q2iA9gR+3js=:tMArK/VrQ5+N2hkljgr5sl
 ACoSz2Y4Dy2oMx7MzjhiYadF9QpO39PbstIkys6uSDih1nxLCDws7XE8X9WNGEOdCwdm/cp+o
 k3fZtQjuk0GTXgjBj40HrRgb1HcTcNpd9JsSjaI8KjeH9euVma2+zC/DTY6m+ctKRFiNFIezT
 UOxBIEKz8Sru1wROvSnRx8Mu+OZkPn1da1wHulvrTBJHyqgDq3tDAnp2B9ATlot/j5VJvocg2
 6FDR4JiCrcavZAWoJPeCkBklgArIjjb9xl12PLT/P416osh78mhjvprpDm1T+Q6LHHYqecwwP
 HFwgQClWB3xBhCVRj+jwyGADMf1Jlr2EsWfaHjxHftO65OuUIY00bRXP097/D5500dll9EmGH
 ZqBAH68kSjmzy/+cpR+OkUlE8pWsmzsl+Vs+0rS3LUvIO+Np3803znF/9p0Tf8BlVp7vaV4ju
 4D2qlA55HV6PC3Ttjafmc6reoiTdIDsW8N5igmxNioScIg/y88qYBdkshZTqDdgZIVZoazhtp
 38LmoAu5QnHZZsz7uFFEmxY5wXQ6hYSCAt4YSa0Q6FZlJSpozyFysK3W2tdEi6BpWyAYZ+2EB
 5Wi3LG63oWgY7fp6QB4d5sBN7jNyo/mJ0wcDQqAhSwUiCbeoZ2iOID6XCKX2rkhbm7EBVjFEX
 XeHEXivyMHturRK3Du/9JlSgqnpKbHuYs22ZU6+ewF8W/QxFg0Be4smXU6MX8v8KaL+CpA8DI
 zIi6DF+9+NJFrmADzxI8q7JP126rxBHxS62eskZvylIIHeYpTQuctQpICRM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL 4/4] MAINTAINERS: Change maintership of Xen code
 under hw/9pfs
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Greg Kurz <groug@kaod.org>, Paul Durrant <paul.durrant@citrix.com>,
 Anthony PERARD <anthony.perard@citrix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Xen folks are the actual maintainers for this.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Acked-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Message-Id: <155912548463.2019004.3515830305299809902.stgit@bahia.lan>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cad58b948791..8206fc51dbbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -408,7 +408,7 @@ M: Paul Durrant <paul.durrant@citrix.com>
 L: xen-devel@lists.xenproject.org
 S: Supported
 F: */xen*
-F: hw/9pfs/xen-9p-backend.c
+F: hw/9pfs/xen-9p*
 F: hw/char/xen_console.c
 F: hw/display/xenfb.c
 F: hw/net/xen_nic.c
@@ -1498,6 +1498,7 @@ virtio-9p
 M: Greg Kurz <groug@kaod.org>
 S: Supported
 F: hw/9pfs/
+X: hw/9pfs/xen-9p*
 F: fsdev/
 F: tests/virtio-9p-test.c
 T: git https://github.com/gkurz/qemu.git 9p-next
-- 
2.21.0


