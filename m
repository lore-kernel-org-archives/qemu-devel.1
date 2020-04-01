Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0E9C2D0F2
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5E220772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUOTNK2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5E220772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJa4C-0005h4-TQ
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 05:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZys-0004aU-5K
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZyp-0002HK-Ud
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:18 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53628)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJZyp-0002Gz-Me
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:15 -0400
Received: by mail-wm1-x343.google.com with SMTP id b12so5847085wmj.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 02:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wiruPLRzIVKr/sqR3IRGFAA55bADwbShqW9FNeJTSKM=;
 b=NUOTNK2FpGsl230XFpru04XaorS9Fxu5/PUxhVMSncfKVd12/RXuw7nVpC/KZyfzCN
 5nRYhBRBaefVMu8OwfBvvISF3bbLoKILzcRF+ANgtCaC1rrvbqCC2Ti4OUk4IkMpiO/1
 8Qs0GIymvfHqSCXN6bYvRc/P1f9DFnNCeBFxo5cZjrOerWl5fQQdGHTj0wNsi4AHuRfR
 UVzVAhiPh8UzYx7ynQ0EBNM3MXBGLvgxsR8cQBPUkkImvEHDONQeT+Jkc1qoCE/lKH6i
 5WA7XZB4BSpVYRkbK+M4MLCTW36VV46+naQvpsNLQdfjHlB41cjWbT04soIKYWeWAWcq
 XnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wiruPLRzIVKr/sqR3IRGFAA55bADwbShqW9FNeJTSKM=;
 b=cGj7yJMh+reTVRPHEl/QnRmx+M8VTfukCW0xrr6vStLdTzt8V9BGdTA1Dha/VF3pCP
 TDA6WtIW9TaLSMHimEKduoA/PbIgpZt0clU4UHSss7snIO71YOaFJr3hzsWVmibkcWwn
 0KMjaMhZz3d9NuK5DI8ThnagvSwZhbdzRvuSrUowPs3hX5Q/QhkkuRgYeh7yPR4PTFwH
 LZOXqj6NQfWZQGKgWiZLJq7uAUTnsn9Kz8+08Th3KU+4XfiBXtpIbH2MFLDEE0YMqRQF
 FXcNxjlkWkNs15d/kd1EMmokrNo+5y6fiXjPajSclGPQ1Ro/dK491Feerr7HYO+XzFet
 7Z1g==
X-Gm-Message-State: AGi0PuYek+NsMFbS5FiL6t2ri5oqh2KcPhGUYK+/Asxj1EnbkKWWrOuf
 ZWCNJiVALfxGOCKjxhmOCezWQtdV9Tk=
X-Google-Smtp-Source: APiQypLdIx782lgw4/UD2ldY+eLHyDtWTRn1EUvCLVFl21Vm9hfDHa+7CGE2qb9fqBc/AMHEiQou4Q==
X-Received: by 2002:a7b:c145:: with SMTP id z5mr3413061wmi.55.1585734494441;
 Wed, 01 Apr 2020 02:48:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l10sm2329335wrq.95.2020.04.01.02.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 02:48:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 09A011FF99;
 Wed,  1 Apr 2020 10:48:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 10/10] linux-user: completely re-write init_guest_space
Date: Wed,  1 Apr 2020 10:47:59 +0100
Message-Id: <20200401094759.5835-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401094759.5835-1-alex.bennee@linaro.org>
References: <20200401094759.5835-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tries to simplify the init_guest_space code to be a little less
convoluted and remove the brute force mapping algorithm that gets
tripped up so badly by the sanitizers.

We first try to do what is requested by the host. Failing that we try
and satisfy the guest requested base address. If all those options
fail we fall back to finding a space in the memory map using our
recently written read_self_maps() helper.

Less mind-binding gotos and hopefully clearer logic although perhaps
more sloppy casting than I'm totally happy with.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/elfload.c | 279 +++++++++++++++++++------------------------
 1 file changed, 125 insertions(+), 154 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 619c054cc48..88c08513119 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -11,6 +11,7 @@
 #include "qemu/queue.h"
 #include "qemu/guest-random.h"
 #include "qemu/units.h"
+#include "qemu/selfmap.h"
 
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
@@ -2075,6 +2076,34 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     return sp;
 }
 
+/*
+ * Wrapper to hide to keep the ugliness of the commpage checks out of
+ * the init_guest_space function bellow. For non-32 bit ARM targets it
+ * always succeeds.
+ */
+static bool check_commpage(unsigned long start, unsigned long size)
+{
+#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
+    if (init_guest_commpage(start, size) != 1) {
+        return false;
+    }
+#endif
+   return true;
+}
+
+/*
+ * init_guest_space:
+ *
+ * Reserve the initial chunk of guest address space. In order we try:
+ *
+ *   - if given host_start just verify it
+ *   - else try and allocate at guest_start to save offset calculations
+ *   - finally allocate from lowest available >= host_size'd gap
+ *
+ * In practice it shouldn't matter if the guest can't extend brk above
+ * it's initial allocation because any moderately sane memory
+ * allocation library should be using mmap to allocate additional blocks.
+ */
 unsigned long init_guest_space(unsigned long host_start,
                                unsigned long host_size,
                                unsigned long guest_start,
@@ -2082,183 +2111,125 @@ unsigned long init_guest_space(unsigned long host_start,
 {
     /* In order to use host shmat, we must be able to honor SHMLBA.  */
     unsigned long align = MAX(SHMLBA, qemu_host_page_size);
-    unsigned long current_start, aligned_start;
-    int flags;
+    void *map_addr = NULL;
+    const int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE | MAP_FIXED;
 
     assert(host_start || host_size);
 
-    /* If just a starting address is given, then just verify that
-     * address.  */
+    /*
+     * If just a starting address is given, then just verify that
+     * address. If the commpage isn't happy we pretty much give up
+     * now.
+     */
     if (host_start && !host_size) {
-#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
-        if (init_guest_commpage(host_start, host_size) != 1) {
+        if (!check_commpage(host_start, host_size)) {
             return (unsigned long)-1;
+        } else {
+            qemu_log_mask(CPU_LOG_PAGE, "%s: host_start @ %#lx verified\n",
+                          __func__, host_start);
+            return host_start;
         }
-#endif
-        return host_start;
     }
 
-    /* Setup the initial flags and start address.  */
-    current_start = host_start & -align;
-    flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE;
-    if (fixed) {
-        flags |= MAP_FIXED;
-    }
-
-    /* Otherwise, a non-zero size region of memory needs to be mapped
-     * and validated.  */
-
-#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
-    /* On 32-bit ARM, we need to map not just the usable memory, but
-     * also the commpage.  Try to find a suitable place by allocating
-     * a big chunk for all of it.  If host_start, then the naive
-     * strategy probably does good enough.
+    /*
+     * Now we are going to try and map something, we start by trying
+     * to satisfy exactly what the guest wants. This is unlikely to
+     * succeed but will make the code generators job easier if it can
+     * be done.
+     *
+     * If the commpage check isn't happy after we allocate we need to
+     * fall back to finding a big enough hole in the address space.
      */
-    if (!host_start) {
-        unsigned long guest_full_size, host_full_size, real_start;
-
-        guest_full_size =
-            (0xffff0f00 & qemu_host_page_mask) + qemu_host_page_size;
-        host_full_size = guest_full_size - guest_start;
-        real_start = (unsigned long)
-            mmap(NULL, host_full_size, PROT_NONE, flags, -1, 0);
-        if (real_start == (unsigned long)-1) {
-            if (host_size < host_full_size - qemu_host_page_size) {
-                /* We failed to map a continous segment, but we're
-                 * allowed to have a gap between the usable memory and
-                 * the commpage where other things can be mapped.
-                 * This sparseness gives us more flexibility to find
-                 * an address range.
-                 */
-                goto naive;
-            }
-            return (unsigned long)-1;
+    map_addr = (void *) guest_start;
+    if (mmap(map_addr, host_size, PROT_NONE, flags, -1, 0) == map_addr) {
+        if (check_commpage(guest_start, host_size)) {
+            /* success, everyone is happy :-D */
+            qemu_log_mask(CPU_LOG_PAGE, "%s: got what guest wanted @ %p\n",
+                          __func__, map_addr);
+            return guest_start;
         }
-        munmap((void *)real_start, host_full_size);
-        if (real_start & (align - 1)) {
-            /* The same thing again, but with extra
-             * so that we can shift around alignment.
-             */
-            unsigned long real_size = host_full_size + qemu_host_page_size;
-            real_start = (unsigned long)
-                mmap(NULL, real_size, PROT_NONE, flags, -1, 0);
-            if (real_start == (unsigned long)-1) {
-                if (host_size < host_full_size - qemu_host_page_size) {
-                    goto naive;
-                }
-                return (unsigned long)-1;
-            }
-            munmap((void *)real_start, real_size);
-            real_start = ROUND_UP(real_start, align);
-        }
-        current_start = real_start;
-    }
- naive:
-#endif
-
-    while (1) {
-        unsigned long real_start, real_size, aligned_size;
-        aligned_size = real_size = host_size;
 
-        /* Do not use mmap_find_vma here because that is limited to the
-         * guest address space.  We are going to make the
-         * guest address space fit whatever we're given.
-         */
-        real_start = (unsigned long)
-            mmap((void *)current_start, host_size, PROT_NONE, flags, -1, 0);
-        if (real_start == (unsigned long)-1) {
-            return (unsigned long)-1;
-        }
-
-        /* Check to see if the address is valid.  */
-        if (host_start && real_start != current_start) {
-            qemu_log_mask(CPU_LOG_PAGE, "invalid %lx && %lx != %lx\n",
-                          host_start, real_start, current_start);
-            goto try_again;
+        if (munmap(map_addr, host_size) != 0) {
+            error_report("%s: failed to unmap %p:%lx (%s)", __func__,
+                         map_addr, host_size, strerror(errno));
+            abort();
         }
+    } else if (fixed) {
+        /*
+         * If the caller wanted a fixed address we have pretty much failed
+         * to deliver here so it is time to bail out gracefully.
+         */
+        error_report("%s: failed to honour fixed guest request @ %p",
+                     __func__, map_addr);
+        return (unsigned long)-1;
+    }
 
-        /* Ensure the address is properly aligned.  */
-        if (real_start & (align - 1)) {
-            /* Ideally, we adjust like
-             *
-             *    pages: [  ][  ][  ][  ][  ]
-             *      old:   [   real   ]
-             *             [ aligned  ]
-             *      new:   [     real     ]
-             *               [ aligned  ]
-             *
-             * But if there is something else mapped right after it,
-             * then obviously it won't have room to grow, and the
-             * kernel will put the new larger real someplace else with
-             * unknown alignment (if we made it to here, then
-             * fixed=false).  Which is why we grow real by a full page
-             * size, instead of by part of one; so that even if we get
-             * moved, we can still guarantee alignment.  But this does
-             * mean that there is a padding of < 1 page both before
-             * and after the aligned range; the "after" could could
-             * cause problems for ARM emulation where it could butt in
-             * to where we need to put the commpage.
-             */
-            munmap((void *)real_start, host_size);
-            real_size = aligned_size + align;
-            real_start = (unsigned long)
-                mmap((void *)real_start, real_size, PROT_NONE, flags, -1, 0);
-            if (real_start == (unsigned long)-1) {
-                return (unsigned long)-1;
+    /*
+     * Finally we need to find a hole somewhere in the address space
+     * that will accept the initial mapping as well as being able to
+     * map the (ARM32 specific) commpage later.
+     *
+     * We need to ensure the address is properly aligned. But this
+     * does mean that there is a padding of < 1 page both before and
+     * after the aligned range; the "after" could could cause problems
+     * for aforementioned ARM32 emulation.
+     */
+    {
+#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
+        uint64_t required_size =
+            (0xffff0f00 & qemu_host_page_mask) + qemu_host_page_size;
+#else
+        uint64_t required_size = host_size + align;
+#endif
+        GSList *map_info = read_self_maps();
+        GSList *last, *next;
+        map_addr = NULL;
+
+        for (last = map_info, next = g_slist_next(last);
+             next; last = next, next = g_slist_next(next)) {
+            MapInfo *l = (MapInfo *) last->data;
+            MapInfo *n = (MapInfo *) next->data;
+            uint64_t base = ROUND_UP(l->end, align);
+            uint64_t gap_size = n->start - base;
+            if (gap_size > required_size) {
+                map_addr = (void *) base;
+                break;
             }
-            aligned_start = ROUND_UP(real_start, align);
-        } else {
-            aligned_start = real_start;
         }
 
-#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
-        /* On 32-bit ARM, we need to also be able to map the commpage.  */
-        int valid = init_guest_commpage(aligned_start - guest_start,
-                                        aligned_size + guest_start);
-        if (valid == -1) {
-            munmap((void *)real_start, real_size);
+        /*
+         * We couldn't find any space in the memory map, woe...
+         */
+        if (!map_addr) {
+            error_report("%s: couldn't find a %ld sized gap in the memory map",
+                         __func__, required_size);
             return (unsigned long)-1;
-        } else if (valid == 0) {
-            goto try_again;
         }
-#endif
+    }
 
-        /* If nothing has said `return -1` or `goto try_again` yet,
-         * then the address we have is good.
-         */
-        break;
-
-    try_again:
-        /* That address didn't work.  Unmap and try a different one.
-         * The address the host picked because is typically right at
-         * the top of the host address space and leaves the guest with
-         * no usable address space.  Resort to a linear search.  We
-         * already compensated for mmap_min_addr, so this should not
-         * happen often.  Probably means we got unlucky and host
-         * address space randomization put a shared library somewhere
-         * inconvenient.
-         *
-         * This is probably a good strategy if host_start, but is
-         * probably a bad strategy if not, which means we got here
-         * because of trouble with ARM commpage setup.
-         */
-        if (munmap((void *)real_start, real_size) != 0) {
-            error_report("%s: failed to unmap %lx:%lx (%s)", __func__,
-                         real_start, real_size, strerror(errno));
+    /*
+     * From this point on it should be a formality but lets go through
+     * the steps anyway.
+     */
+    if (mmap(map_addr, host_size + align , PROT_NONE,
+             flags | MAP_FIXED, -1, 0) == map_addr) {
+        unsigned long addr = (unsigned long) map_addr;
+        if (!check_commpage(addr, host_size + align)) {
+            error_report("%s: commpage won't fit in guest_memory @ %p",
+                         __func__, map_addr);
             abort();
+        } else {
+            qemu_log_mask(CPU_LOG_PAGE, "%s: guest address space @ %p\n",
+                          __func__, map_addr);
+            return addr;
         }
-        current_start += align;
-        if (host_start == current_start) {
-            /* Theoretically possible if host doesn't have any suitably
-             * aligned areas.  Normally the first mmap will fail.
-             */
-            return (unsigned long)-1;
-        }
+    } else {
+        error_report("%s: failed to allocate guest address space @ %p (%d/%s)",
+                     __func__, map_addr, errno, strerror(errno));
     }
 
-    qemu_log_mask(CPU_LOG_PAGE, "Reserved 0x%lx bytes of guest address space\n", host_size);
-
-    return aligned_start;
+    /* really should never get here */
+    g_assert_not_reached();
 }
 
 static void probe_guest_base(const char *image_name,
-- 
2.20.1


