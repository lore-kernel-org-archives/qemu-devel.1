Received: from eggs.gnu.org ([2001:4830:134:3::10]:53629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGAeO-0001Np-6U
	for qemu-devel@nongnu.org; Wed, 31 May 2017 16:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGAeN-0003Ab-7f
	for qemu-devel@nongnu.org; Wed, 31 May 2017 16:55:28 -0400
References: <20170531094330.1808-1-pbonzini@redhat.com>
	<20170531094330.1808-4-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd26d13e-ee03-fae5-5cfc-5c7e9887a71a@redhat.com>
Date: Wed, 31 May 2017 15:55:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170531094330.1808-4-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="osvE0wafw4tEG1xp4UIpNaSUiofNHXnGp"
Subject: Re: [Qemu-devel] [PATCH 03/11] vdi: make it thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--osvE0wafw4tEG1xp4UIpNaSUiofNHXnGp
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <bd26d13e-ee03-fae5-5cfc-5c7e9887a71a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/11] vdi: make it thread-safe
References: <20170531094330.1808-1-pbonzini@redhat.com>
 <20170531094330.1808-4-pbonzini@redhat.com>
In-Reply-To: <20170531094330.1808-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 04:43 AM, Paolo Bonzini wrote:
> The VirtualBox driver is using a mutex to order all allocating writes,
> but it is not protecting accesses to the bitmap because they implicitly=

> happen under the AioContext mutex.  Change this to use a CoRwlock
> explicitly.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/vdi.c | 48 ++++++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--osvE0wafw4tEG1xp4UIpNaSUiofNHXnGp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLy2zAAoJEKeha0olJ0NqtYoH/3hlzEiYlGmouek6HPmlh47l
vU5ZDfsmA2hiLbaAnI3VPfhGPwODifJD7CDMCMRg9B9C0hOuNx/AyDXI8I4Zj+54
RzGflomUVxjroKyqifrMPHXVNcBEhd+odAhg8Q35RY64cNIcDm6B3OBp1S6T7cjC
oYLcoYr+5uOJEZzHNyz8sV9Rg5m9hGmCZWtTlFqnqkZeaA7hZUmC+HTBLcgH7VoH
ZNbXU4E8G4uwI9eMYhHI6W9t6AzH7hKX3niPqtxCiCSBsMyRZmUNlsc4U8/GEHP0
GWHRjce/lL3+TU9mrdao3eZO1yl5SQUJVK8yGZLlUVomqu/EjvgaCoti3BpgnBE=
=10z9
-----END PGP SIGNATURE-----

--osvE0wafw4tEG1xp4UIpNaSUiofNHXnGp--
