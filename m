Received: from eggs.gnu.org ([2001:4830:134:3::10]:54267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e9W48-0002e6-2b
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e9W47-0005gv-C8
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:48 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:49911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e9W47-0005ej-5G
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:54:47 -0400
Received: by mail-wr0-x244.google.com with SMTP id g90so15837954wrd.6
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 05:54:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 31 Oct 2017 13:53:57 +0100
Message-Id: <20171031125358.23377-7-richard.henderson@linaro.org>
In-Reply-To: <20171031125358.23377-1-richard.henderson@linaro.org>
References: <20171031125358.23377-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 6/7] linux-user/hppa: Fix TARGET_F_RDLCK,
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
Cc: riku.voipio@iki.fi, Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>

From: Helge Deller <deller@gmx.de>

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-ID: <20170311175019.GA7195@ls3530.fritz.box>
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
2.13.6
