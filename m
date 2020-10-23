Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F121C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E519206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NesXrZOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E519206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzbF-00078I-FN
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFb-0002mI-5E; Fri, 23 Oct 2020 11:45:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFZ-0003iH-2N; Fri, 23 Oct 2020 11:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467905; x=1635003905;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Nll3ROIasLA0w7pHwZzYDjAzssHrWwVoYu35/PADsoY=;
 b=NesXrZOPlm79hA4wfczNbAIGVDrvFzsS2V/RqDxcarZj8Alppr+TKqnY
 9R610rJtF5wp1kgPAJ1ycWXwsLNL2NTvSRNBz+Yt3RHL/z9Qa1mkbjxcq
 nZu9VNifRNrg+lKyP8ieXvlrDdHK5WabfeSjHiNl3qia6nJiK5OlE7hq3
 xztxkrurQq9+GB8Pnfo7nwt8Kj/CMhiKdumYRSPQ+CGo8ihU7BOIoaVJC
 nKo0XWByA2Tlv06nCLbbh33RZ0MdXuqigrnQ0JxU86T8PD4alVeqWeyPl
 Y18c0r/DtnbcXNfl0WjbrAbhKwKpnB/5VW/sA0iPOM+mzHiPH6S2Bvxo9 Q==;
IronPort-SDR: y+FXa0bwOzae8LtcbTOOC2pE97OuHoS6WiliwLnO7o85DiHpYt59crMUjOW99zmJq952kQ/3nO
 KsZVhQTU29aX6wTqPfV37hq3RI3L6u8UG9G3DRGc0aY3/ieqA/onhE76hnrfXWiENqWsuZ6Lqb
 iW/j4dL4yKhUxqN5/5FTtUotuxyda8UcU60EWm9ik4kgfaO8d7aWQL+UBujOapAGYPJCn+4nFt
 l43zXVAIfOYFVXb+taRdkEQsCDYhNjCWEwWfOD0Q3NEw9z+jfBY6lK9scgaAWnr98eHxeNAmdp
 Ij0=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150653297"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:45:03 +0800
IronPort-SDR: QQ0Npu7BZGnC9y01cuTMxjk7zRX79XiObfmIqOFEJcaH53giGocrSzxjn5Ij+O+acBgTWoTYf5
 r4pPDQeAtzpioaqj3SsOaZajTjPpnhKp+VphnrXgLLg2S93tRpxcbBIR7T3nF9q2vymB8Jg0qp
 yA+l8+3+KzmSFADJAx50Ul8Ab6sJiCDw3PECW+bwdARnAt67xDzcBth/iA8Lf72ukdTm7tLG8O
 odrvB4FyRSIqvgSSSFLeUfZgWSimnuyR36ZCq1+UsUXbyoWwg5h+57tpLPNhMr8xpctZHFcttp
 A8MK7SW7C+3tzBr1PqKzvKxe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:30:19 -0700
IronPort-SDR: v+8TVM8ccG/4b8FjfGreq6QFHcyqPVuwR28Cz5wxCXUe+79+f48QF8/dgHHycNvjDU0XLoCaXh
 FS+qHQGW9c8wCfVQodRmnmnkYXjLJud43nt9Utu5pc9Ss3xNQjGuzdoUDKdx13NUwqNqlULKPW
 RKygJR0ftCXWzf9WtsKDPVeMwobXwz3GaznG0PoH9AnGAU1NUHR8Re7F3psYXtNVmFGpokn/j2
 AHv2fGCmWQxyN1fRmv+kW3OYK4/pO6jwGYH9DYXDoUA2zPZQGsbsXNAoaiDbP2b9G9s4umUotI
 BvQ=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:45:04 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 11/16] target/riscv: cpu: Remove compile time XLEN checks
Date: Fri, 23 Oct 2020 08:33:43 -0700
Message-Id: <594ed654cb36645d4c1b0aa3596f3e70d2ec5f7f.1603467169.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603467169.git.alistair.francis@wdc.com>
References: <cover.1603467169.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:27:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |  6 ++----
 target/riscv/cpu.c | 17 +++++++++--------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 86b063543d..6096243aed 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -151,13 +151,11 @@ struct CPURISCVState {
 
     target_ulong mhartid;
     target_ulong mstatus;
+    /* This is RV32 only */
+    target_ulong mstatush;
 
     target_ulong mip;
 
-#ifdef TARGET_RISCV32
-    target_ulong mstatush;
-#endif
-
     uint32_t miclaim;
 
     target_ulong mie;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8f8c568974..1b3efc1c81 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -239,9 +239,9 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #ifndef CONFIG_USER_ONLY
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
-#ifdef TARGET_RISCV32
-    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatush ", env->mstatush);
-#endif
+    if (riscv_cpu_is_32bit(env)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatush ", env->mstatush);
+    }
     if (riscv_has_ext(env, RVH)) {
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsstatus ", env->vsstatus);
@@ -353,11 +353,12 @@ static void riscv_cpu_reset(DeviceState *dev)
 
 static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 {
-#if defined(TARGET_RISCV32)
-    info->print_insn = print_insn_riscv32;
-#elif defined(TARGET_RISCV64)
-    info->print_insn = print_insn_riscv64;
-#endif
+    RISCVCPU *cpu = RISCV_CPU(s);
+    if (riscv_cpu_is_32bit(&cpu->env)) {
+        info->print_insn = print_insn_riscv32;
+    } else {
+        info->print_insn = print_insn_riscv64;
+    }
 }
 
 static void riscv_cpu_realize(DeviceState *dev, Error **errp)
-- 
2.28.0


