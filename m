Received: from eggs.gnu.org ([2001:4830:134:3::10]:44587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSksV-0004ZO-IL
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSksQ-0007Xu-RR
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:02:03 -0400
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-4-eblake@redhat.com>
	<20170704070643.GB10298@lemon.lan>
	<6aafcf61-7923-23c1-496d-6f2c195149d1@redhat.com>
	<20170705120725.GF29382@lemon.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aed7bd2b-b923-4fb9-8f13-2a996d8e4b4e@redhat.com>
Date: Wed, 5 Jul 2017 09:01:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170705120725.GF29382@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Kgew9MgePs9mcj5B9jPl5q3MPLgEcSWuI"
Subject: Re: [Qemu-devel] [PATCH v2 03/15] block: Add flag to avoid wasted
 work in bdrv_is_allocated()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kgew9MgePs9mcj5B9jPl5q3MPLgEcSWuI
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com
Message-ID: <aed7bd2b-b923-4fb9-8f13-2a996d8e4b4e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/15] block: Add flag to avoid wasted
 work in bdrv_is_allocated()
References: <20170703221456.30817-1-eblake@redhat.com>
 <20170703221456.30817-4-eblake@redhat.com> <20170704070643.GB10298@lemon.lan>
 <6aafcf61-7923-23c1-496d-6f2c195149d1@redhat.com>
 <20170705120725.GF29382@lemon.lan>
In-Reply-To: <20170705120725.GF29382@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/2017 07:07 AM, Fam Zheng wrote:
>>>
>>> Sorry for bikeshedding.
>>
>> Not a problem, I also had some double-takes in writing my own code
>> trying to remember which way I wanted the 'allocation' boolean to be
>> set, so coming up with a more intuitive name/default state in order to=

>> help legibility is worth it.  Do any of my above suggestions sound bet=
ter?
>>
>=20
> I'd vote for "mapping" because it has a close connection with offset (a=
s in
> BDRV_BLOCK_OFFSET_VALID).
>=20
> Or simply call it "offset" and if false, never return BDRV_BLOCK_OFFSET=
_VALID.

Well, there ARE drivers that WANT to return BDRV_BLOCK_OFFSET_VALID
regardless of the state of the boolean (namely, any driver that also
returns BDRV_BLOCK_RAW, to hint that this is a passthrough and the query
should be repeated at the next BDS in the chain).  So stating that
'offset' is false MUST preclude BDRV_BLOCK_OFFSET_VALID is a bit too
strong, but I can probably come up with appropriate wording that meets
in the middle ground (if 'offset' is true, then make all efforts to
include BDRV_BLOCK_OFFSET_VALID in the return if that is possible; if it
is false, then omitting the flag in order to get a larger pnum is
acceptable)).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Kgew9MgePs9mcj5B9jPl5q3MPLgEcSWuI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXPFFAAoJEKeha0olJ0NqluoIAKFZkv9NUoJjEOtHlvZyPIxz
LxWlvJLai4ska9Zk2LFc3fhs6eJQ99tZJK4Fe9pShtJq4gaxlHmHo96g2dIIC8Fy
oEUH1vzbAI+7yNsgYkJGQi5taohxoE03zjPdPVwkJwCSbuWV6l3ilCXgwsSk7Ytv
r8xb/cXpKAj/AxD5rPI9wAPFDnvZ24Y61MqW2GHbsSspaK66zvWL98jtQKfJeL41
qzZ/STmgoWtn62K17Dex3EAw3MrcJXYxTMT4AZZOUuiIaeLuovNvuToVKmXetlRd
3Ev7H2sXjNqWR0z/1bFvdOAezfde/8LphJ0xCOK5L7hrleYPjTfbR/LUvLYl+d4=
=A3ka
-----END PGP SIGNATURE-----

--Kgew9MgePs9mcj5B9jPl5q3MPLgEcSWuI--
