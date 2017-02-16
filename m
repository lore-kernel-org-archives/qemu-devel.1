Received: from eggs.gnu.org ([2001:4830:134:3::10]:48629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxb-0002zK-Fo
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:23:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxX-0002SQ-Qa
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:23:03 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:57123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ceMxX-0002RI-F7
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:22:59 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 16 Feb 2017 15:22:15 +0100
Message-Id: <20170216142227.27448-3-laurent@vivier.eu>
In-Reply-To: <20170216142227.27448-1-laurent@vivier.eu>
References: <20170216142227.27448-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 02/14] linux-user: drop __cygwin__ ifdef
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Riku Voipio <riku.voipio@linaro.org>, Richard Henderson <rth@twiddle.net>

From: Riku Voipio <riku.voipio@linaro.org>

linux-user doesn't work on cygwin anyways.

Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/mmap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 61685bf..4ed9cad 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -193,9 +193,6 @@ static int mmap_frag(abi_ulong real_start,
 
 #if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
 # define TASK_UNMAPPED_BASE  (1ul << 38)
-#elif defined(__CYGWIN__)
-/* Cygwin doesn't have a whole lot of address space.  */
-# define TASK_UNMAPPED_BASE  0x18000000
 #else
 # define TASK_UNMAPPED_BASE  0x40000000
 #endif
-- 
2.9.3
