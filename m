Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D16C76196
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58BA20880
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58BA20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho68P-0002CP-Sw
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 09:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55110)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1ho683-0001EC-IN
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ho681-0003b6-ND
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:07:23 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:47363)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ho681-0003aX-D1
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:07:21 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mt6wz-1ihQhI1QxV-00tVBu; Thu, 18 Jul 2019 15:06:45 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 18 Jul 2019 15:06:41 +0200
Message-Id: <20190718130641.15294-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:x03d6jUx8AGGFotJozHAkh71W6f4y3EECIiXRlsOJhzPLgERI2T
 ya1XV4kaIT5rk1nGiJD01GOjBdzQ1+eptB9nCmtc0JXekbnV0ynybQTSrswXt2HaaOKT4m7
 hZaGwvCaUmahuDAcNofNSYxcnOeyPt30aFKfygPk3SlK69NWiFHgpWSTMbVpNXiIWsNTsKk
 0GiV2eXCBKWd4YTtIFuiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H3lJDbWVMtw=:WlizuGWlzc04zXu1PA3yQR
 aSZzmZHkL+DRhdUpAM+ZmL0Ogmhemr7vUUqWlmQ5yKU0xtirCj/uLexxPhML1x2IHa26hgIVu
 VNHspA1akYfYevHkQ1WiNWVr6dBXRqcDLa1YWXgT9nOqMBkP+KHtzelrIm6e0oz+yFIeZ5iLd
 hax05q7E0XbLcl9XrBzi1zMTp+yWNvnQso9hoUj8s8DMn2VduTN3MSp5WgT7zWfygFjy4d1Up
 QdV+gQC7O86XNgKezFbwnfJIhO+F+h4AUCL2bRp2Bzugx7YJh6rtwBp+aPu8ZY8L+Ss4FjYH8
 zsDRjMKaT8tjiyUSBDolgfievQJ3jnZpDxfcSeFc37+pf6GUKjJt0tKuQMCRwL9B2kIdeFD1e
 ubAfcyl40koVoihPiVQHi2P667am5bZDm3SyK0rYTFdPLgyV6IVOLGsmFG03/Ve8MzFxE+i5P
 OvwRfPqtGDa4l+r1J69jQP/LVGijld3f+R760Rq8cAjmHjIR+TVW4/yxX73rEFGFueoFwfJ95
 Pof25m3qqMfhOSlf6OWLToqnae9vHQrnp9J6OuzX/eY9kmimZZh6ufCxDUTo/Rmq/9VzYzNkU
 hQjPZbW0b5on0km//scts0doT+bZ8YGXviyX3vadckQuYP9k7j5+04B1VeXYtaPBoUREhpLZV
 74eFGGmvoehzN1MmL/4psYvtuGBLuWipqfMpUGwH3XxTiacAHGnd/za3kUV56PZ2sSBS5qshr
 6qwRaxenS88RtckTtzHkuWwOSmha7H8+kK3O62rCYcewUSZlagyvKy5+v4E=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: [Qemu-devel] [PATCH v6] linux-user: fix to handle variably sized
 SIOCGSTAMP with new kernels
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

The SIOCGSTAMP symbol was previously defined in the
asm-generic/sockios.h header file. QEMU sees that header
indirectly via sys/socket.h

In linux kernel commit 0768e17073dc527ccd18ed5f96ce85f9985e9115
the asm-generic/sockios.h header no longer defines SIOCGSTAMP.
Instead it provides only SIOCGSTAMP_OLD, which only uses a
32-bit time_t on 32-bit architectures.

The linux/sockios.h header then defines SIOCGSTAMP using
either SIOCGSTAMP_OLD or SIOCGSTAMP_NEW as appropriate. If
SIOCGSTAMP_NEW is used, then the tv_sec field is 64-bit even
on 32-bit architectures

To cope with this we must now convert the old and new type from
the target to the host one.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---

Notes:
    v6: [lv] fix IOCTLEntry entries (host_cmd and name)
    v5: [lv] define special _OLD values for sh
        define special case for SPARC64
        define ioctl helpers
        define target__kernel_sock_timeval and target__kernel_timespec and
        converters to the host type
        always use SIOCGSTAMP and SIOCGSTAMPNS on the host
    
    v4: [lv] timeval64 and timespec64 are { long long , long }
    
    v3: [lv] redefine TARGET_SIOCGSTAMP_NEW, TARGET_SIOCGSTAMPNS_NEW,
        timeval64 and timespec64 to use 0x89 type and abi_llong[2]
    
    v2: [dpb] implement _NEW and _OLD variants

 linux-user/ioctls.h        |  21 +++++-
 linux-user/syscall.c       | 140 +++++++++++++++++++++++++++++--------
 linux-user/syscall_defs.h  |  30 +++++++-
 linux-user/syscall_types.h |   6 --
 4 files changed, 159 insertions(+), 38 deletions(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 5e84dc7c3a77..3281c97ca263 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -222,8 +222,25 @@
   IOCTL(SIOCGIWNAME, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_char_ifreq)))
   IOCTL(SIOCSPGRP, IOC_W, MK_PTR(TYPE_INT)) /* pid_t */
   IOCTL(SIOCGPGRP, IOC_R, MK_PTR(TYPE_INT)) /* pid_t */
-  IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
-  IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
+
+  /*
+   * We can't use IOCTL_SPECIAL() because it will set
+   * host_cmd to XXX_OLD and XXX_NEW and these macros
+   * are not defined with kernel prior to 5.2.
+   * We must set host_cmd to the same value as in target_cmd
+   * otherwise the consistency check in syscall_init()
+   * will trigger an error.
+   * host_cmd is ignored by the do_ioctl_XXX() helpers.
+   * FIXME: create a macro to define this kind of entry
+   */
+  { TARGET_SIOCGSTAMP_OLD, TARGET_SIOCGSTAMP_OLD,
+    "SIOCGSTAMP_OLD", IOC_R, do_ioctl_SIOCGSTAMP },
+  { TARGET_SIOCGSTAMPNS_OLD, TARGET_SIOCGSTAMPNS_OLD,
+    "SIOCGSTAMPNS_OLD", IOC_R, do_ioctl_SIOCGSTAMPNS },
+  { TARGET_SIOCGSTAMP_NEW, TARGET_SIOCGSTAMP_NEW,
+    "SIOCGSTAMP_NEW", IOC_R, do_ioctl_SIOCGSTAMP },
+  { TARGET_SIOCGSTAMPNS_NEW, TARGET_SIOCGSTAMPNS_NEW,
+    "SIOCGSTAMPNS_NEW", IOC_R, do_ioctl_SIOCGSTAMPNS },
 
   IOCTL(RNDGETENTCNT, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 39a37496fed5..8367cb138dfe 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -37,6 +37,7 @@
 #include <sched.h>
 #include <sys/timex.h>
 #include <sys/socket.h>
+#include <linux/sockios.h>
 #include <sys/un.h>
 #include <sys/uio.h>
 #include <poll.h>
@@ -1126,8 +1127,9 @@ static inline abi_long copy_from_user_timeval(struct timeval *tv,
 {
     struct target_timeval *target_tv;
 
-    if (!lock_user_struct(VERIFY_READ, target_tv, target_tv_addr, 1))
+    if (!lock_user_struct(VERIFY_READ, target_tv, target_tv_addr, 1)) {
         return -TARGET_EFAULT;
+    }
 
     __get_user(tv->tv_sec, &target_tv->tv_sec);
     __get_user(tv->tv_usec, &target_tv->tv_usec);
@@ -1142,8 +1144,26 @@ static inline abi_long copy_to_user_timeval(abi_ulong target_tv_addr,
 {
     struct target_timeval *target_tv;
 
-    if (!lock_user_struct(VERIFY_WRITE, target_tv, target_tv_addr, 0))
+    if (!lock_user_struct(VERIFY_WRITE, target_tv, target_tv_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    __put_user(tv->tv_sec, &target_tv->tv_sec);
+    __put_user(tv->tv_usec, &target_tv->tv_usec);
+
+    unlock_user_struct(target_tv, target_tv_addr, 1);
+
+    return 0;
+}
+
+static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
+                                             const struct timeval *tv)
+{
+    struct target__kernel_sock_timeval *target_tv;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_tv, target_tv_addr, 0)) {
         return -TARGET_EFAULT;
+    }
 
     __put_user(tv->tv_sec, &target_tv->tv_sec);
     __put_user(tv->tv_usec, &target_tv->tv_usec);
@@ -1153,6 +1173,48 @@ static inline abi_long copy_to_user_timeval(abi_ulong target_tv_addr,
     return 0;
 }
 
+static inline abi_long target_to_host_timespec(struct timespec *host_ts,
+                                               abi_ulong target_addr)
+{
+    struct target_timespec *target_ts;
+
+    if (!lock_user_struct(VERIFY_READ, target_ts, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_ts->tv_sec, &target_ts->tv_sec);
+    __get_user(host_ts->tv_nsec, &target_ts->tv_nsec);
+    unlock_user_struct(target_ts, target_addr, 0);
+    return 0;
+}
+
+static inline abi_long host_to_target_timespec(abi_ulong target_addr,
+                                               struct timespec *host_ts)
+{
+    struct target_timespec *target_ts;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_ts, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_ts->tv_sec, &target_ts->tv_sec);
+    __put_user(host_ts->tv_nsec, &target_ts->tv_nsec);
+    unlock_user_struct(target_ts, target_addr, 1);
+    return 0;
+}
+
+static inline abi_long host_to_target_timespec64(abi_ulong target_addr,
+                                                 struct timespec *host_ts)
+{
+    struct target__kernel_timespec *target_ts;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_ts, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_ts->tv_sec, &target_ts->tv_sec);
+    __put_user(host_ts->tv_nsec, &target_ts->tv_nsec);
+    unlock_user_struct(target_ts, target_addr, 1);
+    return 0;
+}
+
 static inline abi_long copy_from_user_timezone(struct timezone *tz,
                                                abi_ulong target_tz_addr)
 {
@@ -4899,6 +4961,54 @@ static abi_long do_ioctl_kdsigaccept(const IOCTLEntry *ie, uint8_t *buf_temp,
     return get_errno(safe_ioctl(fd, ie->host_cmd, sig));
 }
 
+static abi_long do_ioctl_SIOCGSTAMP(const IOCTLEntry *ie, uint8_t *buf_temp,
+                                    int fd, int cmd, abi_long arg)
+{
+    struct timeval tv;
+    abi_long ret;
+
+    ret = get_errno(safe_ioctl(fd, SIOCGSTAMP, &tv));
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    if (cmd == (int)TARGET_SIOCGSTAMP_OLD) {
+        if (copy_to_user_timeval(arg, &tv)) {
+            return -TARGET_EFAULT;
+        }
+    } else {
+        if (copy_to_user_timeval64(arg, &tv)) {
+            return -TARGET_EFAULT;
+        }
+    }
+
+    return ret;
+}
+
+static abi_long do_ioctl_SIOCGSTAMPNS(const IOCTLEntry *ie, uint8_t *buf_temp,
+                                      int fd, int cmd, abi_long arg)
+{
+    struct timespec ts;
+    abi_long ret;
+
+    ret = get_errno(safe_ioctl(fd, SIOCGSTAMPNS, &ts));
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    if (cmd == (int)TARGET_SIOCGSTAMPNS_OLD) {
+        if (host_to_target_timespec(arg, &ts)) {
+            return -TARGET_EFAULT;
+        }
+    } else{
+        if (host_to_target_timespec64(arg, &ts)) {
+            return -TARGET_EFAULT;
+        }
+    }
+
+    return ret;
+}
+
 #ifdef TIOCGPTPEER
 static abi_long do_ioctl_tiocgptpeer(const IOCTLEntry *ie, uint8_t *buf_temp,
                                      int fd, int cmd, abi_long arg)
@@ -6271,32 +6381,6 @@ static inline abi_long target_ftruncate64(void *cpu_env, abi_long arg1,
 }
 #endif
 
-static inline abi_long target_to_host_timespec(struct timespec *host_ts,
-                                               abi_ulong target_addr)
-{
-    struct target_timespec *target_ts;
-
-    if (!lock_user_struct(VERIFY_READ, target_ts, target_addr, 1))
-        return -TARGET_EFAULT;
-    __get_user(host_ts->tv_sec, &target_ts->tv_sec);
-    __get_user(host_ts->tv_nsec, &target_ts->tv_nsec);
-    unlock_user_struct(target_ts, target_addr, 0);
-    return 0;
-}
-
-static inline abi_long host_to_target_timespec(abi_ulong target_addr,
-                                               struct timespec *host_ts)
-{
-    struct target_timespec *target_ts;
-
-    if (!lock_user_struct(VERIFY_WRITE, target_ts, target_addr, 0))
-        return -TARGET_EFAULT;
-    __put_user(host_ts->tv_sec, &target_ts->tv_sec);
-    __put_user(host_ts->tv_nsec, &target_ts->tv_nsec);
-    unlock_user_struct(target_ts, target_addr, 1);
-    return 0;
-}
-
 static inline abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
                                                  abi_ulong target_addr)
 {
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index fffa89f2564b..06622703008a 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -209,16 +209,34 @@ struct target_linger {
     abi_int l_linger;       /* How long to linger for       */
 };
 
+#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+struct target_timeval {
+    abi_long tv_sec;
+    abi_int tv_usec;
+};
+#define target__kernel_sock_timeval target_timeval
+#else
 struct target_timeval {
     abi_long tv_sec;
     abi_long tv_usec;
 };
 
+struct target__kernel_sock_timeval {
+    abi_llong tv_sec;
+    abi_llong tv_usec;
+};
+#endif
+
 struct target_timespec {
     abi_long tv_sec;
     abi_long tv_nsec;
 };
 
+struct target__kernel_timespec {
+    abi_llong tv_sec;
+    abi_llong tv_nsec;
+};
+
 struct target_timezone {
     abi_int tz_minuteswest;
     abi_int tz_dsttime;
@@ -749,8 +767,16 @@ struct target_pollfd {
 #define TARGET_SIOCGPGRP       0x8904
 #endif
 
-#define TARGET_SIOCGSTAMP      0x8906          /* Get stamp (timeval) */
-#define TARGET_SIOCGSTAMPNS    0x8907          /* Get stamp (timespec) */
+#if defined(TARGET_SH4)
+#define TARGET_SIOCGSTAMP_OLD   TARGET_IOR('s', 100, struct target_timeval)
+#define TARGET_SIOCGSTAMPNS_OLD TARGET_IOR('s', 101, struct target_timespec)
+#else
+#define TARGET_SIOCGSTAMP_OLD   0x8906
+#define TARGET_SIOCGSTAMPNS_OLD 0x8907
+#endif
+
+#define TARGET_SIOCGSTAMP_NEW   TARGET_IOR(0x89, 0x06, abi_llong[2])
+#define TARGET_SIOCGSTAMPNS_NEW TARGET_IOR(0x89, 0x07, abi_llong[2])
 
 /* Networking ioctls */
 #define TARGET_SIOCADDRT       0x890B          /* add routing table entry */
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index b98a23b0f1b0..4e3698382629 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -14,12 +14,6 @@ STRUCT(serial_icounter_struct,
 STRUCT(sockaddr,
        TYPE_SHORT, MK_ARRAY(TYPE_CHAR, 14))
 
-STRUCT(timeval,
-       MK_ARRAY(TYPE_LONG, 2))
-
-STRUCT(timespec,
-       MK_ARRAY(TYPE_LONG, 2))
-
 STRUCT(rtentry,
        TYPE_ULONG, MK_STRUCT(STRUCT_sockaddr), MK_STRUCT(STRUCT_sockaddr), MK_STRUCT(STRUCT_sockaddr),
        TYPE_SHORT, TYPE_SHORT, TYPE_ULONG, TYPE_PTRVOID, TYPE_SHORT, TYPE_PTRVOID,
-- 
2.21.0


