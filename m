Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE653C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95644206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95644206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38046 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToyj-0005Z7-Rl
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:45:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTox1-0004Kq-0p
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTowz-0006Me-DT
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:10 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53799)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTowz-0006Lj-49
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:09 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1N17l4-1gVmX23mPq-012bag; Thu, 23 May 2019 16:43:47 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:43:34 +0200
Message-Id: <20190523144336.13960-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523144336.13960-1-laurent@vivier.eu>
References: <20190523144336.13960-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RfUqtwaq+SNTjIfAEcu3U45jOpyRrW+Lr1Rq/nN6AvmHsV2Av3x
	3DhBtn7CdObLTJ2Sput6MQwePPrgXLX6+uwTfdRA0BemS98RAyA9R9DIoQvheYPPy4sSA59
	MdApKaTjGjLeGHwqKeoWPla5pAMQn8UABonv8pXYnhsx3AmWUvIqssSUxfy8GtAKm6GtwhC
	bIT6L1bNxB/OSE9gwgREg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F+deb7E1NZ4=:Tq+MUOeXS9AUMRBpdloGWo
	v5389u/hF2NDXvxJfbDY6S4qZfagoo3YfPpvHlj6yvuuC3f+AKSWIPpsl3MuKMpBFPq29WiUZ
	HD6a5NuzLwIPA/eiN7PMV90ljhDpRtbe+dE9JK5Oy0rfxrdcPW7NS/wryJQqDPcJTuBrfVfRj
	g5tfAZjhE29BU0Ag9/YmRznmIUQoHWEJsg7fB3AF50Lw96PcV+TB72tnlQJ1SLa7D42QZJ15T
	Pei+N7lUttiGZCUE6ITOW7UX+BBUYUbjP63zTQ6ZEya4AZhkj6aK61qQ409vgKCPlLOxWn4ik
	ZntBJ2BNGV25JBmIJNHDPbNBCTC4Ia+8Cuem1qXrDxGmLktObbYaG/AbomPYMRyF0euhYx+VQ
	WripoieG3pc4T3mEWkVyaPwLIhi9TONMh8LInPkpAKatYAvnnIJHkXrfaU8CNDnmFUkIbe6uw
	bivqG8nrIbXi/tzYJS0RQychaPt4j/Ior+0rH0npGNuSupomZ9wcMrJE/HRKJwD8FIHX21oJ5
	fo134AqQabYf1mhui4+x744ER0hAwVSsgJwCxTUDNwGfb7+W38SREAhlsC4JnXZ29HXRJGF8K
	/sXwAk0fK51RKwWOpkwwJDeuKygsCtTu2G3YLlzSS9xwXR9GdYXL54wOAcb+/MSgAMBuWlfz+
	ztQBDjOE7DYTvaNOXV/yaBJsNd0naNcADJ570seQxDP8DI11zoeeDruW1Y6FhluhAB1Tmtz99
	gJdOVN4NCnTHXp/E+4070nOMzz5hsxjX6AQRMQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PULL 08/10] linux-user: Fix shmat emulation by
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
	Richard Henderson <richard.henderson@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

For those hosts with SHMLBA > getpagesize, we don't automatically
select a guest address that is compatible with the host.  We can
achieve this by boosting the alignment of guest_base and by adding
an extra alignment argument to mmap_find_vma.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190519201953.20161-13-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 17 ++++++-----
 linux-user/mmap.c    | 70 +++++++++++++++++++++++---------------------
 linux-user/qemu.h    |  2 +-
 linux-user/syscall.c |  3 +-
 4 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 02832adfbc0c..a23aa4493e72 100644
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
index e0249efe4fed..10796b37ac7b 100644
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
+    /* Note that start and size have already been aligned by mmap_find_vma. */
+
     end_addr = start + size;
-    if (end_addr > reserved_va) {
-        end_addr = reserved_va;
+    if (start > reserved_va - size) {
+        /* Start at the top of the address space.  */
+        end_addr = ((reserved_va - size) & -align) + size;
+        looped = true;
     }
-    addr = end_addr - qemu_host_page_size;
 
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
-        }
-        prot = page_get_flags(addr);
-        if (prot) {
-            end_addr = addr;
-        }
-        if (addr && addr + size == end_addr) {
-            break;
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
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index ef400cb78ac6..82d33d7e93d5 100644
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
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a0c2bf7db43c..e43255c29e56 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3935,7 +3935,8 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
     else {
         abi_ulong mmap_start;
 
-        mmap_start = mmap_find_vma(0, shm_info.shm_segsz);
+        /* In order to use the host shmat, we need to honor host SHMLBA.  */
+        mmap_start = mmap_find_vma(0, shm_info.shm_segsz, MAX(SHMLBA, shmlba));
 
         if (mmap_start == -1) {
             errno = ENOMEM;
-- 
2.20.1


