Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB17C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 18:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD3482186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 18:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mrS2QswY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3482186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoXJO-0007je-VI
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 14:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33462)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=096e82a51=alistair.francis@wdc.com>)
 id 1hoXJE-0007Ix-M1
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 14:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=096e82a51=alistair.francis@wdc.com>)
 id 1hoXJD-0003wN-Ka
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 14:08:44 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:4819)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=096e82a51=alistair.francis@wdc.com>)
 id 1hoXJC-0003tZ-41; Fri, 19 Jul 2019 14:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1563559722; x=1595095722;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xtFywvRRIClsTpWeq36BflPxyuFui3oV/7Cz2HmrsIY=;
 b=mrS2QswYaur/7OQScc8rICdm5m/OKOOaHilII+iEPK1GQyBpo7cB85DK
 wR04ricLTVBHJ45H1ZcbJB2YCV0NT3Ur9XydJRdM8oug/oC4/lFNwLAGI
 u3yKdg+hGAslmnhLS+ADsa0N70xB/5Oqxz4URUHvavZ28jpDrVBv87kYj
 lQpDWGNW0ZM3lTyAd754Du0dVYVE4+WQIgaEc1PsFYlIZdyv++UJGyMFh
 Yr/638miQr5NBT6HRZaBRq/v3Ir8ivnwNhn4lAUyOPk16JzlHJDW/UZJj
 5s0Ll58ZauYXMlr0wxFgW9jw+1SMSiiNdLL7iFg/USHXSl9Sup6Ll322H A==;
IronPort-SDR: CI57Xl+IINeFQe0sDResv3kNS25/YPyt+nOZSfGm+6liG0Z/+j/d65ZAuqv7Dz01UB7AhqYF5q
 vcb8Jp7p7k53ZkYXjnImH46MkSaxZ7jv7g7prreD2pDnfc9oTwx0xKMbdaVZSyd6gyMYltlU9a
 6NVi6cMMchLZitiIKWwMkfgzFv6tan6Fbv1g9xJVmDJmPaHnjx+UqLiuSzVydS2h++gLYrUK08
 95ptZAEV4mJowhtFiVWwatpPhevZQRFgb4QzwRnpOK2F+MFmlafc+teOMbAJrcG2F7oaDjmhGe
 O5U=
X-IronPort-AV: E=Sophos;i="5.64,283,1559491200"; d="scan'208";a="118287673"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2019 02:08:36 +0800
IronPort-SDR: BuENbZHmGHhQgYfRieY+w9yrEuFDORsWbXxM24gza1FAQ73XSjncPUDbK5SMhTHkz6Q+R6iwf1
 IydXC95YgRIllckhNpr2Q+2fLYVxCdWNr44kRKpFlXB+l9GLTa0MthzLtfKeCp4V3M7r1iU4kf
 7asXs9wCDwQ6i+J+SItSXiSE5P7AG6gkPTewPBJJWTNGh4+OXpmP2qqlCGGxun5fCAM74CxJba
 N/voTc2didr+oodAoXNtLRUMQ63ob0oJnkZivI6qCythgjN8igqSEfPDge7HhN1B7J0sCOVr3X
 BJXMAGQ2p5WvxSAEkKMrEAfq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 19 Jul 2019 11:07:00 -0700
IronPort-SDR: 68oeJgRsn7cwYWvoVNtxk5NwDq/7pyc27yab1v8uqNo9phRzNDuaRDshiH6/OSK25NftH3aV8Z
 mN4MsJ1wueu9OhJB4Y40C8ASxffn0gHhSxtnXWsw245+pBN4+lwOqed6P29sOppqeB7S5zOgnm
 2qHqNHdqOvzdywldaxzl1GpKptJB7VoxIor//7a02qfM1rrgWWVruIH/A3VKmMHCIl1MG5O/jF
 ooZuBUsoIfyP7tMnh3aT/QLPJHmJ2F9yQOLByPdwldneGRev2JkY7t5atFimAd3HrFw5wTVfWk
 QyE=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 19 Jul 2019 11:08:36 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 19 Jul 2019 11:05:40 -0700
Message-Id: <edd3c94d357207e3862d1f5fec7e7346e70831f4.1563559494.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 1/1] riscv/boot: Fixup the RISC-V firmware
 warning
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a typo in the warning message displayed to users, don't print the
message when running inside qtest and don't mention a specific QEMU
version for the deprecation.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 5dee63011b..4b32ab1d26 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -26,6 +26,7 @@
 #include "hw/riscv/boot.h"
 #include "hw/boards.h"
 #include "elf.h"
+#include "sysemu/qtest.h"
 
 #if defined(TARGET_RISCV32)
 # define KERNEL_BOOT_ADDRESS 0x80400000
@@ -46,10 +47,13 @@ void riscv_find_and_load_firmware(MachineState *machine,
          * In the future this defaul will change to loading the prebuilt
          * OpenSBI firmware. Let's warn the user and then continue.
         */
-        warn_report("No -bios option specified. Not loading a firmware.");
-        warn_report("This default will change in QEMU 4.3. Please use the " \
-                    "-bios option to aviod breakages when this happens.");
-        warn_report("See QEMU's deprecation documentation for details");
+        if (!qtest_enabled()) {
+            warn_report("No -bios option specified. Not loading a firmware.");
+            warn_report("This default will change in a future QEMU release. " \
+                        "Please use the -bios option to avoid breakages when "\
+                        "this happens.");
+            warn_report("See QEMU's deprecation documentation for details");
+        }
         return;
     }
 
-- 
2.22.0


