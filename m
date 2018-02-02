Received: from eggs.gnu.org ([208.118.235.92]:55487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdrX-00062n-Vr
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdrT-0008Sm-DS
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:06:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehdrT-0008Sc-4D
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:06:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BB21629
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 16:06:46 +0000 (UTC)
References: <20180202111022.19269-1-kraxel@redhat.com>
	<20180202111022.19269-12-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fbe423b4-e5d6-ff72-5f5a-d287b141c278@redhat.com>
Date: Fri, 2 Feb 2018 10:06:40 -0600
MIME-Version: 1.0
In-Reply-To: <20180202111022.19269-12-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NliaYF1hhlSbeDBQmUDlKNUqUPexlhmgf"
Subject: Re: [Qemu-devel] [PATCH v3 11/12] vl: drop request_opengl variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NliaYF1hhlSbeDBQmUDlKNUqUPexlhmgf
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <fbe423b4-e5d6-ff72-5f5a-d287b141c278@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 11/12] vl: drop request_opengl variable
References: <20180202111022.19269-1-kraxel@redhat.com>
 <20180202111022.19269-12-kraxel@redhat.com>
In-Reply-To: <20180202111022.19269-12-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 05:10 AM, Gerd Hoffmann wrote:
> Switch over the one leftover user to qapi DisplayType.
> The delete the unused request_opengl variable.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  vl.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20

> =20
> -    if (request_opengl =3D=3D 1 && display_opengl =3D=3D 0) {
> +    if (dpy.has_gl && dpy.gl && display_opengl =3D=3D 0) {
>  #if defined(CONFIG_OPENGL)
>          error_report("OpenGL is not supported by the display");
>  #else

Maybe someday when QAPI supports conditionals we can make the exposure
of the 'gl' field guarded by those conditionals, for better
introspection, rather than the current series' approach of always
exposing it then failing at runtime.  But that doesn't hold up this serie=
s.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NliaYF1hhlSbeDBQmUDlKNUqUPexlhmgf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0jJAACgkQp6FrSiUn
Q2qM1wf/dU24aUv6jf8e78B9zwLAoX4S6w75197zwMooyrA/URqHw/Olyvw1zefo
h13drzwkgqBYwTeS968IpYxkUbMmcPduRmbbRrsWKIS8iuxSyGOw7h8Gta+oMoc+
qBekLqzNl2u5PWDy1cdDGHFvU8RJRORQl/j2x3pH53AYymP7EabB262zTjLM3h9u
hx4Nr9AQrdq5cIoysvzNW1SdBkNocC+9NWdxK+3flNNMZQYzFpaK+11UvuO9q5SU
ZsPBVIpdnMKppmBNmubOF6dcfsqWleoan+gcOOuZvw9dgkXuDrGP1pKaH7dmPTFH
xrgn+bZWbK3HJigPCID0o+EU3Y0lQQ==
=H+qm
-----END PGP SIGNATURE-----

--NliaYF1hhlSbeDBQmUDlKNUqUPexlhmgf--
