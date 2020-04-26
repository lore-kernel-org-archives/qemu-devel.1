Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DD0C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B148020700
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a2aG0p3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B148020700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSkJZ-0008KK-TY
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 12:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk8J-0005NV-DJ
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk8I-0004rA-PM
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk8I-0004hK-60; Sun, 26 Apr 2020 12:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587918474; x=1619454474;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IZ3NBpRUcrbL/MfhZHsJcrqTF5z/rOuirR6/ZLZ3RRc=;
 b=a2aG0p3xYO8gZTHX5X0ln5VM6lL64pZzg7j/wptsQjEQOpG9MRNxfjQx
 0cbauQrnFXPD4Ee2htjs/MWS32vlY19nrwGMIRzrnO1u/6n4TBXxk3k57
 Xsj1xxLteY4VHpEWAUcluxtVzWrCvELocqfBns8EA0yAg/7wxQ0jAw1Yx
 AULqhMKJxLDZSCW9I/1EYRjur2kV4d5ITUfCd5Tw3jlZK/bPLP2MjZ4V5
 POXmkMgW90xOCpbreJVP11QGWx5xSx7yWMgnKtMJ7SvT1xwZG4woca0s5
 CP3zU5XIO+iehPDp2gbn14A7f85Q9PdeRtJyX2wflTWeWvwfWaxYOzNiP g==;
IronPort-SDR: ZjktY0n+/l1P9NL9EXtzuTG5XKLEmyRgt7iltFICru9oEsP2aRd9B+38x6dWTp+6HMj4i8KxVu
 eMhOhez1sVBjl4PcKcFzv1vUKN2q/AGaHEDQf58lg+/8jhxTBnwkz06OEh+GAOGhoQhQvcS20C
 im92SOA9s0PRxciEbXcrKsLuPemnv6sSo7Us6fl2LM4S+1lmy2wivK05XA8KhJKNQC6sTGQX0c
 0tAxbd7GjS0Y+61WvJbqaKBhEJXW1YkEcKTRh50B0sIMIcpJ/LDKeDxUQRmqmbhKlryxDNyhRx
 YLQ=
X-IronPort-AV: E=Sophos;i="5.73,320,1583164800"; d="scan'208";a="136193252"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 00:27:52 +0800
IronPort-SDR: iM6T4RrzbQ8EeHKA/7EJqReU8nBxy4X+opaK+9L3l7P0xeV5Rjv4lFdz/mmD1W3MQhLfbdDoYI
 QnHXI1qydz6WapJwL96Jfscn4tnMZvlCY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 09:18:03 -0700
IronPort-SDR: SGaupjqEcHQFAZQrUPVMz1ZZ5FYOMPzuP/wT/a7Fu2TLhseBGtGo5ByuKLqU0BlSshgFaTq1kT
 mz2cv/jBblMw==
WDCIronportException: Internal
Received: from wdthnc17-0189.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.50])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Apr 2020 09:27:52 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 11/15] target/riscv: Update the Hypervisor trap return/entry
Date: Sun, 26 Apr 2020 09:19:42 -0700
Message-Id: <31d19dbb4166af92c9daf266054e74b4618000c4.1587917657.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1587917657.git.alistair.francis@wdc.com>
References: <cover.1587917657.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=378a396a1=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 12:27:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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
---
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c |  8 +-------
 target/riscv/op_helper.c  |  8 ++------
 target/riscv/translate.c  | 10 ----------
 4 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 028e268faa..6b97c27711 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -430,6 +430,7 @@
 #define HSTATUS_VTSR         0x00400000
 #define HSTATUS_HU           0x00000200
 #define HSTATUS_GVA          0x00000040
+#define HSTATUS_SPVP         0x00000100
 
 #define HSTATUS32_WPRI       0xFF8FF87E
 #define HSTATUS64_WPRI       0xFFFFFFFFFF8FF87EULL
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f7ada23861..84a5b20f56 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -938,9 +938,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             } else if (riscv_cpu_virt_enabled(env)) {
                 /* Trap into HS mode, from virt */
                 riscv_cpu_swap_hypervisor_regs(env);
-                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
-                                         get_field(env->hstatus, HSTATUS_SPV));
-                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
+                env->hstatus = set_field(env->hstatus, HSTATUS_SPVP,
                                          get_field(env->mstatus, SSTATUS_SPP));
                 env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
                                          riscv_cpu_virt_enabled(env));
@@ -951,10 +949,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 riscv_cpu_set_force_hs_excep(env, 0);
             } else {
                 /* Trap into HS mode */
-                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
-                                         get_field(env->hstatus, HSTATUS_SPV));
-                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
-                                         get_field(env->mstatus, SSTATUS_SPP));
                 env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
                                          riscv_cpu_virt_enabled(env));
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index d7f26b22f3..c94aba78b3 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -98,12 +98,8 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
         prev_priv = get_field(mstatus, MSTATUS_SPP);
         prev_virt = get_field(hstatus, HSTATUS_SPV);
 
-        hstatus = set_field(hstatus, HSTATUS_SPV,
-                                 get_field(hstatus, HSTATUS_SP2V));
-        mstatus = set_field(mstatus, MSTATUS_SPP,
-                            get_field(hstatus, HSTATUS_SP2P));
-        hstatus = set_field(hstatus, HSTATUS_SP2V, 0);
-        hstatus = set_field(hstatus, HSTATUS_SP2P, 0);
+        hstatus = set_field(hstatus, HSTATUS_SPV, 0);
+        mstatus = set_field(mstatus, MSTATUS_SPP, 0);
         mstatus = set_field(mstatus, SSTATUS_SIE,
                             get_field(mstatus, SSTATUS_SPIE));
         mstatus = set_field(mstatus, SSTATUS_SPIE, 1);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ce71ca7a92..1d973b62e9 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -754,16 +754,6 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #if !defined(CONFIG_USER_ONLY)
     if (riscv_has_ext(env, RVH)) {
         ctx->virt_enabled = riscv_cpu_virt_enabled(env);
-        if (env->priv_ver == PRV_M &&
-            get_field(env->mstatus, MSTATUS_MPRV) &&
-            MSTATUS_MPV_ISSET(env)) {
-            ctx->virt_enabled = true;
-        } else if (env->priv == PRV_S &&
-                   !riscv_cpu_virt_enabled(env) &&
-                   get_field(env->hstatus, HSTATUS_SPRV) &&
-                   get_field(env->hstatus, HSTATUS_SPV)) {
-            ctx->virt_enabled = true;
-        }
     } else {
         ctx->virt_enabled = false;
     }
-- 
2.26.2


