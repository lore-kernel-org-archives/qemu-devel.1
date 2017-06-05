Received: from eggs.gnu.org ([2001:4830:134:3::10]:47923)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dHtKq-0004BN-SD
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dHtKn-0007AN-O3
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:50:24 -0400
References: <20170531120049.14111-1-n54@gmx.com>
	<26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
Date: Mon, 5 Jun 2017 16:52:16 +0200
MIME-Version: 1.0
In-Reply-To: <26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hwcuq86D6G3os0PEdbb6VHo1983bIkMBk"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v3] ivshmem-server:
 ivshmem-client: Build when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Cc: armbru@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org, marcandre.lureau@gmail.com, peter.maydell@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hwcuq86D6G3os0PEdbb6VHo1983bIkMBk
From: Kamil Rytarowski <n54@gmx.com>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Cc: armbru@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org,
 marcandre.lureau@gmail.com, peter.maydell@redhat.com, eblake@redhat.com
Message-ID: <df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
Subject: Re: [Qemu-trivial] [PATCH v3] ivshmem-server: ivshmem-client: Build
 when eventfd() is available
References: <20170531120049.14111-1-n54@gmx.com>
 <26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
In-Reply-To: <26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable

On 05.06.2017 16:29, Michael Tokarev wrote:
> 31.05.2017 15:00, Kamil Rytarowski wrote:
>> Currently ivshmem requires eventfd() which is Linux specific.
>> Do not and build it unconditionally on every Linux/BSD/Solaris.
>>
>> This patch indirectly fixes build failure on NetBSD, where these tools=

>> additionally require -lrt for shm_open(3). In future there should be
>> added support for NetBSD and the linking addressed appropriately.
>=20
> Unfortunately this breaks static build.
>=20
> $ ../configure --disable-system --disable-linux-user --static
> $ make V=3D1
> ...
> c++ -I/usr/include/pixman-1  -Werror -pthread -I/usr/include/glib-2.0 -=
I/usr/lib/x86_64-linux-gnu/glib-2.0/include -m64 -mcx16 -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredu=
ndant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
> -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels -Wno-shift-neg=
ative-value -Wno-missing-include-dirs -Wempty-body -Wnested-externs
> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-s=
tyle-declaration -Wold-style-definition -Wtype-limits -fstack-protector-s=
trong
> -I/usr/include/libpng16 -I/build/qemu/git/tests -O2 -U_FORTIFY_SOURCE -=
D_FORTIFY_SOURCE=3D2 -g  -Wl,--warn-common -m64 -static -g  -o ivshmem-se=
rver
> libqemuutil.a libqemustub.a   -lm -lgthread-2.0 -pthread -lglib-2.0 -pt=
hread -lpcre -pthread  -lz -lrt -lz -lnettle  -lutil
> /usr/lib/gcc/x86_64-linux-gnu/6/../../../x86_64-linux-gnu/crt1.o: In fu=
nction `_start':
> (.text+0x20): undefined reference to `main'
> collect2: error: ld returned 1 exit status
> Makefile:475: error building =ABivshmem-server=BB
> $ _
>=20
> I'll take a look at this later. reverting it for now.
>=20
> Thanks,
>=20
> /mjt
>=20

I will try to reproduce it locally.


--Hwcuq86D6G3os0PEdbb6VHo1983bIkMBk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZNXAmAAoJEEuzCOmwLnZsqEYQAIVffEFP1ugN3TYUZ7QXylJO
hCQpZWLGVgHCjdIfWWCAiOwt72Gqc04U5mYxXOqAP+mDcq55cFyccNOMPWb5moAG
1rXWAD59VnN9N9agzeKQChnLQXZftKUViubKn5SvxnCtYPkVDIvuU2jgfXjGsozY
hHt0XFMMMZT9PRB+PjKEXVoruTbdcU2/fzqIBMovCFAlWAnJUNdhH1ecK92Ioc39
jYCT4N17iN11so5yu+eavpHAqaLCftIh6wLeT8LrroTHe6VxmB/1pCFANpFT92kw
zDkMOlh80A7lwhZBPzg8sIITxbxJslBSnnpq598/MXy8KvJOAQ4RDEvDSXOoG1hF
4TLQj8S8wd4q/fqCIsbdLZQmWmBZ8YaywnIbmJrr6cg3+C+qpsrQ1b5CuW7tlmfc
TqHd1ebxiDeYeHo++ijcslaunIkjUFzqPWuDQrBHole3K3cea4HpMsYRyLaWv8uI
xkM2WH9KQ+2I3KuHIO7y5L+zEgyAluPh/H+7XS96yBzLNmMhDet7livfLBkzol72
wTu+i6/EKVXJp+BBNda7PNE8ecJrf1wVUSF7m3SXzyihW+jCXezVPkAHf9dbHLye
DgUOyCwp6GBfoBM8NvuX9mrkQ/O7QT6kYj3FUDgVUsIagsmLv88ef9SEbVL7KKPK
AsqBm6c1NA5EYNJrYohy
=piD9
-----END PGP SIGNATURE-----

--Hwcuq86D6G3os0PEdbb6VHo1983bIkMBk--
