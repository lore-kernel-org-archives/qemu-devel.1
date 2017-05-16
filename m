Received: from eggs.gnu.org ([2001:4830:134:3::10]:48949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAdZR-0007El-Uc
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAdZN-00051N-OE
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:35:29 -0400
References: <20170516001150.11508-1-f4bug@amsat.org>
	<20170516001150.11508-2-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <79ae9877-afd9-50a7-c9f2-a12d294ff1ac@redhat.com>
Date: Tue, 16 May 2017 09:35:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170516001150.11508-2-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2nSjV1s54Lmm76rN8I5d4eB6xc3NSRwup"
Subject: Re: [Qemu-devel] [PATCH] coccinelle: fix typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2nSjV1s54Lmm76rN8I5d4eB6xc3NSRwup
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <79ae9877-afd9-50a7-c9f2-a12d294ff1ac@redhat.com>
Subject: Re: [PATCH] coccinelle: fix typo in comment
References: <20170516001150.11508-1-f4bug@amsat.org>
 <20170516001150.11508-2-f4bug@amsat.org>
In-Reply-To: <20170516001150.11508-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2017 07:11 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/coccinelle/return_directly.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Did you intend for this to be threaded with your other 'oslib: strip
trailing '\n'...' patch? If so, where's the 0/2 cover letter and proper
subject lines?

At any rate,
Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/scripts/coccinelle/return_directly.cocci b/scripts/coccine=
lle/return_directly.cocci
> index 48680f2c2a..4cf50e75ea 100644
> --- a/scripts/coccinelle/return_directly.cocci
> +++ b/scripts/coccinelle/return_directly.cocci
> @@ -1,4 +1,4 @@
> -// replace 'R =3D X; return R;' with 'return R;'
> +// replace 'R =3D X; return R;' with 'return X;'
>  @@
>  identifier VAR;
>  expression E;
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2nSjV1s54Lmm76rN8I5d4eB6xc3NSRwup
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGw4bAAoJEKeha0olJ0NqX3MIAJDE3z4GYtwXE7vCUtQeocJ1
H+Xo1vMRW2nuibw8pTQc1tva6LiJK8EbX2M3bDX4t9pjW7xytM1OWNP5TRcGyl3Q
oGn1tFX8ysEXro7xwk1BXIOTc7I5ziyp1QB6uX+H4wvSjrh2RwXivLjVmWiYkfpy
1INmbxZb5wypoDrsaA0BgKT69MAXsY1nUKp9UIJC198Pox64s9S5Z/12wGeRWjU+
rtNw+zEbUQ3kohGk0Vyz2fclyquP/lBMHoX3VYAVHvBUIWSstTYYgwoarF1U90CJ
ZJafwm7RlcUlda5/KMwv7MJV9AIXMy5O63orZ3k8fcc5lezDw016w/hIc1AegTU=
=4LfI
-----END PGP SIGNATURE-----

--2nSjV1s54Lmm76rN8I5d4eB6xc3NSRwup--
