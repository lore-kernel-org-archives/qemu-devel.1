Received: from eggs.gnu.org ([208.118.235.92]:39666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdXb-0001Pv-Gl
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdQV-0003MA-Ty
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:40:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehdQV-0003K6-6X
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:38:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DD193E521
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 15:38:54 +0000 (UTC)
References: <20180202111022.19269-1-kraxel@redhat.com>
	<20180202111022.19269-9-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e734c84d-4448-d299-b04b-05f652f1fab5@redhat.com>
Date: Fri, 2 Feb 2018 09:38:49 -0600
MIME-Version: 1.0
In-Reply-To: <20180202111022.19269-9-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3L3l2OMKvBdeLolL0iag9IZReZurDuEbF"
Subject: Re: [Qemu-devel] [PATCH v3 08/12] curses: use DisplayOptions
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
--3L3l2OMKvBdeLolL0iag9IZReZurDuEbF
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e734c84d-4448-d299-b04b-05f652f1fab5@redhat.com>
Subject: Re: [PATCH v3 08/12] curses: use DisplayOptions
References: <20180202111022.19269-1-kraxel@redhat.com>
 <20180202111022.19269-9-kraxel@redhat.com>
In-Reply-To: <20180202111022.19269-9-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 05:10 AM, Gerd Hoffmann wrote:
> Switch curses ui to use qapi DisplayOptions for configuration.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/console.h | 4 ++--
>  ui/curses.c          | 2 +-
>  vl.c                 | 4 +++-
>  qapi/ui.json         | 5 +++--
>  4 files changed, 9 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3L3l2OMKvBdeLolL0iag9IZReZurDuEbF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0hgkACgkQp6FrSiUn
Q2rdqwf/e9fK15oenlqwa9sxserSWF5KASvykv73+teutfNMBW3VvdT1UwcBYWDJ
Oq6snl7m0JzzupP6zTjQGk94HMwqqOv7Tw9PyRHDfenOA+WECAV3d3vNn7jrIXj1
g7x88pGiaNQu5EEPvC17RNXR+UVlRHVd2tuGcD7pdxQtr+MonB7cpJxp0E8Il2Nh
oFnSljfotXkjmKbfdh2lKEW8srusPGO173L34Sn8lWASC/ipXQEFjh2K2laIbcsL
MoGZvaek1bzh98PWcKxJwTt86CvltnVkdWZMxdw07RSvwXlPrbcgRTs23BkcqGN+
X0960RC5l4cToIklHmbp/r6nyJQyIA==
=F9eL
-----END PGP SIGNATURE-----

--3L3l2OMKvBdeLolL0iag9IZReZurDuEbF--
