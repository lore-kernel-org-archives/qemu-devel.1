Received: from eggs.gnu.org ([2001:4830:134:3::10]:58311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1crRQr-0000Zj-JF
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1crRQo-0001OX-Ge
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:47:17 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:34331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1crRQo-0001OG-A2
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:47:14 -0400
Received: by mail-wr0-x22f.google.com with SMTP id l43so4374951wre.1
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 08:47:14 -0700 (PDT)
Date: Fri, 24 Mar 2017 15:47:10 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170324154710.GC5849@stefanha-x1.localdomain>
References: <87mvccaqhb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <87mvccaqhb.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Question nbd_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 05:48:48PM +0100, Markus Armbruster wrote:
> BlockdevOptionsNbd has a member SocketAddress, and nbd_config() doesn't
> restrict variants.  Thus, all four SOCKET_ADDRESS_KIND_ can occur.
>=20
> Now have a look at nbd_refresh_filename().  s->saddr->type is If
> SOCKET_ADDRESS_KIND_VSOCK or SOCKET_ADDRESS_KIND_FD, then @host, @port
> and @path all remain null, and bs->exact_filename[] is not touched.
>=20
> Does this work as intended?

NDB over AF_VSOCK has not been tested.  I would expect it to fail
earlier than nbd_refresh_filename().  It's certainly possible to come up
with the host=3D,port=3D for AF_VSOCK.

Not sure about file descriptor passing.  Either we could getsockaddr()
and print out the host=3D,port=3D or path=3D (depending on the address
family), or we could use some syntax for referring to the file
descriptor.

Stefan

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY1T9+AAoJEJykq7OBq3PIWUEH/2SfDsV4WUAwVasJVUlsJePz
nL5TLgXaENyS286xLqp5Y/laDTW4uD3KHim+cxyCN5kilLpUnbgULIAnZxhVE1hV
vWlRs5GaFuYpMSRCpRbBV2K21AVAa8qhuHvhKMnFtfsehlSkuj7JVwQC3kBAToGq
SLnie1Srf47jS5ghaIzesVgbnVJJA5nULeA5Iu2A+C3nDeK3NTI6tXu2vtn0CFB4
BkFkmkhdu3C3QH7vkkuL+JKSQNuXkSbkNaPzzFw1sbO2FU97+9Vlk7T0TO99nREx
ENBFGzueAuHcERH2X+RaPVoIWP0f6A16cyZpzET33qMtKCp6yxMyEX1MF4wIM0U=
=laST
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
