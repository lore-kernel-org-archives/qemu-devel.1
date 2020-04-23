Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007DFC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D7B2076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWyAbXct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D7B2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfJk-0003FX-OE
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIc-0000we-Nh
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIc-0005Sx-3A
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRfIb-0005Rl-BF
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id d15so6099893wrx.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HvqdqtvusanP+sIzJfVgQLDOBPUMzvphXIagTaMAVCw=;
 b=fWyAbXctsyVJ/owdq+iFrtsDZe/U9mVY8Dv6UU5DXNZQo63UQ4IcfvygyjwXDjXbF6
 w98wA0bQAsq4+U2wHwU7okTRXjtFZO/g8JZ/taUUmzn3rI/kpYYFe0hniHpe02yBId5S
 65jmc05kM1TrdZTCBJoEcrIaFOgKrOCPYWr8oV9+dQxu52EGbNeVPA/25d2/FVQfLih8
 NyuIYQZs/TeNhbK9JGkWkYWqF3qlhRcs4Rx7nCJnRMfB6u3JGegZ0agAgJSZ4as88D+z
 7MXlawEZNuqYczn1UFwTQEIMQI/9xYD7HbCnMXWL8BeruJX8n3dnSU/vX9wkiPWHh6hT
 4CFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HvqdqtvusanP+sIzJfVgQLDOBPUMzvphXIagTaMAVCw=;
 b=JDTmaFPtyrlsOXoXFjKZgwCZrIu9vGbJjyyWFy37sInQ+xIcgJKL6o/mmJ+iPqfPTM
 9lK1n9ArI0HDsei+4nHRXMu/yzT22p6AKqF2ZI3+hBVa795IMOQZaf0DQHgzccKcxMiy
 O1QhtgtK8xQRdQOqLD1+Oo40dTrb9usmgXzq214Q0JSyM+ybt3zJAtToKHlNzQwxMnIL
 BOPBPJlHSvAegRnDCPF7A2kMM09x3xQx551rOyhngEpVT6gD+s2BqJ5HNFMvZbOC+0Ap
 TUnVsFAUq64LG9kqx/dCqu/ZT04rwQ0L3axAUqUMbzm81tIn92UP/3QWABJS/UgRLJSY
 Ot5w==
X-Gm-Message-State: AGi0Pubrqi35EjeHd6JgHCR6ZcamBDzSD7gzVqoLViSr5AtzG3ejKX0D
 N7bxxs2/14PY/RFw0z+RDr9ufg==
X-Google-Smtp-Source: APiQypIkvfBJFrEzg3W2AxNh+FfDpyLgdmrZD01OBWtnMNWP/2ZZipn688XO3/kU85MLU0bHScjTKg==
X-Received: by 2002:adf:f5c4:: with SMTP id k4mr5970485wrp.294.1587661563032; 
 Thu, 23 Apr 2020 10:06:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c10sm4231466wru.48.2020.04.23.10.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 10:05:58 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8A8161FF8F;
 Thu, 23 Apr 2020 18:05:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 03/14] accel/tcg: Relax va restrictions on 64-bit guests
Date: Thu, 23 Apr 2020 18:05:46 +0100
Message-Id: <20200423170557.31106-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423170557.31106-1-alex.bennee@linaro.org>
References: <20200423170557.31106-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We cannot at present limit a 64-bit guest to a virtual address
space smaller than the host.  It will mostly work to ignore this
limitation, except if the guest uses high bits of the address
space for tags.  But it will certainly work better, as presently
we can wind up failing to allocate the guest stack.

Widen our user-only page tree to the host or abi pointer width.
Remove the workaround for this problem from target/alpha.
Always validate guest addresses vs reserved_va, as there we
control allocation ourselves.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/cpu-all.h    | 23 +++++++++++++++++++----
 target/alpha/cpu-param.h  | 15 ++-------------
 accel/tcg/translate-all.c | 15 +++++++++------
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index b4fb5832c4..c0c2fa3cc5 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -162,12 +162,27 @@ extern unsigned long guest_base;
 extern bool have_guest_base;
 extern unsigned long reserved_va;
 
-#if HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS
-#define GUEST_ADDR_MAX (~0ul)
+/*
+ * Limit the guest addresses as best we can.
+ *
+ * When not using -R reserved_va, we cannot really limit the guest
+ * to less address space than the host.  For 32-bit guests, this
+ * acts as a sanity check that we're not giving the guest an address
+ * that it cannot even represent.  For 64-bit guests... the address
+ * might not be what the real kernel would give, but it is at least
+ * representable in the guest.
+ *
+ * TODO: Improve address allocation to avoid this problem, and to
+ * avoid setting bits at the top of guest addresses that might need
+ * to be used for tags.
+ */
+#if MIN(TARGET_VIRT_ADDR_SPACE_BITS, TARGET_ABI_BITS) <= 32
+# define GUEST_ADDR_MAX_  UINT32_MAX
 #else
-#define GUEST_ADDR_MAX (reserved_va ? reserved_va - 1 : \
-                                    (1ul << TARGET_VIRT_ADDR_SPACE_BITS) - 1)
+# define GUEST_ADDR_MAX_  ~0ul
 #endif
+#define GUEST_ADDR_MAX    (reserved_va ? reserved_va - 1 : GUEST_ADDR_MAX_)
+
 #else
 
 #include "exec/hwaddr.h"
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index 692aee27ca..1153992e42 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -10,22 +10,11 @@
 
 #define TARGET_LONG_BITS 64
 #define TARGET_PAGE_BITS 13
-#ifdef CONFIG_USER_ONLY
-/*
- * ??? The kernel likes to give addresses in high memory.  If the host has
- * more virtual address space than the guest, this can lead to impossible
- * allocations.  Honor the long-standing assumption that only kernel addrs
- * are negative, but otherwise allow allocations anywhere.  This could lead
- * to tricky emulation problems for programs doing tagged addressing, but
- * that's far fewer than encounter the impossible allocation problem.
- */
-#define TARGET_PHYS_ADDR_SPACE_BITS  63
-#define TARGET_VIRT_ADDR_SPACE_BITS  63
-#else
+
 /* ??? EV4 has 34 phys addr bits, EV5 has 40, EV6 has 44.  */
 #define TARGET_PHYS_ADDR_SPACE_BITS  44
 #define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
-#endif
+
 #define NB_MMU_MODES 3
 
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 9924e66d1f..e4f703a7e6 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -173,8 +173,13 @@ struct page_collection {
 #define TB_FOR_EACH_JMP(head_tb, tb, n)                                 \
     TB_FOR_EACH_TAGGED((head_tb)->jmp_list_head, tb, n, jmp_list_next)
 
-/* In system mode we want L1_MAP to be based on ram offsets,
-   while in user mode we want it to be based on virtual addresses.  */
+/*
+ * In system mode we want L1_MAP to be based on ram offsets,
+ * while in user mode we want it to be based on virtual addresses.
+ *
+ * TODO: For user mode, see the caveat re host vs guest virtual
+ * address spaces near GUEST_ADDR_MAX.
+ */
 #if !defined(CONFIG_USER_ONLY)
 #if HOST_LONG_BITS < TARGET_PHYS_ADDR_SPACE_BITS
 # define L1_MAP_ADDR_SPACE_BITS  HOST_LONG_BITS
@@ -182,7 +187,7 @@ struct page_collection {
 # define L1_MAP_ADDR_SPACE_BITS  TARGET_PHYS_ADDR_SPACE_BITS
 #endif
 #else
-# define L1_MAP_ADDR_SPACE_BITS  TARGET_VIRT_ADDR_SPACE_BITS
+# define L1_MAP_ADDR_SPACE_BITS  MIN(HOST_LONG_BITS, TARGET_ABI_BITS)
 #endif
 
 /* Size of the L2 (and L3, etc) page tables.  */
@@ -2497,9 +2502,7 @@ void page_set_flags(target_ulong start, target_ulong end, int flags)
     /* This function should never be called with addresses outside the
        guest address space.  If this assert fires, it probably indicates
        a missing call to h2g_valid.  */
-#if TARGET_ABI_BITS > L1_MAP_ADDR_SPACE_BITS
-    assert(end <= ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
-#endif
+    assert(end - 1 <= GUEST_ADDR_MAX);
     assert(start < end);
     assert_memory_lock();
 
-- 
2.20.1


