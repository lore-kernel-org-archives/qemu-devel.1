Received: from eggs.gnu.org ([2001:4830:134:3::10]:56454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1e0izO-00037O-Rg
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 02:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1e0izK-0003Dy-6K
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 02:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1e0izJ-0003DV-Sp
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 02:53:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8813C04AC40
	for <qemu-devel@nongnu.org>; Sat,  7 Oct 2017 06:53:27 +0000 (UTC)
References: <20171005172013.3098-1-ehabkost@redhat.com>
	<20171005172013.3098-2-ehabkost@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <a62690df-1119-3062-1d0a-52aee9f3f8b4@redhat.com>
Date: Sat, 7 Oct 2017 08:53:25 +0200
MIME-Version: 1.0
In-Reply-To: <20171005172013.3098-2-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Qlq5A3SLiSxmt2W8fwMreEml8ACfC2NnA"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] guestperf: Configure logging on all
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qlq5A3SLiSxmt2W8fwMreEml8ACfC2NnA
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>
Message-ID: <a62690df-1119-3062-1d0a-52aee9f3f8b4@redhat.com>
Subject: Re: [PATCH v2 1/3] guestperf: Configure logging on all shell
 frontends
References: <20171005172013.3098-1-ehabkost@redhat.com>
 <20171005172013.3098-2-ehabkost@redhat.com>
In-Reply-To: <20171005172013.3098-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 5.10.2017 v 19:20 Eduardo Habkost napsal(a):
> The logging module will eventually replace the 'debug' parameter
> in QEMUMachine and QEMUMonitorProtocol.
>=20
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Inline init_logging() method on all callers because not all
>   classes derive from BaseShell (reported by Luk=C3=A1=C5=A1 Doktor)
> ---
>  tests/migration/guestperf/shell.py | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guest=
perf/shell.py
> index 7992459a97..b272978f47 100644
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
> @@ -147,6 +148,10 @@ class Shell(BaseShell):
> =20
>      def run(self, argv):
>          args =3D self._parser.parse_args(argv)
> +        logging.basicConfig(level=3D(logging.DEBUG if args.debug else
> +                                   logging.INFO if args.verbose else
> +                                   logging.WARN))
> +
> =20
>          engine =3D self.get_engine(args)
>          hardware =3D self.get_hardware(args)
> @@ -179,6 +184,10 @@ class BatchShell(BaseShell):
> =20
>      def run(self, argv):
>          args =3D self._parser.parse_args(argv)
> +        logging.basicConfig(level=3D(logging.DEBUG if args.debug else
> +                                   logging.INFO if args.verbose else
> +                                   logging.WARN))
> +
> =20
>          engine =3D self.get_engine(args)
>          hardware =3D self.get_hardware(args)
> @@ -231,6 +240,10 @@ class PlotShell(object):
> =20
>      def run(self, argv):
>          args =3D self._parser.parse_args(argv)
> +        logging.basicConfig(level=3D(logging.DEBUG if args.debug else
> +                                   logging.INFO if args.verbose else
> +                                   logging.WARN))
> +
> =20
>          if len(args.reports) =3D=3D 0:
>              print >>sys.stderr, "At least one report required"
>=20


Yep, this does the trick, also using a shared function would be IMO bette=
r (especially if we need to tweak the setup), something like

```diff
diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestpe=
rf/shell.py
index b272978..c1108ae 100644
--- a/tests/migration/guestperf/shell.py
+++ b/tests/migration/guestperf/shell.py
@@ -36,6 +36,12 @@ from guestperf.plot import Plot
 from guestperf.report import Report
=20
=20
+def _init_logging(args):
+    logging.basicConfig(level=3D(logging.DEBUG if args.debug else
+                               logging.INFO if args.verbose else
+                               logging.WARN))
+
+
 class BaseShell(object):
=20
     def __init__(self):
@@ -148,10 +154,7 @@ class Shell(BaseShell):
=20
     def run(self, argv):
         args =3D self._parser.parse_args(argv)
-        logging.basicConfig(level=3D(logging.DEBUG if args.debug else
-                                   logging.INFO if args.verbose else
-                                   logging.WARN))
-
+        _init_logging(args)
=20
         engine =3D self.get_engine(args)
         hardware =3D self.get_hardware(args)
@@ -184,10 +187,7 @@ class BatchShell(BaseShell):
=20
     def run(self, argv):
         args =3D self._parser.parse_args(argv)
-        logging.basicConfig(level=3D(logging.DEBUG if args.debug else
-                                   logging.INFO if args.verbose else
-                                   logging.WARN))
-
+        _init_logging(args)
=20
         engine =3D self.get_engine(args)
         hardware =3D self.get_hardware(args)
@@ -240,10 +240,7 @@ class PlotShell(object):
=20
     def run(self, argv):
         args =3D self._parser.parse_args(argv)
-        logging.basicConfig(level=3D(logging.DEBUG if args.debug else
-                                   logging.INFO if args.verbose else
-                                   logging.WARN))
-
+        _init_logging(args)
=20
         if len(args.reports) =3D=3D 0:
             print >>sys.stderr, "At least one report required"
```

Anyway both versions are fine by me.

Reviewed-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>=20


--Qlq5A3SLiSxmt2W8fwMreEml8ACfC2NnA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZ2HnlExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsFN
FQgAxfEVGjSDKi3pjNoJBde7DhtwEEbWTh7xUx4Mh7aatEZgoyOVH+dfBNUoqJOD
aeAhF22ixOIjpUaJpT/Q0Tuq39641AoDkOQECLfgXUZbgucoipzzdNFidHgbfNmv
D1xUwY21m6eoUl9exwQyHn7FE2D8IdLrnlNQKUBTLikvtdnrx3uOvz/mY4jqeJgb
ClCgmEVxSz9niX/VFCQ34JYZWcDPD5V8rM+ajvzKzzYUXPsl0FKbHgTQYySU2B/i
pGauYbAbSOj36ISYn84eZU09mMoiTEyrvIRy8rqAFPP+6a2qgM1sW0bLv1c9/0Ri
nN9miL1G6FxV0wQuxRbzABGurA==
=v7wv
-----END PGP SIGNATURE-----

--Qlq5A3SLiSxmt2W8fwMreEml8ACfC2NnA--
