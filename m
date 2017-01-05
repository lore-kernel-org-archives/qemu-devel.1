Received: from eggs.gnu.org ([2001:4830:134:3::10]:41397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPEez-0001UH-1F
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPEev-0001bZ-V0
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:29:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPEev-0001bO-OK
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:29:13 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12DC419D22F
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 20:29:13 +0000 (UTC)
References: <20170105160321.21786-1-berrange@redhat.com>
	<20170105160321.21786-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fc15666a-b40e-01ec-ce5c-ddf9bc373990@redhat.com>
Date: Thu, 5 Jan 2017 14:29:10 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160321.21786-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="flf1qR6SCcHmaF8oUaGqLLiIAD4UDlpBe"
Subject: Re: [Qemu-devel] [PATCH 3/8] io: fix typo in docs for QIOTask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--flf1qR6SCcHmaF8oUaGqLLiIAD4UDlpBe
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <fc15666a-b40e-01ec-ce5c-ddf9bc373990@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] io: fix typo in docs for QIOTask
References: <20170105160321.21786-1-berrange@redhat.com>
 <20170105160321.21786-4-berrange@redhat.com>
In-Reply-To: <20170105160321.21786-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:03 AM, Daniel P. Berrange wrote:
> The GDestroyNotify parameter is already a pointer, so does
> not need a '*' suffix on the type.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/io/task.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/io/task.h b/include/io/task.h

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--flf1qR6SCcHmaF8oUaGqLLiIAD4UDlpBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbqyWAAoJEKeha0olJ0Nq5pUIAJPKjp+jhxHMAeyxBaPVkh5w
rPOgmmt4tw4TFvsyZOXsfjE5but2RhEemb4wBA/ia+ZU3dXpRVEVrBy/q4IEnkHu
QpSe9SaM2qtNvrn31YMWfsZOWJUpnfC2FPUUOb+cA4pMchB38UdsgumIzaOalsBU
ry/Pf5PDqPbsRmte4BN2mmSGPp/XsPkms0DUuZ9/SqPyQusxliJBA8Ud3rtXiQ39
qDZu5SSzZXQSlSKVZBQipskO0x5PUgtp+gW8YV0fhG9qt/gkmhRhjNDIiUT7f21+
xAUc0OPPShEQhjWFofBl4OvknMNEQxlMOODiQTlxXQwVKnrAO3FEr4Lo6+SIO7Q=
=cxcI
-----END PGP SIGNATURE-----

--flf1qR6SCcHmaF8oUaGqLLiIAD4UDlpBe--
