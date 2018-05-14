Received: from eggs.gnu.org ([2001:4830:134:3::10]:48880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIEQ4-0007QI-Pc
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIEQ1-0007gG-LI
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:25:44 -0400
Date: Mon, 14 May 2018 15:25:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514142538.GI5182@stefanha-x1.localdomain>
References: <20180511222052.8734-1-ehabkost@redhat.com>
	<20180511222052.8734-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nO3oAMapP4dBpMZi"
Content-Disposition: inline
In-Reply-To: <20180511222052.8734-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC 02/10] python: futurize -f
 libfuturize.fixes.fix_absolute_import
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 11, 2018 at 07:20:44PM -0300, Eduardo Habkost wrote:
> diff --git a/tests/image-fuzzer/qcow2/layout.py b/tests/image-fuzzer/qcow2/layout.py
> index 63e801f4e8..df2131a855 100644
> --- a/tests/image-fuzzer/qcow2/layout.py
> +++ b/tests/image-fuzzer/qcow2/layout.py
> @@ -1,3 +1,4 @@
> +from __future__ import absolute_import

Please move this below the copyright header.

--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+ZxiAAoJEJykq7OBq3PILgwIAMaksQ8Qux275wk9uFgQ41pg
bJxvdy7n6F+RxPa18QA2SKp8ARpcII7BsqczDgxM22S7o6XyBgYwWBfGvA8K9EIe
D/W54R4YevE5utN4Oi0AaVbNEUNwIlCdipPuPGkLFadTOGBMDidCdCwZSDSSN4ZS
PG8tOzpzClg6+ODyt7lBPWTu9yNAYiXixGOxRRZXT5Y+9Kiiy8evwDo0OcZi7pij
U6ApwDnmZAdzrYHQYyAkpNHLlICjxfZFOF2ZxBHqCRYHQ4XQc/U67H3tE6eTxDMn
uy2egFiipkzz9YkzweTufga241crHooPQs50OjomxxlVb8NSTdipbw2tUZ5zzwU=
=74Fv
-----END PGP SIGNATURE-----

--nO3oAMapP4dBpMZi--
