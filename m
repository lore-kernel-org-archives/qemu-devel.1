Received: from eggs.gnu.org ([2001:4830:134:3::10]:49200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dS61f-0002qf-TV
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dS61f-0007wA-1E
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:24:47 -0400
Date: Mon, 3 Jul 2017 21:24:27 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170703182427.ltj6bbezc3udfiq3@postretch>
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
	<20170629184320.7151-4-el13635@mail.ntua.gr>
	<69eaa5de-6e3c-d520-cdc6-35a6298aee94@redhat.com>
	<a3c3ad15-ae75-4eae-f74e-72da4e96d980@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="glewsaigyx5xcxyx"
Content-Disposition: inline
In-Reply-To: <a3c3ad15-ae75-4eae-f74e-72da4e96d980@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block: add default implementations
 for bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--glewsaigyx5xcxyx
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2017 at 12:51:45PM -0500, Eric Blake wrote:
>On 07/03/2017 11:12 AM, Eric Blake wrote:
>> On 06/29/2017 01:43 PM, Manos Pitsidianakis wrote:
>>> bdrv_co_get_block_status_from_file() and
>>> bdrv_co_get_block_status_from_backing() set *file to bs->file and
>>> bs->backing respectively, so that bdrv_co_get_block_status() can recurse
>>> to them. Future block drivers won't have to duplicate code to implement
>>> this.
>>>
>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>>> ---
>>>  block/blkdebug.c          | 12 +-----------
>>>  block/commit.c            | 12 +-----------
>>>  block/io.c                | 24 ++++++++++++++++++++++++
>>>  block/mirror.c            | 12 +-----------
>>>  include/block/block_int.h | 16 ++++++++++++++++
>>>  5 files changed, 43 insertions(+), 33 deletions(-)
>>
>> My [still-needs-rebasing] part 3 series converting
>> bdrv_co_get_block_status to byte-based will be impacted by this, but I'd
>> rather yours go in first and I can deal with the rebase fallout.
>
>In fact, my rebase fallout is to completely delete
>bdrv_co_get_block_status_from_file().  Why? Because blkdebug is the only
>client, but I want to enhance blkdebug to add in-place assert()ions that
>the values passed by the block layer are properly aligned to
>bs->bl.request_alignment (matching what blkdebug does for read and write
>- after all, if a device cannot access smaller than a given alignment
>for a read, it should not be able to report different statuses half-way
>through that granularity).  However, in-place assertions are no longer
>generic, so we no longer have a client of a generic helper function
>referring to bs->file.
>
>Which means you are REALLY left only with commit and mirror as the two
>functions that have a common implementation of pointing back to=20
>backing.


Hello Eric, thanks for taking the time to review my patches.

The throttle driver I'm working on passes bdrv_co_get_block_status() to=20
bs->file. If there is a problem with an unused default function (it's=20
not static so will compile, but it might not be up to standard), you can=20
just remove it and I will reintroduce it when it's needed. CC me on=20
those patches when you send them if you can.

--glewsaigyx5xcxyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllai9sACgkQc2J8L2kN
9xDiag/8DsiP43myPZHnNM00+St2/6igvSOSkhovtSDiiJLayQgAep1bDCEeSLQY
+YGX6zXiEXbkLor66vW9j3MuSIRraNfPU4TkYTIrjdjiEME1ALlwmbuDrxwS1iOb
eK9tOBdyd/YIlHE5wL5zAkYsjjPB622hzoq3PQG+EI5gy+eS4bWuaKG6ZsXb9wG0
+HShJO/XcfkRy3hl6vmte8fmqeHUdnU0li2klwiUT54NwKeGibCD9FtHrY6YW4K4
+T7rhdqzo9ba7Zp/iNLLxkJtikbC1e9BmCgbe8ygf6YjEuFd25YYyGMTaiKfw/Oc
+wTSuXvdY/+sJWZY+9cCsIA1usijujcGv99uRxPwFIadet3oymYQuZLpa1z9UWUQ
hWIEXKwz3y7rJRjNb2bGtHyYDhPstR5+Vvc2oeHnDKsnF0SZVuy4uUCjVj/IK6Cg
1gCEBuDP561gPjkzRBoBD/YT+iveo4REUUSN2afXvDh2irQgHMGYmkpVZP0hlaRu
gN/07MQNdlHsan+VEVJPVEDXFr10DH3/+yZdUkum4v8SmbVIoL2A0v9LaatOjTMk
c3gy04qJWkwjSh17aEBKEhfeTVirX3DvmefoiOyIs1a+d/jRi9c5nrsvMYvsLzAX
xwMHZoQ9Nk2u5q8mDrf5vMVTzDozQp6VK0aLv12YLtzsStEBOW0=
=jeLi
-----END PGP SIGNATURE-----

--glewsaigyx5xcxyx--
