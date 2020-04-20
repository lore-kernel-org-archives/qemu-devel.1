Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3DBC38A30
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B716E20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNvt03Ft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B716E20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQaen-0003iO-QJ
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 13:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36574 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQabQ-0006ml-G9
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:04 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQabL-00042o-Uu
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:04 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:35442)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jQabL-0003zR-Hw
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:52:59 -0400
Received: by mail-lj1-x243.google.com with SMTP id g4so2874643ljl.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 10:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LaPaoVtThQwYoQG+zx194rpdA5Jb5QupwjNlgtB5GgQ=;
 b=HNvt03FthLs3GrZSrOp6vBmEieBjGl8BccPXAU8N6kN/9n2YF0iIIPUaTQkcKekaCu
 9R4x6oTIIW6cGhFl5w/YkOFkb09J7wbuEGoz/PEUQAjF+IqgxXqvnqIsrB0ltCvE1BgZ
 qCsWzVIr7OpaK6iLbOOViUMQ9jjmjO+/FKwvO9v+FHZdu3040/jNEfdRddlMobhavjWI
 8t0ZImWnxGceRrFNzTsCe0otLdzqOnF6Dh4cyZD1vxCXWPyO+J9m8RWvKs4adKDJ6Wxi
 b1HjWQFrOML7bDUZcfZQ5AHDMxlxFBqmQHAP3HjfYZUM0TOjKfJAs8k3mBvtXk1rWsdF
 hWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LaPaoVtThQwYoQG+zx194rpdA5Jb5QupwjNlgtB5GgQ=;
 b=QZ2bRCDMx1JjwX0LuRN0YxrBni2vxJDtGfbQSitnnabYrm1O7PqnZZQyKYIQioFL78
 OQ99Lr85HIHAFqyZ+ubMJLqEtn59ovtGMTZ6rC6cemdNNGWSm3vyaftcyLu2Z7gro9r+
 u75jYF1XOi2tpHQ9hpDbc1ESmbR8mWt/INXJmLZ0pFr+D/vW+P4SMLQW4b3qN4dUik0i
 qaMfGwyu2CfDBR4kwLuaEQr5pC6T6lacw4h2Xyj9Y4ZB/A9218530C6hrsKjmqah7A7/
 VVEKnUsoDgQFPqVLX2vPDuQdBDtS2StbL9educUnzUbX6SzHZKSofe7HWi0OVWdq1mEb
 /UhA==
X-Gm-Message-State: AGi0Pubk+CS795bKXIPPhipINGbfDHImk1jJmugAG58uGqlniuDALLiK
 SDhT340OWrmdGKjcOK9SlJvDC2wqcNw=
X-Google-Smtp-Source: APiQypKH6HOyd8BVhoarhfmekiq5Ot8mqyiPho5QIgvDOTpecrXZVnsB0UmNI2CYHcQxuf3Rvox5Jg==
X-Received: by 2002:a2e:8046:: with SMTP id p6mr10243326ljg.21.1587405177265; 
 Mon, 20 Apr 2020 10:52:57 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id g3sm122709ljj.13.2020.04.20.10.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 10:52:56 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] target/microblaze: Add the unaligned-exceptions
 property
Date: Mon, 20 Apr 2020 19:52:48 +0200
Message-Id: <20200420175250.25777-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420175250.25777-1-edgar.iglesias@gmail.com>
References: <20200420175250.25777-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::243
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add the unaligned-exceptions property to control if the core
traps unaligned memory accesses.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c       | 4 ++++
 target/microblaze/cpu.h       | 1 +
 target/microblaze/translate.c | 4 ++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 53e80f4e5d..10d90c64dd 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -211,6 +211,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                                                  PVR2_DIV_ZERO_EXC_MASK : 0) |
                         (cpu->cfg.illegal_opcode_exception ?
                                                 PVR2_ILL_OPCODE_EXC_MASK : 0) |
+                        (cpu->cfg.unaligned_exceptions ?
+                                                PVR2_UNALIGNED_EXC_MASK : 0) |
                         (cpu->cfg.opcode_0_illegal ?
                                                  PVR2_OPCODE_0x0_ILL_MASK : 0);
 
@@ -284,6 +286,8 @@ static Property mb_properties[] = {
                      cfg.illegal_opcode_exception, false),
     DEFINE_PROP_BOOL("div-zero-exception", MicroBlazeCPU,
                      cfg.div_zero_exception, false),
+    DEFINE_PROP_BOOL("unaligned-exceptions", MicroBlazeCPU,
+                     cfg.unaligned_exceptions, false),
     DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
                      cfg.opcode_0_illegal, false),
     DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3c07f9b3f7..ef9081db40 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -306,6 +306,7 @@ struct MicroBlazeCPU {
         bool illegal_opcode_exception;
         bool opcode_0_illegal;
         bool div_zero_exception;
+        bool unaligned_exceptions;
         char *version;
         uint8_t pvr;
     } cfg;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b4a78551ef..20b7427811 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -995,7 +995,7 @@ static void dec_load(DisasContext *dc)
     v = tcg_temp_new_i32();
     tcg_gen_qemu_ld_i32(v, addr, mem_index, mop);
 
-    if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
+    if (dc->cpu->cfg.unaligned_exceptions && size > 1) {
         TCGv_i32 t0 = tcg_const_i32(0);
         TCGv_i32 treg = tcg_const_i32(dc->rd);
         TCGv_i32 tsize = tcg_const_i32(size - 1);
@@ -1110,7 +1110,7 @@ static void dec_store(DisasContext *dc)
     tcg_gen_qemu_st_i32(cpu_R[dc->rd], addr, mem_index, mop);
 
     /* Verify alignment if needed.  */
-    if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
+    if (dc->cpu->cfg.unaligned_exceptions && size > 1) {
         TCGv_i32 t1 = tcg_const_i32(1);
         TCGv_i32 treg = tcg_const_i32(dc->rd);
         TCGv_i32 tsize = tcg_const_i32(size - 1);
-- 
2.20.1


