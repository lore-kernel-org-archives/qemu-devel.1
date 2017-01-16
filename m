Received: from eggs.gnu.org ([2001:4830:134:3::10]:34551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anibal.limon@linux.intel.com>) id 1cTFKN-0000Mt-LD
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:00:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anibal.limon@linux.intel.com>) id 1cTFKK-0008Pa-BX
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:00:35 -0500
References: <587D4171.6@linux.intel.com>
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
Message-ID: <587D4329.5020702@linux.intel.com>
Date: Mon, 16 Jan 2017 16:03:21 -0600
MIME-Version: 1.0
In-Reply-To: <587D4171.6@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="qj0E485stXgfPDaASDJLoqEhgBGeWWco1"
Subject: Re: [Qemu-devel] qemu-pcc 2.8.0 linux-user segfaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qj0E485stXgfPDaASDJLoqEhgBGeWWco1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/16/2017 03:56 PM, An=C3=ADbal Lim=C3=B3n wrote:
> Hi folks,
>=20
> I'm trying to upgrade qemu to 2.8.0 in Openembedded-core and segfaults
> in qemu-ppc when is executing:
>=20
> /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2.8=
=2E0-r0/build/ppc-linux-user/qemu-ppc
> -s 16M -r 3.2.0 -cpu 7400 -L
> /home/alimon/repos/poky/build-ppc/tmp/sysroots/qemuppc -E
> LD_LIBRARY_PATH=3D/home/alimon/repos/poky/build-ppc/tmp/work/ppc7400-po=
ky-linux/gobject-introspection/1.50.0-r0/build/.libs:.libs:/home/alimon/r=
epos/poky/build-ppc/tmp/sysroots/qemuppc//usr/lib:/home/alimon/repos/poky=
/build-ppc/tmp/sysroots/qemuppc//lib
> /home/alimon/repos/poky/build-ppc/tmp/work/ppc7400-poky-linux/gobject-i=
ntrospection/1.50.0-r0/build/tmp-introspectu_ewt_1z/Gio-2.0
> --introspect-dump=3D/home/alimon/repos/poky/build-ppc/tmp/work/ppc7400-=
poky-linux/gobject-introspection/1.50.0-r0/build/tmp-introspectu_ewt_1z/f=
unctions.txt,/home/alimon/repos/poky/build-ppc/tmp/work/ppc7400-poky-linu=
x/gobject-introspection/1.50.0-r0/build/tmp-introspectu_ewt_1z/dump.xml
> [Thread debugging using libthread_db enabled]
>=20
>=20
> And the debug info,
>=20
> (gdb) info threads
>   Id   Target Id         Frame
>   1    Thread 0x7ffff7fd0780 (LWP 25457) "qemu-ppc"
> pthread_cond_wait@@GLIBC_2.3.2 () at
> ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
>   2    Thread 0x7ffff647e700 (LWP 25461) "qemu-ppc" syscall () at
> ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
> * 3    Thread 0x7ffff7f4d700 (LWP 25462) "qemu-ppc" 0x000000000086fba4
> in static_code_gen_buffer ()
>=20
> (gdb) bt
> #0  0x000000000086fba4 in static_code_gen_buffer ()
> #1  0x000000000040e922 in cpu_tb_exec (itb=3D<optimized out>,
> itb=3D<optimized out>, cpu=3D0x29864d0) at
> /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2.8=
=2E0-r0/qemu-2.8.0/cpu-exec.c:164
> #2  cpu_loop_exec_tb (sc=3D<optimized out>, tb_exit=3D<synthetic pointe=
r>,
> last_tb=3D<synthetic pointer>, tb=3D<optimized out>, cpu=3D0x29864d0) a=
t
> /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2.8=
=2E0-r0/qemu-2.8.0/cpu-exec.c:544
> #3  cpu_exec (cpu=3Dcpu@entry=3D0x29864d0) at
> /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2.8=
=2E0-r0/qemu-2.8.0/cpu-exec.c:638
> #4  0x0000000000445fba in cpu_loop (env=3Denv@entry=3D0x298e750) at
> /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2.8=
=2E0-r0/qemu-2.8.0/linux-user/main.c:1359
> #5  0x0000000000448a95 in clone_func (arg=3D0x7fffffffa910) at
> /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2.8=
=2E0-r0/qemu-2.8.0/linux-user/syscall.c:6090
> #6  0x00007ffff6a750a4 in start_thread (arg=3D0x7ffff7f4d700) at
> pthread_create.c:309
> #7  0x00007ffff67aa62d in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Here is the core dump,

https://drive.google.com/file/d/0B9uDfO-FJ1kgY3ZhendISTZzOUU/view?usp=3Ds=
haring

>=20
> Any help will be appreciated.
>=20
> Best regards,
> 	alimon
>=20


--qj0E485stXgfPDaASDJLoqEhgBGeWWco1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJYfUMrAAoJEGJqcE9h3glgWeoP/Rxd3V7Gs9ebhOzAT9KfmnGs
J85vMp8m+n6pIJ2izDP38IcaTO9EX4BLTw/HE7N6C3G5M8Bhl2UXKzRc8Z4NS013
/2P8fbfDDXtMFZXMiNqPLHV7fhCZ334T18BEZkosXuRNjxuoY7tyH8V3im+LYr15
mwTiM5zRa1weue1+B4OnGSsPXyU6UKWw/RDVooEUXasjpw6Q+yqBYrWAkIX3y9bS
0MzDhW+TETYOpmeypiqdyZZdvMVZWMid1KQaFLLFY6uFlNLlcbWDzvjUBSGb3rN+
xettzbNF/BhTABpd3ncxwFEFFxDw4l+4ELzoy7nLHWslC006AK/iqcvGEAWxkSjl
TFuuwj0pestBl84dhPP3PzF7aAtH5hIDcV3n5r17OX+v/15dfxiX5FbffPBp4o2d
pLPFA61ZFlrE59up3W327r13x5W3KwvvYCYBkOizYsJvQURTvTbF/q5qoMfNgicg
ub7nSg6xITJwIfGshdVbkXXwrqb2gyJ9F1CMQBl6GJfyWk7ScjCiz4x71q3l3bYB
IFTUI9Q+qCdlD/YCaIbWgu+jNdOTcfRyGDX+qWq+9ZGtEer1V55Y/mLiiR5QmwE3
Ur8HC7waNkVLhPSFeWHX+7NxDatLksxZ4jw86IcR+LoyV1y4gPmB2tUHHKaym84B
DJ+w3G6FKvd69LuOX1ud
=Ll9a
-----END PGP SIGNATURE-----

--qj0E485stXgfPDaASDJLoqEhgBGeWWco1--
