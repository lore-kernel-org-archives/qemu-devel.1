Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3438C35641
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 01:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE67C2071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 01:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V0AJGBZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE67C2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5JJm-0005jW-RO
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 20:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59611)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3Tn9QXgYKCoc95lyAtrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--yuanzi.bounces.google.com>)
 id 1j5JIX-0004PT-Vi
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 20:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3Tn9QXgYKCoc95lyAtrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--yuanzi.bounces.google.com>)
 id 1j5JIW-0007GN-Nw
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 20:09:37 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649]:49571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3Tn9QXgYKCoc95lyAtrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--yuanzi.bounces.google.com>)
 id 1j5JIW-0007Fo-G8
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 20:09:36 -0500
Received: by mail-pl1-x649.google.com with SMTP id w17so2114258plq.16
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 17:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=IPQGrQZvhAVz0CMsHJCJGfpioyE2Bf7rrjMbPG/+q4w=;
 b=V0AJGBZe5Fj4mM2MGmKdci64gEjR3Srxj2sp+1WG2k/I86aCkiBTN1CUz2ihQpeXKc
 OfagAhLpGniCKp6TlZKLuX3rhp1EP+pnSlyzm68i84IbG6+SACB3iBH5oU+Py9QQzPzh
 bopHyuU/B8TIOy/t3qFHFUrp/rt9P1qszXjBZr2rRTtzhroKBvgwXsLEpZlu0xjvVu2h
 VpdJUzTeZ2FBRuGVda9x5cZ7RI9110iyw9FatZpTQ504HU72ISwzvIb/PWHDp3TRI94x
 jnqdoj+73ukFWftPOonxacMmGPumtZXM6YIhONMs4+WUQ7znrcpv2elBF6Rf8OmlUHSC
 jUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=IPQGrQZvhAVz0CMsHJCJGfpioyE2Bf7rrjMbPG/+q4w=;
 b=Pnoc7X/AEZkik1QXg+OMGYmc3jPFaxqvfkIDD/9QexqYHwJ21NHNFNiOgc1wnk8cNg
 0DXVTS7YfN9n/X5GoiLCCdErcaQHix9ynuyn16Yaw+Ff7d2kntSgk6ijuVmw9LbZ33vx
 8AzHqI/oSprtUfl3POcN2wjf5lxLf/yIUqAhJUGXcHQUlU/7ujbKoXS8TWH5/jktREgJ
 lmwzVqld0UqIgpKluy5EbFbLvtJKG0IFIL5sOkb3e509BjPHrQQsC7K01rLfgWa4Pgwt
 zwrfRL1Zmi8fXh8j2QtpbSfkoyVfVA1+wEiG6WJ0DadEKJYQK8f+Hjc85qnA9djNjdFT
 XAoQ==
X-Gm-Message-State: APjAAAU6BCjxi12dQOPvKVWlWBihLZ41cN5NAFUTCAclbh9UCC5SSz1N
 l0AgX2lgL9pRTSIAGbpvHtmoSIBnDeJnMkyOQT0iutZ7Myks3uilGN1rB63tALFgnjjNYIIYUgZ
 /a5hxn2U0+Uq84k0pqdk+nVYWSChdGl2nci8n7Y0a6cYOsABzaQgDP291T9SA
X-Google-Smtp-Source: APXvYqzLyJbBGJPDEELM/tnm0Gbd5huliVOlizwLTgYKttqEYg1WQs2TvWvaO9OEBNlG4xIKQkIxBAaG2QU=
X-Received: by 2002:a63:7e56:: with SMTP id o22mr16265407pgn.136.1582333774523; 
 Fri, 21 Feb 2020 17:09:34 -0800 (PST)
Date: Fri, 21 Feb 2020 17:09:25 -0800
Message-Id: <20200222010925.32858-1-yuanzi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] linux-user: Add an argument QEMU_MMAP_BASE to set custom mmap
 base address in qemu user mode
From: Lirong Yuan <yuanzi@google.com>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Lirong Yuan <yuanzi@google.com>, Riku Voipio <riku.voipio@iki.fi>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::649
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

This change allows us to set custom base address for guest programs. It is needed to allow qemu to work with Thread Sanitizer (TSan), which has specific boundary definitions for memory mappings on different platforms:
https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl/tsan_platform.h

Signed-off-by: Lirong Yuan <yuanzi@google.com>
---
 linux-user/main.c | 12 ++++++++++++
 linux-user/mmap.c |  3 ++-
 linux-user/qemu.h |  5 +++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index fba833aac9..c01af6bfee 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -336,6 +336,16 @@ static void handle_arg_guest_base(const char *arg)
     have_guest_base = 1;
 }
 
+static void handle_arg_mmap_base(const char *arg)
+{
+    int err = qemu_strtoul(arg, NULL, 0, &mmap_base);
+    if (err) {
+        fprintf(stderr, "Invalid mmap_base: %s, err: %d\n", arg, err);
+        exit(EXIT_FAILURE);
+    }
+    mmap_next_start = mmap_base;
+}
+
 static void handle_arg_reserved_va(const char *arg)
 {
     char *p;
@@ -440,6 +450,8 @@ static const struct qemu_argument arg_table[] = {
      "uname",      "set qemu uname release string to 'uname'"},
     {"B",          "QEMU_GUEST_BASE",  true,  handle_arg_guest_base,
      "address",    "set guest_base address to 'address'"},
+    {"mmap_base",  "QEMU_MMAP_BASE",   true,  handle_arg_mmap_base,
+     "",           "begin allocating guest pages at this host address"},
     {"R",          "QEMU_RESERVED_VA", true,  handle_arg_reserved_va,
      "size",       "reserve 'size' bytes for guest virtual address space"},
     {"d",          "QEMU_LOG",         true,  handle_arg_log,
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 8685f02e7e..3f35543acf 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -189,6 +189,7 @@ static int mmap_frag(abi_ulong real_start,
 # define TASK_UNMAPPED_BASE  0x40000000
 #endif
 abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
+abi_ulong mmap_base = TASK_UNMAPPED_BASE;
 
 unsigned long last_brk;
 
@@ -299,7 +300,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 
             if ((addr & (align - 1)) == 0) {
                 /* Success.  */
-                if (start == mmap_next_start && addr >= TASK_UNMAPPED_BASE) {
+                if (start == mmap_next_start && addr >= mmap_base) {
                     mmap_next_start = addr + size;
                 }
                 return addr;
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 560a68090e..83c00cfea2 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -161,6 +161,11 @@ void task_settid(TaskState *);
 void stop_all_tasks(void);
 extern const char *qemu_uname_release;
 extern unsigned long mmap_min_addr;
+/*
+ * mmap_base is minimum address to use when allocating guest pages. All guest
+ * pages will be allocated at this (guest) address or higher addresses.
+ */
+extern abi_ulong mmap_base;
 
 /* ??? See if we can avoid exposing so much of the loader internals.  */
 
-- 
2.25.0.265.gbab2e86ba0-goog


