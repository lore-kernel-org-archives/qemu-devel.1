Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ADBC4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6BC2184D
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa4bdBNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6BC2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMS0M-000230-1A
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 04:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kMRvq-0006Ey-30
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:21:19 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:46672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kMRvo-0005gs-8l
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:21:17 -0400
Received: by mail-pf1-x42f.google.com with SMTP id b124so6632421pfg.13
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 01:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=dMsa5lRH5tIwaxTS7H3DfMBN70OAgPLHqOhJ4q1GNLE=;
 b=Sa4bdBNbuaw79UYEfAZQBiBwF8GTWj1Qf6cU+aw54qvEvslcq35BefhtLPfd16YgHq
 yDIGNeG3r0Sl9wHLBdVeeCnvnhgqe8acpQXpKKLMfubjWQSAjPL8xxPKWqc4lozZe7Am
 8Dlr/heQftudYA6E9Eaty1dYxmwjDT+U1bDkh8phVEp+yP4V7PqreqAVn5jhOwsOY1S1
 EZhSOGRaR08XIuDkhTygI/GOQqvIUN+zDc28wy92J0IsZhyvR/lkv1VFxPSEV1hrnKwY
 zxzeMzCEvFi8z+dGhoIJO9kvBvT2AVdxATXO8zHZ2CzmAhRi26yD8kLpNGkUmnIJuZmC
 d87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=dMsa5lRH5tIwaxTS7H3DfMBN70OAgPLHqOhJ4q1GNLE=;
 b=J3iEFR6IHxdKwGEiMNXTWnTaA+eskJIQJ/zE0S6FAW4T0dHRywBoVXVEpg5rwAfsHK
 0AV88mMSxbHYWcGrrU/LmBVJyDYEFSJXmx/tQnJ3XrALg+CrsjAHD8aQpthJR+EZPnYu
 3GBa1qCCcGh9SStVLv5a3HLvNgh/0+mKhJYEhOWyXzg/PYFmBzXzavxmtKkwHnVJqk8u
 NOTSfHq4LkW4jAKMgnK45l8YYzbsG6MDc3msqrs+6bQHFXcYRWKxfHMoacws3MzCVA0x
 5R8RCUkwhJXE8UM9rvVAwrOVkHSu9Dv8E6vWbUpM554KQ1/oDiX2vnsal2E3ThXBQvFq
 /Ncg==
X-Gm-Message-State: AOAM531PLmlpWGqiSZ4AMWVAybNT+5SMifJ81PcHCtV3rWNTa4aM5cME
 sf/O41+LaWI9lhAxi2zi0x/alON66TN+lQ==
X-Google-Smtp-Source: ABdhPJwf8X5OK9hSbT0+NnellYh/JsouwZsPQX/oUS+DazWbXkaW0zoDDuL5mzD79Hxm/NcHB4rCAw==
X-Received: by 2002:a62:19c4:0:b029:13e:d13d:a081 with SMTP id
 187-20020a6219c40000b029013ed13da081mr6450310pfz.24.1601194873059; 
 Sun, 27 Sep 2020 01:21:13 -0700 (PDT)
Received: from localhost.localdomain ([47.91.219.17])
 by smtp.gmail.com with ESMTPSA id r4sm3414322pjf.4.2020.09.27.01.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 01:21:12 -0700 (PDT)
From: Kele Huang <kele.hwang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/1] accel/tcg: Fix computing of is_write for MIPS
Date: Sun, 27 Sep 2020 16:20:33 +0800
Message-Id: <20200927082033.8716-1-kele.hwang@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=kele.hwang@gmail.com; helo=mail-pf1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kele Huang <kele.hwang@gmail.com>, Xu Zou <iwatchnima@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Detect all MIPS store instructions in cpu_signal_handler for all available
MIPS versions, and set is_write if encountering such store instructions.

This fixed the error while dealing with self-modified code for MIPS.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Kele Huang <kele.hwang@gmail.com>
Signed-off-by: Xu Zou <iwatchnima@gmail.com>
---
 accel/tcg/user-exec.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index bb039eb32d..9ecda6c0d0 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -702,6 +702,10 @@ int cpu_signal_handler(int host_signum, void *pinfo,
 
 #elif defined(__mips__)
 
+#if defined(__misp16) || defined(__mips_micromips)
+#error "Unsupported encoding"
+#endif
+
 int cpu_signal_handler(int host_signum, void *pinfo,
                        void *puc)
 {
@@ -709,9 +713,42 @@ int cpu_signal_handler(int host_signum, void *pinfo,
     ucontext_t *uc = puc;
     greg_t pc = uc->uc_mcontext.pc;
     int is_write;
+    uint32_t insn;
 
-    /* XXX: compute is_write */
+    /* Detect all store instructions at program counter. */
     is_write = 0;
+    insn = *(uint32_t *)pc;
+    switch((insn >> 26) & 077) {
+    case 050: /* SB */
+    case 051: /* SH */
+    case 052: /* SWL */
+    case 053: /* SW */
+    case 054: /* SDL */
+    case 055: /* SDR */
+    case 056: /* SWR */
+    case 070: /* SC */
+    case 071: /* SWC1 */
+    case 074: /* SCD */
+    case 075: /* SDC1 */
+    case 077: /* SD */
+#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
+    case 072: /* SWC2 */
+    case 076: /* SDC2 */
+#endif
+        is_write = 1;
+        break;
+    case 023: /* COP1X */
+        /* Required in all versions of MIPS64 since 
+           MIPS64r1 and subsequent versions of MIPS32r2. */
+        switch (insn & 077) {
+        case 010: /* SWXC1 */
+        case 011: /* SDXC1 */
+        case 015: /* SDXC1 */
+            is_write = 1;
+        }
+        break;
+    }
+
     return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 
-- 
2.17.1


