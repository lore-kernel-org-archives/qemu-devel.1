Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA26FC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 12:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B913B20578
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 12:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B913B20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDSJc-0007kD-SL
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 08:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chengang@emindsoft.com.cn>) id 1jDSHh-0007Fd-O9
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 08:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chengang@emindsoft.com.cn>) id 1jDSHg-0004OU-0f
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 08:22:25 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:43908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jDSHf-0003t5-6L
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 08:22:23 -0400
Received: from localhost (unknown [192.168.167.69])
 by lucky1.263xmail.com (Postfix) with ESMTP id 61284B446B;
 Sun, 15 Mar 2020 20:22:12 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [223.72.82.233])
 by smtp.263.net (postfix) whith ESMTP id
 P20071T140595485996800S1584274925344411_; 
 Sun, 15 Mar 2020 20:22:11 +0800 (CST)
X-UNIQUE-TAG: <74b4f6eec1cae0d7cd0169a97dbe721d>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: riku.voipio@iki.fi
X-SENDER-IP: 223.72.82.233
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: chengang@emindsoft.com.cn
To: riku.voipio@iki.fi,
	laurent@vivier.eu
Subject: [PATCH v2] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
Date: Sun, 15 Mar 2020 20:20:51 +0800
Message-Id: <20200315122051.9360-1-chengang@emindsoft.com.cn>
X-Mailer: git-send-email 2.24.0.308.g228f53135a
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.157.147.132
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
Cc: Chen Gang <chengang@emindsoft.com.cn>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Gang <chengang@emindsoft.com.cn>

Another DRM_IOCTL_* commands will be done later.

Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
---
 linux-user/ioctls.h        |  2 ++
 linux-user/syscall.c       | 62 ++++++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h  | 15 +++++++++
 linux-user/syscall_types.h | 11 +++++++
 4 files changed, 90 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0defa1d8c1..3ae32cbfb1 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -574,6 +574,8 @@
   IOCTL_SPECIAL(SIOCDELRT, IOC_W, do_ioctl_rt,
                 MK_PTR(MK_STRUCT(STRUCT_rtentry)))
=20
+  IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
+                MK_PTR(MK_STRUCT(STRUCT_drm_version)))
 #ifdef TARGET_TIOCSTART
   IOCTL_IGNORE(TIOCSTART)
   IOCTL_IGNORE(TIOCSTOP)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8d27d10807..2eb7c91ab4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -112,6 +112,7 @@
 #include <linux/if_alg.h>
 #include <linux/rtc.h>
 #include <sound/asound.h>
+#include <libdrm/drm.h>
 #include "linux_loop.h"
 #include "uname.h"
=20
@@ -5196,6 +5197,67 @@ static abi_long do_ioctl_tiocgptpeer(const IOCTLEn=
try *ie, uint8_t *buf_temp,
 }
 #endif
=20
+static inline abi_long target_to_host_drmversion(struct drm_version *hos=
t_ver,
+                                                abi_long target_addr)
+{
+    struct target_drm_version *target_ver;
+
+    if (!lock_user_struct(VERIFY_READ, target_ver, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_ver->name_len, &target_ver->name_len);
+    host_ver->name =3D host_ver->name_len ? g2h(target_ver->name) : NULL=
;
+    __get_user(host_ver->date_len, &target_ver->date_len);
+    host_ver->date =3D host_ver->date_len ? g2h(target_ver->date) : NULL=
;
+    __get_user(host_ver->desc_len, &target_ver->desc_len);
+    host_ver->desc =3D host_ver->desc_len ? g2h(target_ver->desc) : NULL=
;
+    unlock_user_struct(target_ver, target_addr, 0);
+    return 0;
+}
+
+static inline abi_long host_to_target_drmversion(abi_ulong target_addr,
+                                                 struct drm_version *hos=
t_ver)
+{
+    struct target_drm_version *target_ver;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_ver, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_ver->version_major, &target_ver->version_major);
+    __put_user(host_ver->version_minor, &target_ver->version_minor);
+    __put_user(host_ver->version_patchlevel, &target_ver->version_patchl=
evel);
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
+        ver =3D (struct drm_version *)buf_temp;
+        memset(ver, 0, sizeof(*ver));
+        ret =3D target_to_host_drmversion(ver, arg);
+        if (is_error(ret)) {
+            return ret;
+        }
+        ret =3D get_errno(safe_ioctl(fd, ie->host_cmd, ver));
+        if (is_error(ret)) {
+            return ret;
+        }
+        ret =3D host_to_target_drmversion(arg, ver);
+        return ret;
+    }
+    return -TARGET_EFAULT;
+}
+
+
 static IOCTLEntry ioctl_entries[] =3D {
 #define IOCTL(cmd, access, ...) \
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 152ec637cb..3c261cff0e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1167,6 +1167,9 @@ struct target_rtc_pll_info {
 #define TARGET_DM_TARGET_MSG          TARGET_IOWRU(0xfd, 0x0e)
 #define TARGET_DM_DEV_SET_GEOMETRY    TARGET_IOWRU(0xfd, 0x0f)
=20
+/* drm ioctls */
+#define TARGET_DRM_IOCTL_VERSION      TARGET_IOWRU('d', 0x00)
+
 /* from asm/termbits.h */
=20
 #define TARGET_NCC 8
@@ -2598,6 +2601,18 @@ struct target_mq_attr {
     abi_long mq_curmsgs;
 };
=20
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
=20
 #include "errno_defs.h"
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 4e12c1661e..e2b0484f50 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -292,6 +292,17 @@ STRUCT(dm_target_versions,
 STRUCT(dm_target_msg,
        TYPE_ULONGLONG) /* sector */
=20
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
--=20
2.24.0.308.g228f53135a




