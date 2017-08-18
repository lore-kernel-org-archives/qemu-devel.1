Received: from eggs.gnu.org ([2001:4830:134:3::10]:44368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <revol@free.fr>) id 1dif83-0003IF-Re
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <revol@free.fr>) id 1dif7z-0007ZV-Ix
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:07:51 -0400
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<0362ffdbfb08b46edef0e2180387078299a9b721.1502643878.git.balaton@eik.bme.hu>
	<20170818015321.GN5509@umbus.fritz.box>
From: =?UTF-8?Q?Fran=c3=a7ois_Revol?= <revol@free.fr>
Message-ID: <194c2b39-e36a-24ea-1ba4-527593b7226f@free.fr>
Date: Fri, 18 Aug 2017 13:07:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170818015321.GN5509@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="5mVEn841MjXRA3JigPcToIFxE3mi3Fqa2"
Subject: Re: [Qemu-devel] [RFC PATCH 09/12] ppc440: Add emulation of
 plb-pcix controller found in some 440 SoCs
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
--5mVEn841MjXRA3JigPcToIFxE3mi3Fqa2
From: =?UTF-8?Q?Fran=c3=a7ois_Revol?= <revol@free.fr>
To: David Gibson <david@gibson.dropbear.id.au>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>
Message-ID: <194c2b39-e36a-24ea-1ba4-527593b7226f@free.fr>
Subject: Re: [RFC PATCH 09/12] ppc440: Add emulation of plb-pcix controller
 found in some 440 SoCs
References: <cover.1502643878.git.balaton@eik.bme.hu>
 <0362ffdbfb08b46edef0e2180387078299a9b721.1502643878.git.balaton@eik.bme.hu>
 <20170818015321.GN5509@umbus.fritz.box>
In-Reply-To: <20170818015321.GN5509@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

Le 18/08/2017 =E0 03:53, David Gibson a =E9crit :
> On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
>=20
> You know I'm going to say it, right: needs a commit message.
>=20
> What's a "plb-pcix", and what's an example of a 440 SoCs which has it.

IIRC that's the PCI(express) controller, which is not memory-mapped but
inside the DCR address space, so accessed from the PLB.

See:

http://www.embeddeddeveloper.com/assets/processors/amcc/datasheets/PP460E=
X_DS2063.pdf

page 9, 13.



Fran=E7ois.


--5mVEn841MjXRA3JigPcToIFxE3mi3Fqa2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRNJo6DsZLupSa6nwuKOKbtgqZASQUCWZbKdgAKCRCKOKbtgqZA
SXuyAJ47YVykC0nzr6YrwGdqm09l+YSJ0QCfVIs1mUuNbplzazpgfFAulHeLeB4=
=Za8H
-----END PGP SIGNATURE-----

--5mVEn841MjXRA3JigPcToIFxE3mi3Fqa2--
