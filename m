Received: from eggs.gnu.org ([2001:4830:134:3::10]:48037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cjUXB-0005EF-85
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cjUX8-0005Bv-4g
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:28:57 -0500
Received: from chuckie.co.uk ([82.165.15.123]:50144
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cjUX7-00056V-SG
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:28:54 -0500
Received: from [86.188.254.49] (helo=[172.30.1.185])
	by s16892447.onlinehome-server.info with esmtpsa
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cjUWu-0006hM-LO
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:28:41 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <a8300848-9e60-7d62-d8bd-c0084691abbb@ilande.co.uk>
Date: Thu, 2 Mar 2017 17:28:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Does anyone else see the following error when trying to build git master?

cc -I/home/build/src/qemu/git/qemu/hw/9pfs -Ihw/9pfs
-I/home/build/src/qemu/git/qemu/tcg
-I/home/build/src/qemu/git/qemu/tcg/i386
-I/home/build/src/qemu/git/qemu/linux-headers
-I/home/build/src/qemu/git/qemu/linux-headers -I.
-I/home/build/src/qemu/git/qemu -I/home/build/src/qemu/git/qemu/include
-I/usr/include/pixman-1   -I/home/build/src/qemu/git/qemu/dtc/libfdt
-Werror -pthread -I/usr/include/glib-2.0
-I/usr/lib/x86_64-linux-gnu/glib-2.0/include   -m64 -mcx16 -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
-Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
-fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels
-Wno-missing-include-dirs -Wempty-body -Wnested-externs
-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
-Wold-style-declaration -Wold-style-definition -Wtype-limits
-fstack-protector-all -I/usr/include/p11-kit-1
-I/usr/include/libpng12   -I/home/build/src/qemu/git/qemu/tests -MMD -MP
-MT hw/9pfs/9p-util.o -MF hw/9pfs/9p-util.d -O2 -U_FORTIFY_SOURCE
-D_FORTIFY_SOURCE=2 -g   -c -o hw/9pfs/9p-util.o hw/9pfs/9p-util.c
In file included from hw/9pfs/9p-util.c:15:0:
hw/9pfs/9p-util.h: In function ‘openat_dir’:
hw/9pfs/9p-util.h:25:57: error: ‘O_PATH’ undeclared (first use in this
function)
hw/9pfs/9p-util.h:25:57: note: each undeclared identifier is reported
only once for each function it appears in
hw/9pfs/9p-util.h:26:1: error: control reaches end of non-void function
[-Werror=return-type]

Build platform is Debian Wheezy on an x86_64 host.


ATB,

Mark.
