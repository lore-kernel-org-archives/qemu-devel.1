Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE993C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 17:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1DC2086A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 17:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lv7ERghf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1DC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG4Y0-0003wC-PH
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 13:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=172cfdf36=alistair.francis@wdc.com>)
 id 1iG4WY-0003FV-B6
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 13:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=172cfdf36=alistair.francis@wdc.com>)
 id 1iG4WW-0001JW-Rk
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 13:04:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54355)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=172cfdf36=alistair.francis@wdc.com>)
 id 1iG4WW-0001Hd-7I; Thu, 03 Oct 2019 13:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570122271; x=1601658271;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8TMbnmR/zLiQJyylzxvf42J8aj+45HyIeTyvX3zhMaY=;
 b=Lv7ERghfwm4oPYnM06B18EWq9MNF0BBjNFQclxtl5hH6L78b0HuRHAE2
 2SuU7JISzuj40lkwva6mLIttzWWN35bqYeUkF7HEUjo0vR4leHiI1l07F
 xu4oenTqsBNze1qjzE/BDoLbUGBbwD5D/qW/sooplKPkgQDVQiy7xRLzG
 HyIHWzmmhQ+pbAGbVfai+wEiW22kOqi+6iIxilzO9wde3V1nBDomU4Lnv
 J3Vj1JkXpIHKNVs7phMDElwU64kbxp/0RhcdCv7GmhA9H6y//DUwWJ4LU
 ukcC3DSjPOm1/r6PK8i2GuCLOqubf0S4tTodo8hiTvAVmWT1uMzu9LnCu A==;
IronPort-SDR: EeZKZbVKB7GFDzOHY3J5aHelu6J19JX+romRKj5TvT4kPHYwjQBCWo/FOyrylW6jToOoKClK0r
 8/gJj858rQRICuMJEj2NXVnRVEg1KI/W09dsxJmXJtlreYZDKekf05ikXZa2n3fIgBXmWFuyRs
 36KFzAWOVw8JBk/pyPSKdrkYtDYyPDFCpuB70WmwNJ+erQsRECDAIZM4adFqJnxOhN2R3MtUyC
 asWKaT2acrOH2IDiIjLJ9MmZX6RPqNbofIj1tk+a7oZN2yxGb2ch/pnrwgdl4Cc+i9WXEzBPBC
 Gb0=
X-IronPort-AV: E=Sophos;i="5.67,253,1566835200"; d="scan'208";a="220670339"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2019 01:04:05 +0800
IronPort-SDR: ZC598ZwiGSSOH+FCkT5bpzzlvj5ALyKJ7B2TBOlAY1HRwCLZZurIgYiEWcq7HwvSC/6ivxo7mU
 dxeulfZDVjBfWC3PwWseyuu6xeieFf7Qky25P9MLRZ9OyFEeHZT+o1/QQY0iHR6b8ZVOZgvdOV
 XPb6oXhE/Z1FHi+LaC9MXVVImOq82FDKeC5NDLDPGzo3Xf+cfC22Cpk5NFRY9OnjRBRFwHgBM9
 fURrS4jATTvXYcizFMEikdntKGrLtJ/DTxv82iAnPVLfTMJOfhwIjSKJdOHUJwo7fsmYMSUeF4
 NB8cV0Rha/wftq12Prmg4mdT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2019 10:00:02 -0700
IronPort-SDR: spj2QAvGgbCPMhCKbKp41+q0vxM9Ev6v7eIDS4sFcaE9CFmLETfVoBQ5FAlTDib5cYeFoklp6u
 E7mK9iNUbEfyNnwRPKHueckNu4i0nlH+kV2yejmrG9ztniuPb2+2C5gSs09lTNrB+KRu0/YnkF
 551pkB38bCYBdJ3zLUzG/8LdnPTQVxTe/r0Rr+KLU9ckQCOuDqRtPI60P99as5Y1aKo/Eu7NEh
 msGn8x2F2NEPkEHRgZODkTRW5PilZipLjMd05HxUcXoJ+DHzQDz5oTSMyCjSrNhH8/hmADPmk0
 dbM=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Oct 2019 10:03:58 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 1/1] riscv/boot: Fix possible memory leak
Date: Thu,  3 Oct 2019 09:59:29 -0700
Message-Id: <07ef5d368b4bbada15eaae0d23378a323969026b.1570121723.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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

Coverity (CID 1405786) thinks that there is a possible memory leak as
we don't guarantee that the memory allocated from riscv_find_firmware()
is freed. This is a false positive, but let's tidy up the code to fix
the warning.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2:
 - Fix commit typos

 hw/riscv/boot.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 2e92fb0680..7fee98d2f8 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -38,7 +38,7 @@ void riscv_find_and_load_firmware(MachineState *machine,
                                   const char *default_machine_firmware,
                                   hwaddr firmware_load_addr)
 {
-    char *firmware_filename;
+    char *firmware_filename = NULL;
 
     if (!machine->firmware) {
         /*
@@ -70,14 +70,11 @@ void riscv_find_and_load_firmware(MachineState *machine,
          * if no -bios option is set without breaking anything.
          */
         firmware_filename = riscv_find_firmware(default_machine_firmware);
-    } else {
-        firmware_filename = machine->firmware;
-        if (strcmp(firmware_filename, "none")) {
-            firmware_filename = riscv_find_firmware(firmware_filename);
-        }
+    } else if (strcmp(machine->firmware, "none")) {
+        firmware_filename = riscv_find_firmware(machine->firmware);
     }
 
-    if (strcmp(firmware_filename, "none")) {
+    if (firmware_filename) {
         /* If not "none" load the firmware */
         riscv_load_firmware(firmware_filename, firmware_load_addr);
         g_free(firmware_filename);
-- 
2.23.0


