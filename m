Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6E2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81362207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81362207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNUb-0000X7-LK
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNRv-0003qf-MR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:39 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:56617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNRt-0000A9-Q8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:39 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MSbp1-1k0lN72dir-00SumF; Thu, 27 Aug 2020 21:20:28 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/18] linux-user: syscall: ioctls: support
 DRM_IOCTL_I915_GETPARAM
Date: Thu, 27 Aug 2020 21:20:03 +0200
Message-Id: <20200827192018.2442099-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827192018.2442099-1-laurent@vivier.eu>
References: <20200827192018.2442099-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MXn0zVzwswKtcIarZsDaSOLtnC8aow9SWx4mBc5EyTfuO+ALaqa
 13cd+SlYJJemq1+Ea1H1feBZ17vwccj++5yIRuL7oyxNbMgCRnD2hLEu81nCnyh53gneCKN
 dwlPU1fL9s+2BK9JaCbQ2W7vr+GD9touPtTp6nkT+pWtbhKVFgXOMQGUbdUuk5fWnLSR0g7
 wk3enMTlTp7/8napEaL3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ezbO9ETbV40=:wuJoyiAXLNRNU07JUOr12i
 y4URvqmRtzytEShS58gUCQWrso5H4ebKNyQF5BnRMs+zewTCYujhiyJ6/kmVfsOxRsmJ6AySm
 CEY2hVJFizczdhEnk4nDjoAmG7AY/peO5HCEEGXc1BTsT90ukBI/k0l6JzztMigVQJfOJhko8
 CNib7qYA5UDZLF09TYnPwc1OEjTKKgjyN2JGi78icqT5RoyFxdeE9pe9pJNoWaQWxq3QkJ+Y9
 w+lIRSK5RUMqV9eLMCf7LIb1L8HjLB2L9BnCOjedgfUbKouPCwYDmBOfleunexKF5sz02xOqB
 6Hc0nokKNkNso8Ya2e58s3gi1uDm+0dTffUPFHw4er74UJjnrEDRwWSIScdL6+OFIglCWfLUV
 VgHQhC0izHRpWtvDOVKongmVk1XUED+F8GNKBQIdTYwCT4NuSXx8X+CNF4pGIjr6RdRFFBwcm
 I60pzYm6vGsjPqDpllorYw5DOjBFAW4BDPMdp1cNPEBwNkmcfAEioj8qSkihzVM02vZgOTr9i
 ZaQhZNlErC/1rSfSUGyACvu4yxjwiBsDY8nT7710XKmMgt5qR7B3yMYdl5ARAPeA0cYvq9roh
 N8s5jEXC58W2jlR1JqWy46mhDIwmv89E5ucxb7/hZIC/ErOrh2AXKp89vIfxudyIGT2isF+tz
 KYisXr9OqnuO0MwBAslZokugHsehpWojXowiWfluDX3QiIkQNZV8Exl29OEhhm3Pmf+pXcbLy
 wJWBQuPYdfBGA3in7w1qUFQYB45SMmi9Z8QTNO4/Tbb2I9fvt2dEVYM8rC+E6rLIgwYLFmRGL
 bk42opoDxjK8hKwj5A2G6DB/oShxk03qhm3f5ngR6gua7sWXbd3zZUDbtFPPmM1CcNZ1VOk
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 15:20:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Chen Gang <chengang@emindsoft.com.cn>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Gang <chengang@emindsoft.com.cn>

Another DRM_IOCTL_I915 patches will be sent next.

Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200802133938.12055-1-chengang@emindsoft.com.cn>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        |  3 +++
 linux-user/syscall.c       | 35 +++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h  |  8 ++++++++
 linux-user/syscall_types.h |  4 ++++
 4 files changed, 50 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0713ae131162..e2fc09b5a5ee 100644
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
index e387246d7196..efaa0a7b8365 100644
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
@@ -5426,6 +5427,40 @@ static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
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
index 9aa3bd724f0c..a6abc7e70be8 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1177,6 +1177,9 @@ struct target_rtc_pll_info {
 /* drm ioctls */
 #define TARGET_DRM_IOCTL_VERSION      TARGET_IOWRU('d', 0x00)
 
+/* drm i915 ioctls */
+#define TARGET_DRM_IOCTL_I915_GETPARAM              TARGET_IOWRU('d', 0x46)
+
 /* from asm/termbits.h */
 
 #define TARGET_NCC 8
@@ -2620,6 +2623,11 @@ struct target_drm_version {
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
index 3f1f0334649b..12bf3484e2bd 100644
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
2.26.2


