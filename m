Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B885C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F9A20767
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVuSM8iO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F9A20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofWH-0004OK-4v
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6Y-0001HI-TP
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:42 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6V-00025s-Am
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:42 -0400
Received: by mail-pf1-x441.google.com with SMTP id b5so4050309pfp.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3GLkukFRFNUJ3dp50WZNEvNqQ9MQfmMd/OfAXS3PDtA=;
 b=aVuSM8iO0IGqBUEqC0YyOgFaWYN7UVoP3bP1m/AQnjqTHU2F5W5L4bjFh48y092Hzw
 wS69sa2IO2aaChJIj9BY/AhCVQ+RWH4aFhZuad7JXosb7gd6gL+10DIHvji2DDnTDeS9
 MNS6HP1bb4IjWazg3E8xRmKAbSt63/oKprsec4THUk0mciMfcK08zJCYZPpukhMriKlc
 2ZWplBalntDlR55TcoOfLZrBoQ8IGvBUNQifxGNv+in4vly9uSEiu5gKEsgb3wf4SfCe
 mfuSD9iEa/Ydh6sIojlLutzK0JossfgcANSjTU+GrK0VYcQ9q8ys9ZaoqiXNp4aSAWrF
 83Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3GLkukFRFNUJ3dp50WZNEvNqQ9MQfmMd/OfAXS3PDtA=;
 b=ixlnv13wkJnsvn7K1+0SA5xAGa6XoLjYVoWqb4uNJ86lDn05DDRdNv93bJlijpJ4bk
 GzSJc+k+HLJh1ciufoE9cs6BdOOs7ei+Slvcq3ZCu2dXFC7cPv5Y+6+kS9IkoFY0FWDZ
 gUdjfLRe6Ao+VU/gcK7aEa3FjOfV+BGxF1d7rYqO/Du6obUMOSxpbXV7LYDnYcNavhIe
 VbB5kOutmzRssyuh4bNGtBlWmRLagPpFTrJOpdpmBQrnBIBrgiIe/+VjFsWNUNKb5ddT
 k6HqwXisImJOhZLsmMpmSegxM2S7edKLXB/AfkdsgWnWBO0gAHpz6uReFkI7x7t+2m9W
 W7Rw==
X-Gm-Message-State: AOAM530KWIBxGCPyrqcwkFoPvThQGiU2YokUU5Jn06xgv0ene8ScL6Ri
 ekaIbJQM6dRnTDKjMwDigaxHf/ZK5/A=
X-Google-Smtp-Source: ABdhPJxEeYzw+GoK1wfuJhH5ypl1eBCJl4y9OIw2qRiVB5QxNt8RIvx79FRdB4hE/cXeNkGngv062Q==
X-Received: by 2002:a63:c58:: with SMTP id 24mr888373pgm.343.1593142357597;
 Thu, 25 Jun 2020 20:32:37 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 38/46] target/arm: Complete TBI clearing for user-only for
 SVE
Date: Thu, 25 Jun 2020 20:31:36 -0700
Message-Id: <20200626033144.790098-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are a number of paths by which the TBI is still intact
for user-only in the SVE helpers.

Because we currently always set TBI for user-only, we do not
need to pass down the actual TBI setting from above, and we
can remove the top byte in the inner-most primitives, so that
none are forgotten.  Moreover, this keeps the "dirty" pointer
around at the higher levels, where we need it for any MTE checking.

Since the normal case, especially for user-only, goes through
RAM, this clearing merely adds two insns per page lookup, which
will be completely in the noise.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v9: Added an assert for tbi in aarch64_tr_init_disas_context (pmm)
---
 target/arm/cpu.c           |  3 +++
 target/arm/sve_helper.c    | 19 +++++++++++++++++--
 target/arm/translate-a64.c |  5 +++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d9876337c0..afe81e9b6c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -203,6 +203,9 @@ static void arm_cpu_reset(DeviceState *dev)
          * Enable TBI0 and TBI1.  While the real kernel only enables TBI0,
          * turning on both here will produce smaller code and otherwise
          * make no difference to the user-level emulation.
+         *
+         * In sve_probe_page, we assume that this is set.
+         * Do not modify this without other changes.
          */
         env->cp15.tcr_el[1].raw_tcr = (3ULL << 37);
 #else
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index ad974c2cc5..382fa82bc8 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3966,14 +3966,16 @@ static void sve_##NAME##_host(void *vd, intptr_t reg_off, void *host)  \
 static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
                              target_ulong addr, uintptr_t ra)               \
 {                                                                           \
-    *(TYPEE *)(vd + H(reg_off)) = (TYPEM)TLB(env, addr, ra);                \
+    *(TYPEE *)(vd + H(reg_off)) =                                           \
+        (TYPEM)TLB(env, useronly_clean_ptr(addr), ra);                      \
 }
 
 #define DO_ST_TLB(NAME, H, TYPEE, TYPEM, TLB) \
 static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
                              target_ulong addr, uintptr_t ra)               \
 {                                                                           \
-    TLB(env, addr, (TYPEM)*(TYPEE *)(vd + H(reg_off)), ra);                 \
+    TLB(env, useronly_clean_ptr(addr),                                      \
+        (TYPEM)*(TYPEE *)(vd + H(reg_off)), ra);                            \
 }
 
 #define DO_LD_PRIM_1(NAME, H, TE, TM)                   \
@@ -4091,6 +4093,19 @@ static bool sve_probe_page(SVEHostPage *info, bool nofault,
     int flags;
 
     addr += mem_off;
+
+    /*
+     * User-only currently always issues with TBI.  See the comment
+     * above useronly_clean_ptr.  Usually we clean this top byte away
+     * during translation, but we can't do that for e.g. vector + imm
+     * addressing modes.
+     *
+     * We currently always enable TBI for user-only, and do not provide
+     * a way to turn it off.  So clean the pointer unconditionally here,
+     * rather than look it up here, or pass it down from above.
+     */
+    addr = useronly_clean_ptr(addr);
+
     flags = probe_access_flags(env, addr, access_type, mmu_idx, nofault,
                                &info->host, retaddr);
     info->flags = flags;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e46c4a49e0..c20af6ee9d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14634,6 +14634,11 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->features = env->features;
     dc->dcz_blocksize = arm_cpu->dcz_blocksize;
 
+#ifdef CONFIG_USER_ONLY
+    /* In sve_probe_page, we assume TBI is enabled. */
+    tcg_debug_assert(dc->tbid & 1);
+#endif
+
     /* Single step state. The code-generation logic here is:
      *  SS_ACTIVE == 0:
      *   generate code with no special handling for single-stepping (except
-- 
2.25.1


