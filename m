Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3A9C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E25524685
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E25524685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vCt-0001zj-N5
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chengang@emindsoft.com.cn>) id 1j6v1s-0003pd-Na
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:39:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chengang@emindsoft.com.cn>) id 1j6v1n-0002E4-Ij
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:39:03 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:44106)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chengang@emindsoft.com.cn>)
 id 1j6v1k-00020N-5q
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:38:57 -0500
Received: from localhost (unknown [192.168.167.13])
 by lucky1.263xmail.com (Postfix) with ESMTP id EC7929F176;
 Wed, 26 Feb 2020 19:38:46 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [223.72.76.204])
 by smtp.263.net (postfix) whith ESMTP id
 P15418T139869026223872S1582717122829966_; 
 Wed, 26 Feb 2020 19:38:47 +0800 (CST)
X-UNIQUE-TAG: <7f7ccd07e8e2b96430f123414bb6acde>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: riku.voipio@iki.fi
X-SENDER-IP: 223.72.76.204
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: chengang@emindsoft.com.cn
To: riku.voipio@iki.fi,
	laurent@vivier.eu
Subject: [PATCH] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
Date: Wed, 26 Feb 2020 19:38:34 +0800
Message-Id: <20200226113834.26404-1-chengang@emindsoft.com.cn>
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
Cc: chengang@emindsoft.com.cn, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Gang <chengang@emindsoft.com.cn>

The other DRM_IOCTL_* commands will be done later.

Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
---
 linux-user/ioctls.h        |   3 +
 linux-user/syscall.c       | 134 +++++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h  |  16 +++++
 linux-user/syscall_types.h |  12 ++++
 4 files changed, 165 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0defa1d8c1..c2294b48a0 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -574,6 +574,9 @@
   IOCTL_SPECIAL(SIOCDELRT, IOC_W, do_ioctl_rt,
                 MK_PTR(MK_STRUCT(STRUCT_rtentry)))
=20
+  IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
+                MK_PTR(MK_STRUCT(STRUCT_drm_version)))
+
 #ifdef TARGET_TIOCSTART
   IOCTL_IGNORE(TIOCSTART)
   IOCTL_IGNORE(TIOCSTOP)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8d27d10807..1f5d48a0b0 100644
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
@@ -5196,6 +5197,139 @@ static abi_long do_ioctl_tiocgptpeer(const IOCTLE=
ntry *ie, uint8_t *buf_temp,
 }
 #endif
=20
+static inline void free_drmversion(struct drm_version *host)
+{
+    if (!host) {
+        return;
+    }
+    if (host->name) {
+        free(host->name);
+    }
+    if (host->date) {
+        free(host->date);
+    }
+    if (host->desc) {
+        free(host->desc);
+    }
+}
+
+static inline bool t2h_drmversion_str(unsigned long *hlen,
+                                      char **h, abi_ulong *glen)
+{
+    __get_user(*hlen, glen);
+    if (*hlen) {
+        *h =3D malloc(*hlen + 1);
+        if (!*h) {
+            return false;
+        }
+        (*h)[*hlen] =3D '\0';
+    } else {
+        *h =3D NULL;
+    }
+    return true;
+}
+
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
+    if (!t2h_drmversion_str(&host_ver->name_len,
+                            &host_ver->name, &target_ver->name_len)) {
+        goto err;
+    }
+    if (!t2h_drmversion_str(&host_ver->date_len,
+                            &host_ver->date, &target_ver->date_len)) {
+        goto err;
+    }
+    if (!t2h_drmversion_str(&host_ver->desc_len,
+                            &host_ver->desc, &target_ver->desc_len)) {
+        goto err;
+    }
+    unlock_user_struct(target_ver, target_addr, 0);
+    return 0;
+
+err:
+    free_drmversion(host_ver);
+    return -TARGET_ENOMEM;
+}
+
+static inline bool h2t_drmversion_str(int hlen, char *h,
+                                      abi_ulong *glen, abi_ulong g)
+{
+    char *target_str;
+
+    if ((hlen > 0) && h) {
+        target_str =3D lock_user(VERIFY_WRITE, g, hlen, 0);
+        if (!target_str) {
+            return false;
+        }
+        memcpy(target_str, h, hlen);
+        unlock_user(target_str, g, hlen);
+    }
+    __put_user(hlen, glen);
+    return true;
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
+    if (!h2t_drmversion_str(host_ver->name_len, host_ver->name,
+                            &target_ver->name_len, target_ver->name)) {
+        return -TARGET_EFAULT;
+    }
+    if (!h2t_drmversion_str(host_ver->date_len, host_ver->date,
+                            &target_ver->date_len, target_ver->date)) {
+        return -TARGET_EFAULT;
+    }
+    if (!h2t_drmversion_str(host_ver->desc_len, host_ver->desc,
+                            &target_ver->desc_len, target_ver->desc)) {
+        return -TARGET_EFAULT;
+    }
+
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
+            free_drmversion(ver);
+            return ret;
+        }
+        ret =3D host_to_target_drmversion(arg, ver);
+        free_drmversion(ver);
+        return ret;
+        break;
+    }
+    return -TARGET_EFAULT;
+}
+
 static IOCTLEntry ioctl_entries[] =3D {
 #define IOCTL(cmd, access, ...) \
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 152ec637cb..5e455a32af 100644
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
@@ -2598,6 +2602,18 @@ struct target_mq_attr {
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
index 4e12c1661e..52a031ad35 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -292,6 +292,18 @@ STRUCT(dm_target_versions,
 STRUCT(dm_target_msg,
        TYPE_ULONGLONG) /* sector */
=20
+/* TODO: use #ifdef 32 bit #else 64 bit, next */
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




