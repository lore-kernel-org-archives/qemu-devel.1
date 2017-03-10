Received: from eggs.gnu.org ([2001:4830:134:3::10]:58841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cmCFa-0000Tb-2o
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cmCFW-00053h-5b
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:33:58 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cmCFW-00053W-0M
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:33:54 -0500
Received: by mail-pf0-x244.google.com with SMTP id o126so9434385pfb.1
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 20:33:53 -0800 (PST)
Date: Fri, 10 Mar 2017 12:33:44 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170310043344.GD4589@stefanha-x1.localdomain>
References: <20170303135150.12145-1-stefanha@redhat.com>
	<20170303135150.12145-3-stefanha@redhat.com>
	<w51k2812x8i.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline
In-Reply-To: <w51k2812x8i.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [RFC 2/4] raw-format: add bdrv_max_size() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, John Snow <jsnow@redhat.com>


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2017 at 11:32:29AM +0100, Alberto Garcia wrote:
> On Fri 03 Mar 2017 02:51:48 PM CET, Stefan Hajnoczi wrote:
>=20
> > +static uint64_t raw_max_size(QemuOpts *opts, BlockDriverState *in_bs,
> > +                             Error **errp)
> > +{
> > +    if (in_bs) {
> > +        int64_t size =3D bdrv_nb_sectors(in_bs);
> > +        if (size < 0) {
> > +            error_setg_errno(errp, -size, "Unable to get image size");
> > +            return 0;
> > +        }
> > +        return (uint64_t)size * BDRV_SECTOR_SIZE;
> > +    }
>=20
> Why not use bdrv_getlength() directly? It gives you the size in bytes.

Good idea.  Will fix.

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYwiyoAAoJEJykq7OBq3PITqYH/1e6t2GTEExjmqmSCyzx1XHH
8TtRTbiCBNVF/VOl3VEoruic6WwJdr4XdtLGfPkYVkDaXE4g6UKXl+CvfKf4sNPe
ozQDrNCQ/cZnNv3SOWA51V2uzTTY1mmwBaHSpIVY4y9iqqN7k263OnIsafpLoSld
FB68gsUg3a0WQ8OyuL9dQ5cDWZ/JMWsrh9uHp3J7XS/neWImmb5ppjYTyFACpLJe
vB2yBrE8Qu1PYLad8hNrNRt87lkdkOpQNs7A9Wa00gCJ/zSxtK6bSpdDNHkIqytL
RNOVLzL3K5SYzl8C6BiGgPZx359XdJSyUynK2r+TWXuEgfA4NCf15+khK2Wcjs4=
=j+oQ
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
