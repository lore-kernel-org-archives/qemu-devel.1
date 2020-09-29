Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8028C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 21:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7292076A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 21:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZREOQKvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7292076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNNFm-0006WY-SY
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 17:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oanderso@google.com>)
 id 1kNNEn-00064x-Ol
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 17:32:43 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532]:33261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oanderso@google.com>)
 id 1kNNEl-0004Oo-LO
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 17:32:41 -0400
Received: by mail-ed1-x532.google.com with SMTP id g4so8288711edk.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=XA+mrk18J1sNU6j9klyWCYlrjyCnZeUHkmu4Ub5BuP4=;
 b=ZREOQKvCecquZR3RdjzbuCyVtrRH7ttRBXvN9uMx/9HoM8nHWkncQ+mZQ3eFP6/HG6
 Qv/sffZVVSwglGaCaXwqtQmRb6bv+XdedaXEVDqLqmZk+u1g/y6YiC+swrd6++ndRXRg
 FaTA1oKPB5GvZyhu3lVZQElpTLaqI1oS7L9BZmPcI1tlKxTwqJIXK8AeDmVycBK7wVmL
 Is/hGZm07x9C1dRqHOxj4LxzLTrXgdBKHV2f6mqzmbpeeagSHDp1Up81unB5AJncXYaN
 4dIOBiGctfDE6y4LkvfB3iCn+FrmfrwcCm3xtfcmoFrfSD1tGZ8hPFlEEIFOeehrii2m
 ZNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=XA+mrk18J1sNU6j9klyWCYlrjyCnZeUHkmu4Ub5BuP4=;
 b=ksZAG4HxaHdqZukvPHwf5BQl7Ma1FX65Jevzuj3+xon1JPALWZ43/qf+h3xyDqgpgI
 1iseB7C88U574IeiP4mPF2cCD3ETSPyfJ2APutej7n/LjcJGVMBgZbdKJ2ljXAXq2mrt
 9gdzoB6zJOJCLJqeZFbZPx2BtGxVgD5WNrLH6nt850m9NfgUBaOQOVUq4NOPzoY+ES6b
 8LtfJuHTdDdi+9XYpESRprEemeLp3Y07/v0c+U9HZkSKmjrfpfQOkHNtBlfi8LX9Ng8P
 skkbpNqOIoBXwFZVkzZtfj8eWmYaGl7u1HaUr0TQ7/SjpDj3TCQNjJSiSHdTcaZ8+SVn
 Mrhg==
X-Gm-Message-State: AOAM531pnJ7YBrwGRVDbrGUYFQd81ukezBiv0QItQlXvPMAkj6F2IsMK
 3h5PjuA/a7Ld9TSE4CaiH65SVqLu3Y8WOZwNqHr7eEOT/1WzxA==
X-Google-Smtp-Source: ABdhPJx2GAYo6MxlRvouHtQp8zRyaGoXpW9NrCJ/FRVDKECLMXXjcLS8iIX5bWXYGg+fH2VQ/Hrd99aLKNWMtUbQpWc=
X-Received: by 2002:a05:6402:1656:: with SMTP id
 s22mr5718478edx.160.1601415156277; 
 Tue, 29 Sep 2020 14:32:36 -0700 (PDT)
MIME-Version: 1.0
From: Owen Anderson <oanderso@google.com>
Date: Tue, 29 Sep 2020 14:32:25 -0700
Message-ID: <CAKs3XfJPrMGxdAouGCje3ppnWKA6fXpNaywQ5rj9u45VkPuUXg@mail.gmail.com>
Subject: [RFC] Don't lookup full CPU state in the indirect branch fast path on
 AArch64 when running in user mode.
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=oanderso@google.com; helo=mail-ed1-x532.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.468,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

I would like to request feedback on the following patch, which I do
not believe should be applied to master as-is.  The idea here is to
avoid gathering the full CPU state in the fast path of an indirect
branch lookup when running in user mode on a platform where the flags
can only be changed in privileged mode.  I believe this is true on the
AArch64 scenario that I care about, but clearly not true in general.
I'm particularly seeking feedback on how to clean this up into a
version that checks the correct necessary and sufficient conditions to
allow all users that can benefit from it to do so.

On the workload that I am targeting (aarch64 on x86), this patch
reduces execution wall time by approximately 20%, and eliminates
indirect branch lookups from the hot stack traces entirely.

Thank you,

--Owen

From 3d96db17d3baacb92ef1bc5e70ef06b97d06a0ae Mon Sep 17 00:00:00 2001
From: Owen Anderson <oanderso@google.com>
Date: Tue, 29 Sep 2020 13:47:00 -0700
Subject: [RFC] Don't lookup full CPU state in the indirect branch fast path on
 AArch64 when running in user mode.

Most of the CPU state can't be changed in user mode, so this is useless work.

Signed-off-by: Owen Anderson <oanderso@google.com>
---
 include/exec/tb-lookup.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/exec/tb-lookup.h b/include/exec/tb-lookup.h
index 9cf475bb03..f4ea0eb4c0 100644
--- a/include/exec/tb-lookup.h
+++ b/include/exec/tb-lookup.h
@@ -25,7 +25,15 @@ tb_lookup__cpu_state(CPUState *cpu, target_ulong
*pc, target_ulong *cs_base,
     TranslationBlock *tb;
     uint32_t hash;

+#if !defined(TARGET_ARM) || !defined(CONFIG_USER_ONLY)
     cpu_get_tb_cpu_state(env, pc, cs_base, flags);
+#else
+    if (is_a64(env)) {
+      *pc = env->pc;
+    } else {
+      *pc = env->regs[15];
+    }
+#endif
     hash = tb_jmp_cache_hash_func(*pc);
     tb = qatomic_rcu_read(&cpu->tb_jmp_cache[hash]);

@@ -34,12 +42,19 @@ tb_lookup__cpu_state(CPUState *cpu, target_ulong
*pc, target_ulong *cs_base,

     if (likely(tb &&
                tb->pc == *pc &&
+#if !defined(TARGET_ARM) || !defined(CONFIG_USER_ONLY)
                tb->cs_base == *cs_base &&
                tb->flags == *flags &&
+#endif
                tb->trace_vcpu_dstate == *cpu->trace_dstate &&
                (tb_cflags(tb) & (CF_HASH_MASK | CF_INVALID)) == cf_mask)) {
         return tb;
     }
+
+#ifdef CONFIG_USER_ONLY
+    cpu_get_tb_cpu_state(env, pc, cs_base, flags);
+#endif
+
     tb = tb_htable_lookup(cpu, *pc, *cs_base, *flags, cf_mask);
     if (tb == NULL) {
         return NULL;
-- 
2.28.0.709.gb0816b6eb0-goog

