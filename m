Received: from eggs.gnu.org ([2001:4830:134:3::10]:51389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fahWa-000224-FD
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fahWX-0002zP-A1
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:08:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57669 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fahWX-0002z5-4Y
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:08:45 -0400
Date: Wed, 4 Jul 2018 14:08:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180704130841.GF32267@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <87tvpfch8g.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tvpfch8g.fsf@gnu.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?q?32-bit_=E2=80=9Cqemu-system-i386_-enable-?=
 =?utf-8?q?kvm=E2=80=9D_segfaults_on_x86=5F64?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ludovic =?utf-8?Q?Court=C3=A8s?= <ludo@gnu.org>
Cc: qemu-devel@nongnu.org

On Wed, Jul 04, 2018 at 02:34:07PM +0200, Ludovic Court=C3=A8s wrote:
> Hello,
>=20
> (I=E2=80=99m reporting the issue here because for some reason the launc=
hpad.net
> login page redirects me to an =E2=80=9Coops=E2=80=9D page and fails to =
log me in.)
>=20
> On a Linux 4.17 x86_64 host, =E2=80=9Cqemu-system-i386 -enable-kvm=E2=80=
=9D, where
> qemu-system-i386 is a 32-bit binary, crashes (it works fine without
> =E2=80=98-enable-kvm=E2=80=99):
>=20
> --8<---------------cut here---------------start------------->8---
> $ uname -rm
> 4.17.3-gnu x86_64
> $ file /gnu/store/h22dc67wzkv0w2l3775f0xqkyr318x5j-qemu-minimal-2.12.0/=
bin/qemu-system-i386=20
> /gnu/store/h22dc67wzkv0w2l3775f0xqkyr318x5j-qemu-minimal-2.12.0/bin/qem=
u-system-i386: ELF 32-bit LSB shared object, Intel 80386, version 1 (SYSV=
), dynamically linked, interpreter /gnu/store/4aka3nwppxf3z072l6vr8cxvwj3=
x5h9s-glibc-2.27/lib/ld-linux.so.2, for GNU/Linux 2.6.32, stripped

It appears that not only are you using qemu-system-i386 on x86_64
host, but this has actually also been built as a 32-bit ELF binary,
so will be using the 32-bit compat syscalls. This is quite possibly
relevant to any crash, so it would be useful to know if qemu-system-i386,
when built as a 64-bit ELF binary works or fails.

It appears you are using 2.12.0 release, so it is also helpful if
you would try using current git master to see if it still reproduces.


> $ /gnu/store/h22dc67wzkv0w2l3775f0xqkyr318x5j-qemu-minimal-2.12.0/bin/q=
emu-system-i386 -enable-kvm /dev/null
> WARNING: Image format was not specified for '/dev/null' and probing gue=
ssed raw.
>          Automatically detecting the format is dangerous for raw images=
, write operations on block 0 will be restricted.
>          Specify the 'raw' format explicitly to remove the restrictions=
.
> VNC server running on 127.0.0.1:5900
> Adres-eraro(nekropsio el=C5=9Dutita)
> --8<---------------cut here---------------start------------->8---
>=20
> I=E2=80=99d need debugging symbols to provide a useful backtrace, but p=
erhaps
> the strace gives useful hints:

strace's are fairly unhelpful I'm afraid, so collecting a stack trace
would be best next step.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
