Received: from eggs.gnu.org ([2001:4830:134:3::10]:44654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1essHz-0001Sg-PJ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1essHy-0007t2-VQ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:44:35 -0500
Date: Mon, 5 Mar 2018 15:44:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180305154429.GM7910@stefanha-x1.localdomain>
References: <60d1e2ab-c3a4-cae2-b810-5e46dc124b0b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/t6ASE28jIy1gGy9"
Content-Disposition: inline
In-Reply-To: <60d1e2ab-c3a4-cae2-b810-5e46dc124b0b@redhat.com>
Subject: Re: [Qemu-devel] Intermittent failure of iotest 203
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--/t6ASE28jIy1gGy9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 02:03:15PM +0100, Max Reitz wrote:
> Hi,
>=20
> iotest 203 relatively often fails for me, at least when run in parallel.
>  When I run the following concurrently on four shells:
>=20
> $ while TEST_DIR=3D/tmp/t1 ./check -T -qcow2 203; do; done
> $ while TEST_DIR=3D/tmp/t2 ./check -T -qcow2 203; do; done
> $ while TEST_DIR=3D/tmp/t3 ./check -T -qcow2 203; do; done
> $ while TEST_DIR=3D/tmp/t4 ./check -T -qcow2 203; do; done
>=20
> Very quickly (like under ten iterations), at least one of those starts
> to hang and then fails because of a timeout in vm.get_qmp_event().
>=20
> Before digging deeper into the ppoll() dungeon* myself, I decided to
> report this so I wouldn't have to. :-)

Thanks for reporting it.  I will send a patch and CC you.

Stefan

> *Backtrace:
>=20
> (gdb) bt
> #0  0x00007f354137b4d6 in ppoll () at /lib64/libc.so.6
> #1  0x000055b659144299 in ppoll (__ss=3D0x0, __timeout=3D0x7ffe4eaca230,
> __nfds=3D<optimized out>, __fds=3D<optimized out>) at
> /usr/include/bits/poll2.h:77
> #2  0x000055b659144299 in qemu_poll_ns (fds=3D<optimized out>,
> nfds=3D<optimized out>, timeout=3Dtimeout@entry=3D39512999619000) at
> util/qemu-timer.c:334
> #3  0x000055b6591450a3 in os_host_main_loop_wait (timeout=3D<optimized
> out>) at util/main-loop.c:255
> #4  0x000055b6591450a3 in main_loop_wait (nonblocking=3D<optimized out>)
> at util/main-loop.c:515
> #5  0x000055b658d4a253 in main_loop () at vl.c:1933
> #6  0x000055b658d4a253 in main (argc=3D<optimized out>, argv=3D<optimized
> out>, envp=3D<optimized out>) at vl.c:4757
>=20
> Max
>=20




--/t6ASE28jIy1gGy9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanWXdAAoJEJykq7OBq3PIzkkH/3Z8oDIe8iRyEWxCAD0T62EZ
9tRr+ezyyD/DxmcxRvP/NTQjL/U79zJAfqSwej/ZLqj5lB5w4/gPwTIrGdUdhggJ
Qz9+lQy1eKnsTvzit0lQ6qyq6Esz7EVEAzAX8V+pYxpAL4O5bT5lkM9T11+zGI50
nPMUyW8xgbVnSSyrMf+OXe+ql0zmIfWdXPD4iocrq5MLf7Bai72EGbLyWlaQ3NNi
NDWTBFNLvx5BJCpmCCY41RvB5XulC1+iH0A0iP09PW0L+xu7xfbqblYTHo6M1Cgc
ErvFddHwZaia/WZ5/bnLCN9E3vAIa9Vf19txnx3A26UtBLiOQqsrgOElGCj4QMg=
=fy2L
-----END PGP SIGNATURE-----

--/t6ASE28jIy1gGy9--
