Received: from eggs.gnu.org ([2001:4830:134:3::10]:52826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCtrz-0006Re-83
	for qemu-devel@nongnu.org; Mon, 22 May 2017 16:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCtry-0000kZ-98
	for qemu-devel@nongnu.org; Mon, 22 May 2017 16:23:59 -0400
References: <20170519023233.24461-1-eblake@redhat.com>
	<20170519023233.24461-4-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a4b9b8f-c1eb-dc71-fe9a-426becd5065c@redhat.com>
Date: Mon, 22 May 2017 15:23:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170519023233.24461-4-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ffp0LVLHJM7r59ulmOno14cnD1vgVqp1t"
Subject: Re: [Qemu-devel] [PATCH 3/4] block: Simplify use of BDRV_BLOCK_RAW.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, jsnow@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ffp0LVLHJM7r59ulmOno14cnD1vgVqp1t
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>,
 jsnow@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <2a4b9b8f-c1eb-dc71-fe9a-426becd5065c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] block: Simplify use of BDRV_BLOCK_RAW.
References: <20170519023233.24461-1-eblake@redhat.com>
 <20170519023233.24461-4-eblake@redhat.com>
In-Reply-To: <20170519023233.24461-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/18/2017 09:32 PM, Eric Blake wrote:

Not sure why I included a trailing dot in the subject line; a maintainer
can remove that if desired.

> The lone caller that cares about a return of BDRV_BLOCK_RAW
> completely replaces the return value, so there is no point in
> passing BDRV_BLOCK_DATA.

For that matter, I could have mentioned that the lone caller is
io.c:bdrv_co_get_block_status().

>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ffp0LVLHJM7r59ulmOno14cnD1vgVqp1t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZI0jUAAoJEKeha0olJ0Nq2pEH/A3UkfoEUVrq/XiQvb48wmqE
EBzf9YM65qjpSOORdZYg2ZxZxfwLexcQ/ghfpSyxL8tESKrMjiViFsRZRu/kXuf8
cWW/tuoxmDe21FShnguZ0bKvE1iUIyrIaK4MG738/7KwbmDParDkmXFImT/LZebO
wSf+DxzEYuMiiTJP/Vn3shvl1oB0NBrWTGAuj7tCnYorGCrq5pLJvmKvzJHbSLR5
VfYC/mQbfnuzq8cWu5x5NPaBY1yH3JmsYyHpP0ZabgGOJGzqrckKLNs/A39L74w9
6yaHK3w0wS2xIfcCrE9ceDwpj3S8NVYms3R7XNRRp+meqBu98YntKwR8Jm1Tdkg=
=4go1
-----END PGP SIGNATURE-----

--Ffp0LVLHJM7r59ulmOno14cnD1vgVqp1t--
