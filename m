Received: from eggs.gnu.org ([209.51.188.92]:51414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hIzMJ-00081S-BM
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hIzKY-00086S-Vv
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:35:44 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49603 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hIzKW-00080M-Ug
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:35:42 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Apr 2019 19:35:22 +0200
Message-Id: <1556040926-23931-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/4] linux-user: A set of misc patches for 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, daniel.santos@pobox.com, jcmvbkbc@gmail.com, lvivier@redhat.com, thuth@redhat.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This is a collection of misc patches for kinux user that I recently
collected. Most of them originate from problems observed on target
mips. However, all of them actually fix problems on multiple
targets.

Aleksandar Markovic (2):
  linux-user: Fix support for the SIOCATMARK and SIOCGPGRP ioctls for
    eXtensa
  linux-user: Add support for the SIOCSPGRP ioctl

Daniel Santos (1):
  linux-user: Sanitize interp_info and, for mips only, init field fp_abi

Neng Chen (1):
  linux-user: Add support the SIOCSIFPFLAGS and SIOCGIFPFLAGS ioctls

 linux-user/elfload.c      | 5 +++++
 linux-user/ioctls.h       | 3 +++
 linux-user/syscall_defs.h | 8 +++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.7.4
