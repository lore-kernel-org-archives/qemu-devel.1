Received: from eggs.gnu.org ([2001:4830:134:3::10]:36462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cvlOC-0002MQ-TD
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cvlOB-0006U4-Vj
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:54:24 -0400
References: <20170405091909.36357-1-bjsdjshi@linux.vnet.ibm.com>
	<20170405091909.36357-2-bjsdjshi@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0910cdba-6e7b-169f-784a-a0e064f2c71d@redhat.com>
Date: Wed, 5 Apr 2017 15:54:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170405091909.36357-2-bjsdjshi@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AUDnR11W1UaRjpLOCawFfe9lTIIvfvsGP"
Subject: Re: [Qemu-devel] [PATCH v4 1/1] block: pass the right options for
 BlockDriver.bdrv_open()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-block@nongnu.org, kwolf@redhat.com
Cc: qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AUDnR11W1UaRjpLOCawFfe9lTIIvfvsGP
From: Max Reitz <mreitz@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 kwolf@redhat.com
Cc: qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com
Message-ID: <0910cdba-6e7b-169f-784a-a0e064f2c71d@redhat.com>
Subject: Re: [PATCH v4 1/1] block: pass the right options for
 BlockDriver.bdrv_open()
References: <20170405091909.36357-1-bjsdjshi@linux.vnet.ibm.com>
 <20170405091909.36357-2-bjsdjshi@linux.vnet.ibm.com>
In-Reply-To: <20170405091909.36357-2-bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 05.04.2017 11:19, Dong Jia Shi wrote:
> raw_open() expects the caller always passing in the right actual
> @options parameter. But when trying to applying snapshot on a RBD
> image, bdrv_snapshot_goto() calls raw_open() (by calling the
> bdrv_open callback on the BlockDriver) with a NULL @options, and
> that will result in a Segmentation fault.
>=20
> For the other non-raw format drivers, it also makes sense to passing
> in the actual options, althought they don't trigger the problem so
> far.
>=20
> Let's prepare a @options by adding the "file" key-value pair to a
> copy of the actual options that were given for the node (i.e.
> bs->options), and pass it to the callback.
>=20
> BlockDriver.bdrv_open() expects bs->file to be NULL and just
> overwrites it with the result from bdrv_open_child(). That means we
> should actually make sure it's NULL because otherwise the child BDS
> will have a reference count that is 1 too high. So we unconditionally
> invoke bdrv_unref_child() before calling BlockDriver.bdrv_open(), and
> we wrap everything in bdrv_ref()/bdrv_unref() so the BDS isn't
> deleted in the meantime.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  block/snapshot.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)

Thank you, I've applied the patch to my block branch (for inclusion in 2.=
9):

https://github.com/XanClic/qemu/commits/block

Max


--AUDnR11W1UaRjpLOCawFfe9lTIIvfvsGP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljk9wYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ANZcH/itA+gzSBzInH/kFo74x9gcoSakuhR1m
v8sZvfC3MHODC9A9uiaO4JyjlRkySA2fdGka1edOxerjRDYiJlmLB+Di/Ced4Hou
wc8V8KvABLjZCB6rwZ8SOttz3+gLVFirAsZxzzJYHbnrOKHwaxhXElyG8OWTJozE
9UuCIm4OyEKcjganyNiaTAoFThivmWiRHCBITPg6c4/jxhC/BluyGWncZgvyeAN2
UxYUEUvz9BrEVTd4YgAgi7ee+y3ARICiC1un1NVyNrXc/H+rJrvCX7C3yQv+xpw/
dckkD8ja7FGWf5YyEMMvT7BRCdO+WYdfK/qV/+vVPOyXz3QnCg66IY4=
=cC4Y
-----END PGP SIGNATURE-----

--AUDnR11W1UaRjpLOCawFfe9lTIIvfvsGP--
