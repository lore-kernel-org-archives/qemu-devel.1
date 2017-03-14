Received: from eggs.gnu.org ([2001:4830:134:3::10]:36453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnqUM-0000fh-J3
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnqUJ-0008AR-IU
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:44:02 -0400
References: <20170314165953.18506-1-andreas@grapentin.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ddea3a8a-715e-c24d-e434-3fa55f5d81b2@redhat.com>
Date: Tue, 14 Mar 2017 12:43:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170314165953.18506-1-andreas@grapentin.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="B1Fs9ph5tptvXwmKHoei2nsCKHsc8XJGA"
Subject: Re: [Qemu-devel] [PATCH v2] use _Static_assert in QEMU_BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Grapentin <andreas@grapentin.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B1Fs9ph5tptvXwmKHoei2nsCKHsc8XJGA
From: Eric Blake <eblake@redhat.com>
To: Andreas Grapentin <andreas@grapentin.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <ddea3a8a-715e-c24d-e434-3fa55f5d81b2@redhat.com>
Subject: Re: [PATCH v2] use _Static_assert in QEMU_BUILD_BUG_ON
References: <20170314165953.18506-1-andreas@grapentin.org>
In-Reply-To: <20170314165953.18506-1-andreas@grapentin.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 11:59 AM, Andreas Grapentin wrote:
> QEMU_BUILD_BUG_ON should use C11's _Static_assert, if the compiler supp=
orts it,
> to provide more readable messages on failure.

>=20
> with _Static_assert:
>=20
>> In file included from /qemu/include/qemu/osdep.h:36:0,
>>                  from /qemu/qga/commands.c:13:
>> /qemu/qga/commands.c: In function =E2=80=98qmp_guest_exec_status=E2=80=
=99:
>> /qemu/include/qemu/compiler.h:94:30: error: static assertion failed: "=
not expecting: sizeof(*&gei->finished) > sizeof(void *)"
>>  #define QEMU_BUILD_BUG_ON(x) _Static_assert((x), #x)

Manual copy-and-paste? Because this is missing the ! present in the
actual definition...

>>                               ^
>> /qemu/include/qemu/atomic.h:146:5: note: in expansion of macro =E2=80=98=
QEMU_BUILD_BUG_ON=E2=80=99
>>      QEMU_BUILD_BUG_ON(sizeof(*ptr) > sizeof(void *));   \
>>      ^~~~~~~~~~~~~~~~~
>> /qemu/include/qemu/atomic.h:417:5: note: in expansion of macro =E2=80=98=
atomic_load_acquire=E2=80=99
>>      atomic_load_acquire(ptr)
>>      ^~~~~~~~~~~~~~~~~~~
>> /qemu/qga/commands.c:160:21: note: in expansion of macro =E2=80=98atom=
ic_mb_read=E2=80=99
>>      bool finished =3D atomic_mb_read(&gei->finished);
>>                      ^~~~~~~~~~~~~~
>=20
> Signed-off-by: Andreas Grapentin <andreas@grapentin.org>
> ---

> +++ b/include/qemu/compiler.h
> @@ -90,7 +90,9 @@
>          int:(x) ? -1 : 1; \
>      }
> =20
> -#ifdef __COUNTER__
> +#if defined(CONFIG_STATIC_ASSERT)
> +#define QEMU_BUILD_BUG_ON(x) _Static_assert(!(x), "not expecting: " #x=
)

=2E..here.

But that's trivial, if the maintainer would like to correct the commit
message.

Reviewed-by: Eric Blake <eblake@redhat.com>


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--B1Fs9ph5tptvXwmKHoei2nsCKHsc8XJGA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyCvcAAoJEKeha0olJ0Nqh7gIAI5G2pOR6l50FZhm6zlN2JVX
9m4MjgZvekmbpy2SZPFvTUbPmuln5swuassj/9wy5M+W/00ZJsdyNMmH8AKFuUeu
4za/PCT8g0CxWybaRLhB4aLGXaGErqx/VEXC9ITzR/1rErx3+mWks/I0IjTh+8Ig
Jd+RZ5vMGSmY1RXxi65DEG0TRPRafovVWNlXwFuy9i4EDlXQLBykSTpwzujQjaSb
tgALEHQ7QYdY07NdzTiZBm0WLxdmexRUljHCGyGjZRqEfYk2dtY07eMduTE2tm5S
VJvMKLoTiNAFMzaHkvipDDTRZUWv6PJvTfQSwwppmISCdvgAoMfzNJ3FLuOrolk=
=/QZm
-----END PGP SIGNATURE-----

--B1Fs9ph5tptvXwmKHoei2nsCKHsc8XJGA--
