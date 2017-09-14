Received: from eggs.gnu.org ([2001:4830:134:3::10]:56539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dsX6s-00011J-4A
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dsX6n-0003Jd-4M
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:35:26 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:63090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dsX6m-0003Ih-RE
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:35:21 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 14 Sep 2017 18:35:04 +0200
Message-Id: <20170914163505.20558-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v4 0/1] target/m68k,
 linux-user: manage FP registers in ucontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

v3:
    rebase and add R-b from rth
    should also fix patchew errors as the missing commits
    are now in the master

v2:
    add missing cpu_m68k_set_fpcr() to update FPU internal state

The v1 was in the v5 of the series "target-m68k: implement 680x0 FPU"

Laurent Vivier (1):
  target/m68k,linux-user: manage FP registers in ucontext

 linux-user/signal.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

-- 
2.13.5
