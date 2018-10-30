Received: from eggs.gnu.org ([2001:4830:134:3::10]:39602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHTYb-0007AC-4H
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHTYU-0006QJ-VA
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:55:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60077 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gHTYM-0006BF-Fq
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:55:29 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 30 Oct 2018 13:55:05 +0100
Message-Id: <1540904108-30873-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 0/3] linux-user: Support for misc features
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

v2-v3:
  - patch on statx() modified according to the feedback
  - patch on semtimedop() modified according to the feedback

v1->v2:
  - fixed a typo in the title
  - cosmetic comment reformats
  - fixed build error related to old label 'efault'
  - fixed wrong email addresses

Aleksandar Rikalo (2):
  linux-user: Add support for statx() syscall
  linux-user: Add support for semtimedop() syscall

Yunqiang Su (1):
  linux-user: Add support for SO_REUSEPORT

 linux-user/strace.c       |   3 +
 linux-user/syscall.c      | 181 +++++++++++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |  38 ++++++++++
 3 files changed, 221 insertions(+), 1 deletion(-)

-- 
2.7.4
