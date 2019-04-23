Received: from eggs.gnu.org ([209.51.188.92]:60226)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<3oI-_XAIKCqkNTPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--ek.bounces.google.com>)
	id 1hJ3mX-0007jb-Uy
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<3oI-_XAIKCqkNTPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--ek.bounces.google.com>)
	id 1hJ3mQ-0005cz-Gc
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:20:50 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a]:48289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<3oI-_XAIKCqkNTPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--ek.bounces.google.com>)
	id 1hJ3mO-0005Sf-Cn
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:20:46 -0400
Received: by mail-pg1-x54a.google.com with SMTP id o1so10835250pgv.15
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:20:18 -0700 (PDT)
Date: Tue, 23 Apr 2019 15:20:05 -0700
Message-Id: <20190423222005.246981-1-ek@google.com>
Mime-Version: 1.0
From: Erik Kline <ek@google.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] The ioctl(SIOCGIFNAME) call requires a struct
 ifreq.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ek@loon.com, Erik Kline <ek@google.com>

Signed-off-by: Erik Kline <ek@google.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1814352
---
 linux-user/ioctls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index ae8951625f..37501f575c 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -178,7 +178,7 @@
 #endif /* CONFIG_USBFS */
 
   IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
-  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(TYPE_INT))
+  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
   IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
   IOCTL(SIOCSIFFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
   IOCTL(SIOCGIFADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
-- 
2.21.0.593.g511ec345e18-goog
