Received: from eggs.gnu.org ([2001:4830:134:3::10]:38333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRRz4-0005f1-BM
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 20:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRRz0-0007VJ-2d
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 20:16:14 -0500
Date: Tue, 27 Nov 2018 11:11:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181127001118.GL2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-5-clg@kaod.org>
	<20181122044450.GF10448@umbus.fritz.box>
	<121d4f915a03c2e734feebceda023947aedb78a3.camel@kernel.crashing.org>
	<20181123011005.GU10448@umbus.fritz.box>
	<12f3da3b-3761-a26f-4460-65d3c978f52d@kaod.org>
	<20181126054429.GH2251@umbus.fritz.box>
	<81ec65f1-f524-10af-8729-9abf890b4ee4@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YIleam+9adpUeYf+"
Content-Disposition: inline
In-Reply-To: <81ec65f1-f524-10af-8729-9abf890b4ee4@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 04/36] ppc/xive: introduce the
 XiveRouter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--YIleam+9adpUeYf+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 10:39:44AM +0100, C=E9dric Le Goater wrote:
> On 11/26/18 6:44 AM, David Gibson wrote:
> > On Fri, Nov 23, 2018 at 11:28:24AM +0100, C=E9dric Le Goater wrote:
> >> On 11/23/18 2:10 AM, David Gibson wrote:
> >>> On Thu, Nov 22, 2018 at 05:50:07PM +1100, Benjamin Herrenschmidt wrot=
e:
> >>>> On Thu, 2018-11-22 at 15:44 +1100, David Gibson wrote:
> >>>>>
> >>>>> Sorry, didn't think of this in my first reply.
> >>>>>
> >>>>> 1) Does the hardware ever actually write back to the EAS?  I know it
> >>>>> does for the END, but it's not clear why it would need to for the
> >>>>> EAS.  If not, we don't need the setter.
> >>>>
> >>>> Nope, though the PAPR model will via hcalls
> >>>
> >>> Right, bit AIUI the set_eas hook is about abstracting PAPR vs bare
> >>> metal details.  Since the hcall knows it's PAPR it can just update the
> >>> backing information for the EAS directly, and no need for an
> >>> abstracted hook.
> >>
> >> Indeed, the first versions of the XIVE patchset did not use such hooks=
,=20
> >> but when discussed we said we wanted abstract methods for the router=
=20
> >> to validate the overall XIVE model, which is useful for PowerNV.=20
> >>
> >> We can change again and have the hcalls get/set directly in the EAT
> >> and ENDT. It would certainly simplify the sPAPR model.
> >=20
> > I think that's the better approach.
>=20
> ok. let's keep that in mind for  :=20
>=20
>  [PATCH v5 11/36] spapr/xive: use the VCPU id as a NVT identifier
>  [PATCH v5 16/36] spapr: add hcalls support for the XIVE exploitation
>=20
> which are using the XiveRouter methods to access the controller EAT=20
> and ENDT. I thought that was good practice to validate the model but=20
> we can use direct sPAPR table accessors or none at all.

Ok.  Consistency is good as a general rule, but I don't think it makes
sense to force the EAT and the ENDT into the same model.  The EAT is
pure configuration, whereas the the ENDT has both configuration and
status.  Or to look at it another way, the EAT is purely software
controlled, whereas the ENDT is at least partially hardware
controlled.

(I realize that gets a bit fuzzy when considering PAPR, but I think
=66rom the point of view of the XIVE model it makes sense to treat the
PAPR hypervisor logic as "software", even though it's "hardware" from the
guest point of view).

>=20
>=20
> I think these prereq patches could be merged now :
>=20
>  [PATCH v5 12/36] spapr: initialize VSMT before initializing the IRQ
>  [PATCH v5 13/36] spapr: introduce a spapr_irq_init() routine
>  [PATCH v5 14/36] spapr: modify the irq backend 'init' method
>=20
> This one also :
>=20
>  [PATCH v5 21/36] spapr: extend the sPAPR IRQ backend for XICS
>=20
> Thanks,
>=20
> C.=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YIleam+9adpUeYf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv8i6QACgkQbDjKyiDZ
s5JEtw/6Az5jf5CLfezP3c88Snuxjx06zfyeoKI9werM52RnGTbOIfNv5ls+RYvO
lNVRDh83HQcW3qizXPIKrEBjwd5MW5ssJHdBcJLZgQPGSt4n7ifI1KAGTnxr9PLU
yW3EjSeN9cZbFg11uOZ2DRt3xbiCnim8knlUc+XToRluy/aseSDhNnW7/UtLuY5K
w79ay9HI/WB3jdA4q35YvPFi5C+0CafkovLoiAJAKu908WRlnyX9Wui6F83gHAln
fwg6UmWE03NDRbRbWBFn9ISJ/PyOC34YBpu6NxskuJDDAAvjb0gSdpSvR0iBpf9P
AhglIMl0Zpd2yX/prsU2QtZMt4Xcz6TOmzZDjzjB0nMSVmd6GoG/VbJLh1zVo0xD
yZ98vNJYzJjYoIp5QO/Mc/ZzSIWUg4sorTd5ZVQQu0axRab9HgMoyY/YOfDEwKpu
JjPqgJOkRSVP7rG8JaRCKv/qgtD9nv9u//VvZ8fuINwY+x0+58M3aZcm+GA9J4z+
XhL/2EufjwHVTP4nCSuGCUAG/BTXARuRd1OzBoLqYeslgNQDE2SPUxRPvh3Dm2jl
9d1p1iiqBlRVxk5l3tNyGfAXBoZnIPs2eIgvi3h6Ww9RVv4XgJC8JAJIPtfNQCyp
Qy9XbShC4NkjRBbv3jPzc92o7p4RwgYYGWbuyNyFETafqcMyt4s=
=Z0lW
-----END PGP SIGNATURE-----

--YIleam+9adpUeYf+--
