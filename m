Received: from eggs.gnu.org ([2001:4830:134:3::10]:38816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5Pp3-0003Rk-TZ
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 01:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5Pp0-0002Sd-Q4
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 01:58:33 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:45331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f5Pp0-0002SG-GB
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 01:58:30 -0400
Received: by mail-pf0-x22a.google.com with SMTP id l27so5247419pfk.12
	for <qemu-devel@nongnu.org>; Sun, 08 Apr 2018 22:58:30 -0700 (PDT)
Date: Mon, 9 Apr 2018 13:58:25 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180409055825.GB4848@stefanha-x1.localdomain>
References: <20180408145933.1149-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <20180408145933.1149-1-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH for-2.12] gdbstub: fix off-by-one in
 gdb_handle_packet()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 08, 2018 at 11:59:33AM -0300, Philippe Mathieu-Daud=E9 wrote:
> memtohex() adds an extra trailing NUL character.
>=20
> Reported-by: AddressSanitizer
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> (gdb) dump binary memory /tmp/dram.bin 0x94000000 0x94100000
> Remote connection closed
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D22732=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on addres=
s 0x7ffe43018340 at pc 0x55f2655fde81 bp 0x7ffe43017210 sp 0x7ffe43017208
> WRITE of size 1 at 0x7ffe43018340 thread T0
>     #0 0x55f2655fde80 in memtohex /source/qemu/gdbstub.c:520
>     #1 0x55f26560254d in gdb_handle_packet /source/qemu/gdbstub.c:1140
>     #2 0x55f2656073c3 in gdb_read_byte /source/qemu/gdbstub.c:1703
>     #3 0x55f2656076a7 in gdb_chr_receive /source/qemu/gdbstub.c:1909
>     #4 0x55f266457656 in qemu_chr_be_write_impl /source/qemu/chardev/char=
=2Ec:175
>     #5 0x55f2664576f9 in qemu_chr_be_write /source/qemu/chardev/char.c:187
>     #6 0x55f26646f6f0 in tcp_chr_read /source/qemu/chardev/char-socket.c:=
470
>     #7 0x55f2664bc9e3 in qio_channel_fd_source_dispatch /source/qemu/io/c=
hannel-watch.c:84
>     #8 0x7f17d01b30f4 in g_main_context_dispatch (/usr/lib/x86_64-linux-g=
nu/libglib-2.0.so.0+0x4c0f4)
>     #9 0x55f2665c7f10 in glib_pollfds_poll /source/qemu/util/main-loop.c:=
215
>     #10 0x55f2665c8100 in os_host_main_loop_wait /source/qemu/util/main-l=
oop.c:263
>     #11 0x55f2665c82d6 in main_loop_wait /source/qemu/util/main-loop.c:522
>     #12 0x55f26599e13b in main_loop /source/qemu/vl.c:1943
>     #13 0x55f2659b0869 in main /source/qemu/vl.c:4734
>=20
> Address 0x7ffe43018340 is located in stack of thread T0 at offset 4192 in=
 frame
>     #0 0x55f265601266 in gdb_handle_packet /source/qemu/gdbstub.c:996
>=20
>   This frame has 3 object(s):
>     [32, 40) 'p'
>     [96, 4192) 'buf' <=3D=3D Memory access at offset 4192 overflows this =
variable
>     [4224, 8320) 'mem_buf'
> SUMMARY: AddressSanitizer: stack-buffer-overflow /source/qemu/gdbstub.c:5=
20 in memtohex
> Shadow bytes around the buggy address:
>   0x1000485fb010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x1000485fb020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x1000485fb030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x1000485fb040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x1000485fb050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =3D>0x1000485fb060: 00 00 00 00 00 00 00 00[f2]f2 f2 f2 00 00 00 00
>   0x1000485fb070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x1000485fb080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x1000485fb090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x1000485fb0a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x1000485fb0b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07
>   Heap left redzone:       fa
>   Freed heap region:       fd
>   Stack left redzone:      f1
>   Stack mid redzone:       f2
>   Stack right redzone:     f3
>   Stack after return:      f5
>   Stack use after scope:   f8
>   Global redzone:          f9
>   Global init order:       f6
>   Poisoned by user:        f7
>   Container overflow:      fc
>   Array cookie:            ac
>   Intra object redzone:    bb
>   ASan internal:           fe
>   Left alloca redzone:     ca
>   Right alloca redzone:    cb
> =3D=3D22732=3D=3DABORTING
> ---
>  gdbstub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaywEBAAoJEJykq7OBq3PIBeAIAJLHHZviBYamO2wlyBehHSD2
6SNm+kDGfauQj2KKgTEW3hl1Smvfpa+E2NScnp3mY8EDB6KjL7Fe8F5pYwbJ6olM
6jPIR6Vwa7qU9egXFXimJjmX1ZP+K/S/hRQMnTHL1bV9Jr9w6hxqheeFmexaFjsj
AIw6qgFnA/pZplU/IAAkKwVh8xULwDrINr9nA/zCO81gk+Otx7Ca8DsL8kZZLZKc
DoBqN6TV2SLayX0u2snhk+bBXLedciypDnHzH5D5x8olZvwy69M8jT8cE+/FYTdR
zBsyqRaAsHjlzA/u4liz7qFaoaQ8bk/pkmxFANhzghF0AxLJlEypIRuZRFe9hL8=
=9YXe
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
