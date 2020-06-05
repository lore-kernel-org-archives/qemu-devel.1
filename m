Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220D6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0ABB2067B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CvZLMjrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0ABB2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1EI-0006f9-WC
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BM-00021G-3g; Thu, 04 Jun 2020 21:30:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BK-00006w-OE; Thu, 04 Jun 2020 21:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591320625; x=1622856625;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OiW+dN6bg3FYJIQSoK9bOQDaMsfREUhCimoZT/7SlwE=;
 b=CvZLMjrbj/DI3djOr3ELaZNv4IYnoou/4H6TnV42Sk0pACNV/cXNv7jc
 KuI7AW7VE88FV+Bfc8IDo7yAtbwggmRDgjpHgJluuU8dHBR56BRfuZMnb
 sfTjuJE59c2DRD6TNOTU9xp3haTYF10OAp0aZnKpKhOMNCF/a62PvleCI
 HEiNVKkObrPoAWFumcOZB4rjJjiGW1OlIpEVhaRPjqrVBmuBcYrDMxqt+
 UYRfXvitZNFyg1J//XRNYcFsF8JRLlSP3XLFeb6w6h7BwtIwvi6t3ZFl9
 P8Gu3ZOZM48r0tq9cVGETUv0lVXukOI0omRk2i7KsPqnWZNyfX+AkF13e Q==;
IronPort-SDR: FEiRbid7u96kpcS1G+z0S4/9RD1GX7h5jwmbxSAk47JlTUgylSBT1w7G3iRcGkpoGQDsqa8YGN
 Uw/9I7gbgQKYW/oyEpGoQ2QHPQROZJ44v2om/5c5eILB0IgV00crSpvuEM2/PsbLkIlBVriITa
 TU01Fw9anGrYZJ/gRXwOAXS8WTFzwQR6WCsMG+CJ5fN3tt3TWQx4eyTjFT3Tg0LqVE8iNr4whI
 /5GodZyNs+RTUff7HkjVMjiVLTdk5lTMJqlH04snsflx4JSxDsmRvRh9uaVOKBv3xWkgRaUftf
 Eys=
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800"; d="scan'208";a="242127046"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 09:30:21 +0800
IronPort-SDR: NFztixPKOs6KPoL+W5CXNCEBrowMnx33e+nojknBGSXLgST32feDkcJVXGoVJXUW7A3Gg+j2Ol
 AAHL/u0In/cpGdwxS1USpwxRSUNBk9Zxw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:19:36 -0700
IronPort-SDR: BQ98O/PFVyKR+9CAx42dRm54oark5HjehLHBMxaouKb7KHWyiTpmaJ8lVASibY3EMHwkqCqx8j
 D0K8cm42PK8g==
WDCIronportException: Internal
Received: from cnf006056.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.233])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Jun 2020 18:30:00 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 11/17] target/riscv: Update the Hypervisor trap return/entry
Date: Thu,  4 Jun 2020 18:21:12 -0700
Message-Id: <04e964562dcef49f0f54f28f8ea2cfa386fba8f3.1591319882.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591319882.git.alistair@alistair23.me>
References: <cover.1591319882.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4185f83b6=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:30:00
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
Cc: alistair.francis@wdc.com, anup.pate@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
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
index 4ea39d5641..c4085e5870 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -916,9 +916,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
@@ -929,10 +927,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
index e0053699cc..efc2d854eb 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -97,12 +97,8 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
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


