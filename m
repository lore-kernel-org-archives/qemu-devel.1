Received: from eggs.gnu.org ([2001:4830:134:3::10]:37305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY7Oc-0000Wn-VS
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY7Oa-0000tc-Ah
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:09:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35584 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fY7Oa-0000sQ-4F
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:09:52 -0400
Date: Wed, 27 Jun 2018 11:09:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180627100949.GA5955@stefanha-x1.localdomain>
References: <20180621150254.4922-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20180621150254.4922-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace: forbid floating point types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2018 at 04:02:54PM +0100, Stefan Hajnoczi wrote:
> Only one existing trace event uses a floating point type.  Unfortunately
> float and double cannot be supported since SystemTap does not have
> floating point types.
>=20
> Remove float and double from the whitelist and document this limitation.
> Update the migrate_transferred trace event to use uint64_t instead of
> double.
>=20
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Daniel P. Berrang=E9 <berrange@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/devel/tracing.txt        | 5 +++++
>  migration/trace-events        | 2 +-
>  qapi/trace-events             | 2 +-
>  scripts/tracetool/__init__.py | 2 --
>  4 files changed, 7 insertions(+), 4 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM2JtAAoJEJykq7OBq3PIpv8H/3VQLzxIp7QqSL/oZjjar8pl
uqFk2yn+o72I3N8/W8zB3zAvo7TedUpNG4yKIfIxb4VakoUOt4qpIDkouuX+DKHA
Jpc1hGLBKPTNoeH2lVDtyGz+xc8y0hvGuA/UDvV4XIs8CzLjI4DBaLM3eCzO4ivr
p1I9rRqX44eKK6F59C43lDY3DUdCOLtGoNeDgVcwuHxy+kM2hZMN0bwMn/9AjC/0
u43yxTSG9p9W8M7wO4xI5om/8Tc/Eg867fNK5qytcGsGh/fOHj7eMSeRj+G+Y4Ke
qAcz/aXx4NcRFnlwE2Wu4TlJ7LSHGqVmaYu3riyf7bBBLRCYSmdA7Z/l0LemvLM=
=ExO6
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
