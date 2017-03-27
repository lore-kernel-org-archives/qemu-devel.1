Received: from eggs.gnu.org ([2001:4830:134:3::10]:57134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csX7l-00011i-5k
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csX7i-0002r8-38
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:04:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1csX7h-0002ph-Rb
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:04:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C54FD4E02D
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 16:04:00 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-2-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <55f73f04-77e7-abee-68fa-a5826d5b9f2b@redhat.com>
Date: Mon, 27 Mar 2017 18:03:57 +0200
MIME-Version: 1.0
In-Reply-To: <1490621195-2228-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JXbhQf8NH8iUOAN4L0rxjErmmrmV4HVcQ"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 01/11] rbd: Reject -blockdev
 server.*.{numeric, to, ipv4, ipv6}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JXbhQf8NH8iUOAN4L0rxjErmmrmV4HVcQ
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com
Message-ID: <55f73f04-77e7-abee-68fa-a5826d5b9f2b@redhat.com>
Subject: Re: [PATCH RFC v3 for-2.9 01/11] rbd: Reject -blockdev
 server.*.{numeric,to,ipv4,ipv6}
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 27.03.2017 15:26, Markus Armbruster wrote:
> We use InetSocketAddress in the QAPI schema.  However, the code
> doesn't use inet_connect_saddr(), but formats "host" and "port" into a
> configuration string for rados_conf_set().  Thus, members "numeric",
> "to", "ipv4" and "ipv6" are silently ignored.  Not nice.  Example:
>=20
>     -blockdev rbd,node-name=3Dnn,pool=3Dp,image=3Di,server.0.host=3Dh0,=
server.0.port=3D12345,server.0.ipv4=3Doff
>=20
> Factor a suitable InetSocketAddressBase out of InetSocketAddress, and
> use that.  "numeric", "to", "ipv4" and "ipv6" are now rejected.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi-schema.json     | 21 ++++++++++++++-------
>  qapi/block-core.json |  2 +-
>  2 files changed, 15 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--JXbhQf8NH8iUOAN4L0rxjErmmrmV4HVcQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljZN+0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ae1MH+QEv4uOGO8nbvrExdkCDbC452VaerB2B
Il6mcOXpqJJzrY8xH7Ip4zBKkLlOEPOp0+D73Zs2uV4nI8JvORPC66gCOTWs2OPA
SvrUT/v+a/LBpuFWt6PHPnpox+7rze9cwjNHPyaDstwf9lp0hZ51e03Pbj1VYFV/
1iHytyqo7wG1uo40F3J1MV5t+ZW0bpLDAjrqwJeE2qnqr2Cd0FbPq6EBin+PJ2b0
BfIDIzuaPhkPFVnUDpKcMy/QHNZ8n2q22OrmtN0uEOeaCOoZA/QYrIwhApBtLo1A
KJC5774Vzx4rsr0bzV9sSNVmtnweG8hMfcSiQU2QnNzDltxBMHxHRio=
=XcEZ
-----END PGP SIGNATURE-----

--JXbhQf8NH8iUOAN4L0rxjErmmrmV4HVcQ--
