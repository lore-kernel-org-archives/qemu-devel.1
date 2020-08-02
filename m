Return-Path: <SRS0=xk1j=BM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF7CC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 13:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F26B2065C
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 13:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F26B2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2EED-0000R8-Jn
	for qemu-devel@archiver.kernel.org; Sun, 02 Aug 2020 09:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1k2EDe-0008RX-9E
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 09:40:06 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:44286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1k2EDb-0007kU-5a
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 09:40:06 -0400
Received: from localhost (unknown [192.168.167.32])
 by lucky1.263xmail.com (Postfix) with ESMTP id 995BBCAC46
 for <qemu-devel@nongnu.org>; Sun,  2 Aug 2020 21:39:45 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [120.244.108.108])
 by smtp.263.net (postfix) whith ESMTP id
 P31037T140065908971264S1596375579754136_; 
 Sun, 02 Aug 2020 21:39:45 +0800 (CST)
X-UNIQUE-TAG: <5e4d2f1d095839f4fa60745582fb3ea1>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: laurent@vivier.eu
X-SENDER-IP: 120.244.108.108
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: chengang@emindsoft.com.cn
To: laurent@vivier.eu
Subject: [PATCH v2] linux-user: syscall: ioctls: support
 DRM_IOCTL_I915_GETPARAM
Date: Sun,  2 Aug 2020 21:39:38 +0800
Message-Id: <20200802133938.12055-1-chengang@emindsoft.com.cn>
X-Mailer: git-send-email 2.24.0.308.g228f53135a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.157.147.130;
 envelope-from=chengang@emindsoft.com.cn; helo=lucky1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/02 09:39:50
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: chengang@emindsoft.com.cn, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Gang <chengang@emindsoft.com.cn>

Another DRM_IOCTL_I915 patches will be sent next.

Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
---
 linux-user/ioctls.h        |  3 +++
 linux-user/syscall.c       | 35 +++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h  |  8 ++++++++
 linux-user/syscall_types.h |  4 ++++
 4 files changed, 50 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0713ae1311..e2fc09b5a5 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -581,6 +581,9 @@
 #ifdef HAVE_DRM_H
   IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
                 MK_PTR(MK_STRUCT(STRUCT_drm_version)))
+
+  IOCTL_SPECIAL(DRM_IOCTL_I915_GETPARAM, IOC_RW, do_ioctl_drm_i915,
+                MK_PTR(MK_STRUCT(STRUCT_drm_i915_getparam)))
 #endif
 
 #ifdef TARGET_TIOCSTART
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 945fc25279..b0e15f373c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -114,6 +114,7 @@
 #include <sound/asound.h>
 #ifdef HAVE_DRM_H
 #include <libdrm/drm.h>
+#include <libdrm/i915_drm.h>
 #endif
 #include "linux_loop.h"
 #include "uname.h"
@@ -5413,6 +5414,40 @@ static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
     return -TARGET_ENOSYS;
 }
 
+static abi_long do_ioctl_drm_i915_getparam(const IOCTLEntry *ie,
+                                           struct drm_i915_getparam *gparam,
+                                           int fd, abi_long arg)
+{
+    abi_long ret;
+    int value;
+    struct target_drm_i915_getparam *target_gparam;
+
+    if (!lock_user_struct(VERIFY_READ, target_gparam, arg, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    __get_user(gparam->param, &target_gparam->param);
+    gparam->value = &value;
+    ret = get_errno(safe_ioctl(fd, ie->host_cmd, gparam));
+    put_user_s32(value, target_gparam->value);
+
+    unlock_user_struct(target_gparam, arg, 0);
+    return ret;
+}
+
+static abi_long do_ioctl_drm_i915(const IOCTLEntry *ie, uint8_t *buf_temp,
+                                  int fd, int cmd, abi_long arg)
+{
+    switch (ie->host_cmd) {
+    case DRM_IOCTL_I915_GETPARAM:
+        return do_ioctl_drm_i915_getparam(ie,
+                                          (struct drm_i915_getparam *)buf_temp,
+                                          fd, arg);
+    default:
+        return -TARGET_ENOSYS;
+    }
+}
+
 #endif
 
 IOCTLEntry ioctl_entries[] = {
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 3c261cff0e..5a1692aa26 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1170,6 +1170,9 @@ struct target_rtc_pll_info {
 /* drm ioctls */
 #define TARGET_DRM_IOCTL_VERSION      TARGET_IOWRU('d', 0x00)
 
+/* drm i915 ioctls */
+#define TARGET_DRM_IOCTL_I915_GETPARAM              TARGET_IOWRU('d', 0x46)
+
 /* from asm/termbits.h */
 
 #define TARGET_NCC 8
@@ -2613,6 +2616,11 @@ struct target_drm_version {
     abi_ulong desc;
 };
 
+struct target_drm_i915_getparam {
+    int param;
+    abi_ulong value;
+};
+
 #include "socket.h"
 
 #include "errno_defs.h"
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 3f1f033464..12bf3484e2 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -325,6 +325,10 @@ STRUCT(drm_version,
        TYPE_ULONG, /* desc_len */
        TYPE_PTRVOID) /* desc */
 
+STRUCT(drm_i915_getparam,
+       TYPE_INT, /* param */
+       TYPE_PTRVOID) /* value */
+
 STRUCT(file_clone_range,
        TYPE_LONGLONG, /* src_fd */
        TYPE_ULONGLONG, /* src_offset */
-- 
2.24.0.308.g228f53135a




