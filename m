Received: from eggs.gnu.org ([2001:4830:134:3::10]:46281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIEFM-0003VT-1y
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIEFG-0003uA-2f
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:14:40 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:53063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fIEFF-0003ss-S3
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:14:34 -0400
Received: by mail-wm0-x243.google.com with SMTP id w194-v6so13742841wmf.2
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 07:14:33 -0700 (PDT)
Date: Mon, 14 May 2018 15:14:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514141431.GG5182@stefanha-x1.localdomain>
References: <1525936711-24538-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1525936711-24538-3-git-send-email-suhang16@mails.ucas.ac.cn>
	<deae818d-7405-f46e-5535-9a603d98ac41@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Content-Disposition: inline
In-Reply-To: <deae818d-7405-f46e-5535-9a603d98ac41@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v7 2/2] Add QTest testcase for the Intel
 Hexadecimal Object File Loader.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <qemu.ml@steffen-goertz.de>
Cc: Su Hang <suhang16@mails.ucas.ac.cn>, darcysail@gmail.com, qemu-devel@nongnu.org


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 08:57:48AM +0200, Steffen G=F6rtz wrote:
> On 10.05.2018 09:18, Su Hang wrote:
> > +
> > +    QTestState *s =3D qtest_startf(
> > +        "-M versatilepb -m 128M -nographic -kernel ../tests/hex-loader=
-check-data/test.hex");
> > +
>=20
> The test binary "text.hex" is not being copied to out-of-tree builds at
> the moment and the test run will therefore fail.
> The acpi tests also use a fixture (acpi-test-data) which is being copied
> to the out-of-tree build in ./configure:L7181 .
> This might also be an option for your test.

To explain how out-of-tree builds work for anyone who hasn't seen them
before:

  $ mkdir /var/tmp/build-dir
  $ cd /var/tmp/build-dir
  $ ~/qemu/configure ... && make

The .o files and other build output will be located in
/var/tmp/build-dir (away from the source code in ~/qemu/).

The build system must ensure that data files are available to the test
program in /var/tmp/build-dir/ if an out-of-tree build is being done.
In the acpi-test-data case that Steffen mentioned the ./configure script
sets up symlinks:

  for test_file in $(find $source_path/tests/acpi-test-data -type f)
  do
      FILES=3D"$FILES tests/acpi-test-data$(echo $test_file | sed -e 's/.*a=
cpi-test-data//')"
  done
  ...
  symlink "$source_path/$f" "$f"

Please add hex-loader-check-data in the same way.

Stefan

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+ZnHAAoJEJykq7OBq3PIThYIAIQ4ZlAmESalf3GPTEc473yX
EZets6FW1xVkumXqZ4jYyYjB+DuF3DmuycFsjbxziCB5lKjeVATqYZNab7SjWPkT
PH94ez+nrwKJMbNJUzvA4T09yKlGfwx5Sa1lE2VsemwuBb6M6h3IjlkbfkI8idDZ
yeNeU9hTVpq351QcnojgFGiJFn1jOojg5Bkvy0bZE/NnTEKNkKqGtkEAM2hSsm22
6yByQ/k1EsX8EaC1Oafzhnc7Xgz+zf96QcowqjvcZLyX0BLqNj/EFU3udCE7fed1
sKwGsarqzoamjkIMRLeRP4VmWF0oC3id4RmYTf/G+NHsSgynvth1ybGDJ7E4bLk=
=pNTd
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
