Received: from eggs.gnu.org ([2001:4830:134:3::10]:32843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslq7-0005Am-6E
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslpx-0006GB-OE
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:19:02 -0400
References: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
	<150541714343.1616.11893912014879112098.stgit@bahia.lan>
	<19f09a67-5b16-6bdf-5c72-c2df84537ea7@redhat.com>
	<20170915063540.GF5250@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fff9daba-393f-a226-4b9d-467e7a6f47a0@redhat.com>
Date: Fri, 15 Sep 2017 10:18:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170915063540.GF5250@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="UPpDfpwETGsD99h2IoNgO9C16rSIGWedD"
Subject: Re: [Qemu-devel] [PATCH 3/3] ppc/kvm: check some capabilities with
 kvm_vm_check_extension()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sam Bobroff <sam.bobroff@au1.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UPpDfpwETGsD99h2IoNgO9C16rSIGWedD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.09.2017 08:35, David Gibson wrote:
> On Fri, Sep 15, 2017 at 07:15:41AM +0200, Thomas Huth wrote:
>> On 14.09.2017 21:25, Greg Kurz wrote:
>>> The following capabilities are VM specific:
>>> - KVM_CAP_PPC_SMT_POSSIBLE
>>> - KVM_CAP_PPC_HTAB_FD
>>
>> BTW, looks like kvmppc_has_cap_htab_fd() is dead code ... should we
>> either remove it or check it somewhere?
>=20
> It's checked in kvmppc_get_htab_fd().

That function checks the "cap_htab_fd" variable, but is not using the
kvmppc_has_cap_htab_fd() function which I was referring to.

 Thomas


--UPpDfpwETGsD99h2IoNgO9C16rSIGWedD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZu4ztAAoJEC7Z13T+cC21TZ4P/AgIaUyLNarQbUMrUZH3Kbbm
IN9OgMawEcGzLbo9Mwq99C55FIUrCaaadA/kJtVjm6ilz/iyIPW4DbgtyWBEY6j5
QvJj9nYx/45DOaffX+VG/DzLBYn5iRucqcyAMC42yNr7MvnHNLS7NyOUGK22VZMP
K0hvLXsob6pH6MMTf6xR9RFsMjIl28UW9gSt+oqyOx+ilKcG4Lf8aoXk3G2Oz408
w2kUseMChIm300+1YglW6ALH09AaRZT84jgvohD7x9IhTc0UGhFJgtWPJjENcPXq
RvG2cx0+p8q8CxPkuHWSYM+EBZgnFzJazG1BYV22OWrfrTG0Z1lLpnH+1ZOBJ3o7
pK1/ptzCsrpYP66gy+F2i8Xmw6SCDa6y7YrKWxnrszOyT4wi2hL283Nr+dpSAJhR
zRD+U2stKsOIQGZeS/5YAtvX7DsZEX4OVHAvz5qYIJFgYGzJlsl1b/KRINcKc27r
ontTYQLFEywh1Ukq4ZSZMbzT93Cmj6KgtCcuN27KFTfzU+GqcbLhX/JRAy+cTU30
ni0yxFiFBQndIV3/T8hEd+nEPwrvfdyhpGVT6PP0dRgfmcyCW26gU8gZhxKwQ0+R
ky8Ja3+tx9lJ78n+aRwLF/E+i3L29+g+GT9BTMoSkHx3IF7AUQgbmaIpzkhjyKFl
8vOP/2jgmw2t6j4zWpik
=0/p4
-----END PGP SIGNATURE-----

--UPpDfpwETGsD99h2IoNgO9C16rSIGWedD--
