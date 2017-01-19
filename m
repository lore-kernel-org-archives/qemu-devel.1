Received: from eggs.gnu.org ([2001:4830:134:3::10]:57572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUE5t-00047d-LT
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUE5p-0001kd-NT
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:53:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cUE5p-0001k5-Ep
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:53:37 -0500
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
	<1484772931-16272-5-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <29f56f57-76f5-8585-c286-70bc0eb60b92@redhat.com>
Date: Thu, 19 Jan 2017 08:53:34 -0600
MIME-Version: 1.0
In-Reply-To: <1484772931-16272-5-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rS12n8S7Cq4KdW1EU2j0T9s9J9vi96p6m"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] ARRAY_SIZE: check that argument is
 an array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Sergey Fedorov <serge.fdrv@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rS12n8S7Cq4KdW1EU2j0T9s9J9vi96p6m
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Sergey Fedorov <serge.fdrv@gmail.com>
Message-ID: <29f56f57-76f5-8585-c286-70bc0eb60b92@redhat.com>
Subject: Re: [PATCH v2 4/4] ARRAY_SIZE: check that argument is an array
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
 <1484772931-16272-5-git-send-email-mst@redhat.com>
In-Reply-To: <1484772931-16272-5-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2017 02:55 PM, Michael S. Tsirkin wrote:
> It's a familiar pattern: some code uses ARRAY_SIZE, then refactoring
> changes the argument from an array to a pointer to a dynamically
> allocated buffer.  Code keeps compiling but any ARRAY_SIZE calls now
> return the size of the pointer divided by element size.
>=20
> Let's add build time checks to ARRAY_SIZE before we allow more
> of these in the code-base.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/qemu/osdep.h | 8 +++++++-

> =20
>  #ifndef ARRAY_SIZE
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +/*
> + * &(x)[0] is always a pointer - if it's same type as x then the argum=
ent is a
> + * pointer, not an array as expected.
> + */
> +#define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + QEMU_BUILD_BUG_O=
N_ZERO( \
> +                        __builtin_types_compatible_p(typeof(x), \

Are we sure that __builtin_types_compatible_p() is supported for all
versions of gcc and clang that we support, or does this need further
#ifdefs?


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rS12n8S7Cq4KdW1EU2j0T9s9J9vi96p6m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgNLuAAoJEKeha0olJ0Nqi9oH/25YTiNBoOeO58SGESaLKLm3
x80rR6q/uiiA9u+sMNuLdPs7wekdCZbegGsKx12WB8yr/2J7u8griNctu3mj6Ugw
DFpozPdpe3ZEcy3VJ9YgjNcZGkzJKAi/vohdJ1SsJvO9Ag/YTprrLAqaWcEjh2Gt
KCZwCJpBqd2hE+JFx9cGIQIYV1+jlNIuYCkjxhc0adKsi2pL5EzSMserkaEwSpZL
ZWL3OlOoSXL5bVO9SnLXpCz/oC2lDGAn3lMRFnaQlMaG5cZj67rvicznzFhDZAr+
ovHEuRQYRuz0knw1SirMth5NzQhhqatRZ8EHRolSmA3GjswjMW0qKEiMguxt46E=
=1h3a
-----END PGP SIGNATURE-----

--rS12n8S7Cq4KdW1EU2j0T9s9J9vi96p6m--
