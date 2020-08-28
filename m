Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26269C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE31207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE31207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBegS-0001E9-8j
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBea7-0003ug-0Q
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:15 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBea1-0007GP-US
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:14 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MjgfT-1krtLK2NI3-00lF85; Fri, 28 Aug 2020 15:37:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/18] linux-user: syscall: ioctls: support
 DRM_IOCTL_I915_GETPARAM
Date: Fri, 28 Aug 2020 15:37:38 +0200
Message-Id: <20200828133753.2622286-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828133753.2622286-1-laurent@vivier.eu>
References: <20200828133753.2622286-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lAIY65guFB1Puqf6q/sorcQRSPUysKUSNRL5W3qlbwERtBgEJMM
 k3xXyQxsz/CDF1vok2WLRNkAFX1eBGC/vmG/0so7zxyDjF4movtIXE9is8u2OJ1INo9nDO+
 hWmyJuxNWLX2qN7jXOM3tNPcDuJssvmKnzzio1ea+oxt7LsTpaJ5IdNY3Epvp5gVAiAiNTi
 rAk7Oi/x9wM0XohjaiY7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rS07zzFIxLo=:MYpfr0Q0S3ShtDHvyrC/kp
 C1YrTAZXE70bb4/sOtAmKj75O6jO09npmTw/kYOr+WyPvAKZGQT3NGodH57mM56yyr7IKfipe
 tia8W0ATEdz0DJ0NDm1CWmdUkvRM55k1+wh7Mpn/HOS6fwT26tL9jjmLkNXy7E/UcHxtLZfwR
 ef/YtUpKkwsd7NskqnqsKu+Fj8S/I9wGJ68Z+4vbaT9MMVYyZ95n1oCxK3ixe48izH1cN+Ejz
 h+6sSDII4Lk+Z6xRKGZj2Vlu2l6WNh0YyiDVCsRKic/yzsgISOPXyMxOz2OPVSOXLr8AKZ8ep
 GwL6DGBXvCva7yAnk6peg8sfr3knE3Royz9lolqLP44NDE9Fpfp8lt9AGlwTdt18/hCkA6IHa
 AkzCIIJ90+VRHPdc2wPCdiVA2egfyxqtpo8UFFv9JLtgZ66DAX2nDleAH9AkgOvl0M9I4gxXy
 qPOCg1R2kSpvHDAN+o+VTlqZ5pES0kh2iBUXHm+TepCdN6yv7vVBvTAC66XjLE+nDxRA9f3yQ
 3Iz4P3H2wKa8zM3Xso0VDm4hoK0ND4YzAGcom9U9QMWqwL09HlNq9uOvEPvHWa0tB+7ZMpBB+
 4Ky6p2tYD1izCp106vXV2VmHjFJA+hapsMgvnQ39ROWJ9yjmPazWbx2akA0lQIpTL7NJ+ckqF
 CFMeq/Nrw5ftAHuIb6cbaxCQLtUUa15PNCIU+L184zKQ+zi7MaU06IGcuV/wrf/UwVPnLBUxm
 v3+fhQWejQXoL7XFH5vSy2kkiRB/TMsb+9XmlmMfD7Y+O/IjrIvp0uVI0ZtKcu7SCBNfRtC8o
 glIiBvZv9dHuVXWTKW0YwDeveiRPdI7dnhU4knY2b02pbgqafZGyG9UAdZWjxBf5otw0fNx
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 09:38:08
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


