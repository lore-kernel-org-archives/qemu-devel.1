Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA18C433E1
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C657620723
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C657620723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrl8B-00030N-1G
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzb-0005bC-ML
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:21 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:44939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzU-0002Pg-DM
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:19 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MVvGt-1kJYkT3ztt-00RmpQ; Sat, 04 Jul 2020 18:25:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/12] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
Date: Sat,  4 Jul 2020 18:25:36 +0200
Message-Id: <20200704162545.311133-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704162545.311133-1-laurent@vivier.eu>
References: <20200704162545.311133-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NvELknXk+02Hu8JoKBvPs5LQq1Z0kFiJwSfSi9vYBD7uNBGUYot
 mAS3bOknZwayIJ0D568exxCvHwXcOlm/UlfX677lZAmIvsaSs9aqKQfM8Pc3b3vNtPgMGPq
 HCgPnvIM0dxKjXuo+mtBPwcfRdPGDaEZllmlCsB3c18drSoirQgW66cJNFTT8rXfPCv9UsJ
 WGj+kJEf+QnHGI1dqmVJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N/MuDt63pYc=:3gE0nRv+p6CqF30U6KzdBs
 /fm4yPlbXK3qA7ZNBGRKU3Sus13KVMSpX7kXWElvyqzsZJZSWpP2WktuZUbEIw8lN8Qbxh6Zu
 KZv6yTzDBEpcACZDVB2qsYHj1b7C5Q18w6qvfDSWmzHqsCpsyr5kpoIfDgPnFJmJ0A1/b194q
 ecD9zKxT0iVPTtDqAEl27+BG3mKF+bcKl500TV3nN6fRav1TEsZNqO2hKTvYpupw2RqkDxpJk
 PBcuo1xCA3y/i+2TQ+0UpALGEHsaYX+1zIhAAkr3XY2ExAlvWL1qfx3xMGFN/NBFDsgWk/T9X
 bDwM0b8/0z/I78RGqJD5cwmZUBWzQLPzcVq5LbwAVTXQYhpDErX6bxaHIOHIdm+JesnFswhwl
 uGKNBpG8yRDOrJjmbHmX6f/Z4CROnlureCPCcBGkUlpiyQ2UUNLpcvdaKhJnwY2TADZokDpeP
 XJig15zsh48jbpQiv740EZX0H2ELjbGYMdE4Qudu1bLhg/0zOI5LzKpL3O8so71BechPBbGvb
 6sG9BJ+tfyoJSAwRlon/nBgMPOZXkEZWIaL2LvEZCrr5JfUHte1jt3vAzBC9kwcJYgum4NIUC
 U5wWDAYvu8JZHPoanyzDZpKuO6pgJDhXdY7o9fm+2Dm+kCpI7RStt66KlkYnYSUcep5i6aC/e
 Uyo4YL+JJ6GEj6+cnWfOGBoM5Ux3GvFmo70ZqQ2+2W17SyjYSiBaza/IsK8v5GLdc048PD2S3
 zIfJHiTAQjZVY8UW5vGjT2/wW3aEumWK9uej8p+5o8eG3lwG5NxVslcN+dIvw9PvMaxouDib1
 gY4WEVLcV/drF3C3J8hb49Pey54xGnQ+jBH8iw9EHfFRK6fUr0=
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 12:25:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Gang <chengang@emindsoft.com.cn>

Another DRM_IOCTL_* commands will be done later.

Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200605013221.22828-1-chengang@emindsoft.com.cn>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure                  | 10 ++++
 linux-user/ioctls.h        |  5 ++
 linux-user/syscall.c       | 98 ++++++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h  | 15 ++++++
 linux-user/syscall_types.h | 11 +++++
 5 files changed, 139 insertions(+)

diff --git a/configure b/configure
index 4a22dcd5631d..2014c72b674d 100755
--- a/configure
+++ b/configure
@@ -3194,6 +3194,13 @@ if ! check_include "ifaddrs.h" ; then
   have_ifaddrs_h=no
 fi
 
+#########################################
+# libdrm check
+have_drm_h=no
+if check_include "libdrm/drm.h" ; then
+    have_drm_h=yes
+fi
+
 ##########################################
 # VTE probe
 
@@ -7377,6 +7384,9 @@ fi
 if test "$have_ifaddrs_h" = "yes" ; then
     echo "HAVE_IFADDRS_H=y" >> $config_host_mak
 fi
+if test "$have_drm_h" = "yes" ; then
+  echo "HAVE_DRM_H=y" >> $config_host_mak
+fi
 if test "$have_broken_size_max" = "yes" ; then
     echo "HAVE_BROKEN_SIZE_MAX=y" >> $config_host_mak
 fi
diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0defa1d8c18d..f2e2fa9c878b 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -574,6 +574,11 @@
   IOCTL_SPECIAL(SIOCDELRT, IOC_W, do_ioctl_rt,
                 MK_PTR(MK_STRUCT(STRUCT_rtentry)))
 
+#ifdef HAVE_DRM_H
+  IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
+                MK_PTR(MK_STRUCT(STRUCT_drm_version)))
+#endif
+
 #ifdef TARGET_TIOCSTART
   IOCTL_IGNORE(TIOCSTART)
   IOCTL_IGNORE(TIOCSTOP)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 97de9fb5c92a..17ed7f8d6b59 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -112,6 +112,9 @@
 #include <linux/if_alg.h>
 #include <linux/rtc.h>
 #include <sound/asound.h>
+#ifdef HAVE_DRM_H
+#include <libdrm/drm.h>
+#endif
 #include "linux_loop.h"
 #include "uname.h"
 
@@ -5276,6 +5279,101 @@ static abi_long do_ioctl_tiocgptpeer(const IOCTLEntry *ie, uint8_t *buf_temp,
 }
 #endif
 
+#ifdef HAVE_DRM_H
+
+static void unlock_drm_version(struct drm_version *host_ver,
+                               struct target_drm_version *target_ver,
+                               bool copy)
+{
+    unlock_user(host_ver->name, target_ver->name,
+                                copy ? host_ver->name_len : 0);
+    unlock_user(host_ver->date, target_ver->date,
+                                copy ? host_ver->date_len : 0);
+    unlock_user(host_ver->desc, target_ver->desc,
+                                copy ? host_ver->desc_len : 0);
+}
+
+static inline abi_long target_to_host_drmversion(struct drm_version *host_ver,
+                                          struct target_drm_version *target_ver)
+{
+    memset(host_ver, 0, sizeof(*host_ver));
+
+    __get_user(host_ver->name_len, &target_ver->name_len);
+    if (host_ver->name_len) {
+        host_ver->name = lock_user(VERIFY_WRITE, target_ver->name,
+                                   target_ver->name_len, 0);
+        if (!host_ver->name) {
+            return -EFAULT;
+        }
+    }
+
+    __get_user(host_ver->date_len, &target_ver->date_len);
+    if (host_ver->date_len) {
+        host_ver->date = lock_user(VERIFY_WRITE, target_ver->date,
+                                   target_ver->date_len, 0);
+        if (!host_ver->date) {
+            goto err;
+        }
+    }
+
+    __get_user(host_ver->desc_len, &target_ver->desc_len);
+    if (host_ver->desc_len) {
+        host_ver->desc = lock_user(VERIFY_WRITE, target_ver->desc,
+                                   target_ver->desc_len, 0);
+        if (!host_ver->desc) {
+            goto err;
+        }
+    }
+
+    return 0;
+err:
+    unlock_drm_version(host_ver, target_ver, false);
+    return -EFAULT;
+}
+
+static inline void host_to_target_drmversion(
+                                          struct target_drm_version *target_ver,
+                                          struct drm_version *host_ver)
+{
+    __put_user(host_ver->version_major, &target_ver->version_major);
+    __put_user(host_ver->version_minor, &target_ver->version_minor);
+    __put_user(host_ver->version_patchlevel, &target_ver->version_patchlevel);
+    __put_user(host_ver->name_len, &target_ver->name_len);
+    __put_user(host_ver->date_len, &target_ver->date_len);
+    __put_user(host_ver->desc_len, &target_ver->desc_len);
+    unlock_drm_version(host_ver, target_ver, true);
+}
+
+static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
+                             int fd, int cmd, abi_long arg)
+{
+    struct drm_version *ver;
+    struct target_drm_version *target_ver;
+    abi_long ret;
+
+    switch (ie->host_cmd) {
+    case DRM_IOCTL_VERSION:
+        if (!lock_user_struct(VERIFY_WRITE, target_ver, arg, 0)) {
+            return -TARGET_EFAULT;
+        }
+        ver = (struct drm_version *)buf_temp;
+        ret = target_to_host_drmversion(ver, target_ver);
+        if (!is_error(ret)) {
+            ret = get_errno(safe_ioctl(fd, ie->host_cmd, ver));
+            if (is_error(ret)) {
+                unlock_drm_version(ver, target_ver, false);
+            } else {
+                host_to_target_drmversion(target_ver, ver);
+            }
+        }
+        unlock_user_struct(target_ver, arg, 0);
+        return ret;
+    }
+    return -TARGET_ENOSYS;
+}
+
+#endif
+
 static IOCTLEntry ioctl_entries[] = {
 #define IOCTL(cmd, access, ...) \
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 152ec637cba6..3c261cff0e5e 100644
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
index 4e12c1661ea6..e2b0484f50e5 100644
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
2.26.2


