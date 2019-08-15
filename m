Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3279C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7880206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L0MaxXHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7880206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyNb2-0003v0-Tb
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 17:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNS6-0002yY-Kp
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNS5-0006G9-D8
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:38:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNRz-0006Cd-37; Thu, 15 Aug 2019 17:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1565905108; x=1597441108;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QWsHDUppx5IItDm6bE2SCzfDZdT1jACkzVRJ5S9OHW4=;
 b=L0MaxXHQThxGEYlkMhoXLxxvJbKZ9aN7EsOKPPKJX7xvLF64unjzKZuZ
 iKkZ9dOl6yzChV4WUjUjHWnZG5CKwAezGlDG9co6+vb7Tk//DsjJHkqPt
 FtROxtTdltMWZcLNNWo7X0Tct5FlbTWvCAxrJhhm/WNZkvxqPdE7GyvlB
 iEosvJhPevPEds2RM9W0skINzBhWLEY4QjktKxOW0ThUuNPCHtxBL1G7D
 kQYj/2FWNfqpiekNFh8nNKJpDfnl923lDiFD8nNwJDUdWSX3gHUv1JNLu
 a3OeGGZwkq7Qr7JipulaJcXx0Oyo7MAaO58f73ZZbxadeSZTkfxwfzSKw w==;
IronPort-SDR: 6b202trFfzjs9jZURU5lwymA2ZvutzcjLCrKvqipKjr3W6ZIRj9WyVS9a/Rn8LH4bVawQhhSzN
 q/YjWKPA+0tf41RnZ+Hbe7q4yYfTYj0Oe9/b5+gPvo5HVcT+8J33RDDUaHG7PFZEAsWYkqFMbi
 tGPf2RYDqVRGL9BAbBDaNaPkuTiW0Ui3+uMuJ/F7Sl15NCN9JVLQu1SVNbegJYwb3FbjT7u2in
 9EnUFFDiFRckeukPtXrOywDNMcPc2bKOgNakRxvyBRuwcuC0qU7cupw/Ccm2UlhcS6mBDAqarw
 Wq8=
X-IronPort-AV: E=Sophos;i="5.64,389,1559491200"; d="scan'208";a="116881534"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2019 05:38:27 +0800
IronPort-SDR: yJR1Pa9MBr/wJFMlUOUIJuhGb0BvCvetNhgU+i9FpYMmBr+wsF0PC5P3Y73CYJMRQyI9koXg6A
 er/vxE+yAnfeG0JiT8ZaEHgb+5lBgwOU1x1Ua5zSQlBvjKrTcm3/C+I+1dR/Wm7aivJFXp6SPW
 N0c5jlreHM+0SFczFNbH+jZW2jl1RgsZTIEgyj8pimmLL0WSh20zITd7aStQ/2lmL0MC7npdui
 IPqi3nrYxP4llG+vgtdnW66p4LfhdrEb4zO4Q9PlB8LQDG9PCI7oN+/vkl4M+Z3rDwOklbekcB
 Flm0xAuCnO9QIHn14OeYVFfK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2019 14:35:57 -0700
IronPort-SDR: V2vvTOk6ru8JxSH+sR112EuuW5S8h9s/4YFK6581kaJxrPM67zspPCDzyVgfR6Auy02rEcBbgi
 ei6O7O3I8DvZHtJQHSuNlaUp6Q5GpjrTl2b//TYr6iPHksEffQ5Do3XzW4k1u1ec5p3pGhQJhs
 1MTZbXpqvb33XcVfUR+E7az+VFTFOYNUgNjF/e6Kb5ZJwOdpXNHzrfEFb+3u85nRJSVrtbNtDT
 fTn5sGvkLZ59BjgI5tUzgAkQny160yCpgHCSDPhCIhTcuP/EZnzLTM0ZjV9Df54fo+FiYVoK/A
 aZY=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 15 Aug 2019 14:38:26 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Thu, 15 Aug 2019 14:34:58 -0700
Message-Id: <4c3b0d0df95674ab0c049b75506f3ee3237ea14b.1565904855.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1565904855.git.alistair.francis@wdc.com>
References: <cover.1565904855.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v3 5/7] target/riscv: Use both register name
 and ABI name
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

From: Atish Patra <atish.patra@wdc.com>

Use both the generic register name and ABI name for the general purpose
registers and floating point registers.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f8d07bd20a..60b95daf60 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -33,17 +33,20 @@
 static const char riscv_exts[26] = "IEMAFDQCLBJTPVNSUHKORWXYZG";
 
 const char * const riscv_int_regnames[] = {
-  "zero", "ra", "sp",  "gp",  "tp", "t0", "t1", "t2",
-  "s0",   "s1", "a0",  "a1",  "a2", "a3", "a4", "a5",
-  "a6",   "a7", "s2",  "s3",  "s4", "s5", "s6", "s7",
-  "s8",   "s9", "s10", "s11", "t3", "t4", "t5", "t6"
+  "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
+  "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
+  "x14/a4",  "x15/a5", "x16/a6", "x17/a7", "x18/s2", "x19/s3",  "x20/s4",
+  "x21/s5",  "x22/s6", "x23/s7", "x24/s8", "x25/s9", "x26/s10", "x27/s11",
+  "x28/t3",  "x29/t4", "x30/t5", "x31/t6"
 };
 
 const char * const riscv_fpr_regnames[] = {
-  "ft0", "ft1", "ft2",  "ft3",  "ft4", "ft5", "ft6",  "ft7",
-  "fs0", "fs1", "fa0",  "fa1",  "fa2", "fa3", "fa4",  "fa5",
-  "fa6", "fa7", "fs2",  "fs3",  "fs4", "fs5", "fs6",  "fs7",
-  "fs8", "fs9", "fs10", "fs11", "ft8", "ft9", "ft10", "ft11"
+  "f0/ft0",   "f1/ft1",  "f2/ft2",   "f3/ft3",   "f4/ft4",  "f5/ft5",
+  "f6/ft6",   "f7/ft7",  "f8/fs0",   "f9/fs1",   "f10/fa0", "f11/fa1",
+  "f12/fa2",  "f13/fa3", "f14/fa4",  "f15/fa5",  "f16/fa6", "f17/fa7",
+  "f18/fs2",  "f19/fs3", "f20/fs4",  "f21/fs5",  "f22/fs6", "f23/fs7",
+  "f24/fs8",  "f25/fs9", "f26/fs10", "f27/fs11", "f28/ft8", "f29/ft9",
+  "f30/ft10", "f31/ft11"
 };
 
 const char * const riscv_excp_names[] = {
-- 
2.22.0


