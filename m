Received: from eggs.gnu.org ([2001:4830:134:3::10]:46398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <revol@free.fr>) id 1difOB-0002mp-8W
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <revol@free.fr>) id 1difO6-0005VP-CS
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:24:31 -0400
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<5e493fd14e60d92d4fd80492ceff5ba13eb7b558.1502643878.git.balaton@eik.bme.hu>
	<20170818061028.GU5509@umbus.fritz.box>
From: =?UTF-8?Q?Fran=c3=a7ois_Revol?= <revol@free.fr>
Message-ID: <dc9842ab-a7b1-5499-7e7c-ddbeff1c70dd@free.fr>
Date: Fri, 18 Aug 2017 13:24:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170818061028.GU5509@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="PNRmdKuwrqcWuUvqoTdh3qnXklJ2x1nAU"
Subject: Re: [Qemu-devel] [RFC PATCH 12/12] ppc: Add aCube Sam460ex board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PNRmdKuwrqcWuUvqoTdh3qnXklJ2x1nAU
From: =?UTF-8?Q?Fran=c3=a7ois_Revol?= <revol@free.fr>
To: David Gibson <david@gibson.dropbear.id.au>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>
Message-ID: <dc9842ab-a7b1-5499-7e7c-ddbeff1c70dd@free.fr>
Subject: Re: [RFC PATCH 12/12] ppc: Add aCube Sam460ex board
References: <cover.1502643878.git.balaton@eik.bme.hu>
 <5e493fd14e60d92d4fd80492ceff5ba13eb7b558.1502643878.git.balaton@eik.bme.hu>
 <20170818061028.GU5509@umbus.fritz.box>
In-Reply-To: <20170818061028.GU5509@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Le 18/08/2017 =E0 08:10, David Gibson a =E9crit :
> On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
>> Add emulation of aCube Sam460ex board based on AMCC 460EX embedded SoC=
=2E
>> This is not a full implementation yet with a lot of components still
>> missing but enough to start a Linux kernel and the U-Boot firmware.
>>
>> Signed-off-by: Fran=E7ois Revol <revol@free.fr>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>=20
> There are a *lot* of devices defined here.  Most of them look like
> they belong to the SoC, not the board (since they use DCRs), so it
> doesn't really make sense to define them in a board file.  It would
> also make it easier to review if they were split up into separate
> patches.
>=20


Indeed, I never thought it would need that many devices to run, and I
intended to move that out but never did.

While it'd make it easier to review, I also recall waiting 3 years to
get a simple patch in just because someone wanted the code to first be
refactored (hint: wacom) :p

Fran=E7ois.


--PNRmdKuwrqcWuUvqoTdh3qnXklJ2x1nAU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRNJo6DsZLupSa6nwuKOKbtgqZASQUCWZbOXQAKCRCKOKbtgqZA
SQzXAJ98fpktMnd58vJ9p0Ve+KoB1xsibwCfWQ4WAmt8qesunWzraYj9/udFCuo=
=6CHM
-----END PGP SIGNATURE-----

--PNRmdKuwrqcWuUvqoTdh3qnXklJ2x1nAU--
