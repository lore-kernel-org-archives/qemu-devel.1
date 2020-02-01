Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE19C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F202063A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MfztiVEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F202063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhLx-0000zS-Ti
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGv-0000ko-Iw
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGt-00069u-FJ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:29 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGt-00069K-5j; Fri, 31 Jan 2020 20:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519306; x=1612055306;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qHmpHK7fMKpNGGhV9Hhlvy1FKVh4htbFkoX5Q5QqcLg=;
 b=MfztiVEChcG0LHHSyeCsGOwxMCYYL3tefaSLFhnbgndLJzD2utAyvZ4S
 jccsZhnIGPiSSVM1zmQOPYvDxa89la/esSC7ZRWlRc7v9saOCRl03yrss
 NdQ4TEGTQKk7hRYcA5ZoFYy2cWvckb8SUT/n2AAnVDstg3fL+4HCjepQG
 t6VnYBJb2x/QxzrbnXErsflRYhzcz7RJKRN+xdScUjQKJmiJRc1kbfIt6
 O+dWCDFZk6IWGh2kY8zreieIYLKAq/LqpJ16iMbK1GKasG8zaSDgHU90E
 +rGPhtBX03zzhSggzCgpErjTMOAB6Y4SiZYAl2mhKxTbpbCUvRjeZ0s+3 w==;
IronPort-SDR: grma4uEqsKthSrLxvnTt/141IKHrFi4/cpW3cSBUKwniBVb3LB3Ysl4gr1HBv/9wL9gSbybssh
 IduILATd3MfupYZxQh7dlXUaQxdx8P6AHqB2LvlosPk1RpLR5qxOyG8Nv20TAFsrkwoO3rK9Xs
 XL9qnQFytJydmuc+HcCMoMlQIorrGWso8bXPtmRR0VcMERVj73mceKguR+1oz96SSM47H67Bbf
 OLJAbUU3G4VsQ6zsDZFKQ5kGhYqTN8c/br/FUYPOXb6DdtnGBcbQyvPZ8VVftYzyBOIunrOvG1
 72A=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872404"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:25 +0800
IronPort-SDR: ZEHBl/Bs84AP1MgveHDtj6+WxSltm5yofuGIp5cXTlTHyFNKhRzWtRR52DkeY5MdulIQKRtkjP
 LtoG2kNvSd+k4sRZPMINW7qDCPYkJuLafD4kBFXKms9YO2kUOj++gjA0GSJpRmfjDRrXatMX9z
 xfpQikTGb+Cm65scKSeAwDcG0+xnzu/6HUdbVay6KtvNWfEUCGr4pOFsjvio8XDr0I9bIpXJOo
 6WSBrxxL1k32lcdrgeFwp+QAZZvjy1Dzh8yvCYzD9SNwa+HKibSgE1Wo4clED7g6Qul2mWRmvf
 d8WmPj4UENVWL5cOuE/0Lkr8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:01:34 -0800
IronPort-SDR: aiuFksYtyuxjj1i78HV/cOnorUUGUOiNwS8f/1vXTppCkEUaII/CKgEL+SjtY8hNYA8jX18KhM
 mbhWTZRgG1q5XPziPunQZiVnbrFdlnGlvFvqiQHJpP2sZpM/8MeYDnDTNJjj093GFIDFXMKvcT
 z7GYo8KsvuGGQX9puOfuOBl5NL4U+54NGaSjrPm0RraoVDmwAhbOaiUX1U3KqRrslfa92Xo7Q1
 CgRSnRvGNN0J8Z2HWuJA+j5e9lihIORi1sePBhGh0K06obDLnICvs5Sja/SXyrp0Q+Z/5sFqq/
 EIY=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 31 Jan 2020 17:08:25 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 05/35] target/riscv: Rename the H irqs to VS irqs
Date: Fri, 31 Jan 2020 17:01:49 -0800
Message-Id: <7d2a69b0dab41c20e1e7aa186596040fb50423e5.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.c      |  6 +++---
 target/riscv/cpu_bits.h | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2f62f5ea19..f7a35c74c2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -80,14 +80,14 @@ const char * const riscv_excp_names[] = {
 const char * const riscv_intr_names[] = {
     "u_software",
     "s_software",
-    "h_software",
+    "vs_software",
     "m_software",
     "u_timer",
     "s_timer",
-    "h_timer",
+    "vs_timer",
     "m_timer",
     "u_external",
-    "s_external",
+    "vs_external",
     "h_external",
     "m_external",
     "reserved",
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 9ce73c36de..eeaa03c0f8 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -514,29 +514,29 @@
 /* Interrupt causes */
 #define IRQ_U_SOFT                         0
 #define IRQ_S_SOFT                         1
-#define IRQ_H_SOFT                         2  /* reserved */
+#define IRQ_VS_SOFT                        2
 #define IRQ_M_SOFT                         3
 #define IRQ_U_TIMER                        4
 #define IRQ_S_TIMER                        5
-#define IRQ_H_TIMER                        6  /* reserved */
+#define IRQ_VS_TIMER                       6
 #define IRQ_M_TIMER                        7
 #define IRQ_U_EXT                          8
 #define IRQ_S_EXT                          9
-#define IRQ_H_EXT                          10 /* reserved */
+#define IRQ_VS_EXT                         10
 #define IRQ_M_EXT                          11
 
 /* mip masks */
 #define MIP_USIP                           (1 << IRQ_U_SOFT)
 #define MIP_SSIP                           (1 << IRQ_S_SOFT)
-#define MIP_HSIP                           (1 << IRQ_H_SOFT)
+#define MIP_VSSIP                          (1 << IRQ_VS_SOFT)
 #define MIP_MSIP                           (1 << IRQ_M_SOFT)
 #define MIP_UTIP                           (1 << IRQ_U_TIMER)
 #define MIP_STIP                           (1 << IRQ_S_TIMER)
-#define MIP_HTIP                           (1 << IRQ_H_TIMER)
+#define MIP_VSTIP                          (1 << IRQ_VS_TIMER)
 #define MIP_MTIP                           (1 << IRQ_M_TIMER)
 #define MIP_UEIP                           (1 << IRQ_U_EXT)
 #define MIP_SEIP                           (1 << IRQ_S_EXT)
-#define MIP_HEIP                           (1 << IRQ_H_EXT)
+#define MIP_VSEIP                          (1 << IRQ_VS_EXT)
 #define MIP_MEIP                           (1 << IRQ_M_EXT)
 
 /* sip masks */
-- 
2.25.0


