Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829BDC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BF1207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rD8S9lV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BF1207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXuN-0007dq-GY
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX5I-00046M-OP
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX5H-0005Lu-7E
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:36 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:39837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX5H-0005LQ-3H; Mon, 06 Jan 2020 13:26:35 -0500
Received: by mail-qt1-x843.google.com with SMTP id e5so43200842qtm.6;
 Mon, 06 Jan 2020 10:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ccbDbqi5TpxjVO4gg8wa3OUyCmF9mr26PCOhgdDhY5Q=;
 b=rD8S9lV90nJR1aQdNOkFzLUnqDwG0zLCFCjl6ZJP1ejSDzVvYdE0laaNUwz9upVf5/
 g340pbGs05UsOrcLPF0FJ8TfXFK7TLju2U+OXUemAG0sIoZEVMKEAFlL3zS2nOLTt5+O
 0lQP7e+aTwhdpiUtNH+BjMwHwOT7AXRjphGTXOMCSKybRcnRdGv1064D1bUAKv41On8V
 URfWk4TbXSnjt+cH3poNEuMte6v1Tlf5bWj90f0qf+ZUVI7Ve46eRs1WzRGWEv9CR51A
 Ht8Y7M8NP1HBw42yX9/5iaFU+yHtowpqzU9yULWxVsQbIwV2hOzCn2sRXmzKeQe33CL9
 nZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ccbDbqi5TpxjVO4gg8wa3OUyCmF9mr26PCOhgdDhY5Q=;
 b=uYPCNre+wEdUVBh2To9LgHebPN8QQnJEFEtzgkldDOiX8NbG29CAtVGelkU7sLodUd
 r7xmTehMQzX5CfzrLDgCQMNSiNv24kZ5BMqFzK/4fKQhEWPFn+dHTPoGKh6v12cvvhKo
 o6NOCH0ef+3E7CFWLl1Kr4zrTBHmParHMd1nCRJH94kN27986kpzS9o1u0HQPKOaN+Ly
 dsBw3L3CbCkWcJMbVboCQ6n+PG/WKU9XGjABpKdS1V1w+9Su2pZeOvAIdw1npT6jzThH
 sRMAHIhW6lev1vDgm/pZ5FaIMEPFifSJobpkAAYcwYgwVkeHWWCpwvZeOwjobWxEMaNp
 IOMw==
X-Gm-Message-State: APjAAAXpAMtYQVDtBDSpJTY1e/l3dZoudnpBi2H0i4IARQ1HNJ1MEK4r
 UkrVWw6ZtJKR2GSUz4VdNrnhGHGZ
X-Google-Smtp-Source: APXvYqwxkipLwpEZ9rRAif+gDyZa4pKepNu5OkiSHk08Vsc1pqvhLLpe3mv8sCxBN8LfE8Q79xkxHg==
X-Received: by 2002:ac8:5215:: with SMTP id r21mr75442967qtn.77.1578335194548; 
 Mon, 06 Jan 2020 10:26:34 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:34 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 57/59] linux-user/syscall.c: fix trailing whitespaces and
 style
Date: Mon,  6 Jan 2020 15:24:23 -0300
Message-Id: <20200106182425.20312-58-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are trailing whitespaces in this file that, if removed
by a text editor that refuses to let the traiing whitespace
alone, which happens to be the editor I am using, will cause
checkpatch.pl to warn about styling problems in the resulting
patch. This happens because the trailing whitespace lines
are using a deprecated style.

To keep the intended change I wanted to do (remove unneeded
labels in do_ioctl_blkpg() and do_sendrecvmsg_locked())
trivial, this patch is another trivial change to fix the
trailing whitespaces and the code style errors that
checkpatch.pl warns about. Doing this change beforehand will
keep the next patch focused just on the label removal changes.

CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 linux-user/syscall.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 171c0caef3..49c6151c2d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1062,7 +1062,7 @@ static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
 {
     abi_ulong target_rlim_swap;
     rlim_t result;
-    
+
     target_rlim_swap = tswapal(target_rlim);
     if (target_rlim_swap == TARGET_RLIM_INFINITY)
         return RLIM_INFINITY;
@@ -1070,7 +1070,7 @@ static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
     result = target_rlim_swap;
     if (target_rlim_swap != (rlim_t)result)
         return RLIM_INFINITY;
-    
+
     return result;
 }
 
@@ -1078,13 +1078,13 @@ static inline abi_ulong host_to_target_rlim(rlim_t rlim)
 {
     abi_ulong target_rlim_swap;
     abi_ulong result;
-    
+
     if (rlim == RLIM_INFINITY || rlim != (abi_long)rlim)
         target_rlim_swap = TARGET_RLIM_INFINITY;
     else
         target_rlim_swap = rlim;
     result = tswapal(target_rlim_swap);
-    
+
     return result;
 }
 
@@ -1526,10 +1526,11 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
     abi_ulong target_cmsg_addr;
     struct target_cmsghdr *target_cmsg, *target_cmsg_start;
     socklen_t space = 0;
-    
+
     msg_controllen = tswapal(target_msgh->msg_controllen);
-    if (msg_controllen < sizeof (struct target_cmsghdr)) 
+    if (msg_controllen < sizeof(struct target_cmsghdr)) {
         goto the_end;
+    }
     target_cmsg_addr = tswapal(target_msgh->msg_control);
     target_cmsg = lock_user(VERIFY_READ, target_cmsg_addr, msg_controllen, 1);
     target_cmsg_start = target_cmsg;
@@ -1610,8 +1611,9 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
     socklen_t space = 0;
 
     msg_controllen = tswapal(target_msgh->msg_controllen);
-    if (msg_controllen < sizeof (struct target_cmsghdr)) 
+    if (msg_controllen < sizeof(struct target_cmsghdr)) {
         goto the_end;
+    }
     target_cmsg_addr = tswapal(target_msgh->msg_control);
     target_cmsg = lock_user(VERIFY_WRITE, target_cmsg_addr, msg_controllen, 0);
     target_cmsg_start = target_cmsg;
@@ -5592,9 +5594,9 @@ abi_long do_set_thread_area(CPUX86State *env, abi_ulong ptr)
     }
     unlock_user_struct(target_ldt_info, ptr, 1);
 
-    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN || 
+    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN ||
         ldt_info.entry_number > TARGET_GDT_ENTRY_TLS_MAX)
-           return -TARGET_EINVAL;
+        return -TARGET_EINVAL;
     seg_32bit = ldt_info.flags & 1;
     contents = (ldt_info.flags >> 1) & 3;
     read_exec_only = (ldt_info.flags >> 3) & 1;
@@ -5670,7 +5672,7 @@ static abi_long do_get_thread_area(CPUX86State *env, abi_ulong ptr)
     lp = (uint32_t *)(gdt_table + idx);
     entry_1 = tswap32(lp[0]);
     entry_2 = tswap32(lp[1]);
-    
+
     read_exec_only = ((entry_2 >> 9) & 1) ^ 1;
     contents = (entry_2 >> 10) & 3;
     seg_not_present = ((entry_2 >> 15) & 1) ^ 1;
@@ -5686,8 +5688,8 @@ static abi_long do_get_thread_area(CPUX86State *env, abi_ulong ptr)
         (read_exec_only << 3) | (limit_in_pages << 4) |
         (seg_not_present << 5) | (useable << 6) | (lm << 7);
     limit = (entry_1 & 0xffff) | (entry_2  & 0xf0000);
-    base_addr = (entry_1 >> 16) | 
-        (entry_2 & 0xff000000) | 
+    base_addr = (entry_1 >> 16) |
+        (entry_2 & 0xff000000) |
         ((entry_2 & 0xff) << 16);
     target_ldt_info->base_addr = tswapal(base_addr);
     target_ldt_info->limit = tswap32(limit);
@@ -10554,8 +10556,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return get_errno(fchown(arg1, low2highuid(arg2), low2highgid(arg3)));
 #if defined(TARGET_NR_fchownat)
     case TARGET_NR_fchownat:
-        if (!(p = lock_user_string(arg2))) 
+        p = lock_user_string(arg2);
+        if (!p) {
             return -TARGET_EFAULT;
+        }
         ret = get_errno(fchownat(arg1, p, low2highuid(arg3),
                                  low2highgid(arg4), arg5));
         unlock_user(p, arg2, 0);
-- 
2.24.1


