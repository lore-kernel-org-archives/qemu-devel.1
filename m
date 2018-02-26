Received: from eggs.gnu.org ([2001:4830:134:3::10]:49892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqI5k-0006p1-TO
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqI5f-0005Oa-Ak
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:41:16 -0500
From: Max Reitz <mreitz@redhat.com>
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-33-kwolf@redhat.com>
	<54c7b6c9-afbc-bbc2-8e9f-52b7245e5128@redhat.com>
Message-ID: <2a1b9e21-d397-a014-78d9-a56e2663f170@redhat.com>
Date: Mon, 26 Feb 2018 13:40:56 +0100
MIME-Version: 1.0
In-Reply-To: <54c7b6c9-afbc-bbc2-8e9f-52b7245e5128@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Gqqng3rhSgrFUwNvmm9nuYuh069sFZ575"
Subject: Re: [Qemu-devel] [PATCH v2 32/36] ssh: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gqqng3rhSgrFUwNvmm9nuYuh069sFZ575
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <2a1b9e21-d397-a014-78d9-a56e2663f170@redhat.com>
Subject: Re: [PATCH v2 32/36] ssh: Support .bdrv_co_create
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-33-kwolf@redhat.com>
 <54c7b6c9-afbc-bbc2-8e9f-52b7245e5128@redhat.com>
In-Reply-To: <54c7b6c9-afbc-bbc2-8e9f-52b7245e5128@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-26 13:40, Max Reitz wrote:
> On 2018-02-21 14:54, Kevin Wolf wrote:
>> This adds the .bdrv_co_create driver callback to ssh, which enables
>> image creation over QMP.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qapi/block-core.json | 16 ++++++++-
>>  block/ssh.c          | 92 +++++++++++++++++++++++++++++--------------=
---------
>>  2 files changed, 67 insertions(+), 41 deletions(-)
>=20
> This needs a rebase on my ssh truncation patches (notably "block/ssh:
> Pull ssh_grow_file() from ssh_create()") -- good thing for me you need
> to rebase, because without those patches you cannot create qcow2 files
> over ssh. O:-)

Oops, meant to reply to v3...

Max


--Gqqng3rhSgrFUwNvmm9nuYuh069sFZ575
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqUAFgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4EIH/in4NoyFei2l+CSD8EG+yBY/IIuqLb5g
/wxmvjUVObnRM8gHKrw2ldUnKqDES7ei5/f1agFRqMMoXVRHDRU9W24/Nh7LFhqd
E2w1fGbZNYKSy0cWGSOB1VLtgA97hOQ8qwIJm1tVQ6I/AzBApLYEMnmwwnorE5if
3e4JT+SsdtRZgJmyp1VIcDfwVXlnR3UqUeVLIVxO7L1k4QFqacsFItrj5d/mBdaa
fxWKvNMiCsBkxL0sZZCC2lW6RSjbrLX6HYzS3vv6PvvxBNrIPsPEJGqaqb3a6sCq
ZdD1AeRnsLzjimpZDMZSCRcbefq+GiIld6DOxBL5ONfIgD+x1KcMQ74=
=OFT2
-----END PGP SIGNATURE-----

--Gqqng3rhSgrFUwNvmm9nuYuh069sFZ575--
