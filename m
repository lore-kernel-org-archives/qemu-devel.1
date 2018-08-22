Received: from eggs.gnu.org ([2001:4830:134:3::10]:50819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsQw5-0004No-E4
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsQrP-0004cs-1z
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:59:35 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-3-jsnow@redhat.com>
	<332129bf-2c69-8ad2-ca0c-c95322639f7c@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c63c5a3b-9168-a502-453f-3ccabc2ff747@redhat.com>
Date: Wed, 22 Aug 2018 12:59:21 +0200
MIME-Version: 1.0
In-Reply-To: <332129bf-2c69-8ad2-ca0c-c95322639f7c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cv6KVmj4FN7wf9IfVDyt2rAxU4SjbTYp5"
Subject: Re: [Qemu-devel] [PATCH 2/7] jobs: canonize Error object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cv6KVmj4FN7wf9IfVDyt2rAxU4SjbTYp5
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com
Message-ID: <c63c5a3b-9168-a502-453f-3ccabc2ff747@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/7] jobs: canonize Error object
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-3-jsnow@redhat.com>
 <332129bf-2c69-8ad2-ca0c-c95322639f7c@redhat.com>
In-Reply-To: <332129bf-2c69-8ad2-ca0c-c95322639f7c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-21 02:10, John Snow wrote:
>=20
>=20
> On 08/17/2018 03:04 PM, John Snow wrote:
>> +            error_setg_errno(&job->err, -job->ret, "job failed");
>=20
> Kevin specifically asked for me to change this, and I lost it in the
> shuffle. I'll send a v3 now, since there are enough nits to warrant it,=

> and I think I want to adjust a few things to set up the "part II"
> portion of this changeset a little more nicely.

But error_setg_errno() uses either strerror() or
g_win32_error_message(), depending on the host OS.  I prefer that over a
blind strerror(), to be honest.

In general, it might make sense to introduce a qemu_strerror() (which
g_strdup()s strerror() on Linux, I presume, so it's compatible with
Win32); or to allow passing a NULL format to error_setg_errno() so you
only get the error string.

Max


--cv6KVmj4FN7wf9IfVDyt2rAxU4SjbTYp5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt9QgkACgkQ9AfbAGHV
z0CSrQgAg0MaCBr4iAFBdq9w5TfQ6gJCopYRo6GuZZKyq7ze2GCR9n1CoksfC6Td
rc26O0B0ntai2X6rakG2H/W+Z4NIED8Kjdf5kIPAZGn+6qAnkbs4dMUcx8D66NAb
SG2hODvrA4jR+8YYQZMc0SBbMYh+rV2fiHfBqNbkD12LAZbgMHlmQzIVpezRMgjo
rwhH6/21Ws7pRMRL25Kb9IBqVbo1h6lftyeWnvTIaW1I2JjfkjnGdjYbBJT5UPWY
uSZVYwRBwJKjBEdOiOnJHTT8ZB2/8xOuo+f22gfaSf/h2pb6Yb6GmUQdaE1I7MK9
Eo6zgN9421Qk+72k0Oz2bysztEw3JQ==
=dYVB
-----END PGP SIGNATURE-----

--cv6KVmj4FN7wf9IfVDyt2rAxU4SjbTYp5--
