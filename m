Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4A7C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 03:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51646206F4
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 03:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51646206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juSsH-0004Hj-Ib
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 23:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1juSrf-0003sh-QF
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 23:41:19 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:54676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1juSrc-0002aT-98
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 23:41:19 -0400
Received: from localhost (unknown [192.168.167.235])
 by lucky1.263xmail.com (Postfix) with ESMTP id 1633DA1222;
 Sun, 12 Jul 2020 11:41:09 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [223.72.94.78])
 by smtp.263.net (postfix) whith ESMTP id
 P5939T140503804798720S1594525264515776_; 
 Sun, 12 Jul 2020 11:41:09 +0800 (CST)
X-UNIQUE-TAG: <5bc714aff7f6d2e0be977ff37281f4e9>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: riku.voipio@iki.fi
X-SENDER-IP: 223.72.94.78
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: chengang@emindsoft.com.cn
To: riku.voipio@iki.fi,
	laurent@vivier.eu
Subject: [PATCH] linux-user: syscall: ioctls: support DRM_IOCTL_I915_GETPARAM
Date: Sun, 12 Jul 2020 11:41:02 +0800
Message-Id: <20200712034102.23355-1-chengang@emindsoft.com.cn>
X-Mailer: git-send-email 2.24.0.308.g228f53135a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.157.147.135;
 envelope-from=chengang@emindsoft.com.cn; helo=lucky1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 23:41:10
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

It is for i915 drm command, and next, I shall send another i915 commands
implementations.

Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
---
 linux-user/ioctls.h        |  3 +++
 linux-user/syscall.c       | 39 ++++++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h  |  9 +++++++++
 linux-user/syscall_types.h |  4 ++++
 4 files changed, 55 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index f2e2fa9c87..83e045deba 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -577,6 +577,9 @@
 #ifdef HAVE_DRM_H
   IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
                 MK_PTR(MK_STRUCT(STRUCT_drm_version)))
+
+  IOCTL_SPECIAL(DRM_IOCTL_I915_GETPARAM, IOC_RW, do_ioctl_drm_i915,
+                MK_PTR(MK_STRUCT(STRUCT_drm_i915_getparam)))
 #endif
 
 #ifdef TARGET_TIOCSTART
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 17ed7f8d6b..6fab9064af 100644
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
@@ -5372,6 +5373,44 @@ static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
     return -TARGET_ENOSYS;
 }
 
+static abi_long do_ioctl_drm_i915_getparam(const IOCTLEntry *ie,
+                                           struct drm_i915_getparam *gparam,
+                                           int fd, abi_long arg)
+{
+    abi_long ret;
+    struct target_drm_i915_getparam *target_gparam;
+
+    if (!lock_user_struct(VERIFY_READ, target_gparam, arg, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(gparam->param, &target_gparam->param);
+    gparam->value = lock_user(VERIFY_WRITE, target_gparam->value,
+                             sizeof(*gparam->value), 0);
+    if (!gparam->value) {
+        unlock_user_struct(target_gparam, arg, 0);
+        return -TARGET_EFAULT;
+    }
+
+    ret = get_errno(safe_ioctl(fd, ie->host_cmd, gparam));
+
+    unlock_user(gparam->value, target_gparam->value, sizeof(*gparam->value));
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
 
 static IOCTLEntry ioctl_entries[] = {
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 3c261cff0e..9082f6c2bc 100644
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
@@ -2613,6 +2616,12 @@ struct target_drm_version {
     abi_ulong desc;
 };
 
+struct target_drm_i915_getparam {
+    int param;
+    abi_ulong value;
+};
+
+
 #include "socket.h"
 
 #include "errno_defs.h"
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index e2b0484f50..ef60d5f38c 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -303,6 +303,10 @@ STRUCT(drm_version,
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




