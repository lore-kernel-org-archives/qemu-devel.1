Received: from eggs.gnu.org ([2001:4830:134:3::10]:49785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPb5T-0005rN-V9
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 15:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPb5Q-0000lo-PI
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 15:26:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPb5Q-0000lk-GD
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 15:26:04 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1412021733
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 20:26:04 +0000 (UTC)
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
	<20170105165329.17227-2-marcandre.lureau@redhat.com>
	<eb000893-3982-016f-e4dc-81ce0f50b6ce@redhat.com>
	<879157803.3629382.1483732242164.JavaMail.zimbra@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8ce84a77-4eae-75eb-54b9-32c30bf7b04f@redhat.com>
Date: Fri, 6 Jan 2017 14:26:00 -0600
MIME-Version: 1.0
In-Reply-To: <879157803.3629382.1483732242164.JavaMail.zimbra@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wnOckllSKOSHKuMBmrkswkXciULsKE8r5"
Subject: Re: [Qemu-devel] [PATCH 01/20] tests: fix linking test-char on win32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wnOckllSKOSHKuMBmrkswkXciULsKE8r5
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Message-ID: <8ce84a77-4eae-75eb-54b9-32c30bf7b04f@redhat.com>
Subject: Re: [PATCH 01/20] tests: fix linking test-char on win32
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
 <20170105165329.17227-2-marcandre.lureau@redhat.com>
 <eb000893-3982-016f-e4dc-81ce0f50b6ce@redhat.com>
 <879157803.3629382.1483732242164.JavaMail.zimbra@redhat.com>
In-Reply-To: <879157803.3629382.1483732242164.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/06/2017 01:50 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> ----- Original Message -----
>> On 01/05/2017 10:53 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> test-char.exe needs main-loop.o symbols, among others. Linking with
>>> $(test-block-obj-y) brings what's necessary. We could try to eventual=
ly
>>> strip to the minimum if needed.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  tests/Makefile.include | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Can I have a bit more background? I'm guessing this doesn't fix an
>> actual failure at the moment (probably due to one of the other files
>> dragging in stuff indirectly), but rather cleans up a latent problem
>> that would otherwise be exposed with patches later in the series (wher=
e
>> splitting files means the stuff is no longer dragged in indirectly, so=

>> we need to mention it explicitly)?
>=20
> It does fix current linking failure:
> x86_64-w64-mingw32-g++ -I/usr/x86_64-w64-mingw32/sys-root/mingw/include=
/pixman-1  -I/home/elmarco/src/qemu/dtc/libfdt -Werror -mms-bitfields -I/=
usr/x86_64-w64-mingw32/sys-root/mingw/include/glib-2.0 -I/usr/x86_64-w64-=
mingw32/sys-root/mingw/lib/glib-2.0/include -I/usr/x86_64-w64-mingw32/sys=
-root/mingw/include  -m64 -mcx16 -mthreads -D__USE_MINGW_ANSI_STDIO=3D1 -=
DWIN32_LEAN_AND_MEAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D=
64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wunde=
f -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -=
fwrapv  -Wendif-labels -Wno-shift-negative-value -Wmissing-include-dirs -=
Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -=
Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype=
-limits -fstack-protector-strong  -I/usr/x86_64-w64-mingw32/sys-root/ming=
w/include/libpng16  -I/home/elmarco/src/qemu/tests -O2 -U_FORTIFY_SOURCE =
-D_FORTIFY_SOURCE=3D2 -g  -Wl,--nxcompat -Wl,--no-seh -Wl,--dynamicbase -=
Wl,--warn-common -m64 -g  -o tests/test-char.exe tests/test-char.o qemu-c=
har.o qemu-timer.o io/channel.o io/channel-buffer.o io/channel-command.o =
io/channel-file.o io/channel-socket.o io/channel-tls.o io/channel-watch.o=
 io/channel-websock.o io/channel-util.o io/task.o crypto/init.o crypto/ha=
sh.o crypto/hash-glib.o crypto/hmac.o crypto/hmac-glib.o crypto/aes.o cry=
pto/desrfb.o crypto/cipher.o crypto/tlscreds.o crypto/tlscredsanon.o cryp=
to/tlscredsx509.o crypto/tlssession.o crypto/secret.o crypto/random-platf=
orm.o crypto/pbkdf.o crypto/ivgen.o crypto/ivgen-essiv.o crypto/ivgen-pla=
in.o crypto/ivgen-plain64.o crypto/afsplit.o crypto/xts.o crypto/block.o =
crypto/block-qcow.o crypto/block-luks.o qom/object.o qom/container.o qom/=
qom-qobject.o qom/object_interfaces.o  libqemuutil.a libqemustub.a /home/=
elmarco/src/qemu/winb/version.o  -L/usr/x86_64-w64-mingw32/sys-root/mingw=
/lib -lgthread-2.0 -lglib-2.0 -lintl  -lwinmm -lws2_32 -liphlpapi  -lz -l=
z=20
> qemu-char.o: In function `win_chr_free':
> /home/elmarco/src/qemu/qemu-char.c:2149: undefined reference to `qemu_d=
el_polling_cb'

Ah, so it's an existing problem in mingw compilation (I missed that
part; I assumed that because it links fine on Linux that there was no
problem - without realizing that the mingw implementation of char
devices drags in more requirements thanks to the #ifdef's char drivers).

> I can add this linking error to the commit log if it helps.

Yes, listing the link failure in the commit message (either just those
two lines above, or the whole she-bang) helps tremendously.

>>
>> Even mentioning _which_ main-loop.o symbol to be grepping for in
>> test-char.c might be helpful to the review.
>=20
> It's from qemu-char.c.

Yep, all clear now.

>> At any rate, test-block-obj-y is simply test-io-obj-y plus the
>> additional block-obj-y, so you're merely adding an additional dependen=
cy
>> on block-obj-y files.  While a nicer commit message may help, I don't
>> see any technical problem in the change, so here's a weak:
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>

And with the commit message improvement, it is now a strong R-b.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--wnOckllSKOSHKuMBmrkswkXciULsKE8r5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb/1YAAoJEKeha0olJ0Nq+3sH/0ydTlnhNREgAONXzm3+99Ms
mrEUSUb1g2enT33PjJfZ0R+SZytHCvZ0Uvp15cMO/I/3IGHfWiNl5vJZST4Oq63l
m8NTOZD5yCQR9mr8iqprzTdWx3Xqj6gbbA2M+vJsrshboYr5XuGVpDq3S6oppfkh
tngp8QRehfukfa/QB0ngJ4dg990eqKS5ASMoFyHiwaoWQ+AcAy7JaVjiDbJjxIV/
tdVasXLCTEwpDr9L4roY3abMKR9H35hScKURylurr1buH51ZbyQENP0EdytuKjVK
yHVyK7J7oR1izsZUe9DAZ4VXqU2/sXO3Lq8p8x1tXeEnKvyPsg+fG/ra3/3cQao=
=UYhi
-----END PGP SIGNATURE-----

--wnOckllSKOSHKuMBmrkswkXciULsKE8r5--
