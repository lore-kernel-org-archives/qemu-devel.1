Received: from eggs.gnu.org ([2001:4830:134:3::10]:59289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUbKj-0005GZ-14
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUbKf-0001nb-2I
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:42:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cUbKe-0001n4-PW
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:42:28 -0500
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-2-git-send-email-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2cc041f-21a5-5ec8-c55a-de7a1a34d575@redhat.com>
Date: Fri, 20 Jan 2017 09:42:25 -0600
MIME-Version: 1.0
In-Reply-To: <1484276800-26814-2-git-send-email-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KCkpvlt16HfQMd6FQx7NXGHIA6LQCduI9"
Subject: Re: [Qemu-devel] [PATCH RFC v3 01/14] IOMMU: add option to enable
 VTD_CAP_CM to vIOMMU capility exposoed to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KCkpvlt16HfQMd6FQx7NXGHIA6LQCduI9
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com,
 jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com,
 bd.aviv@gmail.com
Message-ID: <f2cc041f-21a5-5ec8-c55a-de7a1a34d575@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 01/14] IOMMU: add option to enable
 VTD_CAP_CM to vIOMMU capility exposoed to guest
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
 <1484276800-26814-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1484276800-26814-2-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2017 09:06 PM, Peter Xu wrote:
> From: Aviv Ben-David <bd.aviv@gmail.com>

Long subject line, please try to keep it around 60 or so characters
(look at 'git shortlog -30' for comparison).  Also, fix the typos:
s/capility exposoed/capability exposed/

>=20
> This capability asks the guest to invalidate cache before each map oper=
ation.
> We can use this invalidation to trap map operations in the hypervisor.
>=20
> Signed-off-by: Aviv Ben-David <bd.aviv@gmail.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--KCkpvlt16HfQMd6FQx7NXGHIA6LQCduI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgi/hAAoJEKeha0olJ0NqXNMIAJvV74IeVxNLDY3HiWiXR2Q0
3vmUgt7wNIS+KT6nWaF2tMcRHie+aK3a1O4V5QWTNvr4aK08NpnNvamc5u156KYg
6o5TVVpVWsn0NY2BbjcpYxJ+vFFfxKhDHD3RPUL+tW7hI1DGx1UQU+rljRX4GrGj
LQR/fr3RXpaH5YI8vfpFUbwrr1E03QCx/nkflRoyGIYdkhOOjHh0F5WboFIk7D9X
ZFtH4K/+lbbDZiax23L+AJuf19jtZorkdJA3e8BLXdldNXNP2C0Xyk+pq/w0ADZe
Wf/Crk90rPRT6qh32MMTXv/jmjE+EsmTCh60au2750ZfrtwhyESoltr3nThoMwk=
=fryN
-----END PGP SIGNATURE-----

--KCkpvlt16HfQMd6FQx7NXGHIA6LQCduI9--
