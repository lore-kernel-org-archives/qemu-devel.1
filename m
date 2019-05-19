Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF18C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9E520644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="td151Mif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9E520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53110 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSZM-0002mi-F7
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:38:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSI4-0005kw-B5
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSI1-0007gi-8h
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:15 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSI0-0007cy-Ja
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:12 -0400
Received: by mail-pl1-x641.google.com with SMTP id p1so326972plo.2
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=SiayGyQLvWgiqh6AWRkbo8bNn33tFxS579n6WOmgYIY=;
	b=td151MifHmQglT9fSzTLa8/xgbDoW+f2CiheDLqtm9TYH26L9MS10aENkZgFKAbqZo
	mscpsRTUl0xC01PjpO27A6c5QINPldHpWyFDfIht5UroqWPo8oO7UYuGfWz8Ne8WyFeB
	nND5iTozv5hEKt8CwdWLjtVMTskRf2BauHmFcRRPWBjbhN7VRbPkVimcJHs0hyPdPY95
	YUQSkgwAFSpGWyyz0zyR+JUIkNv+vEcwm5ngLcg0KmPFOOpc1G/rXtfBj0MU0kUiZv0E
	NIYYsG03r0kfyBys8DPxTm9tiA1DVe0nFuyq8bFGAT41De2D81UBWBqgJPbzGTzMT3W5
	/a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=SiayGyQLvWgiqh6AWRkbo8bNn33tFxS579n6WOmgYIY=;
	b=CPwVnnYByFW6CC3Z+6Hf4X8FKTEYWvJpFKv4SNQf4LHep79Ccuj3d6eaXoHaF9bCO3
	wqMmNuB5D3/JL/1T//lU+AFKXTYa2A+zkjxbh9c5RLOZSEeO7SCPgyxsoj5qvuGOX3AR
	xse12Kz9P7ldl6WJWT1AD7PpweYf4yS5G+u+7H0ms2x8Y/kkc8tvP6ap/nfkkO9pXeQT
	8Epxgd7G6tExtPQbEHenrwsOw3FyDbe469dmHCOtSd1GKRveLy5Tq3eOVzBtAHvwsL3K
	cWSJX4p1ppRIv5cM6swPlVRg9SUZYTYpccVvFeFe3JEQNicvO6xfrcC0LiG1d/9tLI2v
	rHsw==
X-Gm-Message-State: APjAAAVRhqkgl8PgZy1PHNi+EHQUuHxdg6Mhkcuybg9/AJTem89POZ7K
	pI+Tsg/yLMpuVAyIpuG81BdsXgHqKTA=
X-Google-Smtp-Source: APXvYqwooEaDDqayizDKzYPqI2W8uD8zX85YcLlXErZmgBpvQJjxqtoj2mMtigO7LBwlcehMzfTFhg==
X-Received: by 2002:a17:902:1126:: with SMTP id
	d35mr36073717pla.82.1558297210992; 
	Sun, 19 May 2019 13:20:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	e14sm18166264pff.60.2019.05.19.13.20.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:20:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:19:52 -0700
Message-Id: <20190519201953.20161-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519201953.20161-1-richard.henderson@linaro.org>
References: <20190519201953.20161-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH 12/13] linux-user: Fix shmat emulation by
 honoring host SHMLBA
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For those hosts with SHMLBA > getpagesize, we don't automatically
select a guest address that is compatible with the host.  We can
achieve this by boosting the alignment of guest_base and by adding
an extra alignment argument to mmap_find_vma.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h    |  2 +-
 linux-user/elfload.c | 17 +++++-----
 linux-user/mmap.c    | 74 +++++++++++++++++++++++---------------------
 linux-user/syscall.c |  3 +-
 4 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index ef400cb78a..82d33d7e93 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -443,7 +443,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_addr);
 extern unsigned long last_brk;
 extern abi_ulong mmap_next_start;
-abi_ulong mmap_find_vma(abi_ulong, abi_ulong);
+abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);
 void mmap_fork_start(void);
 void mmap_fork_end(int child);
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ef42e02d82..fe9f07843e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3,6 +3,7 @@
 #include <sys/param.h>
 
 #include <sys/resource.h>
+#include <sys/shm.h>
 
 #include "qemu.h"
 #include "disas/disas.h"
@@ -2012,6 +2013,8 @@ unsigned long init_guest_space(unsigned long host_start,
                                unsigned long guest_start,
                                bool fixed)
 {
+    /* In order to use host shmat, we must be able to honor SHMLBA.  */
+    unsigned long align = MAX(SHMLBA, qemu_host_page_size);
     unsigned long current_start, aligned_start;
     int flags;
 
@@ -2029,7 +2032,7 @@ unsigned long init_guest_space(unsigned long host_start,
     }
 
     /* Setup the initial flags and start address.  */
-    current_start = host_start & qemu_host_page_mask;
+    current_start = host_start & -align;
     flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE;
     if (fixed) {
         flags |= MAP_FIXED;
@@ -2065,8 +2068,8 @@ unsigned long init_guest_space(unsigned long host_start,
             return (unsigned long)-1;
         }
         munmap((void *)real_start, host_full_size);
-        if (real_start & ~qemu_host_page_mask) {
-            /* The same thing again, but with an extra qemu_host_page_size
+        if (real_start & (align - 1)) {
+            /* The same thing again, but with extra
              * so that we can shift around alignment.
              */
             unsigned long real_size = host_full_size + qemu_host_page_size;
@@ -2079,7 +2082,7 @@ unsigned long init_guest_space(unsigned long host_start,
                 return (unsigned long)-1;
             }
             munmap((void *)real_start, real_size);
-            real_start = HOST_PAGE_ALIGN(real_start);
+            real_start = ROUND_UP(real_start, align);
         }
         current_start = real_start;
     }
@@ -2106,7 +2109,7 @@ unsigned long init_guest_space(unsigned long host_start,
         }
 
         /* Ensure the address is properly aligned.  */
-        if (real_start & ~qemu_host_page_mask) {
+        if (real_start & (align - 1)) {
             /* Ideally, we adjust like
              *
              *    pages: [  ][  ][  ][  ][  ]
@@ -2134,7 +2137,7 @@ unsigned long init_guest_space(unsigned long host_start,
             if (real_start == (unsigned long)-1) {
                 return (unsigned long)-1;
             }
-            aligned_start = HOST_PAGE_ALIGN(real_start);
+            aligned_start = ROUND_UP(real_start, align);
         } else {
             aligned_start = real_start;
         }
@@ -2171,7 +2174,7 @@ unsigned long init_guest_space(unsigned long host_start,
          * because of trouble with ARM commpage setup.
          */
         munmap((void *)real_start, real_size);
-        current_start += qemu_host_page_size;
+        current_start += align;
         if (host_start == current_start) {
             /* Theoretically possible if host doesn't have any suitably
              * aligned areas.  Normally the first mmap will fail.
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index e0249efe4f..10796b37ac 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -202,49 +202,52 @@ unsigned long last_brk;
 
 /* Subroutine of mmap_find_vma, used when we have pre-allocated a chunk
    of guest address space.  */
-static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size)
+static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
+                                        abi_ulong align)
 {
-    abi_ulong addr;
-    abi_ulong end_addr;
+    abi_ulong addr, end_addr, incr = qemu_host_page_size;
     int prot;
-    int looped = 0;
+    bool looped = false;
 
     if (size > reserved_va) {
         return (abi_ulong)-1;
     }
 
-    size = HOST_PAGE_ALIGN(size);
-    end_addr = start + size;
-    if (end_addr > reserved_va) {
-        end_addr = reserved_va;
-    }
-    addr = end_addr - qemu_host_page_size;
+    /* Note that start and size have already been aligned by mmap_find_vma. */
 
+    end_addr = start + size;
+    if (start > reserved_va - size) {
+        /* Start at the top of the address space.  */
+        end_addr = ((reserved_va - size) & -align) + size;
+        looped = true;
+    }
+
+    /* Search downward from END_ADDR, checking to see if a page is in use.  */
+    addr = end_addr;
     while (1) {
+        addr -= incr;
         if (addr > end_addr) {
             if (looped) {
+                /* Failure.  The entire address space has been searched.  */
                 return (abi_ulong)-1;
             }
-            end_addr = reserved_va;
-            addr = end_addr - qemu_host_page_size;
-            looped = 1;
-            continue;
+            /* Re-start at the top of the address space.  */
+            addr = end_addr = ((reserved_va - size) & -align) + size;
+            looped = true;
+        } else {
+            prot = page_get_flags(addr);
+            if (prot) {
+                /* Page in use.  Restart below this page.  */
+                addr = end_addr = ((addr - size) & -align) + size;
+            } else if (addr && addr + size == end_addr) {
+                /* Success!  All pages between ADDR and END_ADDR are free.  */
+                if (start == mmap_next_start) {
+                    mmap_next_start = addr;
+                }
+                return addr;
+            }
         }
-        prot = page_get_flags(addr);
-        if (prot) {
-            end_addr = addr;
-        }
-        if (addr && addr + size == end_addr) {
-            break;
-        }
-        addr -= qemu_host_page_size;
     }
-
-    if (start == mmap_next_start) {
-        mmap_next_start = addr;
-    }
-
-    return addr;
 }
 
 /*
@@ -253,7 +256,7 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size)
  * It must be called with mmap_lock() held.
  * Return -1 if error.
  */
-abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
+abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 {
     void *ptr, *prev;
     abi_ulong addr;
@@ -265,11 +268,12 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
     } else {
         start &= qemu_host_page_mask;
     }
+    start = ROUND_UP(start, align);
 
     size = HOST_PAGE_ALIGN(size);
 
     if (reserved_va) {
-        return mmap_find_vma_reserved(start, size);
+        return mmap_find_vma_reserved(start, size, align);
     }
 
     addr = start;
@@ -299,7 +303,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
         if (h2g_valid(ptr + size - 1)) {
             addr = h2g(ptr);
 
-            if ((addr & ~TARGET_PAGE_MASK) == 0) {
+            if ((addr & (align - 1)) == 0) {
                 /* Success.  */
                 if (start == mmap_next_start && addr >= TASK_UNMAPPED_BASE) {
                     mmap_next_start = addr + size;
@@ -313,12 +317,12 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
                 /* Assume the result that the kernel gave us is the
                    first with enough free space, so start again at the
                    next higher target page.  */
-                addr = TARGET_PAGE_ALIGN(addr);
+                addr = ROUND_UP(addr, align);
                 break;
             case 1:
                 /* Sometimes the kernel decides to perform the allocation
                    at the top end of memory instead.  */
-                addr &= TARGET_PAGE_MASK;
+                addr &= -align;
                 break;
             case 2:
                 /* Start over at low memory.  */
@@ -416,7 +420,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
     if (!(flags & MAP_FIXED)) {
         host_len = len + offset - host_offset;
         host_len = HOST_PAGE_ALIGN(host_len);
-        start = mmap_find_vma(real_start, host_len);
+        start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
             goto fail;
@@ -710,7 +714,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
     } else if (flags & MREMAP_MAYMOVE) {
         abi_ulong mmap_start;
 
-        mmap_start = mmap_find_vma(0, new_size);
+        mmap_start = mmap_find_vma(0, new_size, TARGET_PAGE_SIZE);
 
         if (mmap_start == -1) {
             errno = ENOMEM;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f960556bf8..1feb740f66 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3912,7 +3912,8 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
     else {
         abi_ulong mmap_start;
 
-        mmap_start = mmap_find_vma(0, shm_info.shm_segsz);
+        /* In order to use the host shmat, we need to honor host SHMLBA.  */
+        mmap_start = mmap_find_vma(0, shm_info.shm_segsz, MAX(SHMLBA, shmlba));
 
         if (mmap_start == -1) {
             errno = ENOMEM;
-- 
2.17.1


