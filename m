Received: from eggs.gnu.org ([208.118.235.92]:54752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdKr-00027y-Um
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdJn-0002cq-HI
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:33:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehdJm-0002bC-Sm
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:31:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0303225C41
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 15:31:58 +0000 (UTC)
References: <20180202111022.19269-1-kraxel@redhat.com>
	<20180202111022.19269-6-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d20a0817-6df3-e066-af42-e61b481011ec@redhat.com>
Date: Fri, 2 Feb 2018 09:31:29 -0600
MIME-Version: 1.0
In-Reply-To: <20180202111022.19269-6-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LxbZyziKKXSmHJe59vewvXZWkznygiALs"
Subject: Re: [Qemu-devel] [PATCH v3 05/12] sdl: use DisplayOptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LxbZyziKKXSmHJe59vewvXZWkznygiALs
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d20a0817-6df3-e066-af42-e61b481011ec@redhat.com>
Subject: Re: [PATCH v3 05/12] sdl: use DisplayOptions
References: <20180202111022.19269-1-kraxel@redhat.com>
 <20180202111022.19269-6-kraxel@redhat.com>
In-Reply-To: <20180202111022.19269-6-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 05:10 AM, Gerd Hoffmann wrote:
> Switch sdl ui to use qapi DisplayOptions for configuration.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/console.h |  8 ++++----
>  ui/sdl.c             | 19 +++++++++++++------
>  ui/sdl2.c            | 33 +++++++++++++++++++--------------
>  vl.c                 | 13 +++++++++++--
>  qapi/ui.json         |  5 +++--
>  5 files changed, 50 insertions(+), 28 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LxbZyziKKXSmHJe59vewvXZWkznygiALs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0hFEACgkQp6FrSiUn
Q2rdxgf/Yj8ZHS2lxExVpuyn2Ji9T9mQ7slGvKc4wCm0bzzYZ+/6tsQ7r0E/LY2m
ti6ClRbK4RXPAbETIU6G7o8PqrJdzDyDgdbYARWc71CUh00kF2Z8JzMYWaGHKYdY
e9uJY+wcDFFhQF/igOsAu1Fu9nVJURtxZVL3SvcW0Hy4e9XRy289bju+qGUmItME
L0Cn2U1hQesMhaAjJG3VfJGLL9ltwLWLNKlkfLSb3uKqJefVRJ6ekkYLncYSfgcg
c7mm29MpGyP6tRh6IgXSyI28bOPpOC3TpBWdQwrrMu+RcvRS29N6ZKx5NcVIVWID
StWskMaZQ63ov8io9j/WRkJAOiUjVQ==
=zU+Z
-----END PGP SIGNATURE-----

--LxbZyziKKXSmHJe59vewvXZWkznygiALs--
