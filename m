Received: from eggs.gnu.org ([209.51.188.92]:40727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gma0a-0003dS-21
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gma0X-0001KX-Um
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:05:07 -0500
Date: Thu, 24 Jan 2019 08:57:30 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190124075730.GB1838@andariel.pipo.sk>
References: <20190123211953.28578-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <20190123211953.28578-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH] qemu-nbd: Deprecate qemu-nbd
 --partition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "reviewer:Incompatible changes" <libvir-list@redhat.com>, thuth@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2019 at 15:19:53 -0600, Eric Blake wrote:
> The existing qemu-nbd --partition code claims to handle logical
> partitions up to 8, since its introduction in 2008 (commit 7a5ca86).
> However, the implementation is bogus (actual MBR logical partitions
> form a sort of linked list, with one partition per extended table
> entry, rather than four logical partitions in a single extended
> table), making the code unlikely to work for anything beyond -P5 on
> actual guest images. What's more, the code does not support GPT
> partitions, which are becoming more popular, and maintaining device
> subsetting in both NBD and the raw device is unnecessary maintenance
> burden.  And nbdkit has just added code to properly handle an
> arbitrary number of MBR partitions, along with its existing code
> for handling GPT partitions.
>=20
> Note that obtaining the offsets of a partition can be learned by
> using 'qemu-nbd -c /dev/nbd0 file.qcow2 && sfdisk --dump /dev/nbd0',
> but by the time you've done that, you might as well just mount
> /dev/nbd0p1 that the kernel creates for you.
>=20
> Start the clock on the deprecation cycle, with an example of how
> to write device subsetting without using -P.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-deprecated.texi | 27 +++++++++++++++++++++++++++
>  qemu-nbd.texi        |  6 ++++--
>  qemu-nbd.c           |  2 ++
>  3 files changed, 33 insertions(+), 2 deletions(-)

Libvirt does not use qemu-nbd in any way so it's okay from our POV.

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlxJb+cACgkQHGwCByjY
1GqSXg//YXcxrmQwtfLouSmSBkH4yZCph8m0CERafyQKbvU3H3rbADu/YcgLE5Nq
cprJRFvnjCSzHclPGz+s9taoqePnaojAZc5AHLi01P+tq19RX52hGzYjVdqtprQk
TqbluBTRdixU1GCX4GFiBhWl6tuK7vMxj48eBiVqrGh22qDAaJQjqAmkElUghD+W
HYx/ZzmqbkT8Z5SNKxPwvONAix3MTb8rvOv+1PfrSSbRLqphCj6QO4Sb607MOPZs
q2jYIkPJR0/OaMXQP60qNR90dYqooiyw7kxvBT4iHQhd4QWulsOqFYHshGRxW/cU
Titwjibz3AFMr0KQ4yg7C/Oz5LjhUblSNxF60DD2E0yRXhWi7tyU44rFEKjKDTyM
DVIreEKyJyPIsvGl7JDAT6ghdQAPF5nuYaoaFGtazJ7DScTsh3DBfhFJ21lnYxDn
m5/NLVyCDkMl3fDGQGmWJhK2OK5aF6UGhiX9q/LQncxAHtP0Hv3lPc4k30ILT4Dt
k/oz/ZURjOn58IkKGoqDcqzvELJ1vU6DbUYcvMzc1X/0aGLMROk+ry3jLveN2iCJ
9EDu49q2LzoW+gGO+4VFZHUy3c67lTH553ep9W12ZILmBlw/0rmaNN13JVkc6e+0
TnL3I8v3j4E+ahhY+oTkFOgh/jhY4CuI4gaLhAgb+oG0mfQ88yQ=
=5By2
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
