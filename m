Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454B8C4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 21:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A002070B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 21:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hQo9Dqaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A002070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFmN0-0006oQ-1V
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 17:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=171f219e7=alistair.francis@wdc.com>)
 id 1iFmKQ-0005f1-HG
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 17:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=171f219e7=alistair.francis@wdc.com>)
 id 1iFmKP-00056S-7B
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 17:38:34 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:50539)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=171f219e7=alistair.francis@wdc.com>)
 id 1iFmKO-00055d-JJ; Wed, 02 Oct 2019 17:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570052312; x=1601588312;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7BQg4XA0/9t8lNZTEgdV48qFIwjR9TojjQ/RjfIVpZI=;
 b=hQo9DqafyV8rMMvyX5ZXBk/GD66M9BfoYGd3rS0raZuj9WJoqhTfKSrz
 8ZurLe3xHbkD2/9Up0VEzi0L8JlVWJVi9AOu89S9rR+VPJh9AHAvhVG0n
 BJu+RA9l4TufOWumEwjiRdSvwGS4w9t+8bro4Ma9w5deet8ITTtNWnJ+s
 mxiYwM+uL3Vmj4VP2z/9FRHpPSFlJihGmuP1s3FXRhwtcn1kEhk8m8d8Q
 GoD+Kqc3mb7h98wcJG3OG9hys/8JVz92k1gp0hMcnToQ0D6MxowofwWGb
 McyUWsK/zGDbY4tJXCjSACZ/akrEM0oeY1NaHh4q7X9SYCY3hWrn+ZBsD w==;
IronPort-SDR: RD0eGrKHg85AomY4rE/+PlwaRWwRR+vMq0rkQe1VwjdPUkGi5Z/npZythn4CS560gjlXlG+AKv
 DzIgDign1xG2hS2oA1UMXJcLeIbC/ig5rPrtwYLoNx3bfqIFr77OqdqZqE6p/8Qj8zjMBFVrfp
 jeTxsUblkLur15dF2wi9mTXbIot833K9dhF3sXQZr1yL/2OQtI8ysovnVYZZD5aZhvHCwTyO0v
 mAULX2FJlIRP79Z6wKpFYc0KBIrLlXlLOSYx9zzZ6qgA5kdhJNor9y0obnzaR1HpW9LOwWrzsL
 o/0=
X-IronPort-AV: E=Sophos;i="5.67,249,1566835200"; d="scan'208";a="119664002"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2019 05:38:27 +0800
IronPort-SDR: 2RL0gKh5MyvKJoLUhpDg6tGK6rxyAUsc5Kyds5fchByeEI7vF9SzGi5ZzmYK6sENul9t5DyO3J
 C2DouSWSS/2CNGZh6fsb8ttN/cbzUXYS7fZDm/bPTsi2HrsotHofSbvQBdsAfE8K4DEPdYe0jM
 yBPw0Zo7gQTKByAbUXAwoAc5KqAfQC2vRG14bOI5Y8BOz6dwc3VsCok5+YILSpIdZ6KGZ1XrlO
 N4Ovlve6ZT7ahN/s5ZiKW/EDksmRo3bX5Bv14b4v7i+I9dk1fTgHVPVTYCSO5CkpwENBvTRIXS
 FXLK85a01sCwosgVLk5QxQCT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2019 14:34:39 -0700
IronPort-SDR: RhAlG93KmH/FWxKqApTht6YjBwk7l63wr8edlj5r39FY3Y9BiS889qAVPf90o59AS+C+NcyaKe
 pK8QGfMeyI4E0pJpP0ZPsx8tBp3NgV32fJDxRckL6nh2vpCervL3rtrUgoxPl9gUEtqDlidb/M
 EMO1c57iFgbEO6i5fK7i3Put4TGYJBzHPeKqNwkYMF36OafM3uqSswyJnMd0wKE89M3glI24zh
 xITuILD9UxmCK6WWhcbMa9LmKy1WX1KQ4scMR5UVNNWNn2pxVBYkmEjqQAdEnelHELjkDSQPCP
 0fk=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 02 Oct 2019 14:38:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 1/1] riscv/boot: Fix possible memory leak
Date: Wed,  2 Oct 2019 14:34:00 -0700
Message-Id: <4cba4d80e570372183b6685a26c72fa3e907bb51.1570051975.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity (CID 1405786) thinks that there is a possible memory leak as
we don't guarentee that the memory allocatd from riscv_find_firmware()
is freed. This is a false positive, but let's tidy up the code to fix
the warning.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
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


