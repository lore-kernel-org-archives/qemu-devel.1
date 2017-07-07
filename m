Received: from eggs.gnu.org ([2001:4830:134:3::10]:55917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dTNT2-000065-RA
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dTNSz-0000mC-M1
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:14:20 -0400
Date: Fri, 7 Jul 2017 17:14:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170707071409.GF24325@umbus.fritz.box>
References: <20170621091848.28256-1-david@gibson.dropbear.id.au>
	<f89c6897-9555-100a-7252-a705fcbc8ee6@linux.vnet.ibm.com>
	<20170705110414.GN2180@umbus.fritz.box>
	<0e4deabe-58e9-6c15-5910-cda9f8e63f9b@linux.vnet.ibm.com>
	<89240dbb-56b7-e540-8981-b6af20eb0d8c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
In-Reply-To: <89240dbb-56b7-e540-8981-b6af20eb0d8c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/5] spapr: DRC cleanups (part
 VI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, sursingh@redhat.com, groug@kaod.org, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 11:31:35AM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 07/05/2017 06:53 PM, Daniel Henrique Barboza wrote:
> > Worth a try. I'll see if I can make a POC of this DRC reset at incoming
> > migration time.
>=20
>=20
> Just played a little with the idea of manual reset during migration. I've
> created a
> POC that resets the CPU DRCs in a pre_load hook.

Ok.  I'm not sure does the pre_load hook get called for objects where
nothing ends up being sent in the migration stream?

> Then I've done the same
> experiment - device_add on both source and target before the migration,
> hot unplug the device after migration is completed. The hot unplug worked=
 as
> expected in both QEMU and guest.

That's encouraging.

>=20
> To minimize the impact I am resetting only the DRCs of the CPUs that were
> hotplugged
> in the target instead of resetting everybody.

That sounds like more trouble than it's worth, I think it'll be easier
and safer to reset all DRCs.

> I'll see if this solution works for LMBs and PCI devices. In case
> affirmative, and
> if we are fine with this solution of resetting the DRCs in pre_load (not
> sure if pre_load is
> the right place for doing it - suggestions welcome), I can send a patch to
> be applied on top
> of this series.
>=20
>=20
>=20
> Thanks,
>=20
> Daniel
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZXzTBAAoJEGw4ysog2bOSzP8QAIYDBbHFgvhVGDJEowP90CJg
CenvB0BRmsWNztDCnqKzcswy3PPkwX+NTaatJptSn/8WWhjJtkJcyK5P0y27TDMv
ujtj+OnJCHR4t+Sk227Io6tY0+xQctk6MPH3jXJqEkGzXpU4tFPynFGscOeemxqc
zaY3Lxz427yWuaTSB3R2NtfKhk2f4hPu+hIDknaGcxHqhQ84jncaBOb5bTKtZTmx
zVFgsPbmgCLv0X41MY2UReeyD1ivDe+iK0J/GIfVF91hYJr2zyHMEHVNuzFIV45x
JY+AnxCehSNKygxUsXFqZUc2pN1mzgAgrFqxqC9xXnkwa1L1kwCebehlMsdut3EH
sIZRHA2jQJ7NriRA2ob1dzn3+W4Kv5YlKdO2E/e/FeeO2yqBNtfxLYUu81j9q6ld
3rYvbHRNYw9BZmRj7Ii6z3JQiqndS3tvuwrBqh/zuy0UTPIrHtqhdShFtGN4CXBU
88nH5881VflqmdLFNTntBM6bJEn8i2EzHYxzf3Q7bodjcjP2xRggmhztkpy/5Nkh
i3ggf2CJWUmc1jqEfATYZJd+V+uavpZvekcOZDtytCmkANxOL7ePJpmhk3oBZK9J
zSG14uaSkuJ94g/J5pfB5+F8YOD3fmkOO1IKnBtcPlNBBe7oG4sX1VhB1635owT9
wktwDD/UqBVuMxm+jcgs
=wCrz
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
