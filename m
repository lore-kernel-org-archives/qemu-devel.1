Received: from eggs.gnu.org ([2001:4830:134:3::10]:44022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1gRcJH-0003rE-PP
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:17:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1gRcJC-0008Lx-PX
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:17:47 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:37128
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan@weilnetz.de>) id 1gRcJC-0008LO-J9
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:17:42 -0500
From: Stefan Weil <sw@weilnetz.de>
Date: Tue, 27 Nov 2018 13:17:22 +0100
Message-Id: <20181127121724.19755-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH for-3.1 0/2] Fix disas/nanomips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>

These two patches fix wrong format strings used in disas/nanomips.

The first patch replaces proprietary data types by POSIX data types,
because otherwise the PRI... macros cannot be used in the second patch.

Those patches are only relevant for 3.1 if full nanomips support is considered
important enought and if QEMU is used on big endian machines (I think
the old code will work on little endian hosts even with wrong format
strings).

I use those patches for QEMU for Windows because that is compiled with
more compiler warnings, so compilation would fail without the fix.

Regards
Stefan
