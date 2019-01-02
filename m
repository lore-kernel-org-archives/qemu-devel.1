Received: from eggs.gnu.org ([208.118.235.92]:55470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1geinY-0003X7-J3
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 10:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1geinX-0006pZ-NC
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 10:51:12 -0500
References: <20190102100415.24680-1-mahaocong_work@163.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0817958d-de89-7e78-fcff-d2f208ffbe85@redhat.com>
Date: Wed, 2 Jan 2019 09:51:02 -0600
MIME-Version: 1.0
In-Reply-To: <20190102100415.24680-1-mahaocong_work@163.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wWiPJTJPM6POhYZq3IDAV40aXtKziRGlG"
Subject: Re: [Qemu-devel] [PATCH v2 0/1] drive-mirror: add incremental mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mahaocong <mahaocong_work@163.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, mahaocong <mahaocong@didichuxing.com>, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wWiPJTJPM6POhYZq3IDAV40aXtKziRGlG
From: Eric Blake <eblake@redhat.com>
To: mahaocong <mahaocong_work@163.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, mahaocong
 <mahaocong@didichuxing.com>, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <0817958d-de89-7e78-fcff-d2f208ffbe85@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/1] drive-mirror: add incremental mode
References: <20190102100415.24680-1-mahaocong_work@163.com>
In-Reply-To: <20190102100415.24680-1-mahaocong_work@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/2/19 4:04 AM, mahaocong wrote:
> From: mahaocong <mahaocong@didichuxing.com>
>=20
> This patch adds possibility to start mirroring with user-created-bitmap=
=2E
> Compare with v1, this patch fix some shortcomings.
> 1.separate feature about copy dirty-bitmap to an individual patch.
> 2.remove checking for cancelled after mirror_dirty_init_incremental for=
 bitmap
>   copyimg don't have yield point.
> 3.adjuest input parameters on mirror_start_job and mirror_start, and so=
 It is
>   no need to find bitmap on mirror_dirty_init_incremental again.
> 4.assert the bitmap name is NULL on blockdev_mirror_common.
> 5.change the parameter's name in qmp command 'drive-mirror' from 'bitma=
p_name'
>   to 'bitmap'.
>=20
> As for the doubt about the new incremental mode, I think it is means th=
at the
> initial bitmap is appointed by user, compare with the full mode and top=
 mode.
> There is no different in other behaves, such as in iteration and comple=
te
> action.
>=20
> mahaocong (1):
>   drive-mirror: add incremental mode
>   mirror: add incremental mode. we must add a user-named-bitmap first, =
then set
>           this bitmap as the initial bitmap on incremental mode drive-m=
irror.
>           in details, I first create unnamed-bitmap with the same granu=
larity of
>           user-bitmap. Next, copy It's hbitmap to unnamed-bitmap. Then,=
 start
>           mirror with this unname-bitmap.
>   dirty-bitmap: add new API to copy dirty-bitmap. This feature is add i=
n a
>           separate patch called "add new function to copy dirty-bitmap"=


This is confusing. The first line 'mahaocong (1):' looks like you are
sending a patch series with only one patch (by the way, you can use 'git
commit format.coverletter auto' to only send a 0/N cover letter for N >
1, since a single patch is the only case where you don't technically
need a cover letter).  But the remaining three entries make it look like
you have three patches intended to be sent (and where the patch titled
"mirror: add incremental mode. we must..." is an awfully long subject lin=
e).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--wWiPJTJPM6POhYZq3IDAV40aXtKziRGlG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlws3eYACgkQ3g5py3or
ov3PjAf/cqfYkyDRJHMpvDHAVeGdIPjCRhbSwrKU+3xFhZxrZr27oay5QyF/MgeE
cPQ71qs/KXK4C/6wfJ4CmmwqK2ltmnI8Xx+P638hmUJnftTRmID/zhTayn6mfGNV
9C6oHSf6FjM4M54TxPVGRpEdpJ+ycuLJ7zfMLouqUl7kvLAUUe/eUyCKeEZBX7QI
OGF3BrPHZWhiZk1m3yvSPkS3vN50xSazCGUiu0NWgiQZWQonBOm1h0WRox7txvar
Od0eM2RLt4UdvQhZDePgwS3aF7Gw4Vo85cJpbMo6ujIz5vbOdbyyi+w2QVX+35Nq
YGUrpzVmtdkCpVeEiSPMBaWuoCN3tA==
=lXlR
-----END PGP SIGNATURE-----

--wWiPJTJPM6POhYZq3IDAV40aXtKziRGlG--
