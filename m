Received: from eggs.gnu.org ([2001:4830:134:3::10]:47319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Orb-0006xa-Iv
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Ora-0003C7-NJ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:28:19 -0400
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
	<1493192202-3184-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8958cfa-7018-c740-bcb6-0d33b70d8bf8@redhat.com>
Date: Wed, 26 Apr 2017 10:28:05 -0500
MIME-Version: 1.0
In-Reply-To: <1493192202-3184-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CaiQs8bc8cxcj896GxfrCTUBEo5PEgcmD"
Subject: Re: [Qemu-devel] [PATCH 2/7] sockets: Prepare inet_parse() for
 flattened SocketAddress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CaiQs8bc8cxcj896GxfrCTUBEo5PEgcmD
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org
Message-ID: <c8958cfa-7018-c740-bcb6-0d33b70d8bf8@redhat.com>
Subject: Re: [PATCH 2/7] sockets: Prepare inet_parse() for flattened
 SocketAddress
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
 <1493192202-3184-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1493192202-3184-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 02:36 AM, Markus Armbruster wrote:
> I'm going to flatten SocketAddress: rename SocketAddress to
> SocketAddressLegacy, SocketAddressFlat to SocketAddress, eliminate
> SocketAddressLegacy except in external interfaces.
>=20
> inet_parse() returns a newly allocated InetSocketAddress.  Lift the
> allocation from inet_parse() into its caller socket_parse() to prepare
> for flattening SocketAddress.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/nbd.c            |  8 ++++----
>  include/qemu/sockets.h |  2 +-
>  migration/rdma.c       |  4 ++--
>  migration/socket.c     |  5 +++--
>  util/qemu-sockets.c    | 30 ++++++++++++------------------
>  5 files changed, 22 insertions(+), 27 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CaiQs8bc8cxcj896GxfrCTUBEo5PEgcmD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZALyFAAoJEKeha0olJ0NqzQAIAINgHn/5K88KKLVv1Y7cq7vq
ttW/XY/wRFAyiy+E9h5gk2r1pGEOIjS2Vu+zcEygjqiSvdemn+BJhg/7bVXbR+1Y
+AS95XnrC2gcMOCHmnRpiOiWWa9kLKKrv5Dire/4eAKaDPurto2FelTa0EqnRllp
rhKgv9H2vPRd7QRx449lTVNbfvABHmDpagk44s9tgqu5Gz1OX/YPOL0SyUWKWX4q
Mv/Ma9YEsnS8O45jL20jP3GFkW3dPRKzzZjrlZGsw8U3hs/rB9tuadMRT/7+N6zl
mWerSf/lAiLmbe/LkK3QVZWJglLOwj/DpVLzuXV/WTqgAa3EvuhO5FC9QkyJtu0=
=yE4V
-----END PGP SIGNATURE-----

--CaiQs8bc8cxcj896GxfrCTUBEo5PEgcmD--
