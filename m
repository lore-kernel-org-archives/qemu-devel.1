Received: from eggs.gnu.org ([208.118.235.92]:60856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdPU-00052e-29
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdON-0000Dw-FD
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:37:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehdOM-0000Bp-L5
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:36:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F24683F46
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 15:36:41 +0000 (UTC)
References: <20180202111022.19269-1-kraxel@redhat.com>
	<20180202111022.19269-8-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2678cd05-910a-dfc2-8423-64f8124c4d16@redhat.com>
Date: Fri, 2 Feb 2018 09:36:31 -0600
MIME-Version: 1.0
In-Reply-To: <20180202111022.19269-8-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7765rWAqL1OJuymGC6RLZTE2j31vLRpwH"
Subject: Re: [Qemu-devel] [PATCH v3 07/12] egl-headless: use DisplayOptions
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
--7765rWAqL1OJuymGC6RLZTE2j31vLRpwH
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2678cd05-910a-dfc2-8423-64f8124c4d16@redhat.com>
Subject: Re: [PATCH v3 07/12] egl-headless: use DisplayOptions
References: <20180202111022.19269-1-kraxel@redhat.com>
 <20180202111022.19269-8-kraxel@redhat.com>
In-Reply-To: <20180202111022.19269-8-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 05:10 AM, Gerd Hoffmann wrote:
> Switch egl-headless ui to use qapi DisplayOptions for configuration.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/console.h | 2 +-
>  ui/egl-headless.c    | 2 +-
>  vl.c                 | 3 ++-
>  qapi/ui.json         | 5 +++--
>  4 files changed, 7 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7765rWAqL1OJuymGC6RLZTE2j31vLRpwH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0hX8ACgkQp6FrSiUn
Q2oV8wgAoVYSRZ0cvRRAoPlzBO5sYvURSDO9M6nu72vBVPliptjYDdo5aTiZbEzW
Armvn6HipaZ+dCy1NlZoWesz1BWCLWAz/QAqPKwg5x5FefGqKi+nrPequbXG7PPj
pECMhP+18PoIX2F7ZsGEpRDS3mep5HvlsNeftrRXdf9tsKuKTVMetRWwr6F4HCcP
P967wpL9zQUO49yXagMAe9BqyAwAGkKUnpdrVftfGlVucldPoLeScJ7jj5KbQVV0
hTMmTndeA/6e+s1xxcL80Jz9uXHE9O83MMjmQqTLthghXDi8nbIqWImztoA1GMmW
A28S7VTHOa2iq22lRgYCXksMAuVvfQ==
=JJN8
-----END PGP SIGNATURE-----

--7765rWAqL1OJuymGC6RLZTE2j31vLRpwH--
