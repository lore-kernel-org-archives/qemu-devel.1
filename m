Received: from eggs.gnu.org ([209.51.188.92]:54911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghXdJ-000373-JZ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghXdI-00008H-9z
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:32:17 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ghXdI-00007B-1N
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:32:16 -0500
Received: by mail-wm1-x342.google.com with SMTP id b11so10708695wmj.1
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 02:32:14 -0800 (PST)
Date: Thu, 10 Jan 2019 10:32:12 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190110103212.GE19025@stefanha-x1.localdomain>
References: <alpine.LRH.2.21.1901051827350.16856@linux.fjfi.cvut.cz>
	<20190107091618.GD27089@stefanha-x1.localdomain>
	<alpine.LRH.2.21.1901092339260.19055@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1901092339260.19055@linux.fjfi.cvut.cz>
Subject: Re: [Qemu-devel] Emulation of TCG OPAL self-encrypting drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Kozub <zub@linux.fjfi.cvut.cz>
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 12:05:32AM +0100, David Kozub wrote:
> On Mon, 7 Jan 2019, Stefan Hajnoczi wrote:
>=20
> > QEMU supports LUKS encrypted disk images so no new code is needed for
> > the actual encryption.
>=20
> Thanks for the feedback, Stefan. I know very little about qemu internals =
(I
> looked around a bit). One issue is: OPAL needs some persistent data outsi=
de
> of the actual user-visible data. How does that fit in with storage in QEM=
U?
> Perhaps the implementation could just occupy a fixed size of the associat=
ed
> storage for the OPAL state.

See block/crypto.c for the LUKS block driver.  Perhaps OPAL needs to
something similar (OPAL state + LUKS).

> > > Or, just a pass-through to a block device in the host - but a pass-th=
rough
> > > that would allow OPAL commands.
> >=20
> > You can pass through a storage controller using PCI passthrough or you
> > can pass through a SCSI LUN, but there is no ATA passthrough.
>=20
> I currently don't have a usable box for PCI passthrough. I'm thinking that
> ATA passthrough could be generally usable for any fiddling and perhaps not
> too difficult to implement.
>=20
> If I understand QEMU sources correctly, this needs to touch hw/ide/core.c
> (ide_exec_cmd), either adding a layer for OPAL, or just forwarding ATA
> commands for pass-through. Right?

Yes.

Stefan

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcNx8sAAoJEJykq7OBq3PIy7MH/A7kzFhq5oyCx7gIeUoNyr4v
Poxft6Z0xq3L551gogSXK3ZIN30bjfg2+MYJYQRiLrnB+sAvAgCXTIbPLPn3z08U
8vsvmxXLkIOlHpjmJinJDQQn/3HoVpokXVlJIAQW/4YYXy9mp5z9nN6qFYW3tfc5
V3UVEXv0zN6vjzrpmT2bws0lAYaXnHZqdnuO6Gx1CIfFrohuayzQPp/5zW7ah8v8
dDQ/HLPFG0N/Tz1dHPylzLfB3VctWVMPtWJy2bPdrjpu003IiJRrL8nmXDto+oRP
EXELMlW8XxnVnU4cTLJ70aTqG02Xt4NN+bIODcJ8tpoEJ6KaiGLztS92TAYVRNw=
=x+Gd
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--
