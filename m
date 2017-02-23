Received: from eggs.gnu.org ([2001:4830:134:3::10]:42593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgusd-0008JY-6S
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgusZ-0000h1-AP
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:00:27 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:32815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgusZ-0000gg-3i
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:00:23 -0500
Received: by mail-wr0-x244.google.com with SMTP id s27so4220767wrb.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:00:22 -0800 (PST)
Date: Thu, 23 Feb 2017 15:00:20 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223150020.GU30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760172434.31154.8839343303639823770.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="niUlcCfh/sMBwTxc"
Content-Disposition: inline
In-Reply-To: <148760172434.31154.8839343303639823770.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 21/29] 9pfs: local: improve error handling
 in link op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


--niUlcCfh/sMBwTxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:42:04PM +0100, Greg Kurz wrote:
> When using the mapped-file security model, we also have to create a link
> for the metadata file if it exists. In case of failure, we should rollbac=
k.
>=20
> That's what this patch does.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--niUlcCfh/sMBwTxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrvkEAAoJEJykq7OBq3PIOI4IAIBuLGNLIbJnAs5b7rrpygld
voeKa/ZPrVOlkt7TWSNtzaU8EzE/daw1VSjUHApTc23NYWWOjBXecc9qUBWoIojw
Llk0ArHfu1OLGnl7BRLA5zzFOBvu3aTUxe2Fuh7IXxE/njFje1V1/PdgvoTHp3ln
dZDIOUXGYaEktC8WapelEc4bAIuj2NXeCb+vfUgqPHGd83ZFwNymjuYmrkV7Yqky
jMkW2O4L8P6vporSEc4k3JYIoQoJEBD6Iffn6n3KM5EhSjMnih2lzQ5yHC8T8TxT
Vxyxh62pGaucZYop+mdzmf1M8iJNKAXmsFg8TQ72/+970Wi7p6AdJyOrvjOsMQo=
=Rj4q
-----END PGP SIGNATURE-----

--niUlcCfh/sMBwTxc--
