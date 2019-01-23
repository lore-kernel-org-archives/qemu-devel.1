Received: from eggs.gnu.org ([209.51.188.92]:44361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmMQJ-00005V-4P
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmMQI-0006Fw-D3
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:34:47 -0500
From: Max Reitz <mreitz@redhat.com>
References: <20181221234750.23577-1-mreitz@redhat.com>
	<20181221234750.23577-4-mreitz@redhat.com>
	<b064fb74-520f-3551-3d0c-603889e0cee6@redhat.com>
	<04d2a9e7-9cb8-74cf-0c0e-0c9d19940020@redhat.com>
Message-ID: <8204d711-5769-c2f7-7baf-0d26eaf8fa54@redhat.com>
Date: Wed, 23 Jan 2019 18:34:13 +0100
MIME-Version: 1.0
In-Reply-To: <04d2a9e7-9cb8-74cf-0c0e-0c9d19940020@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GkAaEDL2fFx01wzgHicdsLUmxEkfVxytE"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] iotests: Allow 147 to be
 run concurrently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GkAaEDL2fFx01wzgHicdsLUmxEkfVxytE
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <8204d711-5769-c2f7-7baf-0d26eaf8fa54@redhat.com>
Subject: Re: [Qemu-block] [PATCH 3/3] iotests: Allow 147 to be run
 concurrently
References: <20181221234750.23577-1-mreitz@redhat.com>
 <20181221234750.23577-4-mreitz@redhat.com>
 <b064fb74-520f-3551-3d0c-603889e0cee6@redhat.com>
 <04d2a9e7-9cb8-74cf-0c0e-0c9d19940020@redhat.com>
In-Reply-To: <04d2a9e7-9cb8-74cf-0c0e-0c9d19940020@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.19 14:05, Max Reitz wrote:
> On 21.01.19 21:50, John Snow wrote:

[...]

>> I guess my only other observation is that we have a lot of "while True=
"
>> loops now, is it worth creating some kind of helper that does the dirt=
y
>> work of finding a serviceable port or nah?
>=20
> Seems reasonable, I'll see how it looks.

If I do that, the diff stat looks to be 40+, 33-.  Is that worth it?

Max


--GkAaEDL2fFx01wzgHicdsLUmxEkfVxytE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxIpZUACgkQ9AfbAGHV
z0D1ZQf/XOyzBLa9ENDk6W43O/xMiXTOwp9vzGQshP1fn1jpjeH0c68aQqeWR2yB
Z17ZtNpvHmrFqdCINGS+lPs3BbXlmDCosAaQhoeqAvHfPxMOMVsQfxrjsUCIpACb
zAPMKhqwQuOz3SyfGFM9jOqX7swjmNWtUkr0/AwrOfzu3So87FG/QnbdEnierlkO
YMgSkJxeOHaMq0UC9J4nkLdNAFH1XbveH4XFaqnL+DQEAWtHDDbkfIB+KB7csQI2
c6pPHPH3e8+vkM9G/HZII7bSZ0S5/0kor4UTON/zqCiq/68p3DJQMh8h86me53xC
5jLtr6Ju9u9Wi7/Boye3Tl4vql4dTg==
=MQhc
-----END PGP SIGNATURE-----

--GkAaEDL2fFx01wzgHicdsLUmxEkfVxytE--
