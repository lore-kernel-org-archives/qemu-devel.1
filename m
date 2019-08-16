Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D76DC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 21:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B4212077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 21:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="E14VmCMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4212077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyjm8-0002Sj-5J
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 17:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59709)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <35xtXXQMKCmwcMgQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--scw.bounces.google.com>)
 id 1hyjV5-0005o2-AI
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 17:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <35xtXXQMKCmwcMgQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--scw.bounces.google.com>)
 id 1hyjV3-00078G-Vc
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 17:11:07 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a]:40422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <35xtXXQMKCmwcMgQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--scw.bounces.google.com>)
 id 1hyjV3-00077T-MX
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 17:11:05 -0400
Received: by mail-pf1-x44a.google.com with SMTP id e18so4584989pfj.7
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 14:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=7RKduOP1Zy0Z6W4TdqYEUSnkCMOqjh++D/cBNOzwUMM=;
 b=E14VmCMelPACin5pYsdxyavF+TZgoebRS/MoiQuBgF1vCHIDpl6pr806CETDsQ1ODd
 GwylspVfdPZNJBgSxCERVhCo9yF5yI0dBYRol8QbH/vYmfVV0S2wO4FFYoWfE6tdnk4B
 y6F7Hx9xNC5KC2s6pK6AbgXj32dcL9iCvdVQ7eO2mJHRn4AM0PmC26AfG1txmZrfewtF
 fkA1W7xsrbnxsfO/Hpp8+hepv0T6G/7D3OeqdfXtv+trba2oHTXrXrKG+ohp8T4r9Dvv
 w7BE48ZDkW4fTNpNKpe/rIJsfPLZ7N8bujD36BMhMJSaYO6csIGpr6FbEuZnhmgfH3Ll
 VJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=7RKduOP1Zy0Z6W4TdqYEUSnkCMOqjh++D/cBNOzwUMM=;
 b=uQcqn22d8KPUQY/Hfk+MGmHgceGz7kz2PC3t+K6rAbaL7R3m+OqrGjrc6jdN8gNoa+
 8XjY9Fz9XPLHruQHXU6a8pKyDmDQ6bI5GHKJmyvqb0t7Y1oZRrvzRp+07VFp8wavwRPF
 7p7ILpz+yoYyeY34u2AUDN97jet2ES6/JTRLpnx0K++ribjYV96lzWY80Pc+u04eiE6W
 oDz4wo/DPHzguZLQzvdNx5//PPH3+8X1ifWu2QLO8babEBx/Tx/0WbgrQEhqIfOp9AX1
 nHdVQb3UNGA3F9juzjPJPwjKvfDsm255jhNSN7iPpNNGjRGDSy61jmwj8rhqepOJbWUB
 B5NA==
X-Gm-Message-State: APjAAAWa/YgHo1fnaC8zw29D6UEF60xNZbAByIzWP9Bjc1tR3/gnXOTm
 ahuLDOL0JH/it6/GGM9cH/yagHM=
X-Google-Smtp-Source: APXvYqyiz5JFayocTTc20e52TkykeIu92Wv2wZUAHa0JnTdCZ9jeE89j2zND1hbg4dsHsU/bfwZ/rIA=
X-Received: by 2002:a63:506:: with SMTP id 6mr9350751pgf.434.1565989863105;
 Fri, 16 Aug 2019 14:11:03 -0700 (PDT)
Date: Fri, 16 Aug 2019 14:10:49 -0700
Message-Id: <20190816211049.57317-1-scw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
To: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::44a
X-Mailman-Approved-At: Fri, 16 Aug 2019 17:27:49 -0400
Subject: [Qemu-devel] [PATCH] linux-user: add memfd_create
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
From: Shu-Chun Weng via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Shu-Chun Weng <scw@google.com>
Cc: arunkaly@google.com, qemu-devel@nongnu.org, Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for the memfd_create syscall. If the host does not have the
libc wrapper, translate to a direct syscall with NC-macro.

Buglink: https://bugs.launchpad.net/qemu/+bug/1734792
Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 include/qemu/memfd.h |  4 ++++
 linux-user/syscall.c | 11 +++++++++++
 util/memfd.c         |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
index d551c28b68..975b6bdb77 100644
--- a/include/qemu/memfd.h
+++ b/include/qemu/memfd.h
@@ -32,6 +32,10 @@
 #define MFD_HUGE_SHIFT 26
 #endif
 
+#if defined CONFIG_LINUX && !defined CONFIG_MEMFD
+int memfd_create(const char *name, unsigned int flags);
+#endif
+
 int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
                       uint64_t hugetlbsize, unsigned int seals, Error **errp);
 bool qemu_memfd_alloc_check(void);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8367cb138d..b506c1f40e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/path.h"
+#include "qemu/memfd.h"
 #include <elf.h>
 #include <endian.h>
 #include <grp.h>
@@ -11938,6 +11939,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         /* PowerPC specific.  */
         return do_swapcontext(cpu_env, arg1, arg2, arg3);
 #endif
+#ifdef TARGET_NR_memfd_create
+    case TARGET_NR_memfd_create:
+        p = lock_user_string(arg1);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(memfd_create(p, arg2));
+        unlock_user(p, arg1, 0);
+        return ret;
+#endif
 
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
diff --git a/util/memfd.c b/util/memfd.c
index 00334e5b21..4a3c07e0be 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -35,7 +35,7 @@
 #include <sys/syscall.h>
 #include <asm/unistd.h>
 
-static int memfd_create(const char *name, unsigned int flags)
+int memfd_create(const char *name, unsigned int flags)
 {
 #ifdef __NR_memfd_create
     return syscall(__NR_memfd_create, name, flags);
-- 
2.23.0.rc1.153.gdeed80330f-goog


