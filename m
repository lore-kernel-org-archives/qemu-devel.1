Received: from eggs.gnu.org ([2001:4830:134:3::10]:37545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQC02-0005zd-9u
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQBzy-0002v3-CZ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:23:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQBzy-0002ul-6B
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:23:10 -0400
References: <1498629200-35463-1-git-send-email-wei.w.wang@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <35650f4c-8852-2dcd-94f9-13f0105b76cd@redhat.com>
Date: Wed, 28 Jun 2017 07:22:52 -0500
MIME-Version: 1.0
In-Reply-To: <1498629200-35463-1-git-send-email-wei.w.wang@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pjpMvwGnNSGoe1gwwK0ONve5EA5kXbq4e"
Subject: Re: [Qemu-devel] [PATCH v1] virtio-net: code cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, mst@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pjpMvwGnNSGoe1gwwK0ONve5EA5kXbq4e
From: Eric Blake <eblake@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>, mst@redhat.com, jasowang@redhat.com,
 virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Message-ID: <35650f4c-8852-2dcd-94f9-13f0105b76cd@redhat.com>
Subject: Re: [PATCH v1] virtio-net: code cleanup
References: <1498629200-35463-1-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1498629200-35463-1-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2017 12:53 AM, Wei Wang wrote:
> Use is_power_of_2(), and remove trailing "." from error_setg().
>=20
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  hw/net/virtio-net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pjpMvwGnNSGoe1gwwK0ONve5EA5kXbq4e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZU5+cAAoJEKeha0olJ0NqyPkH/3MfL9hmmaLZgU7Nzb6o1RdA
EW9qh11ihgjPGnUlfg1RUBUQ7O8L1K7OuD9VBQfXmYVPSEP4F9TrORCqW0e3RP06
0QzmLRwExecOmHrG0G1Pgas10qtWW3Ha0t2S/PZgyTWzRx7J/IZEhVO2WaMeU4Ps
f1ab/WVjEhFBQkmqmO2Yv2gz4oXpehgLLyEI7rLadHY+NyOPlOCN/l4e12bwvINy
xhj9S3W8raDrtZH1bUFx6KRbScWrnkLDuNjGiSuyWDnMpGl/7cnnsdJsLadHCBiS
omqV2MXIBOQPSHvTTIJRiedlQcXMM/KQfJsC9Q30YccTgJka8O+t6ViY1Kc20YM=
=Yayq
-----END PGP SIGNATURE-----

--pjpMvwGnNSGoe1gwwK0ONve5EA5kXbq4e--
