Received: from eggs.gnu.org ([2001:4830:134:3::10]:58531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gWibW-00059O-J1
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gWibQ-0003fi-JH
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:01:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gWibQ-0003aa-9A
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:01:36 -0500
Date: Tue, 11 Dec 2018 14:01:24 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181211140124.GA23460@stefanha-x1.localdomain>
References: <1544049446-6359-1-git-send-email-liam.merwick@oracle.com>
	<1544049446-6359-2-git-send-email-liam.merwick@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <1544049446-6359-2-git-send-email-liam.merwick@oracle.com>
Subject: Re: [Qemu-devel] [RFC 1/3] pvh: Add x86/HVM direct boot ABI header
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net, xen-devel@lists.xenproject.org, sgarzare@redhat.com, mst@redhat.com, maran.wilson@oracle.com


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 10:37:24PM +0000, Liam Merwick wrote:
> From: Liam Merwick <Liam.Merwick@oracle.com>
>=20
> The x86/HVM direct boot ABI permits Qemu to be able to boot directly
> into the uncompressed Linux kernel binary without the need to run firmwar=
e.
>=20
> 	https://xenbits.xen.org/docs/unstable/misc/pvh.html
>=20
> This commit adds the header file that defines the start_info struct
> that needs to be populated in order to use this ABI.
>=20
> Signed-off-by: Maran Wilson <Maran.Wilson@oracle.com>
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> Reviewed-by: Konrad Rzeszutek Wilk <Konrad.Wilk@oracle.com>
> ---
>  include/hw/xen/start_info.h | 146 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 include/hw/xen/start_info.h

Does it make sense to bring in Linux
include/xen/interface/hvm/start_info.h via QEMU's
include/standard-headers/?

QEMU has a script in scripts/update-linux-header.sh for syncing Linux
headers into include/standard-headers/.  This makes it easy to keep
Linux header files up-to-date.  We basically treat files in
include/standard-headers/ as auto-generated.

If you define start_info.h yourself without using
include/standard-headers/, then it won't be synced with Linux.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcD8M0AAoJEJykq7OBq3PIOlMH/0Xf2zqEnnYKUyPXmya3wH6y
LNjfD5I10PacQClqAaM/ZMBEjX3GNd2fppFZXCdv6ELktHx0Ix5HFTDa0P/ABCMs
M3HT+tJ4J11rZwh1U0CZod7xbavQnoIMWJhQuPy367KsrscIRCEpoV3eO/4lu4gb
3vkl+t+4e2GCegs0CWLPCHfv+Qs084prHK/0BoURzQGNLB7il/O5g6FGG1LmZlse
gKkboRKnN/MiG6ct+Z1RQZhp16+u4s94MYGy+hgtSVI6Q5cNFYZ6UbzA8f5+FTFQ
rqOQZ+LHqMV2dZ/yRugRkjbvld1AGSPyp3AkiAkDdOC89TVSTSx91+2YQg2i1GQ=
=Wifw
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
