Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550EEC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A2520869
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A2520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47176 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHE5p-0000nB-BH
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 16:57:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0T-00056L-Fe
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0S-0005Bl-74
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0R-0005Aa-Vm
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EE7C306C3F0;
	Thu, 18 Apr 2019 20:51:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 033A35D9D6;
	Thu, 18 Apr 2019 20:51:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 408DE11329CD; Thu, 18 Apr 2019 22:51:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 22:51:07 +0200
Message-Id: <20190418205135.6686-9-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 18 Apr 2019 20:51:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 08/36] mips/boston: Report errors with
 error_report(), not error_printf()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Paul Burton <pburton@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418205107.nw0EzUUVechK3XEcxPCwmGSj0B2eSM50A0Baxdf0J8A@z>

Cc: Paul Burton <pburton@wavecomp.com>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190417190641.26814-5-armbru@redhat.com>
---
 hw/mips/boston.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index e5bab3cadc..a8b29f62f5 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -528,21 +528,21 @@ static void boston_mach_init(MachineState *machine)
         fw_size =3D load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * MiB);
         if (fw_size =3D=3D -1) {
-            error_printf("unable to load firmware image '%s'\n",
+            error_report("unable to load firmware image '%s'",
                           machine->firmware);
             exit(1);
         }
     } else if (machine->kernel_filename) {
         fit_err =3D load_fit(&boston_fit_loader, machine->kernel_filenam=
e, s);
         if (fit_err) {
-            error_printf("unable to load FIT image\n");
+            error_report("unable to load FIT image");
             exit(1);
         }
=20
         gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000,
                      s->kernel_entry, s->fdt_base, is_64b);
     } else if (!qtest_enabled()) {
-        error_printf("Please provide either a -kernel or -bios argument\=
n");
+        error_report("Please provide either a -kernel or -bios argument"=
);
         exit(1);
     }
 }
--=20
2.17.2


