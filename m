Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C38CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3B320659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ByuDQD6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3B320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgWDG-0004Ah-5S
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWAF-0007ge-7o
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWAE-00060l-6z
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591201370; x=1622737370;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PtGShkqlLQHF8j/jMpdV9t9d4QzcKFqH3498gOMEzz8=;
 b=ByuDQD6DNcjpYReyGTkAUOI5JhBjvougXE1/FVhaJsGRTx9QTTjRiruL
 yBeUmOvp04DUdbPSEzb3h4aCdQA0V//FBW+HBMaO9sZJXU282K1irroAa
 xk9osOL1P1z7DSufwTJBd3y9VPgKRMOKRp4bRI+5D9mskoPnrsO3TEEUZ
 pl4NxrU6iXhxIdjiHvBtlM+9mfZ52r4WDb09yFxaZXohktm/0PyxvexUB
 FQsEcB37UXBE4AyKC0YRjddDvn/rzn8UHesGNsUzB3d11jdooIP1YXYJx
 efcnrEttkiZQqj2dKH0e5c2dBQ4QkAmKMZSLJqWJM6//XD0t0sx+wxdkE g==;
IronPort-SDR: +9gNHU7UaCeYMzj85zkAoFUmRB+17t1bzYftsf+zwLzT69UTupvEkRnzVuDHZBCfIBDVxwW6p4
 nL949D9slprgFpqkKsIw729bbifJkOruD/o3h3Ka0QPs5qsga9oCVnH5URFPU5Jt0oimJHZxDT
 iOosa5QSx8H2JAstxPcQJgp2evY6eASdohbEtiF+D11I58UWHh65vDCE0syjbfZrYkNtRBxnqD
 ff6UH8oIUjvuTQQw2TeDrOqVbahAx0I17lSB8v9ocbj3pi5N0RScWw1QmfwVkBGBAr2stHurXc
 +HI=
X-IronPort-AV: E=Sophos;i="5.73,468,1583164800"; d="scan'208";a="143451357"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 00:22:41 +0800
IronPort-SDR: Eh7RjRQiWsl+00DO6zlYtS2AqUSFlV3EoA91LJTNDgv1t3kRdSEg454XFugnqjtVrKasLiARVK
 1boaCWO8Ajqzk24T6VjOap2vdjTXhVn84=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 09:11:46 -0700
IronPort-SDR: iGA2RTzoPzC3+W7xv2WwLItxPKAVJsvzFOvuW1NIJLW/1RDQt13oXebq2uSXMa3wQn84hnG6bI
 3ReKknJ2v4Vw==
WDCIronportException: Internal
Received: from cne220230.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.144])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jun 2020 09:22:40 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 02/15] riscv: Change the default behavior if no -bios option is
 specified
Date: Wed,  3 Jun 2020 09:13:45 -0700
Message-Id: <20200603161352.744204-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603161352.744204-1-alistair.francis@wdc.com>
References: <20200603161352.744204-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=416cc4bc0=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 12:22:40
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Per QEMU deprecated doc, QEMU 4.1 introduced support for the -bios
option in QEMU for RISC-V for the virt machine and sifive_u machine.
The default behavior has been that QEMU does not automatically load
any firmware if no -bios option is included.

Now 2 releases passed, it's time to change the default behavior to
load the default OpenSBI firmware automatically. The firmware is
included with the QEMU release and no user interaction is required.
All a user needs to do is specify the kernel they want to boot with
the -kernel option.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1588335545-649-1-git-send-email-bmeng.cn@gmail.com
Message-Id: <1588335545-649-1-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index da5817d438..adb421b91b 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -41,34 +41,11 @@ void riscv_find_and_load_firmware(MachineState *machine,
 {
     char *firmware_filename = NULL;
 
-    if (!machine->firmware) {
+    if ((!machine->firmware) || (!strcmp(machine->firmware, "default"))) {
         /*
-         * The user didn't specify -bios.
-         * At the moment we default to loading nothing when this hapens.
-         * In the future this defaul will change to loading the prebuilt
-         * OpenSBI firmware. Let's warn the user and then continue.
-        */
-        if (!qtest_enabled()) {
-            warn_report("No -bios option specified. Not loading a firmware.");
-            warn_report("This default will change in a future QEMU release. " \
-                        "Please use the -bios option to avoid breakages when "\
-                        "this happens.");
-            warn_report("See QEMU's deprecation documentation for details.");
-        }
-        return;
-    }
-
-    if (!strcmp(machine->firmware, "default")) {
-        /*
-         * The user has specified "-bios default". That means we are going to
-         * load the OpenSBI binary included in the QEMU source.
-         *
-         * We can't load the binary by default as it will break existing users
-         * as users are already loading their own firmware.
-         *
-         * Let's try to get everyone to specify the -bios option at all times,
-         * so then in the future we can make "-bios default" the default option
-         * if no -bios option is set without breaking anything.
+         * The user didn't specify -bios, or has specified "-bios default".
+         * That means we are going to load the OpenSBI binary included in
+         * the QEMU source.
          */
         firmware_filename = riscv_find_firmware(default_machine_firmware);
     } else if (strcmp(machine->firmware, "none")) {
-- 
2.26.2


