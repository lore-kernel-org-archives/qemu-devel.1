Received: from eggs.gnu.org ([2001:4830:134:3::10]:42280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cjb6v-0003mQ-JF
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 19:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cjb6s-0000P1-7o
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 19:30:17 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:35810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cjb6s-0000Oi-3c
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 19:30:14 -0500
Received: by mail-io0-x243.google.com with SMTP id f103so5265316ioi.2
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 16:30:14 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.56353.1488479169.22739.qemu-devel@nongnu.org>
Date: Thu, 2 Mar 2017 19:30:11 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B8BC075-03EB-4D2E-8A98-6D8422167291@gmail.com>
References: <mailman.56353.1488479169.22739.qemu-devel@nongnu.org>
Subject: Re: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org


On Mar 2, 2017, at 1:26 PM, qemu-devel-request@nongnu.org wrote:
>=20
> Does anyone else see the following error when trying to build git =
master?
>=20
> cc -I/home/build/src/qemu/git/qemu/hw/9pfs -Ihw/9pfs
> -I/home/build/src/qemu/git/qemu/tcg
> -I/home/build/src/qemu/git/qemu/tcg/i386
> -I/home/build/src/qemu/git/qemu/linux-headers
> -I/home/build/src/qemu/git/qemu/linux-headers -I.
> -I/home/build/src/qemu/git/qemu =
-I/home/build/src/qemu/git/qemu/include
> -I/usr/include/pixman-1   -I/home/build/src/qemu/git/qemu/dtc/libfdt
> -Werror -pthread -I/usr/include/glib-2.0
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include   -m64 -mcx16 =
-D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
> -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
> -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels
> -Wno-missing-include-dirs -Wempty-body -Wnested-externs
> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> -Wold-style-declaration -Wold-style-definition -Wtype-limits
> -fstack-protector-all -I/usr/include/p11-kit-1
> -I/usr/include/libpng12   -I/home/build/src/qemu/git/qemu/tests -MMD =
-MP
> -MT hw/9pfs/9p-util.o -MF hw/9pfs/9p-util.d -O2 -U_FORTIFY_SOURCE
> -D_FORTIFY_SOURCE=3D2 -g   -c -o hw/9pfs/9p-util.o hw/9pfs/9p-util.c
> In file included from hw/9pfs/9p-util.c:15:0:
> hw/9pfs/9p-util.h: In function ?openat_dir?:
> hw/9pfs/9p-util.h:25:57: error: ?O_PATH? undeclared (first use in this
> function)
> hw/9pfs/9p-util.h:25:57: note: each undeclared identifier is reported
> only once for each function it appears in
> hw/9pfs/9p-util.h:26:1: error: control reaches end of non-void =
function
> [-Werror=3Dreturn-type]
>=20
> Build platform is Debian Wheezy on an x86_64 host.
>=20
>=20
> ATB,
>=20
> Mark.

Today when I tried building QEMU I saw this error message that said I =
was not on a branch. I never saw that before. After a quick 'git =
checkout master', I was able to 'pull' and 'make' QEMU successfully. I =
made qemu-system-ppc. Here is the latest commit from git log:=20

commit ecb24d334af1a98ef0329f4b3b0e14ae8cb8770d
Merge: 6835504 3db010c
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Thu Mar 2 22:06:41 2017 +0000

Which target are you trying to build?=20=
