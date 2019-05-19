Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A22C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A689420675
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDiAzAWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A689420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53581 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hST4h-0005ZH-Rh
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:10:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZi-0003ie-Qj
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZh-0004X3-BL
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:30 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZh-0004W5-1T
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:29 -0400
Received: by mail-pg1-x542.google.com with SMTP id z16so5724088pgv.11
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=AI0qmlYjgj5NtbNVWKgQPuyo9CkZotUm28Hs9oy8FWY=;
	b=WDiAzAWBoYrx+T/f1r514LVxPvjELJd8UIHCR8Cr8GWYn5WVntha55DkeNUQE2z2we
	MUbkuYQJaFCBtmdTgMwFMXQ2X7B90J1yR5s6SH7Wi1RUTybLjBW8goKWVwx8bYaWYgue
	/GwLb2E3sSQaxM54uduTRpK2wCApQob7Bzz0+mZ7aLegGqB1TlZrif2klOcWj536pjxb
	b+D6ziPYs4LyMAdkfXVWP0/82RHPlVtj/fLTMHroupF0IE3Ee4jez40ZB7A0e2EsGN4R
	iQPYXqjqlvNjUcVV4iMz7yYqHtvjCBO9mmOj/024MkRRBcjR+gYroI/d0urevPElf53n
	LH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=AI0qmlYjgj5NtbNVWKgQPuyo9CkZotUm28Hs9oy8FWY=;
	b=D0YHcSGPTEDdcxVmrbhUlY3vjmj/oLB2ZtoNWE4iJdVtBjuAZU9ONv0Yyi93glDK/R
	Z/x6HJdhPo4Gf8UKQX4+nQf2wycJZrc+hyDiHVgE4O7MbxwG2TqAbb5d8vNVJxMEu0rr
	VjB6mF/y9Lsp8Vma2Z8ic3ZxuvYzg1Hrz2aNt9Ig48Hvx+cFhHT4aJHufaIE/WSPLVAB
	xDTpYkjyCVHUhdBBC54nYf1V9EDck05bg2HQxAjWvYUIH3WM0ge3pgmwol6irkZrsi7x
	kvKGXsmetBif8uP0hwVH3TxH7UHjD7Z7HbHA0wYjpWa+HXeFUB3aJUUiPksEZTjTAkPp
	GhSg==
X-Gm-Message-State: APjAAAUVjXgH6Tkd+/kYVlnglU54KfpwoOfzZwwkghmG75tksGBogSqV
	RbAfDyXSpwLJfn12DCr4Hi1EUBBoDDI=
X-Google-Smtp-Source: APXvYqyYvwesz+zi/r1Hku7Djj+p9gxszWayC2IFmPn32fI9Kr3eRrOgkNaGOxDNevmaaU8yBtqgHw==
X-Received: by 2002:a63:4346:: with SMTP id q67mr71033800pga.241.1558298307785;
	Sun, 19 May 2019 13:38:27 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:58 -0700
Message-Id: <20190519203726.20729-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v7 46/74] linux-user: Move syscall_init to the
 end
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

No functional change.  This will aid moving everything
related to ioctls to a separate file.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 113 +++++++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 52 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5343486a58..d0e76c392e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4831,58 +4831,6 @@ _syscall1(int, sys_setgid, gid_t, gid)
 _syscall3(int, sys_setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
 _syscall3(int, sys_setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid)
 
-void syscall_init(void)
-{
-    IOCTLEntry *ie;
-    const argtype *arg_type;
-    int size;
-    int i;
-
-    thunk_init(STRUCT_MAX);
-
-#define STRUCT(name, ...) thunk_register_struct(STRUCT_ ## name, #name, struct_ ## name ## _def);
-#define STRUCT_SPECIAL(name) thunk_register_struct_direct(STRUCT_ ## name, #name, &struct_ ## name ## _def);
-#include "syscall_types.h"
-#undef STRUCT
-#undef STRUCT_SPECIAL
-
-    /* Build target_to_host_errno_table[] table from
-     * host_to_target_errno_table[]. */
-    for (i = 0; i < ERRNO_TABLE_SIZE; i++) {
-        target_to_host_errno_table[host_to_target_errno_table[i]] = i;
-    }
-
-    /* we patch the ioctl size if necessary. We rely on the fact that
-       no ioctl has all the bits at '1' in the size field */
-    ie = ioctl_entries;
-    while (ie->target_cmd != 0) {
-        if (((ie->target_cmd >> TARGET_IOC_SIZESHIFT) & TARGET_IOC_SIZEMASK) ==
-            TARGET_IOC_SIZEMASK) {
-            arg_type = ie->arg_type;
-            if (arg_type[0] != TYPE_PTR) {
-                fprintf(stderr, "cannot patch size for ioctl 0x%x\n",
-                        ie->target_cmd);
-                exit(1);
-            }
-            arg_type++;
-            size = thunk_type_size(arg_type, 0);
-            ie->target_cmd = (ie->target_cmd &
-                              ~(TARGET_IOC_SIZEMASK << TARGET_IOC_SIZESHIFT)) |
-                (size << TARGET_IOC_SIZESHIFT);
-        }
-
-        /* automatic consistency check if same arch */
-#if (defined(__i386__) && defined(TARGET_I386) && defined(TARGET_ABI32)) || \
-    (defined(__x86_64__) && defined(TARGET_X86_64))
-        if (unlikely(ie->target_cmd != ie->host_cmd)) {
-            fprintf(stderr, "ERROR: ioctl(%s): target=0x%x host=0x%x\n",
-                    ie->name, ie->target_cmd, ie->host_cmd);
-        }
-#endif
-        ie++;
-    }
-}
-
 static inline uint64_t target_offset64(abi_ulong word0, abi_ulong word1)
 {
 #if TARGET_ABI_BITS == 64
@@ -9072,3 +9020,64 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     trace_guest_user_syscall_ret(cpu, num, ret);
     return ret;
 }
+
+void syscall_init(void)
+{
+    IOCTLEntry *ie;
+    const argtype *arg_type;
+    int size;
+    int i;
+
+    thunk_init(STRUCT_MAX);
+
+#define STRUCT(name, ...) \
+    thunk_register_struct(STRUCT_ ## name, #name, struct_ ## name ## _def);
+#define STRUCT_SPECIAL(name) \
+    thunk_register_struct_direct(STRUCT_ ## name, #name, \
+                                 &struct_ ## name ## _def);
+
+#include "syscall_types.h"
+
+#undef STRUCT
+#undef STRUCT_SPECIAL
+
+    /*
+     * Build target_to_host_errno_table[] table from
+     * host_to_target_errno_table[].
+     */
+    for (i = 0; i < ERRNO_TABLE_SIZE; i++) {
+        target_to_host_errno_table[host_to_target_errno_table[i]] = i;
+    }
+
+    /*
+     * We patch the ioctl size if necessary.  We rely on the fact that
+     * no ioctl has all the bits at '1' in the size field.
+     */
+    ie = ioctl_entries;
+    while (ie->target_cmd != 0) {
+        if (((ie->target_cmd >> TARGET_IOC_SIZESHIFT) & TARGET_IOC_SIZEMASK) ==
+            TARGET_IOC_SIZEMASK) {
+            arg_type = ie->arg_type;
+            if (arg_type[0] != TYPE_PTR) {
+                fprintf(stderr, "cannot patch size for ioctl 0x%x\n",
+                        ie->target_cmd);
+                exit(1);
+            }
+            arg_type++;
+            size = thunk_type_size(arg_type, 0);
+            ie->target_cmd = (ie->target_cmd &
+                              ~(TARGET_IOC_SIZEMASK << TARGET_IOC_SIZESHIFT)) |
+                (size << TARGET_IOC_SIZESHIFT);
+        }
+
+        /* automatic consistency check if same arch */
+#if (defined(__i386__) && defined(TARGET_I386) && defined(TARGET_ABI32)) || \
+    (defined(__x86_64__) && defined(TARGET_X86_64))
+        if (unlikely(ie->target_cmd != ie->host_cmd)) {
+            fprintf(stderr, "ERROR: ioctl(%s): target=0x%x host=0x%x\n",
+                    ie->name, ie->target_cmd, ie->host_cmd);
+        }
+#endif
+        ie++;
+    }
+}
-- 
2.17.1


