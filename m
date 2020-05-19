Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A06AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD01206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nU8DUN0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD01206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb7Qz-0001qZ-5o
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb7Q4-0000GZ-Kj
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:56:52 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb7Q3-0000DG-Fj
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:56:52 -0400
Received: by mail-pj1-x1041.google.com with SMTP id n15so78891pjt.4
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uJwFYzyoN3vgk+NTWo7JdhHFzW99tliQq1czlI7p5IU=;
 b=nU8DUN0wCoVUvDiyOzBqlkGfP1TNjZzTWi4e9m+cXW+dmUAUDEqW9T8y4zLc+y96fS
 kIa6zG54SkSJnAN80PqbeXkct0GNqk1UCSOesJk80BSVp7UfMkKqqqwj1Q1p/1PTPVc4
 83pL/a788/ptXlMlaussSMYeh+y4QbRG9Y2umR6S0gRplAZHft/DgbW+IIAO07u/qbhC
 G0mZ79oIdcSL8zvN7Y4xYc7v3DIBTn4tCpWNT4XzlAH/h//jM5sW3DfZG85QogTwgc4u
 Qn9+fUTV3S1WKsSbqRdvyYu7FtsNd0uVMzbDC/ojky40LLBGeJ/AWZLmdZzWo7exDIO+
 jNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uJwFYzyoN3vgk+NTWo7JdhHFzW99tliQq1czlI7p5IU=;
 b=XtJige6G3h13XiWOG2IH8Df8HcSJWV4tf27HPraoFqPffpz6z9UzLZjv5e0T62Xxtb
 TqVx8vajNLMitVFcH20HvrE8t+/dFstkNNGE0OXHir5CEh3VOTT01fHh2VUqezfqxVsK
 0iL0DPQl0jU2G1iCZZEAG/vOGw4kpKZ5d6fboRjD6Wg85oOVAMgmQhylus3TtoAnZQA4
 bMBG/kAbVXdQNZyqore9AnIuSJyVruY08B736hVNtx3Qpc5HbNQ4nW0QoYb0PYiXRl0F
 H7S1VmoufSG4u3owCLreWmsEZHApGdqbPAS0h4kuQlL6ScDh/vHLsEMSIHgyuW31opR5
 NJ4Q==
X-Gm-Message-State: AOAM532E+91OchePV+uLh3huqMZ2yMNPuskfOyM76ImCn26TJZBAOIUS
 3vnuPBeAKTqRlH93h5VxL7pG1FTcdc8=
X-Google-Smtp-Source: ABdhPJz1eEq6x+Yi6rNedk1BBcamYshKjeolpPEWFAuhZiil4q0ESdJludvH6eSZMtSupper5TbYXw==
X-Received: by 2002:a17:90a:f40f:: with SMTP id
 ch15mr1047945pjb.178.1589914607857; 
 Tue, 19 May 2020 11:56:47 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b5sm237658pju.50.2020.05.19.11.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:56:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] linux-user: Validate mmap/mprotect prot value
Date: Tue, 19 May 2020 11:56:44 -0700
Message-Id: <20200519185645.3915-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519185645.3915-1-richard.henderson@linaro.org>
References: <20200519185645.3915-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel will return -EINVAL for bits set in the prot argument
that are unknown or invalid.  Previously we were simply cropping
out the bits that we care about.

Introduce validate_prot_to_pageflags to perform this check in a
single place between the two syscalls.  Differentiate between
the target and host versions of prot.  Compute the qemu internal
page_flags value at the same time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 106 +++++++++++++++++++++++++++++++---------------
 1 file changed, 73 insertions(+), 33 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index e378033797..36fd1e2250 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -59,64 +59,96 @@ void mmap_fork_end(int child)
         pthread_mutex_unlock(&mmap_mutex);
 }
 
+/*
+ * Validate target prot bitmask.
+ * Return the prot bitmask for the host in *HOST_PROT.
+ * Return 0 if the target prot bitmask is invalid, otherwise
+ * the internal qemu page_flags (which will include PAGE_VALID).
+ */
+static int validate_prot_to_pageflags(int *host_prot, int prot)
+{
+    int valid = PROT_READ | PROT_WRITE | PROT_EXEC | TARGET_PROT_SEM;
+    int page_flags = (prot & PAGE_BITS) | PAGE_VALID;
+
+    /*
+     * For the host, we need not pass anything except read/write/exec.
+     * While PROT_SEM is allowed by all hosts, it is also ignored, so
+     * don't bother transforming guest bit to host bit.  Any other
+     * target-specific prot bits will not be understood by the host
+     * and will need to be encoded into page_flags for qemu emulation.
+     */
+    *host_prot = prot & (PROT_READ | PROT_WRITE | PROT_EXEC);
+
+    return prot & ~valid ? 0 : page_flags;
+}
+
 /* NOTE: all the constants are the HOST ones, but addresses are target. */
-int target_mprotect(abi_ulong start, abi_ulong len, int prot)
+int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 {
     abi_ulong end, host_start, host_end, addr;
-    int prot1, ret;
+    int prot1, ret, page_flags, host_prot;
 
-    trace_target_mprotect(start, len, prot);
+    trace_target_mprotect(start, len, target_prot);
 
-    if ((start & ~TARGET_PAGE_MASK) != 0)
+    if ((start & ~TARGET_PAGE_MASK) != 0) {
         return -TARGET_EINVAL;
+    }
+    page_flags = validate_prot_to_pageflags(&host_prot, target_prot);
+    if (!page_flags) {
+        return -TARGET_EINVAL;
+    }
     len = TARGET_PAGE_ALIGN(len);
     end = start + len;
     if (!guest_range_valid(start, len)) {
         return -TARGET_ENOMEM;
     }
-    prot &= PROT_READ | PROT_WRITE | PROT_EXEC;
-    if (len == 0)
+    if (len == 0) {
         return 0;
+    }
 
     mmap_lock();
     host_start = start & qemu_host_page_mask;
     host_end = HOST_PAGE_ALIGN(end);
     if (start > host_start) {
         /* handle host page containing start */
-        prot1 = prot;
-        for(addr = host_start; addr < start; addr += TARGET_PAGE_SIZE) {
+        prot1 = host_prot;
+        for (addr = host_start; addr < start; addr += TARGET_PAGE_SIZE) {
             prot1 |= page_get_flags(addr);
         }
         if (host_end == host_start + qemu_host_page_size) {
-            for(addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
+            for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
                 prot1 |= page_get_flags(addr);
             }
             end = host_end;
         }
-        ret = mprotect(g2h(host_start), qemu_host_page_size, prot1 & PAGE_BITS);
-        if (ret != 0)
+        ret = mprotect(g2h(host_start), qemu_host_page_size,
+                       prot1 & PAGE_BITS);
+        if (ret != 0) {
             goto error;
+        }
         host_start += qemu_host_page_size;
     }
     if (end < host_end) {
-        prot1 = prot;
-        for(addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
+        prot1 = host_prot;
+        for (addr = end; addr < host_end; addr += TARGET_PAGE_SIZE) {
             prot1 |= page_get_flags(addr);
         }
-        ret = mprotect(g2h(host_end - qemu_host_page_size), qemu_host_page_size,
-                       prot1 & PAGE_BITS);
-        if (ret != 0)
+        ret = mprotect(g2h(host_end - qemu_host_page_size),
+                       qemu_host_page_size, prot1 & PAGE_BITS);
+        if (ret != 0) {
             goto error;
+        }
         host_end -= qemu_host_page_size;
     }
 
     /* handle the pages in the middle */
     if (host_start < host_end) {
-        ret = mprotect(g2h(host_start), host_end - host_start, prot);
-        if (ret != 0)
+        ret = mprotect(g2h(host_start), host_end - host_start, host_prot);
+        if (ret != 0) {
             goto error;
+        }
     }
-    page_set_flags(start, start + len, prot | PAGE_VALID);
+    page_set_flags(start, start + len, page_flags);
     mmap_unlock();
     return 0;
 error:
@@ -360,19 +392,26 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 }
 
 /* NOTE: all the constants are the HOST ones */
-abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
+abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                      int flags, int fd, abi_ulong offset)
 {
     abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host_len;
+    int page_flags, host_prot;
 
     mmap_lock();
-    trace_target_mmap(start, len, prot, flags, fd, offset);
+    trace_target_mmap(start, len, target_prot, flags, fd, offset);
 
     if (!len) {
         errno = EINVAL;
         goto fail;
     }
 
+    page_flags = validate_prot_to_pageflags(&host_prot, target_prot);
+    if (!page_flags) {
+        errno = EINVAL;
+        goto fail;
+    }
+
     /* Also check for overflows... */
     len = TARGET_PAGE_ALIGN(len);
     if (!len) {
@@ -438,14 +477,15 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         /* Note: we prefer to control the mapping address. It is
            especially important if qemu_host_page_size >
            qemu_real_host_page_size */
-        p = mmap(g2h(start), host_len, prot,
+        p = mmap(g2h(start), host_len, host_prot,
                  flags | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
-        if (p == MAP_FAILED)
+        if (p == MAP_FAILED) {
             goto fail;
+        }
         /* update start so that it points to the file position at 'offset' */
         host_start = (unsigned long)p;
         if (!(flags & MAP_ANONYMOUS)) {
-            p = mmap(g2h(start), len, prot,
+            p = mmap(g2h(start), len, host_prot,
                      flags | MAP_FIXED, fd, host_offset);
             if (p == MAP_FAILED) {
                 munmap(g2h(start), host_len);
@@ -479,19 +519,19 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
             /* msync() won't work here, so we return an error if write is
                possible while it is a shared mapping */
             if ((flags & MAP_TYPE) == MAP_SHARED &&
-                (prot & PROT_WRITE)) {
+                (host_prot & PROT_WRITE)) {
                 errno = EINVAL;
                 goto fail;
             }
-            retaddr = target_mmap(start, len, prot | PROT_WRITE,
+            retaddr = target_mmap(start, len, target_prot | PROT_WRITE,
                                   MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS,
                                   -1, 0);
             if (retaddr == -1)
                 goto fail;
             if (pread(fd, g2h(start), len, offset) == -1)
                 goto fail;
-            if (!(prot & PROT_WRITE)) {
-                ret = target_mprotect(start, len, prot);
+            if (!(host_prot & PROT_WRITE)) {
+                ret = target_mprotect(start, len, target_prot);
                 assert(ret == 0);
             }
             goto the_end;
@@ -502,13 +542,13 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
             if (real_end == real_start + qemu_host_page_size) {
                 /* one single host page */
                 ret = mmap_frag(real_start, start, end,
-                                prot, flags, fd, offset);
+                                host_prot, flags, fd, offset);
                 if (ret == -1)
                     goto fail;
                 goto the_end1;
             }
             ret = mmap_frag(real_start, start, real_start + qemu_host_page_size,
-                            prot, flags, fd, offset);
+                            host_prot, flags, fd, offset);
             if (ret == -1)
                 goto fail;
             real_start += qemu_host_page_size;
@@ -517,7 +557,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         if (end < real_end) {
             ret = mmap_frag(real_end - qemu_host_page_size,
                             real_end - qemu_host_page_size, end,
-                            prot, flags, fd,
+                            host_prot, flags, fd,
                             offset + real_end - qemu_host_page_size - start);
             if (ret == -1)
                 goto fail;
@@ -533,13 +573,13 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
             else
                 offset1 = offset + real_start - start;
             p = mmap(g2h(real_start), real_end - real_start,
-                     prot, flags, fd, offset1);
+                     host_prot, flags, fd, offset1);
             if (p == MAP_FAILED)
                 goto fail;
         }
     }
  the_end1:
-    page_set_flags(start, start + len, prot | PAGE_VALID);
+    page_set_flags(start, start + len, page_flags);
  the_end:
     trace_target_mmap_complete(start);
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
-- 
2.20.1


