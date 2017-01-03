Received: from eggs.gnu.org ([2001:4830:134:3::10]:56487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOQxi-00067S-HM
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOQxf-0005oS-Ck
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:25:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOQxf-0005oO-41
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:25:15 -0500
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
	<1483371890-289981-2-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1c69ec6e-e8e9-d544-f2c5-52ace0acf2bb@redhat.com>
Date: Tue, 3 Jan 2017 09:25:11 -0600
MIME-Version: 1.0
In-Reply-To: <1483371890-289981-2-git-send-email-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VWft0xjfRFC4I3nN0GpGIm5m0Wp7EusSr"
Subject: Re: [Qemu-devel] [PATCH 1/3] cleanup: remove not used header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com, afaerber@suse.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VWft0xjfRFC4I3nN0GpGIm5m0Wp7EusSr
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 afaerber@suse.de
Message-ID: <1c69ec6e-e8e9-d544-f2c5-52ace0acf2bb@redhat.com>
Subject: Re: [PATCH 1/3] cleanup: remove not used header
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
 <1483371890-289981-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1483371890-289981-2-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/02/2017 09:44 AM, Igor Mammedov wrote:

perhaps s/not used/unused/ in the subject

Reviewed-by: Eric Blake <eblake@redhat.com>

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  qom/object_interfaces.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index ded4d84..4b880d0 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -3,7 +3,6 @@
>  #include "qom/object_interfaces.h"
>  #include "qemu/module.h"
>  #include "qapi-visit.h"
> -#include "qapi/qobject-output-visitor.h"
>  #include "qapi/opts-visitor.h"
> =20
>  void user_creatable_complete(Object *obj, Error **errp)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--VWft0xjfRFC4I3nN0GpGIm5m0Wp7EusSr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYa8JXAAoJEKeha0olJ0Nq/tIIAJzFgMEfDU6Plv0V8lxn9dl4
u2M4dhVzieA5+ONW6qLPMH3tmKGY4GS7Tousau7QuD1GEK2VtAy03ytLu/MV1t3K
a8xrGDonEaD436TADtD3r63HJbMfsFlWq1SBDjQYjkX71ZMaXZiKF5dFYJFVVeWD
MUSdfUqQkjJp7oAqNnHvQGLd19FIhfBp9EiCWhB15tc7sl9aUcB4ZuMRuXI1hSls
5GHY2EH/GDSSZY57ARg1WiGyPTz2RlVW2hfdTDJMaa2dHJKd4ra81EuYYR98cZY5
CwxJoRwRdTV4RC8Rv9LD3baL7kxEfn6Q1ijM/K9mnqbCBz0IsesnWgJfsvEsF1Q=
=N+Zh
-----END PGP SIGNATURE-----

--VWft0xjfRFC4I3nN0GpGIm5m0Wp7EusSr--
