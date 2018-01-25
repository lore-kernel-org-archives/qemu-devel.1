Received: from eggs.gnu.org ([2001:4830:134:3::10]:43612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eeiG6-0000MU-95
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:12:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eeiG2-0006zE-8Z
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:12:06 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:46835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eeiG2-0006yN-2O
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:12:02 -0500
Received: by mail-wm0-x235.google.com with SMTP id 143so14833778wma.5
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 06:12:02 -0800 (PST)
Date: Thu, 25 Jan 2018 14:11:58 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180125141158.GC28396@stefanha-x1.localdomain>
References: <7e30d2cc-6c42-15e9-78ef-1085e081a386@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <7e30d2cc-6c42-15e9-78ef-1085e081a386@redhat.com>
Subject: Re: [Qemu-devel] Functional tests (AKA Avocado-based tests)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, Jeff Nelson <jen@redhat.com>


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 17, 2018 at 03:05:54AM -0500, Cleber Rosa wrote:
> This is about how QEMU developers can get started with functional
> tests that are built on top of the Avocado libraries (and meant to be
> run with the Avocado test runner).

Here is my guess at where this fits into QEMU's testing landscape:

Avocado can help us write a new kind of test - functional (acceptance)
tests - that run full-blown guest operating systems, invoke shell
commands inside guests, and also use QMP.  Avocado can probably test
guest OS installation and boot.

There is some overlap with what exists in tests/ today, but I guess it
won't replace check (unit tests), qtests, or qemu-iotests.

Is this how you envision Avocado usage in QEMU?

Stefan

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaaeWuAAoJEJykq7OBq3PIj9sH/09sNW8pvNW/CFe9HEqB5gXd
4PSvNGy+G5SI/4zj7ASIHdCoYT3+3+wzxz6PKDWC3/Ze9bxGTS4y3VRaOyFqkogp
MHzFWOLe8RdxeQxaihWfZ8lnk3AeTqXnDSWpBeVSf3fE18r4H1z5yMVjY3ry4D4K
A0nbgj9QoDUE171fh1uskEh4nOF+tigSJ9dZhf9lW8JylCc6Ayioc+00XrCNVoP7
hmCZq1McPaNkJlhHtJp1nZQTHgsVcyy99hGFMzEV+jJhQi+H9Rkdq566Kd2csshY
eKyAx6RQ9ncj60aUS7ZUenPW55OjSb2fXFu9fP+0DW832titInUjRG9rMePmELE=
=OTpc
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
