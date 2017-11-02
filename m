Received: from eggs.gnu.org ([2001:4830:134:3::10]:37009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAI2V-0000gO-72
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAI2P-0006ML-Cf
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:08:19 -0400
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-17-mreitz@redhat.com>
	<w51shdwwxpn.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b28222f7-e360-a31b-dc24-798e2db7d089@redhat.com>
Date: Thu, 2 Nov 2017 17:07:50 +0100
MIME-Version: 1.0
In-Reply-To: <w51shdwwxpn.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JH5MwQaIwrIMmHpIDvmwM1jd5D1MKqsLc"
Subject: Re: [Qemu-devel] [PATCH v6 16/25] block: Add 'base-directory' BDS
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JH5MwQaIwrIMmHpIDvmwM1jd5D1MKqsLc
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <b28222f7-e360-a31b-dc24-798e2db7d089@redhat.com>
Subject: Re: [PATCH v6 16/25] block: Add 'base-directory' BDS option
References: <20170929165347.29658-1-mreitz@redhat.com>
 <20170929165347.29658-17-mreitz@redhat.com>
 <w51shdwwxpn.fsf@maestria.local.igalia.com>
In-Reply-To: <w51shdwwxpn.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-02 15:40, Alberto Garcia wrote:
> On Fri 29 Sep 2017 06:53:38 PM CEST, Max Reitz wrote:
>> Using this option, one can directly override what bdrv_dirname() will
>> return. This is useful if one uses e.g. qcow2 on top of quorum (with
>> only protocol BDSs under the quorum BDS) and wants to be able to use
>> relative backing filenames.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Who would be using this option in practice? I understand that managemen=
t
> tools should be using always absolute filenames, and this API doesn't
> seem so convenient for humans.

Hmmm.  I seem to recall Eric liked it a couple of years ago when he was
still more on the libvirt side of things. :-)

Max


--JH5MwQaIwrIMmHpIDvmwM1jd5D1MKqsLc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAln7QtYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A3g0H/imHVIbe5U2R7+SscvXEiRutNFS2SMnd
IVNTtPBQWvex32X15vppW/GBNZoc5JoK7PRdMXUSdfbJYObRO4B4hxpRKipMsy1a
gLW/2jk4+Uzp/zEK+egwG1rr4CFXc/b1ChPvJOF7liHYFq/oZ+vyY218U02UJGb8
rupWe+g9KBi41yirtT6PxIrxzAPhRP+3Ns8C0eK9fyBEVTT7Sm22bvXR+jVvT2Kb
8+JGHMCUZVwQ7ZB98VqIL8cvbNDr6Km0rIZzc6E4neWDEtXruKIYLHOcRbgTwyeA
BQFjRt3AI07PHcwHOeT1hRG7YvkLe1XSk84Hq579qQNY4zQiuj7i56A=
=rJN0
-----END PGP SIGNATURE-----

--JH5MwQaIwrIMmHpIDvmwM1jd5D1MKqsLc--
