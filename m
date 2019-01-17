Received: from eggs.gnu.org ([209.51.188.92]:51503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkAKW-0003Wi-LB
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkAKU-00071F-QE
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:15:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gkAKU-0006aC-Gg
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:15:42 -0500
References: <20190117153321.29749-1-eblake@redhat.com>
	<20190117160657.GD11022@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cbb2fb16-9429-31d7-4771-e6393160420e@redhat.com>
Date: Thu, 17 Jan 2019 10:15:22 -0600
MIME-Version: 1.0
In-Reply-To: <20190117160657.GD11022@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="foLlvdnnbmhvAoKOj3Naszej2zkYJl36Y"
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] Expand 'qemu-img info' to show
 protocol details
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--foLlvdnnbmhvAoKOj3Naszej2zkYJl36Y
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com,
 jsnow@redhat.com
Message-ID: <cbb2fb16-9429-31d7-4771-e6393160420e@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] Expand 'qemu-img info' to show
 protocol details
References: <20190117153321.29749-1-eblake@redhat.com>
 <20190117160657.GD11022@redhat.com>
In-Reply-To: <20190117160657.GD11022@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/17/19 10:06 AM, Daniel P. Berrang=C3=A9 wrote:

> One thing that occurs to me is that the qemu-img info output data is
> getting larger & larger over time. Especially with LUKS, the format
> specific data is quite huge. Adding protocol specific info makes it
> larger again.
>=20
> In retrospect, IMHO, it would have been nice to not show the format
> specific info by default, requiring a --verbose arg. Assuming we don't
> want to change default behaviour though, we might as well show protocol=

> specific info by default too.
>=20
> I wonder though if we could benefit from a '-b' / '--brief' arg to make=

> it switch to show only the short common metadata, for people who want a=

> more concise output.

Do we have any backwards-compatibility guarantees on the output?  The
--output=3Djson is obviously going to be verbose, no matter what. But tha=
t
argues that any machine parsing should use --output=3Djson, and that
--output=3Dhuman can change without regards to back-compat.  Or, we could=

have --output=3Dbrief as a new third ofmt option (without having to burn
-b), and/or make --output=3Dfull be the verbose human form, and let the
default --output=3Dhuman stick to brief by default.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--foLlvdnnbmhvAoKOj3Naszej2zkYJl36Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxAqhoACgkQp6FrSiUn
Q2o+wwf/cvCivr06YTpKAw+1vCHZrpOliWPnl09ZOMGFld48uxHnBhdi1OyqMNew
dLSB2XIs0IfhHPyMYZTZriB5M8r4q4neig4QezflXcQ1xTKkEIn6E4Or51DvSQWH
ErP3DUkmyuh0UXg0DkT5er1ppMQF03+5rCDR0Hl77cCjFq1SchWU7nv0EpCLASWK
eHF7AMhSxO+jq8MeuKqQIhRUGgkjqBZu1SBw01H1Llm25v6Y+piFQIkX04Q5FvRA
x9ahEStsDNfbjQG1uW25+SWzJcBjO0c38udodY/iLIvy3UqIMldOurbmK3Q2+ynD
z3I2jbMCQEXFzV+/exCQXClcjFrSYQ==
=wKHv
-----END PGP SIGNATURE-----

--foLlvdnnbmhvAoKOj3Naszej2zkYJl36Y--
