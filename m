Received: from eggs.gnu.org ([209.51.188.92]:37093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghynr-0006Xf-3j
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghynq-0000iA-6L
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:32:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ghynp-0000h3-UN
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:32:58 -0500
References: <20190111093116.17188-1-kraxel@redhat.com>
	<20190111093116.17188-2-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fe14541c-8b57-014c-3972-113ce60161a1@redhat.com>
Date: Fri, 11 Jan 2019 09:32:43 -0600
MIME-Version: 1.0
In-Reply-To: <20190111093116.17188-2-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6ftLq3SqGbHC44ddIhkBWvDmoeZbgVTgC"
Subject: Re: [Qemu-devel] [PATCH 1/5] vfio: update kernel headers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, intel-gvt-dev@lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6ftLq3SqGbHC44ddIhkBWvDmoeZbgVTgC
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 intel-gvt-dev@lists.freedesktop.org
Message-ID: <fe14541c-8b57-014c-3972-113ce60161a1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] vfio: update kernel headers.
References: <20190111093116.17188-1-kraxel@redhat.com>
 <20190111093116.17188-2-kraxel@redhat.com>
In-Reply-To: <20190111093116.17188-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 3:31 AM, Gerd Hoffmann wrote:
> Temporary, for testing convinience.

convenience

>=20
> Once qemu master is synced with the linux 5.0-rc1 headers
> this is not needed any more.

What's the timeline for when that patch will happen, compared to whether
we want this one now followed by a revert?

>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  linux-headers/linux/vfio.h | 50 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 50 insertions(+)


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6ftLq3SqGbHC44ddIhkBWvDmoeZbgVTgC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw4txwACgkQp6FrSiUn
Q2rwFgf/ZfQrs5rrD83kPVbH0sjVvwjb5VK4A2DLqvR7XY+dSINjvo6dwZE4Z+lY
gEEa9fL0hfYHuZINu1cvpW+CiQyTy/E+DgTQup3lGVYyCp2GHXI0cdcb6OKbTpzH
riea6rFdSrfwMsFAhzYgnptFIS+vh54oesVhmCVBdVhz5E0ZG/32LFIobAYinxG4
PQ/y/SFRiEf9fgTIbXTbnH+2ErByYQktvvrSq5olrKEzl9UeK6cZn+/+H9j3AcNA
Z64Jl+AVmKBphuajlKJ4TA7vXovtpnGA+NYXwW0Git7Czhd+Ze/NIte5Ji6v5U5W
SZhyIhdsnAluk+MezUe4AeNfiEWClw==
=ZWIT
-----END PGP SIGNATURE-----

--6ftLq3SqGbHC44ddIhkBWvDmoeZbgVTgC--
