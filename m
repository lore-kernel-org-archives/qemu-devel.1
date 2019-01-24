Received: from eggs.gnu.org ([209.51.188.92]:34923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmc7x-0002dD-3q
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmc3Z-0000Fy-9q
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:16:22 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gmc3Z-0000Cz-0i
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:16:21 -0500
Received: by mail-wr1-x433.google.com with SMTP id v13so5800487wrw.5
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 02:16:20 -0800 (PST)
Date: Thu, 24 Jan 2019 10:16:18 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190124101618.GD4764@stefanha-x1.localdomain>
References: <720ebdfeb9506e0719481fc1913c9272@grossmann-venter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
In-Reply-To: <720ebdfeb9506e0719481fc1913c9272@grossmann-venter.com>
Subject: Re: [Qemu-devel] networking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liebrecht@grossmann-venter.com
Cc: qemu-devel@nongnu.org


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 10:02:09PM -0500, liebrecht@grossmann-venter.com wr=
ote:
> The windows 7 guest on linux host had networking out of the box.
> It now lost it for some reason.
> The qemu string remained the same....

Please post your QEMU command-line.

> It now want to do DHCP and fails.
> It has an intel nic as nic device in device manager.
>=20
> What i cant understand is how to dop a static network config in this case.
> lets say my network is 192.168.1.x
>=20
> Do i give it a static ip say 192.168.1.33 ?
> The mask 255.255.255.0
> What must the default gateway be ?
> On my linux network this at 192.168.1.100

The details of QEMU's default networking configuration ("slirp"
userspace networking) is as follows:

Subnet: 10.0.2.0/24
Gateway: 10.0.2.2

Therefore statically assigning a 192.168.1.0/24 address will not work,
you need to pick a 10.0.2.0/24 address and use 10.0.2.2 as the gateway.

If you are using tap networking then this does not apply.  Details of
your host networking setup would be necessary in order to help you.

> Should I give an external e.g. google dns or is there a specific internal
> DNS it needs to use ?
>=20
> thanks
>=20
> Why networking just broke I really cannot understand
>=20
>=20

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcSZByAAoJEJykq7OBq3PIWcEIAMBDo35hzl12Zx36NYskRkXx
5EaGbgQsBWjcdrhbaSZgeM3jG0YCM8m8I3tNnJaLJghuCEUlJGeegPxHe2MI868S
kXKfzsYxK9k8JXpkwtGSEh4V18roj9wA4WHuibRT6yhM6XBqiYLgpm3VheJA5okB
+ccVTpI7kAihJ7v++a/ZHEvhR9YRy9SDwRpJ4NjY5064LS6X+vwzw5mp+EAp4Y+f
RSp4QdWk4DSexyBs7rmEr0JYZmUbrfSGUHcTEZXURX93c9FSyyJMOfDA9g1SYAZE
5tu05Lpc+uCwTviB0/bjTw4GBu5BPTQ9AtAO8vLQ5x1NeK00kThB3CmGuslWP1Y=
=hQtz
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
