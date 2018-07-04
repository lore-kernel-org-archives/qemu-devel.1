Received: from eggs.gnu.org ([2001:4830:134:3::10]:35762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1faiT5-0003NI-Co
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1faiT4-0003Al-Ex
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:09:15 -0400
References: <20180702025836.20957-1-famz@redhat.com>
	<02d1f79b-c055-bb2a-edd5-3429ff64af90@redhat.com>
	<20180703012626.GB485@lemon.usersys.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d9d73f8e-89c8-4ae9-c6b6-a180826768bd@redhat.com>
Date: Wed, 4 Jul 2018 16:09:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180703012626.GB485@lemon.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CIA6RBFzzO5G7xNj3NjhivydGSToU6TWD"
Subject: Re: [Qemu-devel] [PATCH 0/4] block: Trivial fixes in offloading code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CIA6RBFzzO5G7xNj3NjhivydGSToU6TWD
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <d9d73f8e-89c8-4ae9-c6b6-a180826768bd@redhat.com>
Subject: Re: [PATCH 0/4] block: Trivial fixes in offloading code
References: <20180702025836.20957-1-famz@redhat.com>
 <02d1f79b-c055-bb2a-edd5-3429ff64af90@redhat.com>
 <20180703012626.GB485@lemon.usersys.redhat.com>
In-Reply-To: <20180703012626.GB485@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-07-03 03:26, Fam Zheng wrote:
> On Mon, 07/02 14:35, Max Reitz wrote:
>> On 2018-07-02 04:58, Fam Zheng wrote:
>>> These are the low priority ones spotted by Kevin and Max last week.
>>>
>>> Fam Zheng (4):
>>>   qcow2: Drop unused cluster_data
>>>   file-posix: Fix fd_open check in raw_co_copy_range_to
>>>   qcow2: Drop unreachable break
>>>   raw: Drop superfluous semicolon
>>>
>>>  block/file-posix.c | 2 +-
>>>  block/qcow2.c      | 3 ---
>>>  block/raw-format.c | 2 +-
>>>  3 files changed, 2 insertions(+), 5 deletions(-)
>>
>> Thanks, applied to my block branch:
>>
>> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
>>
>>
>> Do you want to make qcow2_co_copy_range_to() do something special on
>> BDRV_REQ_ZERO_WRITE?  To me, it seems natural, but on the other hand
>> maybe it wouldn't bring anything.  If the protocol layer supports copy=

>> offloading, then it'll probably do that zero write efficiently anyway.=

>> If it doesn't, qemu-img convert will just fall back to the usual
>> implementation which involves writing zeroes when zeroes are read, so.=
=2E.
>>  What's your opinion?
>=20
> In bdrv_co_copy_range_internal() there is
>=20
>     if (flags & BDRV_REQ_ZERO_WRITE) {
>         return bdrv_co_pwrite_zeroes(dst, dst_offset, bytes, flags);
>     }
>=20
> before calling driver .bdrv_co_copy_range_to() callback. I think this i=
s enough?

Ah, right...  Yep, that's enough. :-)

Max


--CIA6RBFzzO5G7xNj3NjhivydGSToU6TWD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAls81QAACgkQ9AfbAGHV
z0AYxQgAnVic2zMkW94JnGzo2lFmgB74zOmSYtY9t+yLIn+smhc8hkhjZBv8Nj1O
PvOB/VLucMmfapdDQtoDnblFWxlDjN3w5n8Z6usl4cnbvqvC0dHhzqOu8sL2ZOq/
nyTnlMc/GuNAU0kx38gsXC9qohFh4pkjDKx+/lE0LPZyWo4XK1mu+86gxDPOQkAE
bBQhIbDwVdXmPC6igUs23aytA1SoAN0F274r2OA/EP/vkv/yIMuethmOZPpDyJ3I
EkC/7LGxgpR2ECgyROWKRV1LMj9u4U3X3te25h8uWwx+Slx9hQ8oSrgEF8dvJ3lc
yILF41cknIoKZQl5oird7m3qF/XlNQ==
=l/qL
-----END PGP SIGNATURE-----

--CIA6RBFzzO5G7xNj3NjhivydGSToU6TWD--
