Received: from eggs.gnu.org ([2001:4830:134:3::10]:35966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6KU2-0000tg-G0
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6KU1-0007Pu-Fs
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:24:06 -0400
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
	<1493916761-32319-5-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <78ab2bbd-3dab-360c-3fb2-47cc250d8088@redhat.com>
Date: Thu, 4 May 2017 12:23:54 -0500
MIME-Version: 1.0
In-Reply-To: <1493916761-32319-5-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gtIrq6Sg36K4SKal0GHIb6O9savRAdPJ3"
Subject: Re: [Qemu-devel] [PATCH 4/6] block: Inactivate parents before
 children
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gtIrq6Sg36K4SKal0GHIb6O9savRAdPJ3
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <78ab2bbd-3dab-360c-3fb2-47cc250d8088@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/6] block: Inactivate parents before
 children
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
 <1493916761-32319-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493916761-32319-5-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 11:52 AM, Kevin Wolf wrote:
> The proper order for inactivating block nodes is that first the parents=

> get inactivated and then the children. If we do things in this order, w=
e
> can assert that we didn't accidentally leave a parent activated when on=
e
> of its child nodes is inactive.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gtIrq6Sg36K4SKal0GHIb6O9savRAdPJ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZC2OqAAoJEKeha0olJ0NqZYYH/RLfWrZvVgibhReA767TmTr6
Tjq7tEKYaXfxquQvMYvnr3/YcVwZQh8gHBcAXxlpH/EZ3Kub+IJU+5vZhC/LqYkI
UwmOQSSooFYJr0DjLDeyHLqj6NBBPptFIfr4Ds7F8eXcQrxyLzi+Ie51LiTkscd7
uTTeqCI/1uDgusgMxjwZ0Zc+A7zay8MVNUaJgYD+ChqmnsgOizTv9vaS+k25FPqf
5f1WyTBN1roddXmwXJC9IkSblwhQPxUOIcmoqVLWBs861yWvPrEHK3USTIm2rCJp
X/VP0DQsBNdU+PyKrF+ET5qy625F9t/QN5HJS8IMzo1CNUfTFDodFGNAU/Z1v24=
=72x5
-----END PGP SIGNATURE-----

--gtIrq6Sg36K4SKal0GHIb6O9savRAdPJ3--
