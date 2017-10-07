Received: from eggs.gnu.org ([2001:4830:134:3::10]:42312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1e0kZf-0000Ng-N0
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 04:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1e0kZZ-0004gj-Ks
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 04:35:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1e0kZZ-0004eu-CJ
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 04:35:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D585F5F7BB
	for <qemu-devel@nongnu.org>; Sat,  7 Oct 2017 08:34:59 +0000 (UTC)
References: <20171005172013.3098-1-ehabkost@redhat.com>
	<20171005172013.3098-4-ehabkost@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <cf1d369d-6c59-8513-2662-ca10c58c517c@redhat.com>
Date: Sat, 7 Oct 2017 10:34:57 +0200
MIME-Version: 1.0
In-Reply-To: <20171005172013.3098-4-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n7hm92vFCOEPfvK6f8wrNtkdK79pKUJCt"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] scripts: Remove debug parameter
 from QEMUMachine
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
--n7hm92vFCOEPfvK6f8wrNtkdK79pKUJCt
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>
Message-ID: <cf1d369d-6c59-8513-2662-ca10c58c517c@redhat.com>
Subject: Re: [PATCH v2 3/3] scripts: Remove debug parameter from QEMUMachine
References: <20171005172013.3098-1-ehabkost@redhat.com>
 <20171005172013.3098-4-ehabkost@redhat.com>
In-Reply-To: <20171005172013.3098-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 5.10.2017 v 19:20 Eduardo Habkost napsal(a):
> All scripts that use the QEMUMachine and QEMUQtestMachine classes
> (device-crash-test, tests/migration/*, iotests.py, basevm.py)
> already configure logging.
>=20
> The basicConfig() call inside QEMUMachine.__init__() is being
> kept just to make sure a script would still work if it didn't
> configure logging.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qemu.py                     | 6 ++----
>  tests/migration/guestperf/engine.py | 6 ++----
>  tests/qemu-iotests/iotests.py       | 2 --
>  3 files changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index f6d2e68627..9bfdf6d37d 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -54,7 +54,7 @@ class QEMUMachine(object):
> =20
>      def __init__(self, binary, args=3DNone, wrapper=3DNone, name=3DNon=
e,
>                   test_dir=3D"/var/tmp", monitor_address=3DNone,
> -                 socket_scm_helper=3DNone, debug=3DFalse):
> +                 socket_scm_helper=3DNone):
>          '''
>          Initialize a QEMUMachine
> =20
> @@ -65,7 +65,6 @@ class QEMUMachine(object):
>          @param test_dir: where to create socket and log file
>          @param monitor_address: address for QMP monitor
>          @param socket_scm_helper: helper program, required for send_fd=
_scm()"
> -        @param debug: enable debug mode
>          @note: Qemu process is not started until launch() is used.
>          '''
>          if args is None:
> @@ -85,12 +84,11 @@ class QEMUMachine(object):
>          self._events =3D []
>          self._iolog =3D None
>          self._socket_scm_helper =3D socket_scm_helper
> -        self._debug =3D debug
>          self._qmp =3D None
>          self._qemu_full_args =3D None
> =20
>          # just in case logging wasn't configured by the main script:
> -        logging.basicConfig(level=3D(logging.DEBUG if debug else loggi=
ng.WARN))
> +        logging.basicConfig()
Yes, this behaves the same as `debug=3DFalse`

> =20
>      def __enter__(self):
>          return self
> diff --git a/tests/migration/guestperf/engine.py b/tests/migration/gues=
tperf/engine.py
> index 0a13050bc6..e14d4320b2 100644
> --- a/tests/migration/guestperf/engine.py
> +++ b/tests/migration/guestperf/engine.py
> @@ -388,15 +388,13 @@ class Engine(object):
>                                 args=3Dself._get_src_args(hardware),
>                                 wrapper=3Dself._get_src_wrapper(hardwar=
e),
>                                 name=3D"qemu-src-%d" % os.getpid(),
> -                               monitor_address=3Dsrcmonaddr,
> -                               debug=3Dself._debug)
> +                               monitor_address=3Dsrcmonaddr)
> =20
>          dst =3D qemu.QEMUMachine(self._binary,
>                                 args=3Dself._get_dst_args(hardware, uri=
),
>                                 wrapper=3Dself._get_dst_wrapper(hardwar=
e),
>                                 name=3D"qemu-dst-%d" % os.getpid(),
> -                               monitor_address=3Ddstmonaddr,
> -                               debug=3Dself._debug)
> +                               monitor_address=3Ddstmonaddr)
> =20
>          try:
>              src.launch()
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index 36a7757aaf..6f057904a9 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -195,8 +195,6 @@ class VM(qtest.QEMUQtestMachine):
>          super(VM, self).__init__(qemu_prog, qemu_opts, name=3Dname,
>                                   test_dir=3Dtest_dir,
>                                   socket_scm_helper=3Dsocket_scm_helper=
)
> -        if debug:
> -            self._debug =3D True

And this is the main issue. So instead of the fix I proposed in previous =
commit major changes to "tests/qemu-iotests/iotests.py" are necessary.

>          self._num_drives =3D 0
> =20
>      def add_device(self, opts):
>=20


--n7hm92vFCOEPfvK6f8wrNtkdK79pKUJCt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZ2JGxExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsG/
LAf+OCKuaKnM69rFwDYTheoud4Kjut3k4sGlhczQtXKJpL4JAbmCrwILG5epz4jK
COTmr1AB6/CRpBTbfDyjPcioAH/dJRgWznE4En1LU4Fv5RcCErFXFRz+4Bi/RO3x
HUqwtIoeRWBct9EKUD4Hl+aRTFyzqR/3UfY7OEFubCk7J8ah8oKa+ZtcfPrSL7qn
0ETsB8SYmz930KBywPOdGFk2ap5OzSVPSOYv8XA1wDH24MMDt2wrguX0dHLPiXi9
FviLjc5XZfmlV8nY81yierkMrfw67M5X0AkrCfC/oxcjyZPqsMOxMrHTFBYeJ4f0
7iCx3zHExaZHJn81oXPsYTpEcg==
=nt+T
-----END PGP SIGNATURE-----

--n7hm92vFCOEPfvK6f8wrNtkdK79pKUJCt--
