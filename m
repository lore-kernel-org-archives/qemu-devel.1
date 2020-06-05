Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D48C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CF1206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxMROiUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CF1206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh3sK-0006M0-Gx
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 00:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nf-0004Uk-Cb
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:47 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3ne-0000kh-Il
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:47 -0400
Received: by mail-pj1-x1043.google.com with SMTP id s88so2179647pjb.5
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 21:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nCxIirgN5OzmYmJJvTz1Ncldrcyg3LSoeyCRUE7/tl0=;
 b=YxMROiUmSMWoMRilm0Ow7tHnIWiDyjBi33Ml7dfIqbCZtEUDsT+NFO9ubOAnOb0WE3
 uBB5vDn6D6ta07XlPURgTyJW7kDEklNuHOr6eYuE7jg7kAbZYBRxGtvuJxRKEC6wRsa1
 2Ue0vfJsJXvw1ctA1QOLZDpPztNkwBao6fUlaRzBNJSjj/ruCMXvPZLH6itcx6pu5qko
 ner6WCZamoZZrIUlVR+FkGMfZXdK3wKzYc2P+/xh888lQsRVawCZ/RrnHsmRHZI/ZtN8
 t8WqwqM9ne333TErHpYu+n3naILGXfYnGugrK5UAjjzSEwzcgT0rXCGhSP5UBGbn141p
 0OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nCxIirgN5OzmYmJJvTz1Ncldrcyg3LSoeyCRUE7/tl0=;
 b=lJneh+VPJtTeT2m8QMgLW2RzzqeUpRP5AWGtVqSAm0UOaYfNjBXI5nltuFPkCb5O1q
 +OXB4u/ZsVV3U3ep2qzUONHR9z8pxcN3FEkxQ3Y/Es8hbcsvRVB4qx1H9/67cmyCVupU
 VmE17bsnb8QaotpHxv03Kv4+4GV7EvtMHPNEWeEbMvK7x9JS4bsxXhwqTCMu5JU2SbiN
 4tfXq0dNDhyMkcztBO14Zk6eYAnwWtPWmjXYKaWHq8KQJjGvgewx6eqdaqlKfXZofLYj
 17l+oIZDCxXlOlVzqhXQHCfjI5z8Q55m+liP9GftV+39Bro/Hcy21udHprtuRNsI4x75
 6Piw==
X-Gm-Message-State: AOAM530U/8s7Z0VIKeJ2s2ZlQujMQREAa4mW0EOwntLhMCW0Rb/MnTtd
 u4fhjmf3vb3u9f1e1fFugh5JaG4Ed+o=
X-Google-Smtp-Source: ABdhPJzjUUWZPyLui9Jga+9L7iKRXYDte6mM3iDJnjJK6TqvJIDN2pGqIPOGCkOVOsl1T+0Vq266hg==
X-Received: by 2002:a17:90a:6047:: with SMTP id
 h7mr738751pjm.145.1591330664883; 
 Thu, 04 Jun 2020 21:17:44 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm5440902pgl.12.2020.06.04.21.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 21:17:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/17] exec: Add support for TARGET_TAGGED_ADDRESSES
Date: Thu,  4 Jun 2020 21:17:24 -0700
Message-Id: <20200605041733.415188-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605041733.415188-1-richard.henderson@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The AArch64 Linux ABI has always enabled TBI, but has historically
required that pointer tags be removed before a syscall.  This has
changed in the lead-up to ARMv8.5-MTE, in a way that affects the
ABI generically and not specifically to MTE.

This patch allows the target to indicate that (1) there are tags
and (2) whether or not they should be taken into account at the
syscall level.

Adjust g2h, guest_addr_valid, and guest_range_valid to ignore
pointer tags, similar to how TIF_TAGGED_ADDR alters __range_ok
in the arm64 kernel source.

The prctl syscall is not not yet updated, so this change by itself
has no visible effect.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 22 ++++++++++++++++++----
 target/arm/cpu-param.h  |  3 +++
 bsd-user/main.c         |  5 +++++
 linux-user/main.c       |  5 +++++
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 066cf33f70..d84847dc70 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -69,17 +69,31 @@ typedef uint64_t abi_ptr;
 #define TARGET_ABI_FMT_ptr "%"PRIx64
 #endif
 
+#ifdef TARGET_TAGGED_ADDRESSES
+extern abi_ptr untagged_addr_mask;
+static inline abi_ptr untagged_addr(abi_ptr x)
+{
+    return x & untagged_addr_mask;
+}
+#else
+static inline abi_ptr untagged_addr(abi_ptr x) { return x; }
+#endif
+
 /* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
-#define g2h(x) ((void *)((unsigned long)(abi_ptr)(x) + guest_base))
+static inline void *g2h(abi_ptr x)
+{
+    return (void *)(uintptr_t)(untagged_addr(x) + guest_base);
+}
 
 static inline bool guest_addr_valid(abi_ptr x)
 {
-    return x <= GUEST_ADDR_MAX;
+    return untagged_addr(x) <= GUEST_ADDR_MAX;
 }
 
-static inline int guest_range_valid(unsigned long start, unsigned long len)
+static inline bool guest_range_valid(abi_ptr start, abi_ulong len)
 {
-    return len - 1 <= GUEST_ADDR_MAX && start <= GUEST_ADDR_MAX - len + 1;
+    return len - 1 <= GUEST_ADDR_MAX &&
+           untagged_addr(start) <= GUEST_ADDR_MAX - len + 1;
 }
 
 #define h2g_valid(x)  ((uintptr_t)(x) - guest_base <= GUEST_ADDR_MAX)
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 6321385b46..f922aa0650 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -20,6 +20,9 @@
 
 #ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 12
+# ifdef TARGET_AARCH64
+#  define TARGET_TAGGED_ADDRESSES
+# endif
 #else
 /*
  * ARMv7 and later CPUs have 4K pages minimum, but ARMv5 and v6
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 0bfe46cff9..87c99fc6c2 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -45,6 +45,11 @@ unsigned long guest_base;
 bool have_guest_base;
 unsigned long reserved_va;
 
+#ifdef TARGET_TAGGED_ADDRESSES
+/* Default to no tagged addresses, i.e. all pointer bits valid.  */
+abi_ptr untagged_addr_mask = -1;
+#endif
+
 static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
 const char *qemu_uname_release;
 extern char **environ;
diff --git a/linux-user/main.c b/linux-user/main.c
index 3597e99bb1..8fcca3f5f1 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -103,6 +103,11 @@ static int last_log_mask;
 
 unsigned long reserved_va;
 
+#ifdef TARGET_TAGGED_ADDRESSES
+/* Default to no tagged addresses, i.e. all pointer bits valid.  */
+abi_ptr untagged_addr_mask = -1;
+#endif
+
 static void usage(int exitcode);
 
 static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
-- 
2.25.1


