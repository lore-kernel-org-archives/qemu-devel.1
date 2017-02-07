Received: from eggs.gnu.org ([2001:4830:134:3::10]:48382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cavaf-0003R0-Mm
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:33:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cavaf-0005Ub-07
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:33:09 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:34924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cavae-0005UU-SX
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:33:08 -0500
Received: by mail-io0-x243.google.com with SMTP id m98so11535577iod.2
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 18:33:08 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  6 Feb 2017 18:32:27 -0800
Message-Id: <20170207023229.29431-4-rth@twiddle.net>
In-Reply-To: <20170207023229.29431-1-rth@twiddle.net>
References: <20170207023229.29431-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 3/5] linux-user: define correct UTS machine name
 for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Laurent Vivier <laurent@vivier.eu>

From: Laurent Vivier <laurent@vivier.eu>

the correct UTS machine name (as expected by systemd) is "parisc",
not "hppa".

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20170126080449.28255-4-laurent@vivier.eu>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/hppa/target_syscall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/hppa/target_syscall.h b/linux-user/hppa/target_syscall.h
index ac18a9c..e2f3668 100644
--- a/linux-user/hppa/target_syscall.h
+++ b/linux-user/hppa/target_syscall.h
@@ -19,7 +19,7 @@ struct target_pt_regs {
     target_ulong ipsw;
 };
 
-#define UNAME_MACHINE "hppa"
+#define UNAME_MACHINE "parisc"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 #define TARGET_CLONE_BACKWARDS
 #define TARGET_MINSIGSTKSZ       2048
-- 
2.9.3
