Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D86ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16CEA205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CEA205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wZ5-0005xc-Ff
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7wRh-00065N-Qv
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7wRg-0004Oi-EN
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:41 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36063)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7wRg-0004Nl-4x
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:40 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N2Dks-1iG9aT46rW-013eFZ; Wed, 11 Sep 2019 08:49:28 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 08:49:10 +0200
Message-Id: <20190911064920.1718-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911064920.1718-1-laurent@vivier.eu>
References: <20190911064920.1718-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:n84p1J/+NgbBL4KSeiMwKyNItfyANhcsb9q3qPhMAKibBDdeeSg
 FFvSDv7PkbsYxJvRQSSxh9e6wtB/oaNseFyK/udsBEnnxgocSQca4O4stzjmY0in9Cjzahz
 +bo2iGmgPXbEwqX8WTr6//vuiDBXw0y0ZH5tL3IRAQfJ7iYm2n9er6LizgPFx6rxt+rKXLX
 sYSomXedZJ/6aRxlJFC9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yssrlqachBQ=:ltXFK8C9bj8fp1aKPUSQBa
 QH2SHBZx90B7ePIis0RITZY9KyjZpSKjGjetRyARigM0ZG2ILJJDw5f1NI0czKzrW5geEA/wT
 m+YXokh0i/sA31NxKbxljjnCtPsogvuXvLQx3BLcTqV3hQgctOO4PNLcWr/QI2tRR9dsvsDYT
 YRbh2N9//aNNh7qbOHTRxLNxdwEgI9tjVwGiqbV9xsBgFjdna6+jPmqrEBctLhfo6Y4/2LWdx
 1UKGd0qCLBuXJkdoiZa7e76pHuPODKSfl8EbLI7VpEud1OHdXlt0rbfhCLdzDRuCiW4554FGz
 KHRZY3ZbHjYhN65t2Ju3cG84794AgVZtiHN+M23Zz3ix41WqVwJHZ9KmSKJsUgEB4btcPoX2N
 aYWB9zKeqlVcWLPmweXL5htdTu4vDBXP2zuRAiCbmE2K9kwvIij/NWPcSG8glsjGbwylKrKVG
 LYk2Nn4s9rXFfW2iwmzWbRf7FaOdI6BpvmX31lrBQX6ybMnVEoVaiyxesGbwZsLTjiS90E9OR
 BBSSX/kr8VjDCqG7hvhWjq7iMNX64BmZ0q6NzjvtOUmfyW4WCX7W08DnVT9Tno+RpNAOuKp4i
 65euaRFmCNzHw1Qarj1Yzm/swHE50tBu828Xne/njspoJ9MA5YtNalG7lq488Jv81aXymXCbU
 XnKubxofs4aBnam35sHGriU1SaJMt47QggEFTogRrV7loRK1JN4UnybyFwZajePi0phLoicsC
 25/8f3O2uwz9s5Dv2pN/KijH/meLKIwRvIZSJq2HDro8fmSOqYmy3TbVkGDrLWz/ZmmV9Wv/J
 2XykyZt8X4azkRAD7qKHShLI/Jm7NwaNGnF9OB0hpgtU49UEoI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL v2 05/15] linux-user: add memfd_create
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

From: Shu-Chun Weng <scw@google.com>

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


