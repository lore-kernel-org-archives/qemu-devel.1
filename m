Received: from eggs.gnu.org ([2001:4830:134:3::10]:58565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dxUvE-0008TA-QU
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dxUv8-0007bD-P1
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:15:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dxUv8-0007aq-Ex
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:15:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91F75D097B
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 09:15:49 +0000 (UTC)
References: <20170927130339.21444-1-ehabkost@redhat.com>
	<20170927130339.21444-2-ehabkost@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <655d9ac0-f36e-a764-0e3c-d1d28818bd9a@redhat.com>
Date: Thu, 28 Sep 2017 11:15:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170927130339.21444-2-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s6SkifAdtJsv0jv5Eo39Rj9KsckTBFlpi"
Subject: Re: [Qemu-devel] [PATCH 1/5] guestperf: Configure logging on all
 shell frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s6SkifAdtJsv0jv5Eo39Rj9KsckTBFlpi
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, "Daniel P . Berrange"
 <berrange@redhat.com>
Message-ID: <655d9ac0-f36e-a764-0e3c-d1d28818bd9a@redhat.com>
Subject: Re: [PATCH 1/5] guestperf: Configure logging on all shell frontends
References: <20170927130339.21444-1-ehabkost@redhat.com>
 <20170927130339.21444-2-ehabkost@redhat.com>
In-Reply-To: <20170927130339.21444-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 27.9.2017 v 15:03 Eduardo Habkost napsal(a):
> The logging module will eventually replace the 'debug' parameter
> in QEMUMachine and QEMUMonitorProtocol.
>=20
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/migration/guestperf/shell.py | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guest=
perf/shell.py
> index 7992459a97..e378cf0cfa 100644
> --- a/tests/migration/guestperf/shell.py
> +++ b/tests/migration/guestperf/shell.py
> @@ -26,6 +26,7 @@ sys.path.append(os.path.join(os.path.dirname(__file__=
),
>  import argparse
>  import fnmatch
>  import platform
> +import logging
> =20
>  from guestperf.hardware import Hardware
>  from guestperf.engine import Engine
> @@ -64,6 +65,11 @@ class BaseShell(object):
> =20
>          self._parser =3D parser
> =20
> +    def init_logging(self, args):
> +        logging.basicConfig(level=3D(logging.DEBUG if args.debug else
> +                                   logging.INFO if args.verbose else
> +                                   logging.WARN))
> +
>      def get_engine(self, args):
>          return Engine(binary=3Dargs.binary,
>                        dst_host=3Dargs.dst_host,
> @@ -147,6 +153,7 @@ class Shell(BaseShell):
> =20
>      def run(self, argv):
>          args =3D self._parser.parse_args(argv)
> +        self.init_logging(args)
> =20
>          engine =3D self.get_engine(args)
>          hardware =3D self.get_hardware(args)
> @@ -179,6 +186,7 @@ class BatchShell(BaseShell):
> =20
>      def run(self, argv):
>          args =3D self._parser.parse_args(argv)
> +        self.init_logging(args)
> =20
>          engine =3D self.get_engine(args)
>          hardware =3D self.get_hardware(args)
> @@ -231,6 +239,7 @@ class PlotShell(object):
> =20
>      def run(self, argv):
>          args =3D self._parser.parse_args(argv)

This class is not inherited from the `BaseShell`, therefor it does not co=
ntain `init_logging` method. Apart from this it looks good.

> +        self.init_logging(args)
> =20
>          if len(args.reports) =3D=3D 0:
>              print >>sys.stderr, "At least one report required"
>=20



--s6SkifAdtJsv0jv5Eo39Rj9KsckTBFlpi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZzL3DExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsGp
1AgAuOwzs5xSw/if3toryXwwe578cElaELSf+CUQ/BMSNwpUHM69/xcMzAkZyIUY
8IZ6fkfpW8XJAmwSYsvlmrJdqpJGWwlO8mT2V5eXLPnBZN73DHKJkm4DdV4miQv1
IIf82FGJ0fUZV22/TG02oJTLmE4lH7KNXq3dpEdtrjk1NmccXYveZk3zNr1HzxTA
fda37OHa2iUSB2eSN+Z9GAAOiaugil2BVCKWDpEte+ZGYlWNee0PTi+WqRv577jb
gXoZDH+OrzauPc9orptTKmCvWKxYVMO0ndv4dfWc2c95hiVxl5khEkItoWTgv453
mJiWpt2H3qooQgp9IzY7Kkynnw==
=bwe3
-----END PGP SIGNATURE-----

--s6SkifAdtJsv0jv5Eo39Rj9KsckTBFlpi--
