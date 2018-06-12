Received: from eggs.gnu.org ([2001:4830:134:3::10]:50332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh1E-0003q4-VA
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh1A-0007OE-Va
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:59:21 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:47965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSh1A-0007Ne-Lv
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:59:16 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 12 Jun 2018 12:58:30 +0200
Message-Id: <20180612105831.25703-8-laurent@vivier.eu>
In-Reply-To: <20180612105831.25703-1-laurent@vivier.eu>
References: <20180612105831.25703-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 7/8] linux-user/microblaze: Fix typo in accept4
 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180607184844.30126-4-richard.henderson@linaro.org>
[lv: replace tabs by spaces]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/microblaze/syscall_nr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/microblaze/syscall_nr.h b/linux-user/microblaze/syscall_nr.h
index 0704449bae..5d1a47a9a9 100644
--- a/linux-user/microblaze/syscall_nr.h
+++ b/linux-user/microblaze/syscall_nr.h
@@ -363,7 +363,7 @@
 #define TARGET_NR_shutdown		359 /* new */
 #define TARGET_NR_sendmsg		360 /* new */
 #define TARGET_NR_recvmsg		361 /* new */
-#define TARGET_NR_accept04		362 /* new */
+#define TARGET_NR_accept4               362 /* new */
 #define TARGET_NR_preadv                363 /* new */
 #define TARGET_NR_pwritev               364 /* new */
 #define TARGET_NR_rt_tgsigqueueinfo     365 /* new */
-- 
2.14.4
