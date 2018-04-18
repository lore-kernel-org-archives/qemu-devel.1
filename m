Received: from eggs.gnu.org ([2001:4830:134:3::10]:52627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8oHU-0007uy-0z
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8oHT-0003HM-4T
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:41:56 -0400
References: <1468901281-22858-1-git-send-email-eblake@redhat.com>
	<20160720073836.GF10539@ad.usersys.redhat.com>
	<1796238868.8815050.1469006377577.JavaMail.zimbra@redhat.com>
	<20160720123025.GO2031@devil.localdomain>
	<360732077.8875393.1469022006074.JavaMail.zimbra@redhat.com>
	<20160721124119.GR2031@devil.localdomain>
	<1072047668.9469836.1469111028358.JavaMail.zimbra@redhat.com>
	<20160722085857.GT2031@devil.localdomain>
	<1401857113.9662127.1469184084100.JavaMail.zimbra@redhat.com>
	<d01285ba-7431-2a4f-cd01-77bc9075202f@virtuozzo.com>
	<c823c94e-3fdb-51fb-f9bd-fca35c5b72b8@redhat.com>
	<9abf1411-cd3c-871e-12af-df3944f3afe0@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aca8b121-b7d0-2f5c-8ce3-d9961ecd1a48@redhat.com>
Date: Wed, 18 Apr 2018 09:41:43 -0500
MIME-Version: 1.0
In-Reply-To: <9abf1411-cd3c-871e-12af-df3944f3afe0@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="px2DDt4K96fI1OQ5v9Hsw6M8gM1SSzIlQ"
Subject: Re: [Qemu-devel] semantics of FIEMAP without FIEMAP_FLAG_SYNC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Dave Chinner <dchinner@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Dmitry Monakhov <dmonakhov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Lukas Czerner <lczerner@redhat.com>, P@draigBrady.com, Niels de Vos <ndevos@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--px2DDt4K96fI1OQ5v9Hsw6M8gM1SSzIlQ
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dave Chinner <dchinner@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Dmitry Monakhov <dmonakhov@virtuozzo.com>, "Denis V. Lunev"
 <den@openvz.org>, Lukas Czerner <lczerner@redhat.com>, P@draigBrady.com,
 Niels de Vos <ndevos@redhat.com>
Message-ID: <aca8b121-b7d0-2f5c-8ce3-d9961ecd1a48@redhat.com>
Subject: Re: [Qemu-devel] semantics of FIEMAP without FIEMAP_FLAG_SYNC
References: <1468901281-22858-1-git-send-email-eblake@redhat.com>
 <20160720073836.GF10539@ad.usersys.redhat.com>
 <1796238868.8815050.1469006377577.JavaMail.zimbra@redhat.com>
 <20160720123025.GO2031@devil.localdomain>
 <360732077.8875393.1469022006074.JavaMail.zimbra@redhat.com>
 <20160721124119.GR2031@devil.localdomain>
 <1072047668.9469836.1469111028358.JavaMail.zimbra@redhat.com>
 <20160722085857.GT2031@devil.localdomain>
 <1401857113.9662127.1469184084100.JavaMail.zimbra@redhat.com>
 <d01285ba-7431-2a4f-cd01-77bc9075202f@virtuozzo.com>
 <c823c94e-3fdb-51fb-f9bd-fca35c5b72b8@redhat.com>
 <9abf1411-cd3c-871e-12af-df3944f3afe0@virtuozzo.com>
In-Reply-To: <9abf1411-cd3c-871e-12af-df3944f3afe0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/18/2018 09:25 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Do your code with
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 /* Found an extent, and we're inside it.=C2=A0=
 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 *next =3D f.fe.fe_logical + f.fe.fe_length;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (f.fe.fe_flags & FIEMAP_EXTENT_UNWRITTEN)=
 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BDRV_BLOCK_DA=
TA|BDRV_BLOCK_ZERO;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BDRV_BLOCK_DA=
TA;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> provide safe block_status based on FIEMAP without FLAG_SYNC?
>> No, in fact we found data corruption with FIEMAP.
>=20
> How to reproduce it? I've tried your code, looks like it shows all
> "data" regions even if I didn't call "sync".
>=20

There's no easy way to reproduce unsafe data races reliably; but FIEMAP
without sync is such an unsafe data race (most of the time, you will get
the answer you expect, but under the right conditions, FIEMAP may report
the area as unallocated even though you have already called write(); if
you treat that unallocated region as BDRV_BLOCK_ZERO, rather than
read()ing it, you have corrupted data).  That's because FIEMAP only
reports what the disk has allocated, but file systems can have delayed
allocations where contents in the kernel cache are NOT yet flushed to
disk unless you use sync; but using sync kills performance.

If you want examples of FIEMAP corrupting data, look at the coreutils
archive from several years ago, where FIEMAP without sync caused
corruptions during cp. A quick search found at least this example:
https://lists.gnu.org/archive/html/bug-coreutils/2011-04/msg00023.html

For more details, see qemu commits c4875e5b and 38c4d0a, and discussion
at https://lists.gnu.org/archive/html/qemu-devel/2014-09/msg04921.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--px2DDt4K96fI1OQ5v9Hsw6M8gM1SSzIlQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrXWScACgkQp6FrSiUn
Q2qKFgf+I9EMfuFtTrn3T+Zv+95eIu+eYrFx7JPg9lmPRWixT0u0Rg+H1ijt9wL9
DN86/Xw93NYyIq0UE1e/+3PTrGRd3+M4BYD13OKPgP1gGEcogWYC1RGgG6ZHNKeQ
v9GCXQ7Ru8wmVEUKpoqGTgaQd2+7Wqa7n9Gn0uhj5yfb6as/doLnpY+GhtKjI4UY
O0ZeVKuiCRUGUa/kQB4VQPQoT3fKuOpufS3Fo0+9YrfkMBBGSv6a/rB0P0kJ5osM
H2IyKaSUudsTz21KtsMfk2YgqGVEmFzYTVq4Gg2sxR80dNuCQcEnBn9QhmPF812q
ecCMmBbLUWmd5IUGtA8yX9NDmrdJPg==
=RsZB
-----END PGP SIGNATURE-----

--px2DDt4K96fI1OQ5v9Hsw6M8gM1SSzIlQ--
