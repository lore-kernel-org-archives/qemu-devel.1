Received: from eggs.gnu.org ([2001:4830:134:3::10]:50391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ531-0004j8-S3
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 21:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ52y-0005AS-K6
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 21:23:51 -0500
Date: Tue, 18 Dec 2018 13:09:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181218020924.GB23604@umbus.fritz.box>
References: <20181214015520.20467-1-aik@ozlabs.ru>
	<20181217062133.GK5597@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20181217062133.GK5597@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH qemu v3] ppc/spapr: Receive and store
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, gkurz@linux.ibm.com


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 05:21:33PM +1100, David Gibson wrote:
> On Fri, Dec 14, 2018 at 12:55:20PM +1100, Alexey Kardashevskiy wrote:
> > SLOF receives a device tree and updates it with various properties
> > before switching to the guest kernel and QEMU is not aware of any chang=
es
> > made by SLOF. Since there is no real RTAS (QEMU implements it), it makes
> > sense to pass the SLOF final device tree to QEMU to let it implement
> > RTAS related tasks better, such as PCI host bus adapter hotplug.
> >=20
> > Specifially, now QEMU can find out the actual XICS phandle (for PHB
> > hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
> > assisted NMI - FWNMI).
> >=20
> > This stores the initial DT blob in the sPAPR machine and replaces it
> > in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
> >=20
> > This adds an @update_dt_enabled machine property to allow backward
> > migration.
> >=20
> > SLOF already has a hypercall since
> > https://github.com/aik/SLOF/commit/e6fc84652c9c0073f9183
> >=20
> > This makes use of the new fdt_check_full() helper. In order to allow
> > the configure script to pick the correct DTC version, this adjusts
> > the DTC presense test.
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> Applied, thanks.

And now, unapplied.

I don't know quite how, but somehow this patch is causing aarch64
tests to SEGV.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwYVtEACgkQbDjKyiDZ
s5LHKw/8CQc1etSQ6Y7xonJxIiLe5tKUPKhSMnFO5eEuVjsm2Zhx+GDtU0m/ol1o
jpzYduBJg15HMSfKxbq2u+LoUoZtad6zMrTn+7X25t+r4lRgprpL3qznUhT4U53d
Lt/pfq70Fqyai/Wx7ruAvy01VYhH9ESOrmMvpUAU6VEDjyyc4qi7+/bvwp1BVdId
LwYTRzzhDlFeowkaYtuY4UGC6rvUTu3Wd3GdenZybM62uvCI1OPL//lnTKCQr6We
iuo6svrCZe6ttuG/4SjvHVltYi94mUR2OOXPYkworwZCvi3yRYW97hc0+gHTJ8D/
jrWJnAV/w9lrKUWzhAG1WNBl+oVm7GsrPKJ2/bimtHZJcjrp3BBmtFae48npHsx3
lgokH613w+7pwpWtlSBVIm4pYmbLZjZABCmuVRXruPu0otQRwTg0IvJYwwKMLQ6r
RdRlRN+F61nsq+x0bHWVH2/WdMFNjQ/kgkFfjm9mX9Kfy3tSxbhUhZKvssznezaN
FM1rSDzgTPUvqwCBizyFBuZuenb5xMFj/LdTnAFy4xla0bpJWrwcLkJHhQTIt5TM
jvx6SHtr9VfAgY8OPWEhwicLWLRV+wZ6HF4afXSEGsOYcHXjHF3MMOIbg1IFAXme
F04ZsEz+/qjnzdmVm37V6jZgJrjk5yXQgzVpKx1GUJWI7tiyqdE=
=XNZe
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
