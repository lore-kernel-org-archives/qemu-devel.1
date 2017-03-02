Received: from eggs.gnu.org ([2001:4830:134:3::10]:51866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjUiS-0000P6-1p
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjUiO-00043b-6x
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:40:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cjUiO-00042b-0E
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:40:32 -0500
Date: Thu, 2 Mar 2017 17:40:26 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170302174026.GI11445@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <a8300848-9e60-7d62-d8bd-c0084691abbb@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8300848-9e60-7d62-d8bd-c0084691abbb@ilande.co.uk>
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel <qemu-devel@nongnu.org>

On Thu, Mar 02, 2017 at 05:28:24PM +0000, Mark Cave-Ayland wrote:
> Does anyone else see the following error when trying to build git maste=
r?
>=20
> cc -I/home/build/src/qemu/git/qemu/hw/9pfs -Ihw/9pfs
> -I/home/build/src/qemu/git/qemu/tcg
> -I/home/build/src/qemu/git/qemu/tcg/i386
> -I/home/build/src/qemu/git/qemu/linux-headers
> -I/home/build/src/qemu/git/qemu/linux-headers -I.
> -I/home/build/src/qemu/git/qemu -I/home/build/src/qemu/git/qemu/include
> -I/usr/include/pixman-1   -I/home/build/src/qemu/git/qemu/dtc/libfdt
> -Werror -pthread -I/usr/include/glib-2.0
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include   -m64 -mcx16 -D_GNU_SOURC=
E
> -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
> -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
> -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels
> -Wno-missing-include-dirs -Wempty-body -Wnested-externs
> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> -Wold-style-declaration -Wold-style-definition -Wtype-limits
> -fstack-protector-all -I/usr/include/p11-kit-1
> -I/usr/include/libpng12   -I/home/build/src/qemu/git/qemu/tests -MMD -M=
P
> -MT hw/9pfs/9p-util.o -MF hw/9pfs/9p-util.d -O2 -U_FORTIFY_SOURCE
> -D_FORTIFY_SOURCE=3D2 -g   -c -o hw/9pfs/9p-util.o hw/9pfs/9p-util.c
> In file included from hw/9pfs/9p-util.c:15:0:
> hw/9pfs/9p-util.h: In function =E2=80=98openat_dir=E2=80=99:
> hw/9pfs/9p-util.h:25:57: error: =E2=80=98O_PATH=E2=80=99 undeclared (fi=
rst use in this
> function)
> hw/9pfs/9p-util.h:25:57: note: each undeclared identifier is reported
> only once for each function it appears in
> hw/9pfs/9p-util.h:26:1: error: control reaches end of non-void function
> [-Werror=3Dreturn-type]
>=20
> Build platform is Debian Wheezy on an x86_64 host.

IIUC, O_PATH was introduced in glibc 2.14 and Wheezy only has 2.13.

So unless we want to make this 9pfs code a configurable option, this=20
means Debian Wheezy is no longer a supportable platform for QEMU.

Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
