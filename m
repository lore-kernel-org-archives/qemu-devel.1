Received: from eggs.gnu.org ([2001:4830:134:3::10]:48980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fnmIe-0000Cg-Li
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fnmId-0002xS-JR
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:52:28 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::11]:30996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1fnmId-0002vJ-3F
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:52:27 -0400
Date: Thu, 9 Aug 2018 16:52:20 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180809165220.47e306d4.olaf@aepfle.de>
In-Reply-To: <20180809163816.092a7c8c.olaf@aepfle.de>
References: <20180809141403.11296-1-olaf@aepfle.de>
	<20180809162403.32c53c50.olaf@aepfle.de>
	<30203041-c944-1a12-d983-9735756dc334@redhat.com>
	<20180809163816.092a7c8c.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Fx0WMBX2NLBB8+ZsQsBeCVt";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v1] exec: handle NULL pointer in
 flatview_read_continue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>

--Sig_/Fx0WMBX2NLBB8+ZsQsBeCVt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 9 Aug 2018 16:38:16 +0200
schrieb Olaf Hering <olaf@aepfle.de>:

> Someone familiar with that code has to figure that out. A ballooned page =
will trigger that bug.

Indeed, xen-4.4 + qemu-3.0 crashes with ballooned pages. That can easily ha=
ppen if the domU does readdir via NFS.

Olaf

Thread 1 "qemu-system-i38" received signal SIGSEGV, Segmentation fault.
0x00007f439593f2ee in __memcpy_sse2_unaligned () from /lib64/libc.so.6
#0  0x00007f439593f2ee in __memcpy_sse2_unaligned () at /lib64/libc.so.6
#1  0x000055c7f7c8ee14 in memcpy (__len=3D1, __src=3D<optimized out>, __des=
t=3D0x7fff6819bc68) at /usr/include/bits/string3.h:53
#2  0x000055c7f7c8ee14 in flatview_read_continue (fv=3D0x55c7f99350f0, addr=
=3D3833593856, attrs=3D..., buf=3D0x7fff6819bc68 "", len=3D1, addr1=3D38335=
93856, l=3D1, mr=3D0x55c7f88309a0 <ram_memory>)
    at /usr/src/debug/qemu-3.0-20180807T172617.6ad9080538/exec.c:3321
#3  0x000055c7f7c8efef in flatview_read (fv=3D0x55c7f99350f0, addr=3D383359=
3856, attrs=3D..., buf=3D0x7fff6819bc68 "", len=3D1) at /usr/src/debug/qemu=
-3.0-20180807T172617.6ad9080538/exec.c:3354
#4  0x000055c7f7c8f11f in address_space_read_full (as=3D<optimized out>, ad=
dr=3D<optimized out>, attrs=3D..., buf=3D<optimized out>, len=3D<optimized =
out>)
    at /usr/src/debug/qemu-3.0-20180807T172617.6ad9080538/exec.c:3367
#5  0x000055c7f7c8f337 in cpu_physical_memory_rw (addr=3D<optimized out>, b=
uf=3D<optimized out>, len=3D<optimized out>, is_write=3D<optimized out>)
    at /usr/src/debug/qemu-3.0-20180807T172617.6ad9080538/exec.c:3404
#6  0x000055c7f7d980a6 in read_phys_req_item (val=3D0x7fff6819bc68, i=3D0, =
req=3D0x7fff6819bc60, addr=3D<optimized out>)
    at /usr/src/debug/qemu-3.0-20180807T172617.6ad9080538/hw/i386/xen/xen-h=
vm.c:841
#7  0x000055c7f7d980a6 in cpu_ioreq_move (req=3D0x7fff6819bc60) at /usr/src=
/debug/qemu-3.0-20180807T172617.6ad9080538/hw/i386/xen/xen-hvm.c:904
#8  0x000055c7f7d980a6 in handle_ioreq (state=3D<optimized out>, req=3D0x7f=
ff6819bc60) at /usr/src/debug/qemu-3.0-20180807T172617.6ad9080538/hw/i386/x=
en/xen-hvm.c:1046
#9  0x000055c7f7d99b85 in cpu_handle_ioreq (opaque=3D0x55c7f90fe360) at /us=
r/src/debug/qemu-3.0-20180807T172617.6ad9080538/hw/i386/xen/xen-hvm.c:1153
#10 0x000055c7f811e288 in aio_dispatch_handlers (ctx=3D0x55c7f9052130) at u=
til/aio-posix.c:406
#11 0x000055c7f811ec48 in aio_dispatch (ctx=3D0x55c7f9052130) at util/aio-p=
osix.c:437
#12 0x000055c7f811a75e in aio_ctx_dispatch (source=3D<optimized out>, callb=
ack=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:261
#13 0x00007f43965d6134 in g_main_context_dispatch () at /usr/lib64/libglib-=
2.0.so.0
#14 0x000055c7f811dca7 in glib_pollfds_poll () at util/main-loop.c:215
#15 0x000055c7f811dca7 in os_host_main_loop_wait (timeout=3D<optimized out>=
) at util/main-loop.c:238
#16 0x000055c7f811dca7 in main_loop_wait (nonblocking=3D<optimized out>) at=
 util/main-loop.c:497
#17 0x000055c7f7e129c2 in main_loop () at vl.c:1866
#18 0x000055c7f7c7efdc in main ()

--Sig_/Fx0WMBX2NLBB8+ZsQsBeCVt
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW2xVJAAKCRBdQqD6ppg2
fhuRAKDDBx0URmVNBXJMrUcF54yZAgmzBACg056z6fYEiqon+e31OIe0A0Z8W9I=
=Vk9o
-----END PGP SIGNATURE-----

--Sig_/Fx0WMBX2NLBB8+ZsQsBeCVt--
