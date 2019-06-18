Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A95C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454D320B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NR6zz/KD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454D320B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdO7U-0004Ql-Bq
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 20:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40765)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jimw@sifive.com>) id 1hdO5p-0003Dy-71
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jimw@sifive.com>) id 1hdNvR-0005RI-Ni
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 19:54:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42330)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jimw@sifive.com>) id 1hdNvR-0005Pv-E0
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 19:54:05 -0400
Received: by mail-pg1-x541.google.com with SMTP id l19so8523929pgh.9
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 16:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=WMwe6Qit41WmqA64gKLcpXQW1KrnLGT5GUWMAd3rSnk=;
 b=NR6zz/KDnvs8icAu4hTDe72z+rf4oG83GHPG2/iutwCK2kwQ/NMmaWBq34aDLtWspH
 ABAzufpBzLuqyKOXZehamRE40iAhYQvnmmoc2kCaxAE0QzyO/lTHOU7bsDRAnBeOY3zq
 au72pOlo824UPAUMCdQaeKJRNuoYfyhl4K2/IndYupf6DvtAxLMzNRlvs5miQdKz7ZSq
 QUNa1txs6P5x8Nb13C8AyDU28w0OfYv9n7CIsAUtGp3sIQdX6khELj0Qs1c1DDghh3vQ
 lX3B+GnFOzA8rQe7lLhu5OK32D3kUa48arO7LV78oSNi/eO5drpBxnTvxScfdWmE0U0B
 gWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=WMwe6Qit41WmqA64gKLcpXQW1KrnLGT5GUWMAd3rSnk=;
 b=Y73qWtcdHDE4UN9KVlIvsPNexy7g/MgKhp/UCQxQIKPd7CDYSm54xsOr8ODKnvijFP
 RW8RSP/GXWcNwtY5CmOLCOZ05Ue3qttotjDOMJMnrx0J4IPhDAQ9MRNR28B+nTKIg3f1
 3dwbnd9IPZrKhuaLk9yDXZjmI7lTbonRsprObTGRD3S1a/yRhpyfuIp0tYmyK9cqTgae
 Rh1FJeMvM9HxcudE6i31j9UT/slEPqBuCTENmbRG7GyIf5YePPhiMGXmx0ls2v2aWeTC
 +Y6E2OdOnDUHN4mHC2bkFTMqz1AReDhH5gRRsnRPcasA1eLFi4tyd3RNDIaHv6e65w09
 +4rQ==
X-Gm-Message-State: APjAAAWVxnsTVDLSJNfxKnVsbCv13ejOPmqZFcttIRfjqtqkOwsbbTzN
 Pjd/P9Vyo6uSBazmp8vgNZDPV5qNvGlIEw==
X-Google-Smtp-Source: APXvYqxzYOXMhaVYgTW2i0YKUWyHHatJpOBPZ67pnc/DGCBE7C/bAauh2e4PyJIv2xJKuvDUMnI+NA==
X-Received: by 2002:a17:90a:23ce:: with SMTP id
 g72mr7931568pje.77.1560902043893; 
 Tue, 18 Jun 2019 16:54:03 -0700 (PDT)
Received: from rohan.sifive.com ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id t5sm16989219pgh.46.2019.06.18.16.54.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 18 Jun 2019 16:54:03 -0700 (PDT)
From: Jim Wilson <jimw@sifive.com>
To: qemu-devel@nongnu.org
Date: Tue, 18 Jun 2019 16:53:13 -0700
Message-Id: <20190618235313.13223-1-jimw@sifive.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH] linux-user: Add strace support for statx.
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Jim Wilson <jimw@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All of the flags need to be conditional as old systems don't have statx
support.  Otherwise it works the same as other stat family syscalls.
This requires the pending patch to add statx support.

Tested on Ubuntu 16.04 (no host statx) and Ubuntu 19.04 (with host statx)
using a riscv32-linux toolchain.

Signed-off-by: Jim Wilson <jimw@sifive.com>
---
 linux-user/strace.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  3 ++
 2 files changed, 89 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 6f72a74..c80e93b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -976,6 +976,76 @@ UNUSED static struct flags msg_flags[] = {
     FLAG_END,
 };
 
+UNUSED static struct flags statx_flags[] = {
+#ifdef AT_EMPTY_PATH
+    FLAG_GENERIC(AT_EMPTY_PATH),
+#endif
+#ifdef AT_NO_AUTOMOUNT
+    FLAG_GENERIC(AT_NO_AUTOMOUNT),
+#endif
+#ifdef AT_SYMLINK_NOFOLLOW
+    FLAG_GENERIC(AT_SYMLINK_NOFOLLOW),
+#endif
+#ifdef AT_STATX_SYNC_AS_STAT
+    FLAG_GENERIC(AT_STATX_SYNC_AS_STAT),
+#endif
+#ifdef AT_STATX_FORCE_SYNC
+    FLAG_GENERIC(AT_STATX_FORCE_SYNC),
+#endif
+#ifdef AT_STATX_DONT_SYNC
+    FLAG_GENERIC(AT_STATX_DONT_SYNC),
+#endif
+    FLAG_END,
+};
+
+UNUSED static struct flags statx_mask[] = {
+/* This must come first, because it includes everything.  */
+#ifdef STATX_ALL
+    FLAG_GENERIC(STATX_ALL),
+#endif
+/* This must come second; it includes everything except STATX_BTIME.  */
+#ifdef STATX_BASIC_STATS
+    FLAG_GENERIC(STATX_BASIC_STATS),
+#endif
+#ifdef STATX_TYPE
+    FLAG_GENERIC(STATX_TYPE),
+#endif
+#ifdef STATX_MODE
+    FLAG_GENERIC(STATX_MODE),
+#endif
+#ifdef STATX_NLINK
+    FLAG_GENERIC(STATX_NLINK),
+#endif
+#ifdef STATX_UID
+    FLAG_GENERIC(STATX_UID),
+#endif
+#ifdef STATX_GID
+    FLAG_GENERIC(STATX_GID),
+#endif
+#ifdef STATX_ATIME
+    FLAG_GENERIC(STATX_ATIME),
+#endif
+#ifdef STATX_MTIME
+    FLAG_GENERIC(STATX_MTIME),
+#endif
+#ifdef STATX_CTIME
+    FLAG_GENERIC(STATX_CTIME),
+#endif
+#ifdef STATX_INO
+    FLAG_GENERIC(STATX_INO),
+#endif
+#ifdef STATX_SIZE
+    FLAG_GENERIC(STATX_SIZE),
+#endif
+#ifdef STATX_BLOCKS
+    FLAG_GENERIC(STATX_BLOCKS),
+#endif
+#ifdef STATX_BTIME
+    FLAG_GENERIC(STATX_BTIME),
+#endif
+    FLAG_END,
+};
+
 /*
  * print_xxx utility functions.  These are used to print syscall
  * parameters in certain format.  All of these have parameter
@@ -2611,6 +2681,22 @@ print_tgkill(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_statx
+static void
+print_statx(const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_at_dirfd(arg0, 0);
+    print_string(arg1, 0);
+    print_flags(statx_flags, arg2, 0);
+    print_flags(statx_mask, arg3, 0);
+    print_pointer(arg4, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 /*
  * An array of all of the syscalls we know about
  */
diff --git a/linux-user/strace.list b/linux-user/strace.list
index db21ce4..63a9466 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1650,3 +1650,6 @@
 #ifdef TARGET_NR_atomic_barrier
 { TARGET_NR_atomic_barrier, "atomic_barrier", NULL, NULL, NULL },
 #endif
+#ifdef TARGET_NR_statx
+{ TARGET_NR_statx, "statx", NULL, print_statx, NULL },
+#endif
-- 
2.7.4


