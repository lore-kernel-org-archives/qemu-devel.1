Received: from eggs.gnu.org ([2001:4830:134:3::10]:47671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dajcA-0001dy-UB
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dajc7-0004lW-RF
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:18:10 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dajc7-0004lM-KM
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:18:07 -0400
Received: by mail-wm0-x242.google.com with SMTP id r77so10816350wmd.2
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 07:18:07 -0700 (PDT)
Date: Thu, 27 Jul 2017 15:18:04 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170727141804.GJ10129@stefanha-x1.localdomain>
References: <20170725171014.25193-1-apahim@redhat.com>
	<20170725171014.25193-2-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZVh52eu0Ophig4D"
Content-Disposition: inline
In-Reply-To: <20170725171014.25193-2-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/6] qemu.py: make 'args' public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com


--YZVh52eu0Ophig4D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 07:10:09PM +0200, Amador Pahim wrote:
> Let's make args public so users can extend it in instances
> without feeling like abusing the internal API.
>=20
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py               | 14 +++++++-------
>  tests/qemu-iotests/iotests.py | 18 +++++++++---------
>  2 files changed, 16 insertions(+), 16 deletions(-)

As discussed in the previous revision, I don't think this patch is
justified because all current users just need a protected field.  There
are no users who need the field to be public so this change is
premature.

Stefan

--YZVh52eu0Ophig4D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBAgAGBQJZefYcAAoJEJykq7OBq3PIdJ0H93nCUweWxZVSvdQzy4uKsrUL
FQFhjbPE9eXvn3W31pZeLYdbJd3R6PzUHaCXzIH7DfLFe12LT7OGJ5wr/gaO0sTq
Cqc+z7ADfLf75qpKwI7S/DtY/pvOXSAMa8NxhA2DPKDfigDOAFXCcoogIBX3Y3in
QfPfvC50HGoV5seNxBNIW7h5uBOvWonPzJJAiKHi+yBTH6dlcr2tT3tegBFeMSs0
GnINXjJjBD/Fs++TTwg5X4djiOmjgHBob1ATz7ua0TfuFIjh5sK6H3APWbVSrhN4
VWSqiMeCHJ0UF55x8E+P3luUdol286rsEVtPtOOkoEZKeH7cRpiUxESAPzG77A==
=Dvyw
-----END PGP SIGNATURE-----

--YZVh52eu0Ophig4D--
