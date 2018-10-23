Received: from eggs.gnu.org ([2001:4830:134:3::10]:42154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEtdP-0004V2-Mb
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 06:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEtSD-00014O-FF
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:58:30 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57540 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEtS6-0000wq-NN
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:58:23 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Oct 2018 11:58:05 +0200
Message-Id: <1540288688-4482-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/3] linux-user: Support for misc feateres
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, arikalo@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, riku.voipio@iki.fi, laurent@vivier.eu, ysu@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This series add support for two system calls and a socket-related
improvement.

Aleksandar Rikalo (2):
  linux-user: Add support for statx() syscall
  linux-user: Add support for semtimedop() syscall

Yunqiang Su (1):
  linux-user: Add support for SO_REUSEPORT

 linux-user/strace.c       |   3 +
 linux-user/syscall.c      | 158 +++++++++++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |  38 +++++++++++
 3 files changed, 198 insertions(+), 1 deletion(-)

-- 
2.7.4
