Received: from eggs.gnu.org ([209.51.188.92]:57241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1guOVD-00035N-Je
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1guOSR-0002qp-0v
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:22:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1guOSQ-0002o7-IR
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:22:10 -0500
References: <20190214201939.494-1-philmd@redhat.com>
	<20190214201939.494-8-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d2eede57-fc2b-3f7f-1aa6-bc502c0fa36d@redhat.com>
Date: Thu, 14 Feb 2019 15:22:07 -0600
MIME-Version: 1.0
In-Reply-To: <20190214201939.494-8-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Wb0wKGzm3TnFg9RROLTN8TE6FjfcNziMO"
Subject: Re: [Qemu-devel] [PATCH v2 7/9] ccid-card-passthru: Use
 QERR_MISSING_PARAMETER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wb0wKGzm3TnFg9RROLTN8TE6FjfcNziMO
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <d2eede57-fc2b-3f7f-1aa6-bc502c0fa36d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/9] ccid-card-passthru: Use
 QERR_MISSING_PARAMETER
References: <20190214201939.494-1-philmd@redhat.com>
 <20190214201939.494-8-philmd@redhat.com>
In-Reply-To: <20190214201939.494-8-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/14/19 2:19 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/usb/ccid-card-passthru.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index 6cb8b2d26b..d63aa28584 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -16,6 +16,7 @@
>  #include "qemu/sockets.h"
>  #include "ccid.h"
>  #include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"
> =20
>  #define DPRINTF(card, lvl, fmt, ...)                    \
>  do {                                                    \
> @@ -339,7 +340,7 @@ static void passthru_realize(CCIDCardState *base, E=
rror **errp)
>      PassthruState *card =3D PASSTHRU_CCID_CARD(base);
> =20
>      if (!qemu_chr_fe_backend_connected(&card->cs)) {
> -        error_setg(errp, "missing chardev");
> +        error_setg(errp, QERR_MISSING_PARAMETER, "chardev");

We're trying to get rid of QERR_ usage, not add more. But this
particular one seems to be a wash:

$ git grep '"missing ' | wc -l
24
$ git grep QERR_MISSING_P | wc -l
25

so I'd be interested if Markus has an opinion on this one.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Wb0wKGzm3TnFg9RROLTN8TE6FjfcNziMO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxl2/8ACgkQp6FrSiUn
Q2pOpgf/feVghDC7/MOwx0IprGdR9FhvpvbclVmUWyaY6snzchtKO2Mn9GV0qENx
Dm1VDmSYC3m8xlnx7KnMDLAjITP4Eqpl4dqdaVEvtKzZQKjcD4QO9rybk8ux84yp
IIYWQT5pZC2Hwcz4ddaUq1xBrLMRhpt31Qoui3CVnCSRNNPygC/IJuZzo07n5PRE
wZvJJXAYFkW1OU+UOkv8uZ64TDZkNfy2JLtUDZXn0mi2CU4XeSNQd764irc0CTCY
18qc3JL+maYHZit9pkoymkOjU3C+HgqrhYB4fnxWGT5fvQmAuQs9YaDfXsjckKiz
nZFlgUIaiuSZiXQl9iGWirqUnAA14g==
=UhJl
-----END PGP SIGNATURE-----

--Wb0wKGzm3TnFg9RROLTN8TE6FjfcNziMO--
