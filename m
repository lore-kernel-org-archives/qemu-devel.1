Received: from eggs.gnu.org ([2001:4830:134:3::10]:58640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egXzk-0002NR-FT
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egXzg-0007SZ-GD
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:38:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1egXzg-0007RI-A2
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:38:44 -0500
Date: Tue, 30 Jan 2018 11:58:57 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180130115857.GA15551@stefanha-x1.localdomain>
References: <20180129160740.1195-1-stefanha@redhat.com>
	<151724248550.788.16657123948321508466@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <151724248550.788.16657123948321508466@5adcb62bf0d6>
Subject: Re: [Qemu-devel] [PULL 0/3] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 08:14:46AM -0800, no-reply@patchew.org wrote:
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/3: tracetool: prefix parse errors with line numbers...
> Checking PATCH 2/3: tracetool: clarify that "formats" means "format strin=
gs"...
> ERROR: line over 90 characters
> #39: FILE: scripts/tracetool/__init__.py:240:
> +            raise ValueError("Only events with 'tcg' property can have t=
wo format strings")
>=20
> WARNING: line over 80 characters
> #42: FILE: scripts/tracetool/__init__.py:242:
> +            raise ValueError("Events with 'tcg' property must have two f=
ormat strings")
>=20
> total: 1 errors, 1 warnings, 27 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> Checking PATCH 3/3: tracetool: report error on foo() instead of foo(void)=
=2E..
> WARNING: line over 80 characters
> #26: FILE: scripts/tracetool/__init__.py:79:
> +                raise ValueError("Empty argument (did you forget to use =
'void'?)")
>=20
> total: 0 errors, 1 warnings, 8 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> =3D=3D=3D OUTPUT END =3D=3D=3D

For the record, I didn't wrap these error messages so that grep(1)
works.

Stefan

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJacF4BAAoJEJykq7OBq3PIDhIH/33fekn1SjDFa8Y3wgXCnxkR
bM1RXIGOHraNF2+dzSSAlZiwPbClB6zNLIZ34rB1zArMON8S7/ZP2CD/nJA3pnui
E9ni/+23MBMr+IwuWjKHjjAHC69izVZEtu8a7x4HEhCB5eoP4/6D4xr9WVK6XacF
6TZ30wlbeCJ84ktEYW8+uxNuiJgRpK74uS07oFGBmQL6/Wp7Jhn4cAGxuvr7/hjJ
aQPJKCai4+7smuh7AzI/3h59+Ejs3xH5PDAbjqGiUUBys0LdTuFVNB2xHyptop6t
5R03g+u+/sTifVjoH2D2fguUQZbFSsp62NPc0e1W0dipO/q6giKVu830nMsIVQg=
=wkRT
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
