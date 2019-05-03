Received: from eggs.gnu.org ([209.51.188.92]:59682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hMfxQ-0007hR-5m
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hMfxP-0006ZB-4p
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:43:04 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eroken1@gmail.com>) id 1hMfxO-0006YW-Te
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:43:03 -0400
Received: by mail-wm1-x341.google.com with SMTP id y197so8240372wmd.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 14:43:02 -0700 (PDT)
Date: Fri, 3 May 2019 22:46:08 +0100
From: Ernest Esene <eroken1@gmail.com>
Message-ID: <20190503214608.GA20318@erokenlabserver>
References: <20190503193141.GA17700@erokenlabserver>
	<7f3b0a70-cec4-f267-c1fa-0bed6851b8cf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <7f3b0a70-cec4-f267-c1fa-0bed6851b8cf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] chardev/char-i2c: Implement Linux I2C
 character device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 03:24:06PM -0500, Eric Blake wrote:
> On 5/3/19 2:31 PM, Ernest Esene wrote:
> > Add support for Linux I2C character device for I2C device passthrough
> > For example:
> > -chardev linux-i2c,address=3D0x46,path=3D/dev/i2c-N,id=3Di2c-chardev
> >=20
> > Signed-off-by: Ernest Esene <eroken1@gmail.com>
> > ---
>=20
> Just an interface review:
>=20
> > +++ b/qapi/char.json
> > @@ -240,6 +240,21 @@
> >    'data': { 'device': 'str' },
> >    'base': 'ChardevCommon' }
> > =20
> Missing a 'Since: 4.1' line.
4.1? Oh! I couldn't guess this number, I had to deliberately omit it.
>=20
> > +{ 'struct': 'ChardevI2c',
> > +  'data': { 'device': 'str',
> > +            'address': 'int16'},
> > +  'base': 'ChardevCommon'}
>=20
> 'if': 'defined(CONFIG_LINUX)'
>=20
> as part of the usage of this struct, so that introspection will only see
> the struct where it can be used.
>=20
> > +
> >  ##
> >  # @ChardevSocket:
> >  #
> > @@ -398,6 +413,7 @@
> >    'data': { 'file': 'ChardevFile',
> >              'serial': 'ChardevHostdev',
> >              'parallel': 'ChardevHostdev',
> > +            'i2c': 'ChardevI2c',
> >              'pipe': 'ChardevHostdev',
> >              'socket': 'ChardevSocket',
> >              'udp': 'ChardevUdp',
> >=20
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>=20
Thanks so much for the useful review. I have applied the changes and
will soon send v2 of the patch.

I hope it is OK to update the "MAINTAINERS" file this

Character Devices (Linux I2C)
M: Ernest Esene <eroken1@gmail.com>
S: Maintained
F: chardev/char-i2c.c


-Ernest Esene

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFkNmxXgplc+HqgQGJZ4JoaCvxKoFAlzMtpwACgkQJZ4JoaCv
xKqUwA/9GkgzayiigY18eBeVzu6Dt9HHCgJgi+mlbMw1gvjJGOjQzLr1BbEbmadm
4N7TybYz4QVX/c0BiOOW14W/NABFOhzse8GU+LztVIMZXn9JlWXDwrRjOyajTPt/
g0naudGYMDUAcPwdWHQ9beUVbBX44BlFXzp2OQ73pPJ+BuwMP6HsvMHnpnKDZxyt
qN7PuLPBCZdGjSXX6mdxgMQeWmMTyX1n9BCmknU970srLM1BVROvQti/jaWmqvWc
5xfo+JjHCDmelGaNS/DXeKXnaSM7uotgpNK++U0Ow590k2s/biwE7/22mDedB/mm
6FG7IFpUVSspKmudwfNMwSu8rJTXA/ww1fjvAt3NNTHO9VltNrxJkhFyOaEYCk9X
ADhG7DVfqm9onhY1Mn3JVXyXaa0gPFzz7xY/I+Zx2bR97VXYHXT3if7ckjUxuYXM
nPUGxC1LMzJp0e+qbhYo266T4R4w5N8hgR9U+NHR2Qen5ubDDOroQY/Pz93dpX8D
DULrqZAkVzLrr/sZBVA8y/NULkZ5njGKmq7NkSVEVPuygMwjDK02WuIciJjdgmrM
6XS6APVYnaoiGnuj0WHUUzIKtaX+BpgYF9X+3yO68S4kOxA4oR5Ai6DMA+JmJ4g3
y7pDjYRKZFJ8A+pTpX29n6+rzKXTt2i1gNgkjTuLTNf0tT1MlJo=
=FJ+O
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
