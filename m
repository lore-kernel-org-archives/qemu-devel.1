Received: from eggs.gnu.org ([2001:4830:134:3::10]:48455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8AgZ-0007WX-67
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8AgV-00022q-W6
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:20:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d8AgV-00022T-NY
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:20:35 -0400
References: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7598ea81-5fcb-d806-ce18-a6eb401b5259@redhat.com>
Date: Tue, 9 May 2017 14:20:30 -0500
MIME-Version: 1.0
In-Reply-To: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kw1Xu4a2gUkDiXoHNsMu91N5wds7gTMbe"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] xen/9pfs: fix two resource leaks on
 error paths, discovered by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org, xen-devel@lists.xen.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kw1Xu4a2gUkDiXoHNsMu91N5wds7gTMbe
From: Eric Blake <eblake@redhat.com>
To: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, aneesh.kumar@linux.vnet.ibm.com,
 groug@kaod.org, xen-devel@lists.xen.org
Message-ID: <7598ea81-5fcb-d806-ce18-a6eb401b5259@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] xen/9pfs: fix two resource leaks on
 error paths, discovered by Coverity
References: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2017 02:04 PM, Stefano Stabellini wrote:
> CID: 1374836
>=20
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> CC: anthony.perard@citrix.com
> CC: groug@kaod.org
> CC: aneesh.kumar@linux.vnet.ibm.com
> ---
>  hw/9pfs/xen-9p-backend.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kw1Xu4a2gUkDiXoHNsMu91N5wds7gTMbe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEhZ+AAoJEKeha0olJ0NqkbEIAJhbzBiLBr9GfP6C5UD7J+lh
lFDhcxjtfn1215o2fdOq/oBO6z3Phy9CyDC2eQ8m2DmLRn50CgbC8EQwoA3sIuh8
oHS7gJTPitQdkMTJ6N2hMZg5WroKEUYaqTRyp195UcMrV2mPFJ8CIe1iDz5jrC2d
051EWebnwzKyWZgsP1IQ3lLVLaBqmLE4pTmSaYoPYKvuThBgI6kFNexQK2cPzhwd
fo2SrYPl1pqHDpoCy/qLJlTR+75U+dfv89+GQDmkwwK0pI4Zl/p20WZ4yjhvKFj0
UKvn/TAvJYp6SLS9recI5WLOiMEyjNK508zrw74zEJzQqQDwcq36SOlFxijYUMg=
=TiwB
-----END PGP SIGNATURE-----

--kw1Xu4a2gUkDiXoHNsMu91N5wds7gTMbe--
