Received: from eggs.gnu.org ([2001:4830:134:3::10]:51342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfOCE-00049q-SO
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfOCC-0007B4-5f
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:26:38 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dfOCB-0007AP-Ul
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:26:36 -0400
Received: by mail-wm0-x22a.google.com with SMTP id m85so28070984wma.0
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 03:26:35 -0700 (PDT)
Date: Wed, 9 Aug 2017 11:26:27 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170809102627.GH18003@stefanha-x1.localdomain>
References: <20170726144226.6913-1-ldoktor@redhat.com>
	<20170726144226.6913-2-ldoktor@redhat.com>
	<20170808123829.GM16801@stefanha-x1.localdomain>
	<110c04e3-e676-c705-a6f9-de040208538e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Enx9fNJ0XV5HaWRu"
Content-Disposition: inline
In-Reply-To: <110c04e3-e676-c705-a6f9-de040208538e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 01/10] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org


--Enx9fNJ0XV5HaWRu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 02:56:47PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> Dne 8.8.2017 v 14:38 Stefan Hajnoczi napsal(a):
> > On Wed, Jul 26, 2017 at 04:42:17PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> >>      def command(self, cmd, conv_keys=3DTrue, **args):
> >> +        '''
> >> +        Invoke a QMP command and on success report result dict or on =
failure
> >=20
> > s/report/return/ ?
> >=20
> Don't see much difference, but I'll use the "return" in the next version.

"report" could mean the function logs or prints a message.  I have not
heard it used to mean "return".

Stefan

--Enx9fNJ0XV5HaWRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZiuNTAAoJEJykq7OBq3PIhUwH/0BBB+CtTbtBay0/Q6vFxJxv
aRf7w3S76wBlVrSYVzRl6BVmYepUbt1YTyBHGJfOo3k2guN6D24D23Htj3BQjZHM
nJpF8CyE2MLjXVUo1WJS0QlSztgbiJ5DKNkMa2C5rXWzIBzSAD8nnAYmDJ/TpiK+
MTSfP/Y3sQsaEkJ3c3FMcHWRJbc0wNWGlpzgsotmghpR402FnSTsr2ELG5SzlaoT
oX3BL6sgGl+iFikchJKQjZ8y/s6tk5O8DKMna6N88jId7Wxk5NDufIrGxf5uyxka
rQfXg2zYHYI09aiN/592maq4raetHnJGbyFLlZXOs9pS5tZCJZRa+iybOTmo/Sg=
=o/pT
-----END PGP SIGNATURE-----

--Enx9fNJ0XV5HaWRu--
