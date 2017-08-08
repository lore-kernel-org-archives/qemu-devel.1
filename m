Received: from eggs.gnu.org ([2001:4830:134:3::10]:50938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df5Iu-0007dT-Vd
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df5It-0003q1-Oj
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:16:16 -0400
References: <20170807203007.19033-1-eblake@redhat.com>
	<20170807203007.19033-3-eblake@redhat.com>
	<20170808082854.GB4850@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <365907cd-3990-b390-fd71-5213275edc27@redhat.com>
Date: Tue, 8 Aug 2017 09:16:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170808082854.GB4850@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="B1MX2LB9aJuv2qtk4pb7wMOG9wN4bTVr8"
Subject: Re: [Qemu-devel] [PATCH 2/4] qcow: Check failure of
 bdrv_getlength() and bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B1MX2LB9aJuv2qtk4pb7wMOG9wN4bTVr8
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <365907cd-3990-b390-fd71-5213275edc27@redhat.com>
Subject: Re: [PATCH 2/4] qcow: Check failure of bdrv_getlength() and
 bdrv_truncate()
References: <20170807203007.19033-1-eblake@redhat.com>
 <20170807203007.19033-3-eblake@redhat.com>
 <20170808082854.GB4850@dhcp-200-186.str.redhat.com>
In-Reply-To: <20170808082854.GB4850@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 03:28 AM, Kevin Wolf wrote:
> Am 07.08.2017 um 22:30 hat Eric Blake geschrieben:
>> This also requires changing the return type of get_cluster_offset()
>> and adjusting all callers.
>>
>> Use osdep.h macros instead of open-coded rounding while in the
>> area.
>>
>> Reported-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

> qcow2 ended up with this prototype:
>=20
> int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
>                              unsigned int *bytes, uint64_t *cluster_off=
set)
>=20
> Separating a full uin64_t offset by-reference parameter and an 0/-errno=

> status return code feels a little cleaner to me.
>=20
> And in fact, it's not only cleaner, but bit 63 is QCOW_OFLAG_COMPRESSED=
,
> so this patch breaks compressed images.

Looks like I'll be sending a v2, then.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--B1MX2LB9aJuv2qtk4pb7wMOG9wN4bTVr8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmJx6UACgkQp6FrSiUn
Q2rtzggAovf0F+B0Kf2M7VlAOdUGx37hm+fkpW3pOy0s8OzCrdKlolcPVqlnZq0a
5eb9udZoq5CWFam6xiFeiOYNzI9gWIi44RjL9FOsfbm7AKdRlUP18e0litklW2CD
yV7s7HG4HgEynfd+KIvDdFs4vwzATofk8BYC71LSG97wHMIq79xMp6xtEKU36Xhp
b37eFSAUV4Bsggi02o6LZBjUUb3UiEv2BA8nHim4g9bGW65oN0TezxVMANUJbYLM
4ReJ+JxzMoSSiPoSwV86fP1MM15eG9eAsXhmm3K4BvgdUis+53PaF6EsgTydp5s9
P37mVtxwYM5eTnZap/Gw6IfZQxZ9lQ==
=kwRJ
-----END PGP SIGNATURE-----

--B1MX2LB9aJuv2qtk4pb7wMOG9wN4bTVr8--
