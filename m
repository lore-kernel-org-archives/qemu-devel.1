Received: from eggs.gnu.org ([2001:4830:134:3::10]:48524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8Agx-0007ia-6b
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8Agt-00029u-SP
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:21:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d8Agt-00029h-Gy
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:20:59 -0400
References: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
	<1494356693-13190-2-git-send-email-sstabellini@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4b6be500-760b-dcd8-6113-6953bc8f0dce@redhat.com>
Date: Tue, 9 May 2017 14:20:57 -0500
MIME-Version: 1.0
In-Reply-To: <1494356693-13190-2-git-send-email-sstabellini@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EOobQJ3OnDr93AN8soljKmnnLhI6Jv9wi"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] Check the return value of fcntl in
 qemu_set_cloexec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xen.org, groug@kaod.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EOobQJ3OnDr93AN8soljKmnnLhI6Jv9wi
From: Eric Blake <eblake@redhat.com>
To: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xen.org, groug@kaod.org, pbonzini@redhat.com
Message-ID: <4b6be500-760b-dcd8-6113-6953bc8f0dce@redhat.com>
Subject: Re: [PATCH v2 2/3] Check the return value of fcntl in
 qemu_set_cloexec
References: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
 <1494356693-13190-2-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1494356693-13190-2-git-send-email-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2017 02:04 PM, Stefano Stabellini wrote:
> Assert that the return value is not an error. This issue was found by
> Coverity.
>=20
> CID: 1374831
>=20
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> CC: groug@kaod.org
> CC: pbonzini@redhat.com
> CC: Eric Blake <eblake@redhat.com>
> ---
>  util/oslib-posix.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EOobQJ3OnDr93AN8soljKmnnLhI6Jv9wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEhaZAAoJEKeha0olJ0NqdysIAIWTqT9MpDe5WpYZDOWo7lAS
KLOrUVm3wz9mif1zXuR1mRPyu4x3ZbIFmvRs8PaK3Mbp9F5IGQzji8tQNrDpYU3H
+aFVXz65epvRY0DPYwQseq3wBYNqUZv/mDq8ouMkKOLEmf/Vlhrf+lhHg5dxtyiz
orfTVZUjMZxQK7uFkETrEjzZCEVoYb3jskdD+HhpuHmbGCoK8DKfaZLvYjgwcoT2
gsfMqUXnseKCHJ4cZlR9v76kUsoNdcsfQzE7XXmc4R36n2Y8eA6ECtWx11lxLwYV
wrVk6/+q+PNmNv4qAS72Uo5DhsfWpb+Ndl6IPsMxHJO9UUc8m0SfhSXIgpQSBFQ=
=EdXe
-----END PGP SIGNATURE-----

--EOobQJ3OnDr93AN8soljKmnnLhI6Jv9wi--
