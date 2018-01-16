Received: from eggs.gnu.org ([2001:4830:134:3::10]:46470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZwU-0007EU-Gn
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZwT-0007CD-JY
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:42:54 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<ef848b9847fecf18fbb05f9a9824436e6601a09d.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d5d984f-5d25-a2da-b50d-71c7a49e3de3@redhat.com>
Date: Tue, 16 Jan 2018 16:42:45 -0600
MIME-Version: 1.0
In-Reply-To: <ef848b9847fecf18fbb05f9a9824436e6601a09d.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9wjKVtgw5HIlodafb8qbol3ZbihlCpszd"
Subject: Re: [Qemu-devel] [PATCH v2 18/32] qcow2: Update
 qcow2_get_cluster_offset() to support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9wjKVtgw5HIlodafb8qbol3ZbihlCpszd
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <6d5d984f-5d25-a2da-b50d-71c7a49e3de3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 18/32] qcow2: Update
 qcow2_get_cluster_offset() to support L2 slices
References: <cover.1513342045.git.berto@igalia.com>
 <ef848b9847fecf18fbb05f9a9824436e6601a09d.1513342045.git.berto@igalia.com>
In-Reply-To: <ef848b9847fecf18fbb05f9a9824436e6601a09d.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> qcow2_get_cluster_offset() checks how many contiguous bytes are
> available at a given offset. The returned number of bytes is limited
> by the amount that can be addressed without having to load more than
> one L2 table.
>=20
> Since we'll be loading L2 slices instead of full tables this patch
> changes the limit accordingly using the size of the L2 slice for the
> calculations instead of the full table size.
>=20
> The l2_table variable is also renamed to l2_slice to reflect this, and
> offset_to_l2_index() is replaced with offset_to_l2_slice_index().
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>=20

Callers like 'qemu-img map' will potentially have to iterate in more
steps over an entire image; but that's not a severe limitation.  The
block_status() functions already document that as long as drivers make
progress, callers must be prepared for back-to-back calls that return
the same status, so you are not breaking semantics with a shorter
clamping limit.

Maybe some of that is worth mentioning in the commit message.  Either way=
,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9wjKVtgw5HIlodafb8qbol3ZbihlCpszd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpef+UACgkQp6FrSiUn
Q2r74ggAlkkf44rAS7khwPMScnWa0/lRG1p1PqrnU1hy7BOKfdvdC1Hl27ZtGAOt
UgkUvHEXmoYh6xLRDLbO0CIOiiUqaJ5d7QOnckyhvk9XL94sof/VEt86QaTJMcSH
PXCFPTBKObRBt2lVXptqOi6fFMQjYs0/gOlcD1D8+YYQvjdM3syJkE//BpBr2y+0
no40RkJp5/JsETTrBLl1KGJ9qp/TqANijp3neDDmaybqKYjFzfs/s5ldQzLqQZ2g
WfZhTZwK8S+KDwLuC55HMqPKSDZDk71vdM8mRQ0XawZVdzQ2gKHwnkmYlBzabBhE
yxtw7wKRDCoDpvUewjcFS079PM/gng==
=mnaF
-----END PGP SIGNATURE-----

--9wjKVtgw5HIlodafb8qbol3ZbihlCpszd--
