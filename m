Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47358C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 10:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171972086A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 10:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171972086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBcjS-00081E-8K
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 06:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBciY-0007PZ-9t
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 06:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBciX-0000o9-7V
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 06:34:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iBciT-0000md-R4; Sat, 21 Sep 2019 06:34:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C61A5307D91F;
 Sat, 21 Sep 2019 10:34:12 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-61.brq.redhat.com [10.40.204.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA978600C6;
 Sat, 21 Sep 2019 10:34:07 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Subject: [PATCH] hw/arm/boot: Use the IEC binary prefix definitions
Date: Sat, 21 Sep 2019 12:34:04 +0200
Message-Id: <20190921103405.19623-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Sat, 21 Sep 2019 10:34:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

IEC binary prefixes ease code review: the unit is explicit.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/boot.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index bf97ef3e33..59bb2fa0d3 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1095,7 +1095,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cp=
u,
      * we might still make a bad choice here.
      */
     info->initrd_start =3D info->loader_start +
-        MIN(info->ram_size / 2, 128 * 1024 * 1024);
+        MIN(info->ram_size / 2, 128 * MiB);
     if (image_high_addr) {
         info->initrd_start =3D MAX(info->initrd_start, image_high_addr);
     }
@@ -1155,13 +1155,13 @@ static void arm_setup_direct_kernel_boot(ARMCPU *=
cpu,
                  *
                  * Let's play safe and prealign it to 2MB to give us som=
e space.
                  */
-                align =3D 2 * 1024 * 1024;
+                align =3D 2 * MiB;
             } else {
                 /*
                  * Some 32bit kernels will trash anything in the 4K page=
 the
                  * initrd ends in, so make sure the DTB isn't caught up =
in that.
                  */
-                align =3D 4096;
+                align =3D 4 * KiB;
             }
=20
             /* Place the DTB after the initrd in memory with alignment. =
*/
@@ -1178,7 +1178,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cp=
u,
                 info->loader_start + KERNEL_ARGS_ADDR;
             fixupcontext[FIXUP_ARGPTR_HI] =3D
                 (info->loader_start + KERNEL_ARGS_ADDR) >> 32;
-            if (info->ram_size >=3D (1ULL << 32)) {
+            if (info->ram_size >=3D 4 * GiB) {
                 error_report("RAM size must be less than 4GB to boot"
                              " Linux kernel using ATAGS (try passing a d=
evice tree"
                              " using -dtb)");
--=20
2.20.1


