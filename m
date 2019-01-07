Received: from eggs.gnu.org ([209.51.188.92]:39124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ggR1F-0004Dh-D3
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:16:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ggR1E-0002re-GA
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:16:25 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ggR1E-0002qF-9k
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:16:24 -0500
Received: by mail-wr1-x436.google.com with SMTP id j2so42510914wrw.1
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 01:16:23 -0800 (PST)
Date: Mon, 7 Jan 2019 09:16:18 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190107091618.GD27089@stefanha-x1.localdomain>
References: <alpine.LRH.2.21.1901051827350.16856@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1901051827350.16856@linux.fjfi.cvut.cz>
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
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, kwolf@redhat.com


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 05, 2019 at 07:27:03PM +0100, David Kozub wrote:
> Hi,
>=20
> Can QEMU emulate an OPAL disk? The only relevant thing I found is a post
> from 2017 about TPM that mentions OPAL:
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04586.html

CCing John Snow (IDE/ATA) and Kevin Wolf (QEMU block layer).

> specifically this bit:
>=20
> > Well, at some point somebody's going to want us to implement this,
> > but... they can do that when they do that.
>=20
> So I assume it is not implemented. (?)

Right.

> I agree with the sentiment expressed in the mail linked above w.r.t. OPAL
> security. I'm interested in this from SW development/debugging/fiddling
> perspective. A sufficient solution for me would not add any real encrypti=
on

QEMU supports LUKS encrypted disk images so no new code is needed for
the actual encryption.

> but would respond to the various OPAL commands send via ATA TRUSTED
> SEND/RECEIVE commands.
>=20
> In fact, a more generic solution would work for me: If it was possible to
> send ATA commands from QEMU to a separate process which could then handle
> them as it liked and reply back to QEMU. This could be useful for other
> fiddling/debugging situations too.

Might as well implement it in QEMU so users can easily take advantage of
it without setting up external software.

> Or, just a pass-through to a block device in the host - but a pass-through
> that would allow OPAL commands.

You can pass through a storage controller using PCI passthrough or you
can pass through a SCSI LUN, but there is no ATA passthrough.

> I'm grateful for any hints/ideas. Perhaps something like this is already
> possible with QEMU?
>=20
> Best regards,
> David
>=20

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcMxjiAAoJEJykq7OBq3PIpu4H/RHClNPImCO48lnyOnf5NU91
CDYBEU5NsAcse7z7LIds9aCBPfJGw6aTLvQZlT0vXPr5k7YEVS2hw+2cJxDUSBfV
RJcM0usTZGzwu3G/iSEwQZ8FjBSC+S3CIABQQ5otWgZwaNnVXj8Ol/yerLZjdluv
cqvQ/Qkj0YZyDxvVpjX4d/zOMAckc08iUJiZJGfgIxzZ3in30q9GyKmJ9c0v2BBJ
Tl0nznWX8bs6R9upw0Eh9Dg8vfGF9A0aUQbY4VU1jsn3hiloMXQ6Q9EXh7Obr6Hi
GMcv05ZyZ7Ac44TdCnEkSWYy43UNyvpm/HrPLDdmsqW1vs4QvkBBplyHHBRKzd0=
=LIWd
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
