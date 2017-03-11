Received: from eggs.gnu.org ([2001:4830:134:3::10]:48375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cmduW-0006KD-T9
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 05:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cmduR-0001UG-26
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 05:06:04 -0500
Received: from mout.gmx.net ([212.227.15.18]:60884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1cmduQ-0001U2-NM
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 05:05:58 -0500
Date: Sat, 11 Mar 2017 11:05:43 +0100
From: Helge Deller <deller@gmx.de>
Message-ID: <20170311100543.GA29669@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] linux-user/hppa: Fix typo for
 TARGET_NR_epoll_wait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>
Cc: Richard Henderson <rth@twiddle.net>

This fixes running a dynamically linked nslookup binary on hppa with
LD_BIND_NOW=1.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/hppa/syscall_nr.h b/linux-user/hppa/syscall_nr.h
index 0f396fa..55bdf71 100644
--- a/linux-user/hppa/syscall_nr.h
+++ b/linux-user/hppa/syscall_nr.h
@@ -228,7 +228,7 @@
 #define TARGET_NR_lookup_dcookie    223
 #define TARGET_NR_epoll_create      224
 #define TARGET_NR_epoll_ctl         225
-#define TARGET_NR_epill_wait        226
+#define TARGET_NR_epoll_wait        226
 #define TARGET_NR_remap_file_pages  227
 #define TARGET_NR_semtimedop        228
 #define TARGET_NR_mq_open           229
