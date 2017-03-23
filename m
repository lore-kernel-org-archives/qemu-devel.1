Received: from eggs.gnu.org ([2001:4830:134:3::10]:42752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqyVP-0001VX-14
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqyVO-0004YL-Ag
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:54:03 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cqyVO-0004YE-3q
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:54:02 -0400
Received: by mail-wm0-x241.google.com with SMTP id z133so15161407wmb.2
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 01:54:01 -0700 (PDT)
Date: Thu, 23 Mar 2017 08:53:58 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323085358.GK16717@stefanha-x1.localdomain>
References: <1490092792-30957-1-git-send-email-thuth@redhat.com>
	<1490092792-30957-3-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ee6FjwWxuMujAVRe"
Content-Disposition: inline
In-Reply-To: <1490092792-30957-3-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] libqtest: Add a generic function to
 run a callback function for every machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


--ee6FjwWxuMujAVRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2017 at 11:39:51AM +0100, Thomas Huth wrote:
> Some tests need to run single tests for every available machine of the
> current QEMU binary. To avoid code duplication, let's extract this
> code that deals with 'query-machines' into a separate function.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/libqtest.c    | 30 +++++++++++++++++
>  tests/libqtest.h    |  8 +++++
>  tests/pc-cpu-test.c | 95 ++++++++++++++++++++---------------------------=
------
>  tests/qom-test.c    | 36 ++++----------------
>  4 files changed, 80 insertions(+), 89 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ee6FjwWxuMujAVRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY040mAAoJEJykq7OBq3PIkuwH/1s4VNf79SLq+jZ9UILCcztv
GOFR4PoJnLQ6bAXzQEVme4lQnqtSKhJnqPpMEPpiD6VHINeWMZnCwaXiwCoXbKcF
5x95XRIb9Cjp7vHzJgt7AgJ3y1hVnweObhLHlwoysCZa+QN2OYt2mw0Fm5/HNQVA
IR9C3NzlZ/pE5B6D/eVnr4WQuD1ZqvyYzggiWNtC0AhAEQdT1ZYKkU9atT89+NTn
i+82wkwWLe7a3s9uW2Yh0LdEBERzUephsSsK1+wEYEGtVBoqcW1skTIlI82nLYb3
Fus8YYNH2Yizi6KqlWCOfB2GjgE7YuyTf7jgbqor7xcZaD1V0c1wa49ijOaUHmo=
=Ze8P
-----END PGP SIGNATURE-----

--ee6FjwWxuMujAVRe--
