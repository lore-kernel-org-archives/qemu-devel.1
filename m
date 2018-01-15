Received: from eggs.gnu.org ([2001:4830:134:3::10]:36620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eb8Fi-0005Cp-NJ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eb8Ff-0002IM-E5
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:08:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eb8Fe-0002Ho-UA
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:08:51 -0500
References: <20180115170243.24578-1-berrange@redhat.com>
	<20180115170243.24578-6-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5cbfed3a-f7d7-6a05-951d-b13d9a64ba46@redhat.com>
Date: Mon, 15 Jan 2018 11:08:44 -0600
MIME-Version: 1.0
In-Reply-To: <20180115170243.24578-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D5IIIo2NAA8nuDG2SXEPRoigfcDNAVO7K"
Subject: Re: [Qemu-devel] [PATCH v4 05/13] qapi: remove '-q' arg to diff
 when comparing QAPI output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D5IIIo2NAA8nuDG2SXEPRoigfcDNAVO7K
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5cbfed3a-f7d7-6a05-951d-b13d9a64ba46@redhat.com>
Subject: Re: [PATCH v4 05/13] qapi: remove '-q' arg to diff when comparing
 QAPI output
References: <20180115170243.24578-1-berrange@redhat.com>
 <20180115170243.24578-6-berrange@redhat.com>
In-Reply-To: <20180115170243.24578-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/15/2018 11:02 AM, Daniel P. Berrange wrote:
> When the qapi schema tests fail they merely print that the expected
> output didn't match the actual output. This is largely useless when
> trying diagnose what went wrong. Removing the '-q' arg to diff
> means that it is still silent on successful tests, but when it
> fails we'll see details of the incorrect output.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/Makefile.include | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--D5IIIo2NAA8nuDG2SXEPRoigfcDNAVO7K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpc4BwACgkQp6FrSiUn
Q2pAPgf7BEbF/jyDh8pwt2szTA559OVWfMuxPjYHPAiBX9P+VOJv5BDn3htcRkAM
C/TifSBraQmup1fWqS9vWGt+1cpYXe6UBlBTMNIt9VKjtnRkG45BShamoKthXxrJ
O2Pw6ZSEsowS1sTK5vBnuDcmTZzjAt9TWvOreeyNBMpdHCSYlMV0ZlmycB2sGsK9
Bo45/Sc2ZWO25BuT6/h2G14AkDgF+USb0ZykhxFDJW1eKwTP8cME4/RXAwcqIGck
ZR+3SmTuLPF+MLd3nqgYgF12E9OD6Ds9n77qmcrijLK7YNnzaHUgt3PPesWoyNHU
P6tbEsRU2YNA1999G9oJ96O2uinjgg==
=Xryu
-----END PGP SIGNATURE-----

--D5IIIo2NAA8nuDG2SXEPRoigfcDNAVO7K--
