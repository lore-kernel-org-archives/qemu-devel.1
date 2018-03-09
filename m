Received: from eggs.gnu.org ([2001:4830:134:3::10]:39623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1euHXt-00054d-4o
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1euHXs-0005Dx-E2
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:54:49 -0500
References: <20180306130121.30243-1-berto@igalia.com>
	<cec0f674-b25a-9c7c-e12c-49513e0060d0@redhat.com>
	<w518tb3qae5.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <08c5381a-cacf-6d0d-d804-4066a7d3018c@redhat.com>
Date: Fri, 9 Mar 2018 13:54:31 +0100
MIME-Version: 1.0
In-Reply-To: <w518tb3qae5.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q36PGl0Kg9Hz87d1tdob4TiEsSTj1A61N"
Subject: Re: [Qemu-devel] [PATCH v4] iotests: Tweak 030 in order to trigger
 a race condition with parallel jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q36PGl0Kg9Hz87d1tdob4TiEsSTj1A61N
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <08c5381a-cacf-6d0d-d804-4066a7d3018c@redhat.com>
Subject: Re: [PATCH v4] iotests: Tweak 030 in order to trigger a race
 condition with parallel jobs
References: <20180306130121.30243-1-berto@igalia.com>
 <cec0f674-b25a-9c7c-e12c-49513e0060d0@redhat.com>
 <w518tb3qae5.fsf@maestria.local.igalia.com>
In-Reply-To: <w518tb3qae5.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-08 08:44, Alberto Garcia wrote:
> On Wed 07 Mar 2018 06:54:51 PM CET, Max Reitz wrote:
>>> v4: Mention that commit 1a63a907507fbbcfaee3f622907ec24 also
>>>     contributes to solve the original bug (both commits need to
>>>     reverted in order to reproduce this bug reliably).
>>>
>>>     Rewrite the loop that writes data into the images to make it more=

>>>     readable.
>>
>> Thanks!  Applied to my block tree:
>>
>> https://github.com/XanClic/qemu/commits/block
>>
>> (Still took me a couple of attempts to get it to fail both commits
>> reverted, though...)
>=20
> Odd, I can reproduce it 100% of the cases. Were you maybe running the
> tests on tmpfs ?

=2E..yes? O:-)

Max

> Anyway, thanks!



--q36PGl0Kg9Hz87d1tdob4TiEsSTj1A61N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqihAcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AqoEH/1ncqjVichCNGt3lzVaWoaTgUdGf2s9f
uikkVQA8ptmFL/4NziAau5hIt/H3HS1FDNaj29EBLd5ky5CgYIrGGwDLCR8jR1Z4
mXv4Aq8bX4IuNaHzf7HM98YG1BoQZr1MnxHeo71SduogV7qsGaZMa2Gh51DujZOz
J140geksNkxAg5LDM3q9163rj5dwmV/hwlebql+aSMRU9oADAeU5VbNz7INmYBX7
e92grmBXGRJtZEs8qxFNX1DaG5TvvNa8rSAj6LTdkxsTLY5uTz9pX3GVdwKoEwwv
PRc71YELB2AKum51JS9tWUo5P/qgJB3O6esb/fDseZzb2Qs8mTjehVE=
=CQzf
-----END PGP SIGNATURE-----

--q36PGl0Kg9Hz87d1tdob4TiEsSTj1A61N--
