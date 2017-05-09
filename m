Received: from eggs.gnu.org ([2001:4830:134:3::10]:37906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8FtK-0007K3-FF
	for qemu-devel@nongnu.org; Tue, 09 May 2017 20:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8FtH-0000hQ-CQ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 20:54:10 -0400
Date: Tue, 9 May 2017 17:05:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170509070558.GO25748@umbus.fritz.box>
References: <20170509034519.16291-1-david@gibson.dropbear.id.au>
	<40670f11-21fa-7a8c-db7a-3053d61f082b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1bhFRg6vL9BT9osV"
Content-Disposition: inline
In-Reply-To: <40670f11-21fa-7a8c-db7a-3053d61f082b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Allow workarounds for POWER9
 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: lvivier@redhat.com, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de


--1bhFRg6vL9BT9osV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 06:41:23AM +0200, Thomas Huth wrote:
> On 09.05.2017 05:45, David Gibson wrote:
> > POWER9 DD1 silicon has some bugs which mean it a) isn't really compliant
> > with the ISA v3.00 and b) require a number of special workarounds in the
> > kernel.
> >=20
> > At the moment, qemu isn't aware of DD1.  For TCG we don't really want i=
t to
> > be (why bother emulating buggy silicon).  But with KVM, the guest does =
need
> > to be aware of DD1 so it can apply the necessary workarounds.
> >=20
> > Meanwhile, the feature negotiation between qemu and the guest strongly
> > favours architected compatibility modes to "raw" CPU modes.  In combina=
tion
> > with the above, this means the guest sees architected POWER9 mode, and
> > doesn't apply the DD1 workarounds.  Well, unless it has yet another
> > workaround to partially ignore what qemu tells it.
> >=20
> > This patch addresses this by disabling support for compatibility modes =
when
> > using KVM on a POWER9 DD1 host.
>=20
> I first though: Hey, it should be fixed in the guest kernel instead, but
> thinking about this twice, I think you're right. If the CPU is not fully
> compatible to the ISA, we really should not announce it as "architected
> / compatible POWER9" in QEMU.
> So basically ACK to your patch, I've just got a cosmetic request below...
>=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  target/ppc/kvm.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 8574c36..591b5b5 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2380,6 +2380,17 @@ static void kvmppc_host_cpu_class_init(ObjectCla=
ss *oc, void *data)
> > =20
> >  #if defined(TARGET_PPC64)
> >      pcc->radix_page_info =3D kvm_get_radix_page_info();
> > +
> > +    if ((pcc->pvr & 0xffffff00) =3D=3D 0x004e0100) {
>=20
> Could you please add a proper #define for that magic DD1.0 value to
> cpu-models.h, please?

Good point, done.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1bhFRg6vL9BT9osV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEWpTAAoJEGw4ysog2bOS6ScQAJ+M5PIy39L147/lum0tepIX
XARMs3UEZGNxR8FjCxG0VWNSIOTYKNrKDoRWeG3tzE5o57UDRkP21c1bxEQVp6iU
7a/P1XlnH67zjquueax4WkaUFIn0iA4Os9FWRYpjl5ZVvik40bc2GwVTlEJwibNC
66KyzHTDDjx/eUm6UVV6t3nfIi7jrOEAvnO0xM3OWare0KZDLktwCauBo9tJ4D6s
+C/caJbz8y4Jtt1aeCqC10NTb8r7YpgEL/6ILCCLjT+UIuEVUVVKBJW/ueC6+1Dm
EeqNmasiCRvn1BW22owxIznqjwlqTJ8kvS7etBkYzRCprs+XGpvwhyS/B5WpNCJq
IEgqKuvvCsFkGCk5Erf1W9aGmoaU4lKCf2IXSyHRD2avdxXJdm4mW/rAOm4ombSg
H7ISVWHiko5TQmM0u/u0ts8PRYW2VoDrpeRPX9n3BtL293pUx9KQY7L+n9pL45xy
13oNmxaev7UYmV8bfmE+nluXLC9yhr7WzM+ihiqUTWD5quEl48lhbQHnoS/sZ8R+
eSBeTjbVEr+g/NuavdqD6VRRa/QEvvGG+KjZmiNqziG6RHeynHYqgtRo8Q2ZLvzb
XIbebZMx+6Ea8S2ridVRPbly/vgHCKe3H0/Rr/ekyRVwxHR0c06elMKK6tuRtsNF
/McahAC5Op8wzrlptSCl
=BRjO
-----END PGP SIGNATURE-----

--1bhFRg6vL9BT9osV--
