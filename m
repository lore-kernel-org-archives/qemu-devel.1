Received: from eggs.gnu.org ([2001:4830:134:3::10]:39874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAYue-0006Xx-RT
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAYuZ-0008Sh-Tj
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:09:20 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:48169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eAYuZ-0008SB-Kd
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:09:15 -0400
Received: by mail-wr0-x22f.google.com with SMTP id 15so2035699wrb.5
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 03:09:15 -0700 (PDT)
Date: Fri, 3 Nov 2017 10:09:12 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103100912.GG5078@stefanha-x1.localdomain>
References: <CADak6y5eSo9=C2FJx+cTdqxArWeQqNDAvVgY+vS7H-9yGeuZvw@mail.gmail.com>
	<20171101094537.GA2786@work-vm>
	<CADak6y485_OSHrzji4Wq7_3vOrK+ch6Vm1FW1RMidSzoO3U-kQ@mail.gmail.com>
	<CADak6y5mfPnDfQbQSBjY-iGXsFEAmRX6cd=Cv-z-kD5VArKA9Q@mail.gmail.com>
	<CADak6y5zT2qxHe8-iCQhpgxdAyHcerMMbcDNvRig8i2PvopHBg@mail.gmail.com>
	<20171103091045.GA2616@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Content-Disposition: inline
In-Reply-To: <20171103091045.GA2616@work-vm>
Subject: Re: [Qemu-devel] qemu disk use writeback don't take effect in
 centos 7.2 1511
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Schlacter <wlfightup@gmail.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2017 at 09:10:45AM +0000, Dr. David Alan Gilbert wrote:
> * Paul Schlacter (wlfightup@gmail.com) wrote:
> > latest progress=EF=BC=9A
> > use centos 7.2   https://cloud.centos.org/centos/7/images/
> > test version: 1511  1601  1604 1606 1608
> >=20
> > From the above version in turn test, found the previous version 1511 16=
01
> > 1603 have the problem,
> > The latter two versions 1606 1608 are normal, dont't have the prblem,
> > Normal is cache =3D writeback io significantly higher than none mode
> >=20
> > why?
>=20
> It's a fun bug, but I don't know the cause - the fact it's dependent
> on guest version but fixed, suggests something changed in the guest
> kernel.  If you really wanted to figure out why I guess the only way
> would be to walk through the CentOS guest kernel versions and find the
> exact kernel that fixed it; then we could hunt down which change fixed
> it.
>=20
> (I've cc'd in Stefan for block stuff, but this is sounding more guest
> than qemu)

Please provide full details of the problem you are observing:

1. qemu command-line on the host (ps aux | grep qemu)
2. dd command-line inside the guest
3. "Good" output and "bad" output

Stefan

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/EBIAAoJEJykq7OBq3PI/cAH/RMzhO2Qc+BkijiC8SYIsLZh
2hZlSAB5Vnt1g0b1jRhRnUwgVyuJZQ29J06dKV5wQBz4EO6M9C29gL51IbVKM9wI
EIMpaXk5FPtfS+6lk05p3rJdnszbfMD2FL+l3T8ZcBa5Ijadu6k2S/2BFcc4iEbS
7azGbGIDsG5z9hOyslyiTn4/ixxD4rAye0RIVOyBW2Af5AI9ETU9+mdD0cfEQDaQ
Wqd14y+6trQZP9TdZNQFbysxB8vx7Twvv//Zo6X+hKLreuwknuA+NO6t8oHihOcU
Lb3112BHy3ezKBYxgcA1tnc/EsBPmKQfzzU/TcJb/JGNGLNa8ESAfwezNhpei2w=
=8ot9
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
