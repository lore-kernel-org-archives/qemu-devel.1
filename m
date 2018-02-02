Received: from eggs.gnu.org ([208.118.235.92]:57253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdug-0000JG-7U
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdua-0001fl-Q0
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:10:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehdua-0001eq-Em
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:10:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAF1376540
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 16:09:59 +0000 (UTC)
References: <20180202111022.19269-1-kraxel@redhat.com>
	<20180202111022.19269-13-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <728857ad-0d00-07b0-6d54-b62b572eebba@redhat.com>
Date: Fri, 2 Feb 2018 10:09:51 -0600
MIME-Version: 1.0
In-Reply-To: <20180202111022.19269-13-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EerXSBxr7nczp53gzaBgLTgCfXVlATFGt"
Subject: Re: [Qemu-devel] [PATCH v3 12/12] vl: drop display_type variable
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
--EerXSBxr7nczp53gzaBgLTgCfXVlATFGt
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <728857ad-0d00-07b0-6d54-b62b572eebba@redhat.com>
Subject: Re: [PATCH v3 12/12] vl: drop display_type variable
References: <20180202111022.19269-1-kraxel@redhat.com>
 <20180202111022.19269-13-kraxel@redhat.com>
In-Reply-To: <20180202111022.19269-13-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 05:10 AM, Gerd Hoffmann wrote:
> Switch over all leftover users to qapi DisplayType.
> Then delete the unused display_type variable.
>=20
> Add 'default' DisplayType, which isn't an actual display type but
> a placeholder for "user didn't specify a display".  It will be replaced=

> by the DisplayType actually used, which in turn depends on the
> DisplayTypes availabel in the particular build.

s/availabel/available/

>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  vl.c         | 54 ++++++++++++++--------------------------------------=
--
>  qapi/ui.json |  5 +++--
>  2 files changed, 17 insertions(+), 42 deletions(-)
>=20

> +++ b/qapi/ui.json
> @@ -1017,7 +1017,7 @@
>  #
>  ##
>  { 'enum'    : 'DisplayType',
> -  'data'    : [ 'none', 'gtk', 'sdl',
> +  'data'    : [ 'default', 'none', 'gtk', 'sdl',
>                  'egl-headless', 'curses', 'cocoa' ] }

Worth documenting that the 'default' value is special and will be
converted to one of the other types, based on compile-time availability?

> =20
>  ##
> @@ -1039,7 +1039,8 @@
>                  '*window-close'  : 'bool',
>                  '*gl'            : 'bool' },
>    'discriminator' : 'type',
> -  'data'    : { 'none'           : 'DisplayNoOpts',
> +  'data'    : { 'default'        : 'DisplayNoOpts',
> +                'none'           : 'DisplayNoOpts',
>                  'gtk'            : 'DisplayGTK',
>                  'sdl'            : 'DisplayNoOpts',
>                  'egl-headless'   : 'DisplayNoOpts',
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EerXSBxr7nczp53gzaBgLTgCfXVlATFGt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0jU8ACgkQp6FrSiUn
Q2pHWQgAiE/OZ/sHegNR6B35MQPVgPW+JW1kcqUpNi4yd+rHPEJowIKQegEidsrY
+Gk50jjo8bP1xcDmYEbZiozH1/9a7iTWWKSyuWkjrB9LBOaiKfrbnX13ALRTNmp1
P0WrTMWtAnpRaLwbDWoEgRenb5Sor6KV8fv3gIb+cOSgq1hjlan30OzizcKyKSry
0yf+Y4Rg53vMRsO/Nj/JGDoRfedlY8l56vbeN7a+eycINGOp2S9lOcpoxqiuPv42
8MYxwMLM2EHtz/Jgaf1X9x11ybW1VbtsuHKPIa2q7kgGk9bvfNnrMOJCckC8+HZX
q8PFy+Mt+jX2BJruO6Ac3hZtgFnm0w==
=bDhP
-----END PGP SIGNATURE-----

--EerXSBxr7nczp53gzaBgLTgCfXVlATFGt--
