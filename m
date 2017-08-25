Received: from eggs.gnu.org ([2001:4830:134:3::10]:51995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl6V3-0008Bt-Ph
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 00:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl6V2-0000R6-Qk
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 00:45:41 -0400
Date: Fri, 25 Aug 2017 14:23:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170825042313.GD2772@umbus.fritz.box>
References: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
	<20170824025448.GA27401@fergus.ozlabs.ibm.com>
	<20170824181122.GA5632@ram.oc3035372033.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Content-Disposition: inline
In-Reply-To: <20170824181122.GA5632@ram.oc3035372033.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: Add ibm,
 processor-storage-keys property to CPU DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Paul Mackerras <paulus@ozlabs.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Michael Ellerman <mpe@ellerman.id.au>


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 11:11:22AM -0700, Ram Pai wrote:
> On Thu, Aug 24, 2017 at 12:54:48PM +1000, Paul Mackerras wrote:
> > On Mon, Aug 21, 2017 at 05:00:36PM -0300, Thiago Jung Bauermann wrote:
> > > LoPAPR says:
> > >=20
> > >     =E2=80=9Cibm,processor-storage-keys=E2=80=9D
> > >=20
> > >     property name indicating the number of virtual storage keys suppo=
rted
> > >     by the processor described by this node.
> > >=20
> > >     prop-encoded-array: Consists of two cells encoded as with encode-=
int.
> > >     The first cell represents the number of virtual storage keys supp=
orted
> > >     for data accesses while the second cell represents the number of
> > >     virtual storage keys supported for instruction accesses. The cell=
 value
> > >     of zero indicates that no storage keys are supported for the acce=
ss
> > >     type.
> > >=20
> > > pHyp provides the property above but there's a bug in P8 firmware whe=
re the
> > > second cell is zero even though POWER8 supports instruction access ke=
ys.
> > > This bug will be fixed for P9.
> > >=20
> > > Tested with KVM on POWER8 Firenze machine and with TCG on x86_64 mach=
ine.
> > >=20
> > > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> > > ---
> > >=20
> > > The sysfs files are provided by this patch for Linux:
> >=20
> > Those sysfs files relate to the kernel's support for userspace
> > processes using storage keys.  That is quite distinct from KVM's
> > support for guests using storage keys, so I think that using those
> > sysfs files to indicate what the guest can do is wrong.
> >=20
> > In fact KVM allows guests to specify storage keys in the HPTE values
> > that they set, except that there is a bug (for which Ram Pai has
> > posted a patch) that means that KVM loses the top two bits of the key
> > number.
> >=20
> > What I would suggest is that we use the 'pad' field in the struct
> > kvm_ppc_smmu_info to report the number of keys supported by KVM for
> > guest use.  That will be 0 in all current kernels, indicating that
> > keys are not supported, which is reasonable because of the bug.  I
> > will make sure the patch fixing the bug goes in first.
>=20
> with the current kernels, even with the bug, KVM can still support 8
> keys. Should we say 8 instead of 0?  It will help enable keys on KVM
> earlier and give a jump start to its adaption by applications.

But the point isn't really what we *can* say, it's with what is
implicitly said by kernels that don't advertise anything
specifically.  Which is 0.

If we're going to change the kernel to put something else in smmu
info, we can also change it to fix the storage key stuff anyway, so we
can put the full value in there.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmfpjAACgkQbDjKyiDZ
s5IzaxAAv6lWTfZ2nQQW/c0LejRXHEDcVr8FjVmjqRFBwrqLdVlfUWoirSNlcEuQ
qaT/f/94ZEbHxdRWpF+luTwxyRTHUrV1PUUS8XFiJsW53qGNoIZWSD9U8PEZVj/k
ecczwM1U09XpuLRRInHL+iRT8yItV+ucj8b/loJpU2Wgi7hUBpX/Xoz2SkT0UIxT
qg8eptgWpEgGm5KKO7mv8mh2g6hCObxLy0vK5sx+9aqvq69vdQhZX3A69UENBhNf
etF/dsP8BldQOEAyiKxodI+mQZve0oUnhFYlRGGu36LVXaQHb9g3pP7mA0gB8fQ6
MN47f8SZfNHh9G6R6nwzVmGDn2SVRxn/nnK8D5elLxQzKEGw+gMbpt70/VVWMYuI
/3yp1vsERJBiukcVsem7WzV4KjWiLr+FmVVGYucmqcEzzA9GOUX8it5+eyqQF4Ov
k0WkWsIi21m4FQ8uzYf5omAUlPFX70ZWVVq1MXR6PceZKnYYhfF/0OaA2dbq+duo
YGoaQieifn/EfgDu09mjU0zgalF8/j14C8KxF2H8EcwPbw2J5Z52jQ9b9Dv8EdTw
bT5kwAA/Lq8McvEGV6SUm0bPAhvRXDgzp6rkgcrz85LYOyGGMI03gtNPuqakr+5u
PiMt4jzP/GthSoMtuQFOrBa0tjsZpYBM3DkjfVlTMC0laRYlKB8=
=V1tm
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
