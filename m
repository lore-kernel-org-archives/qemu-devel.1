Received: from eggs.gnu.org ([2001:4830:134:3::10]:58190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVv-0004c9-BH
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVs-0007n1-5H
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:59 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:42558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtVr-0007mK-UU
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:56 -0500
Received: by mail-lf0-x244.google.com with SMTP id m1so11692250lfj.9
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:21:55 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:34 +0200
Message-Id: <3d60c84deaa11826ff0bc7599aeb73cad54c4fbf.1511212753.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1511212753.git.riku.voipio@linaro.org>
References: <cover.1511212753.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 06/15] linux-user/hppa: Fix TARGET_F_RDLCK,
 TARGET_F_WRLCK, TARGET_F_UNLCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>

From: Helge Deller <deller@gmx.de>

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-ID: <20170311175019.GA7195@ls3530.fritz.box>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall_defs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index a6ed30d70e..daa2a57398 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2361,6 +2361,9 @@ struct target_statfs64 {
 #define TARGET_F_SETOWN        24       /*  for sockets. */
 #define TARGET_F_GETOWN        23       /*  for sockets. */
 #elif defined(TARGET_HPPA)
+#define TARGET_F_RDLCK         1
+#define TARGET_F_WRLCK         2
+#define TARGET_F_UNLCK         3
 #define TARGET_F_GETLK         5
 #define TARGET_F_SETLK         6
 #define TARGET_F_SETLKW        7
-- 
2.14.2
