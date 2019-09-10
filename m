Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6B9C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36DC2082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36DC2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jNl-00062d-NM
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7j7y-0004hq-UF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7j7x-0002AS-LF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:26 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:56731)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7j7x-00029l-CL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:25 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8QiW-1i3JGt2lYe-004XCH; Tue, 10 Sep 2019 18:36:11 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:35:50 +0200
Message-Id: <20190910163600.19971-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
References: <20190910163600.19971-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4eKavIKS2mpYouw47awiX+VDUg4EsMju00X+tqbb4u0JwD6/WKZ
 kIanhMxOPY/qtkWvLq90yrR/Vn2u0Mjn3v024oOp4lwRatPznFIuiRYjgLgN3DgCDProIvv
 jaMZtPudnmRjmNZTfBxSbigI+btK7RDg044bwCDpsDypxpy/1cRaeFY5pJeEARRF+g3n7Yx
 zZcMFjRe1ZWWwU/hLXVXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sQA5gutfdQA=:vhQhw5nNhmKq3ShLhRSrgA
 7vWJ5W7m2cJgQAlcTDPstRkdP59Efu5qooK5eY5cEeGumoBdT/R7i5RKmcw2nyoyKgWqKsB1v
 UgUwK0XI3+ID/3ZdqOnNhG4Jlj3lDyRxlK2DKhCpcShm4gCREZ/AwZWCWNnzF5lZvnFBptsHN
 iCltmwLWSBufjc9mUQ4FM/lWIEeeDFeB3U/1HKteRpEGcUAsrb3eeHcTVKlZPmiIu3PboRv45
 St/3PI3FxI8BmrbV4e1Rp070vDbcFtsXscdKB+I4y3nwmNafFR8Jk/pSi+WD8xSzRtRQCDmLP
 0o8SNv5B78bRzFB1vFs+xOb4vFgveYFa0Xpd5dOU5a0o8DK9M78LmqN7LGjBmzX9/RWobsgFj
 Hr8YFmUlf5QmVrD96tflGgtzEbIjr8BWjMfJ5DSIT4sIBS5DinxVIStnjtddRwoayxZ8vizzN
 0kD48lGq8n7ndig25tQhu5SpNPb5592uIkO8lu2h8oAXjzqOMUlc4UuKAEP1hv7P5ADw41lfO
 8W90OKFGCpkRedKgnjEhJyn/9mzTFkIOOBA6EE9T+7gpqSoY859mrA5g7pT7M1mkL0Nyvsyup
 JZwXgGS4SsTPYJnjVa5ISfwy3dAsT4Uz2ekH4UsDJRqEWablo6blWO8YOJ6lCq9k0VUofyyJq
 JQaV1hVrjNyfShed9HrrQA2ezcpR1PuWP2IkuaXEsHSwTGQZdpzEkqh08b0hTj2OZKxqCj2wF
 iy59qANbTUZZTVx8mkEdQd2WGoYwYcK5ERc15EX4n3Je5fJZWIhHqNMcYM98z71J+aeO+poVl
 8Y6dV9qItEP2QO2okolbaWJpFJjNYqqKffhnbqV5jg9eVp0Ao8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PULL 05/15] linux-user: add memfd_create
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shu-Chun Weng via Qemu-devel <qemu-devel@nongnu.org>

Add support for the memfd_create syscall. If the host does not have the
libc wrapper, translate to a direct syscall with NC-macro.

Buglink: https://bugs.launchpad.net/qemu/+bug/1734792
Signed-off-by: Shu-Chun Weng <scw@google.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190819180947.180725-1-scw@google.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/qemu/memfd.h |  4 ++++
 linux-user/syscall.c | 12 ++++++++++++
 util/memfd.c         |  2 +-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
index d551c28b6850..975b6bdb7797 100644
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
index b42f59a32c8d..6928f654ced3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/path.h"
+#include "qemu/memfd.h"
 #include "qemu/queue.h"
 #include <elf.h>
 #include <endian.h>
@@ -11938,6 +11939,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
+        fd_trans_unregister(ret);
+        unlock_user(p, arg1, 0);
+        return ret;
+#endif
 
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
diff --git a/util/memfd.c b/util/memfd.c
index 00334e5b218f..4a3c07e0bee6 100644
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
2.21.0


