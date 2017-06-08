Received: from eggs.gnu.org ([2001:4830:134:3::10]:58512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIzdw-0003fo-BI
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIzdt-0004S4-3r
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:46:40 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:65154)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIzds-0004QV-PE
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:46:37 -0400
Date: Thu, 8 Jun 2017 18:46:27 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170608154627.6nl5m4mzyrjdkfqn@postretch>
References: <20170608133906.12737-1-ehabkost@redhat.com>
	<20170608133906.12737-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="irmoea5ptce6kmrw"
Content-Disposition: inline
In-Reply-To: <20170608133906.12737-4-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] websock: Don't try to set *errp
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>


--irmoea5ptce6kmrw
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 10:39:04AM -0300, Eduardo Habkost wrote:
>Assigning directly to *errp is not valid, as errp may be NULL,
>&error_fatal, or &error_abort.  Use error_propagate() instead.
>
>Cc: "Daniel P. Berrange" <berrange@redhat.com>
>Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>---
> io/channel-websock.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/io/channel-websock.c b/io/channel-websock.c
>index 8fabadea2f..5a3badbec2 100644
>--- a/io/channel-websock.c
>+++ b/io/channel-websock.c
>@@ -856,7 +856,7 @@ static ssize_t qio_channel_websock_readv(QIOChannel *i=
oc,
>     ssize_t ret;
>
>     if (wioc->io_err) {
>-        *errp =3D error_copy(wioc->io_err);
>+        error_propagate(errp, error_copy(wioc->io_err));
>         return -1;
>     }
>
>@@ -902,7 +902,7 @@ static ssize_t qio_channel_websock_writev(QIOChannel *=
ioc,
>     ssize_t ret;
>
>     if (wioc->io_err) {
>-        *errp =3D error_copy(wioc->io_err);
>+        error_propagate(errp, error_copy(wioc->io_err));
>         return -1;
>     }
>
>--=20
>2.11.0.259.g40922b1
>
>
>

Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

--irmoea5ptce6kmrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlk5cVMACgkQc2J8L2kN
9xBOGw//fNC7syg13FGKWsZYC//LFyEavGdukDS+qUMxYR00XC0CLg2Frubv0Mhw
dQy9Jt0r1yoibnzXeaw9f4SzwNRST5zO20nlHlqN/RHt5v8i4G7fYeI8ZYW69L9b
QhQ9/uUNql984l9qODFO4aqm2KC5KKJcbnNKA4IGFSiKMHZ+kPi6XPpIZfZOzwas
YUplO/CzpSiuL+ExDZmgQM9yHFxvzuxB0XyueVtIVC3Jmj1NbBQWVSuhtRxbZW04
VMHYoFVeogmRVhqrUPz7CQIhOREfXvdXBZ17Hbba0S3gE7eILNRLn1Paa/flCQwH
6dubdqvasZA0FEDtPCF2erd19OdRjVJXZ4VQIIX/Z7qnKk345+gOhuDl4kFH7y7Z
ZvVtCa6bgOYwnA/rQa+TCMp4bhft8XseUo21GB2noV0odaYqGoPFdn9Sr0lHHHJ/
+CcYBrvx095H8q4FW5dl8Ba/n0oiNp+cQ98DULs+A/pL0kdAwzlaMTka7vSHhWta
ija/vMmXPoWzyun7tc3ZnXFTu3FjN+J/tUryUGhBOKX6a3l2Q41KkLp7sHG8LUwJ
yyTrArGdT0SkJr6SsyMkuS5tG4ChucUyrWh2PyRNwZ/8I9S3TwXyrjuq+baFrQXh
G36CXXxf7wdQwsbc0aNciI23wNT7ru+HQN0fuV9nt612mLf/p3s=
=lDuk
-----END PGP SIGNATURE-----

--irmoea5ptce6kmrw--
