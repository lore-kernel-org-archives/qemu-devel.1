Received: from eggs.gnu.org ([2001:4830:134:3::10]:44295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCgTw-0001Ws-9a
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCgTv-0006Bu-Ct
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:38:32 -0500
Date: Thu, 9 Nov 2017 17:38:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171109063822.GD7732@umbus.fritz.box>
References: <20171016052004.31397-1-aik@ozlabs.ru>
	<20171016093641.GH2776@umbus.fritz.box>
	<e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
	<20171019062440.GY2776@umbus.fritz.box>
	<699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
	<9227196b-789c-e4b2-c9c5-4fd95ed42b4e@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <9227196b-789c-e4b2-c9c5-4fd95ed42b4e@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v3] RFC: ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>, slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 06:14:04PM +1100, Alexey Kardashevskiy wrote:
> On 20/10/17 11:46, Alexey Kardashevskiy wrote:
> > On 19/10/17 17:24, David Gibson wrote:
> >> On Tue, Oct 17, 2017 at 04:55:03PM +1100, Alexey Kardashevskiy wrote:
> >>> On 16/10/17 20:36, David Gibson wrote:
> >>>> On Mon, Oct 16, 2017 at 04:20:04PM +1100, Alexey Kardashevskiy
> >>> wrote:
> >> [snip]
> >>>> ||
> >>>>
> >>>> Yeah.. this is all a bit complicated, I'm really thinking about a
> >>>> fdt_fsck() function for libfdt.
> >>>
> >>>
> >>> Oh. So what now? Do as below or wait for libdtc update?
> >>
> >> So I started hacking on this.  It's a bit fiddlier to get right than I
> >> anticipated.  How about you make a placeholder function to "test" the
> >> tree for now, with a comment that it will be updated once the libfdt
> >> extensions are there.
> >=20
> > What would the placeholder do? Nothing or my proposed "FDT_CHK" thingy?
> >=20
> > Are we in a hurry with this one at all, or I can wait till libfdt gets =
this
> > fsck()?
>=20
>=20
> Ping?
>=20
> This is not v2.11 material, is it?

Not at this stage, no.

I've started looking at writing the fdt_fsck() thing, but got
sidetracked by a bunch of related fixes to safety of handling
corrupted blobs in libfdt.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloD990ACgkQbDjKyiDZ
s5LicRAA5JNnCqc5r0fJECoEzRhHf1axP+GBuNl7IACxq2FL/MMAngWnI+9B6G1v
qJHQ9959osXim+oiiUwUk+b+u8f1/LcMW53CxRiz7udUBxLQp2QaaR5GJ0iupIuh
skrrLUyfJXQ439RV6gcVAwMDa67nkc+aMHTT5qUd2slqpzTpGjErtLI75HOH53Un
NG9xvK9HI5ao/IrRKkvaOcOsQ1lXew5HaPhE6Br16K6GoYjAhncC7FDBnSi6sJ6z
fdPF0K9906VRI0kMpV+Qjf9LF09tEY+PqB1VpcNVF3looO6vj/ea0JwX4xGrC7qk
58zmJCxT3UZIkvPcuGYCKrEtOs/riuX9auPLbsvRN5nWG4gEaDqOfBFsr8VyA1B4
kA1iXzBFi4gDA/RF9s06qFLvy9wN1bXH/zPeSi9OAa+NFIiEUGf/1/4xqZGTrlq8
W2UArKTFSyHxWQdm4n3BLH6/LRmQUr5WfCjm9ZgYFGmuSPTpg2G3aBUTzlNm2AgB
jHeexgCPfTCLTkHSMOCK9XbXVvhTP0Q8wHFBYA4CnNZnY2lUPCAmoom3zH9wTkEE
Og9R1SudXHqZ5ZSbbunsNdaC+cblxy4ou9pX0CsNy3bN0lHpisoaXX1NUR311bDv
AT4WaaDYsFyRtB5VNzk0kOeWpUzokKu9T1mEXuWatrR1tPTUZ3I=
=ryd2
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
