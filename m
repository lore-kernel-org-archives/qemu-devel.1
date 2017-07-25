Received: from eggs.gnu.org ([2001:4830:134:3::10]:59754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dZzHq-0004XE-Ks
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dZzHm-0007Kh-Nl
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:50:06 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:38314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dZzHm-0007KL-Fj
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:50:02 -0400
Received: by mail-wr0-x236.google.com with SMTP id f21so62142385wrf.5
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 05:50:02 -0700 (PDT)
Date: Tue, 25 Jul 2017 13:49:58 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725124958.GA23343@stefanha-x1.localdomain>
References: <20170725112656.30122-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20170725112656.30122-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 (for 2.10) 0/1] Document deprecation
 policy & features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 12:26:55PM +0100, Daniel P. Berrange wrote:
> This is a followup to
>=20
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg02390.html
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01286.html
>   v3: https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00651.html
>   v4: https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04239.html
>=20
> I would really strongly like to see this documented in time for the
> 2.10 release, so that we can start the clock ticking on our deprecation
> policy and thus actually delete some stuff in the not too distant
> future.
>=20
> The goal is to clarify to users & app developers what they can expect
> from QEMU in terms of feature life & any deprecation policy should
> it be neccessary to remove features.
>=20
> The list of features marked as deprecated was determined by looking at
> the QEMU source for the word "deprecated'. It was then compared with
> the doc Thomas put up at http://wiki.qemu.org/Features/LegacyRemoval
>=20
> Key differences with the wiki page that Thomas wrote up vs patch 2
> in this series
>=20
>  - Deprecated features are given a fixed lifespan of 2 releases,
>    rather than listing deletion at a future "major" v3.0.0 release.
>    This ensures that applications like libvirt have a predictable
>    fixed amount of time to react to deprecations.
>=20
>  - Only lists features which are currently officially deprecated,
>    no list of possible future candidates. The wiki page is probably
>    a good place to maintain a list of future possible deprecations.
>    To turn them into actual deprecations, a patch to the QEMU doc
>    can then be posted & reviewed in the normal manner.
>=20
>  - Not listing the '-6' and '-e' args to qemu-img create. Those
>    were never deprecations, because the functionality was
>    immediately turned into a fatal error. Patches to delete these
>    have been merged now
>=20
> Changed in v6:
>=20
>  - Remove all discussion of machine types lifecycle since it
>    looks like they will be better kept upstream for as long=20
>    as any downstream wants them (Paolo)
>=20
>  - Get rid of separate "Support lifecycle" appendix and fold
>    its content into the "Deprecated features" appendix (Daniel)
>=20
>  - Fix s/-monitor/-mon/  (Thomas)
>=20
> Changed in v5:
>=20
>  - Removed misleading reference to "major" release (Eduardo)
>=20
> Changed in v4:
>=20
>  - Misc typos / wording clarification (Thomas)
>=20
> Changed in v3:
>=20
>  - Rename appendix to "Deprecated features" (Markus)
>  - List all currently deprecated features
>  - Document that deprecated features will be removed after
>    2 releases of being deprecated
>  - Clarify that clock for removing historically deprecated
>    features starts with the forthcoming release.
>=20
> Changed in v2:
>=20
>  - Split into 2 patches so we can consider each suggested addition
>    independantly.
>=20
>=20
> Daniel P. Berrange (1):
>   docs: document deprecation policy & deprecated features in appendix
>=20
>  qemu-doc.texi | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 175 insertions(+)
>=20
> --=20
> 2.13.3
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZdz52AAoJEJykq7OBq3PI/nkH/0Of/FSBnk7MgSTID0tvyALe
ISISx7va0PNYHqLxocld6nmXgp816zVkaBg67674rY4tBx837trvDjQp/NbALowi
slvQ9/UvWegRtHD4SJRDCEe3Oy+Q3ItBAA7Bpb0goWkOXvfMf9mdEK6tKLNk9hz6
i4dNx0Fpvq0Y8uVmKipsKr3G4+g31mDkIz7O+5KEaDbfGLuaOpV9JelaoRKENcEA
qkQx8Akmha4I5y3bMCF2vDVQogoWbZmyUC7EpAdoEXBiAkVHfJ+xsywxwLjEx8qe
eYPogf18llNDvdlMQi0j2e8R0SZ6Q2ArEh3tTNpLh7Vf7ddGsyUAhPqZGAaFAH4=
=n7Pw
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
