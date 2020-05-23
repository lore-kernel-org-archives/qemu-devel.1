Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30873C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 13:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F160C20727
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 13:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F160C20727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcUAL-0001SN-6I
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 09:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jcU9o-00013A-A8
 for qemu-devel@nongnu.org; Sat, 23 May 2020 09:25:44 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:39914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jcU9l-0005qq-R6
 for qemu-devel@nongnu.org; Sat, 23 May 2020 09:25:44 -0400
Received: from localhost (unknown [192.168.167.70])
 by lucky1.263xmail.com (Postfix) with ESMTP id 0F851A71F9;
 Sat, 23 May 2020 21:25:30 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [223.72.95.57])
 by smtp.263.net (postfix) whith ESMTP id
 P7896T140606537963264S1590240322167699_; 
 Sat, 23 May 2020 21:25:29 +0800 (CST)
X-UNIQUE-TAG: <0801bc12dbc9b118b427e2d333fa1737>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: laurent@vivier.eu
X-SENDER-IP: 223.72.95.57
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: chengang@emindsoft.com.cn
To: laurent@vivier.eu,
	riku.voipio@iki.fi
Subject: [PATCH v3] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
Date: Sat, 23 May 2020 21:24:42 +0800
Message-Id: <20200523132442.22538-1-chengang@emindsoft.com.cn>
X-Mailer: git-send-email 2.24.0.308.g228f53135a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.157.147.131;
 envelope-from=chengang@emindsoft.com.cn; helo=lucky1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 09:25:31
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Another DRM_IOCTL_* commands will be done later.

Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
---
 configure                  | 18 +++++++++++
 linux-user/ioctls.h        |  3 ++
 linux-user/syscall.c       | 61 ++++++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h  | 15 ++++++++++
 linux-user/syscall_types.h | 11 +++++++
 5 files changed, 108 insertions(+)

diff --git a/configure b/configure
index e225a1e3ff..2c2c489d1e 100755
--- a/configure
+++ b/configure
@@ -3912,6 +3912,24 @@ EOF
     fi
 fi
 
+#########################################
+# libdrm check
+
+cat > $TMPC << EOF
+#include <libdrm/drm.h>
+#include <sys/ioctl.h>
+int main(void)
+{
+        struct drm_version version;
+        ioctl(-1, DRM_IOCTL_VERSION, &version);
+        return 0;
+}
+EOF
+if ! compile_prog "" ; then
+    error_exit "libdrm check failed" \
+        "Make sure to have the libdrm/drm.h installed."
+fi
+
 ##########################################
 # SHA command probe for modules
 if test "$modules" = yes; then
diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0defa1d8c1..c2294b48a0 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -574,6 +574,9 @@
   IOCTL_SPECIAL(SIOCDELRT, IOC_W, do_ioctl_rt,
                 MK_PTR(MK_STRUCT(STRUCT_rtentry)))
 
+  IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
+                MK_PTR(MK_STRUCT(STRUCT_drm_version)))
+
 #ifdef TARGET_TIOCSTART
   IOCTL_IGNORE(TIOCSTART)
   IOCTL_IGNORE(TIOCSTOP)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5af55fca78..de2e1e3de4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -112,6 +112,7 @@
 #include <linux/if_alg.h>
 #include <linux/rtc.h>
 #include <sound/asound.h>
+#include <libdrm/drm.h>
 #include "linux_loop.h"
 #include "uname.h"
 
@@ -5275,6 +5276,66 @@ static abi_long do_ioctl_tiocgptpeer(const IOCTLEntry *ie, uint8_t *buf_temp,
 }
 #endif
 
+static inline abi_long target_to_host_drmversion(struct drm_version *host_ver,
+                                                abi_long target_addr)
+{
+    struct target_drm_version *target_ver;
+
+    if (!lock_user_struct(VERIFY_READ, target_ver, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_ver->name_len, &target_ver->name_len);
+    host_ver->name = host_ver->name_len ? g2h(target_ver->name) : NULL;
+    __get_user(host_ver->date_len, &target_ver->date_len);
+    host_ver->date = host_ver->date_len ? g2h(target_ver->date) : NULL;
+    __get_user(host_ver->desc_len, &target_ver->desc_len);
+    host_ver->desc = host_ver->desc_len ? g2h(target_ver->desc) : NULL;
+    unlock_user_struct(target_ver, target_addr, 0);
+    return 0;
+}
+
+static inline abi_long host_to_target_drmversion(abi_ulong target_addr,
+                                                 struct drm_version *host_ver)
+{
+    struct target_drm_version *target_ver;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_ver, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_ver->version_major, &target_ver->version_major);
+    __put_user(host_ver->version_minor, &target_ver->version_minor);
+    __put_user(host_ver->version_patchlevel, &target_ver->version_patchlevel);
+    __put_user(host_ver->name_len, &target_ver->name_len);
+    __put_user(host_ver->date_len, &target_ver->date_len);
+    __put_user(host_ver->desc_len, &target_ver->desc_len);
+    unlock_user_struct(target_ver, target_addr, 0);
+    return 0;
+}
+
+static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
+                             int fd, int cmd, abi_long arg)
+{
+    struct drm_version *ver;
+    abi_long ret;
+
+    switch (ie->host_cmd) {
+    case DRM_IOCTL_VERSION:
+        ver = (struct drm_version *)buf_temp;
+        memset(ver, 0, sizeof(*ver));
+        ret = target_to_host_drmversion(ver, arg);
+        if (is_error(ret)) {
+            return ret;
+        }
+        ret = get_errno(safe_ioctl(fd, ie->host_cmd, ver));
+        if (is_error(ret)) {
+            return ret;
+        }
+        ret = host_to_target_drmversion(arg, ver);
+        return ret;
+    }
+    return -TARGET_EFAULT;
+}
+
 static IOCTLEntry ioctl_entries[] = {
 #define IOCTL(cmd, access, ...) \
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 152ec637cb..3c261cff0e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1167,6 +1167,9 @@ struct target_rtc_pll_info {
 #define TARGET_DM_TARGET_MSG          TARGET_IOWRU(0xfd, 0x0e)
 #define TARGET_DM_DEV_SET_GEOMETRY    TARGET_IOWRU(0xfd, 0x0f)
 
+/* drm ioctls */
+#define TARGET_DRM_IOCTL_VERSION      TARGET_IOWRU('d', 0x00)
+
 /* from asm/termbits.h */
 
 #define TARGET_NCC 8
@@ -2598,6 +2601,18 @@ struct target_mq_attr {
     abi_long mq_curmsgs;
 };
 
+struct target_drm_version {
+    int version_major;
+    int version_minor;
+    int version_patchlevel;
+    abi_ulong name_len;
+    abi_ulong name;
+    abi_ulong date_len;
+    abi_ulong date;
+    abi_ulong desc_len;
+    abi_ulong desc;
+};
+
 #include "socket.h"
 
 #include "errno_defs.h"
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 4e12c1661e..e2b0484f50 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -292,6 +292,17 @@ STRUCT(dm_target_versions,
 STRUCT(dm_target_msg,
        TYPE_ULONGLONG) /* sector */
 
+STRUCT(drm_version,
+       TYPE_INT, /* version_major */
+       TYPE_INT, /* version_minor */
+       TYPE_INT, /* version_patchlevel */
+       TYPE_ULONG, /* name_len */
+       TYPE_PTRVOID, /* name */
+       TYPE_ULONG, /* date_len */
+       TYPE_PTRVOID, /* date */
+       TYPE_ULONG, /* desc_len */
+       TYPE_PTRVOID) /* desc */
+
 STRUCT(file_clone_range,
        TYPE_LONGLONG, /* src_fd */
        TYPE_ULONGLONG, /* src_offset */
-- 
2.24.0.308.g228f53135a




