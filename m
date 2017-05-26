Received: from eggs.gnu.org ([2001:4830:134:3::10]:58435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE7pT-0006Ia-J4
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE7pP-0001Hs-He
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:30:27 -0400
Received: from ozlabs.org ([103.22.144.67]:35035)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dE7pO-0001Hi-SB
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:30:23 -0400
Date: Fri, 26 May 2017 15:30:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170526053014.GL12929@umbus.fritz.box>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
	<1493285660-4470-7-git-send-email-peterx@redhat.com>
	<20170501045822.GM13773@umbus.fritz.box>
	<20170508054814.GA2820@pxdev.xzpeter.org>
	<20170508060744.GG25748@umbus.fritz.box>
	<20170508073217.GD2820@pxdev.xzpeter.org>
	<20170510070406.GU25748@umbus.fritz.box>
	<20170511050426.GF28293@pxdev.xzpeter.org>
	<20170515053211.GB11105@umbus.fritz.box>
	<20170525072430.GA22816@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sMZCuqyhuhd4ycTi"
Content-Disposition: inline
In-Reply-To: <20170525072430.GA22816@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC PATCH 6/8] memory: introduce AddressSpaceOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>


--sMZCuqyhuhd4ycTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2017 at 03:24:30PM +0800, Peter Xu wrote:
> On Mon, May 15, 2017 at 03:32:11PM +1000, David Gibson wrote:
> > On Thu, May 11, 2017 at 01:04:26PM +0800, Peter Xu wrote:
> > > On Wed, May 10, 2017 at 05:04:06PM +1000, David Gibson wrote:
> > > > On Mon, May 08, 2017 at 03:32:17PM +0800, Peter Xu wrote:
> > > > > On Mon, May 08, 2017 at 04:07:44PM +1000, David Gibson wrote:
> > > > > > On Mon, May 08, 2017 at 01:48:14PM +0800, Peter Xu wrote:
> > > > > > > On Mon, May 01, 2017 at 02:58:22PM +1000, David Gibson wrote:
> > > > > > > > On Thu, Apr 27, 2017 at 05:34:18PM +0800, Peter Xu wrote:
> > > > > > > > > This is something similar to MemoryRegionOps, it's just f=
or address
> > > > > > > > > spaces to store arch-specific hooks.
> > > > > > > > >=20
> > > > > > > > > The first hook I would like to introduce is iommu_get().
> > > > > > > > >=20
> > > > > > > > > For systems that have IOMMUs, we will create a special ad=
dress space per
> > > > > > > > > device which is different from system default address spa=
ce for
> > > > > > > > > it (please refer to pci_device_iommu_address_space()). No=
rmally when
> > > > > > > > > that happens, there will be one specific IOMMU (or say, t=
ranslation
> > > > > > > > > unit) stands right behind that new address space.
> > > > > > > > >=20
> > > > > > > > > This iommu_get() fetches that guy behind the address spac=
e. Here, the
> > > > > > > > > guy is defined as IOMMUObject, which is currently a (void=
 *). In the
> > > > > > > > > future, maybe we can make it a better definition, but imh=
o it's good
> > > > > > > > > enough for now, considering it's arch-dependent.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > > > >=20
> > > > > > > > This doesn't make sense to me.  It would be entirely possib=
le for a
> > > > > > > > single address space to have different regions mapped by di=
fferent
> > > > > > > > IOMMUs.  Or some regions mapped by IOMMUs and others direct=
 mapped to
> > > > > > > > a device or memory block.
> > > > > > >=20
> > > > > > > Oh, so it's more complicated than I thought... Then, do we re=
ally have
> > > > > > > existing use case that one device is managed by more than one=
 IOMMU
> > > > > > > (on any of the platform)? Frankly speaking I haven't thought =
about
> > > > > > > complicated scenarios like this, or nested IOMMUs yet.
> > > > > >=20
> > > > > > Sort of, it depends what you count as "more than one IOMMU".
> > > > > >=20
> > > > > > spapr can - depending on guest configuration - have two IOMMU w=
indows
> > > > > > for each guest PCI domain.  In theory the guest can set these up
> > > > > > however it wants, in practice there's usually a small (~256MiB)=
 at PCI
> > > > > > address 0 for the benefit of 32-bit PCI devices, then a much la=
rger
> > > > > > window up at a high address to allow better performance for 64-=
bit
> > > > > > capable devices.
> > > > > >=20
> > > > > > Those are the same IOMMU in the sense that they're both impleme=
nted by
> > > > > > logic built into the same virtual PCI host bridge.  However, th=
ey're
> > > > > > different IOMMUs in the sense that they have independent data
> > > > > > structures describing the mappings and are currently modelled a=
s two
> > > > > > different IOMMU memory regions.
>=20
> [1]
>=20
> > > > > >=20
> > > > > >=20
> > > > > > I don't believe we have any existing platforms with both an IOM=
MU and
> > > > > > a direct mapped window in a device's address space.  But it see=
ms to
> > > > > > be just too plausible a setup to not plan for it. [1]
> > > > > >=20
> > > > > > > This patch derived from a requirement in virt-svm project (on=
 x86).
> > > > > > > Virt-svm needs some notification mechanism for each IOMMU (or=
 say, the
> > > > > > > IOMMU that managers the SVM-enabled device). For now, all IOM=
MU
> > > > > > > notifiers are per-memory-region not per-iommu, and that's imh=
o not
> > > > > > > what virt-svm wants. Any suggestions?
> > > > > >=20
> > > > > > I don't know SVM, so I can't really make sense of that.  What f=
ormat
> > > > > > does this identifier need?  What does "for one IOMMU" mean in t=
his
> > > > > > context - i.e. what guest observable properties require the IDs=
 to be
> > > > > > the same or to be different.
> > > > >=20
> > > > > Virt-svm should need to trap the content of a register (actually =
the
> > > > > data is in the memory, but, let's assume it's a mmio operation for
> > > > > simplicity, considering it is finally delivered via invalidation
> > > > > requests), then pass that info down to kernel. So the listened el=
ement
> > > > > is per-iommu not per-mr this time. When the content changed, vfio=
 will
> > > > > need to be notified, then pass this info down.
> > > >=20
> > > > I don't entirely follow what you're saying.  When the virtual hardw=
are
> > > > gets an invalidate request, it looks up the unit to invalidate in
> > > > memory?  Which component gets to decide that ID?  How is it adverti=
sed
> > > > to the guest OS?
> > > >=20
> > > > If your ID is tied to the AS now, you could just iterate through the
> > > > AS and invalidate any IOMMU MRs that are present within it.
> > > >=20
> > > > Alternatively, if the ID is tied to something more concrete, like a
> > > > specific PCI host bridge (which incorporates the IOMMU logic), then
> > > > that device probably already has a handle on the right IOMMU MR to
> > > > invalidate it.
> > >=20
> > > Sorry to be unclear on the requirement. I don't know what's the ID you
> > > mentioned above... Anyway, let me try to further simplify the use
> > > case.
> >=20
> > Right, the ID was me guessing badly at what's going on here, so I
> > think it confused rather than clarifying.
> >=20
> > > Just assume we have such a requirement: when one register of vIOMMU
> > > changes, we need to pass this register data to the hardware IOMMU by
> > > some way. And, let's assume this is a notification mechanism, so that
> > > every device in the system can listen to this register change, then
> > > capture what has changed to what. Here the point is, in all cases this
> > > event is not related to memory region at all. So imho we need some
> > > other way to do it besides memory region IOMMU notifiers.
> >=20
> > Ok.  So is this right?
> > 	* You have a single bank of vIOMMU registers
> > 	* Which control two (or more) IOMMU regions in in the guest's
> >           address space
> > 	* Assuming the host also has an AMD IOMMU, those will be
> >           backed by a single IOMMU on the host ("single" meaning
> >           controlled by a single bank of host registers)
> >=20
> > I'm assuming the guest IOMMU code must know which IOMMU regions it is
> > managing, so getting from the guest registers to the set of IOMMU MRs
> > should be easy.
> >=20
> > What's the operation that needs to happen on the host IOMMU, in terms
> > of the VFIO IOMMU interface?
>=20
> (Sorry to respond so late...)
>=20
> It'll pass the captured data downward to host IOMMU in some way.
>=20
> IMHO if we are discussing the notifier thing only, we don't really
> need to know what would it do after it gets the data. The point is how
> we should define this kind if notifies, which differs from current
> memory region based notifiers.

I'm trying to understand how it differs - I still don't have a clear
picture.  That's why I'm asking what needs to be passed to the host
MMU, so I can see why you need this different notifier.

> > Is this inherently only possible if both host and guest have an AMD
> > IOMMU?  Could it be made to work if the guest had an AMD IOMMU but the
> > host had an Intel one, or the other way around?
> >=20
> > Would it make sense to have a single IOMMU MR in the guest, but
> > instead of mapping it whole into the guest address space, have two
> > (or more) alias MRs in the AS which each allow access to a portion of
> > the IOMMU MR?
>=20
> For these questions, again I don't know whether it'll affect how we
> design a notifier mechanism to the remapping unit... Would it really?
> Or maybe I missed anything?
>=20
> Till now, after I know the case for SPAPR you have explained [1]
> (thanks btw!), could I say that these multiple IOMMU windows still be
> backed by some unified hardware in the PCI host bridge? Can that be
> the so-called single "IOMMU" object behind that device? And, would it
> possible that we might have similar requirement in the future just
> like what Yi has met with virt-svm? (I don't know whether Power would
> support SVM or similar, but I guess ARM should support it?)

Well, yes, as I've said the two IOMMU windows in sPAPR are the same
IOMMU in the sense that they're implemented by basically the same
logic in the host bridge.

But what consitutes one or multiple IOMMUs all depends on your
definitions, and I'm still not understanding what about your structure
impacts on the notifier design.

> I am just thinking how we can define a better and general (for all
> platforms) IOMMU model in QEMU that can best suite our needs. And
> currently that should be a model that can satisfy Yi's requirement.

I'm still trying to wrap my head around what those requirements are.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sMZCuqyhuhd4ycTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJ71mAAoJEGw4ysog2bOSQvgQAKzZHusW/XL4GvgwsCpsGH5N
EmV22WE/78kNoaBs34eBViXOGaFxxIe/j86s5nH9mBafqdmfAdmwFHnly4Hnaq+E
c/u9l+XYRM9T3nOwf5al99pOGu4rER/tP7s1J3KUnjb5ZpEFQ211lV8fvc07IAXJ
pxFfF0RDC56A6h2d0CXDe3IMP3OJQz9TCxLdaKpCQPjbCIukE/4LzGsRyZca2COb
7MbGMsRNDT4CMdPAbxsr7qII4+axMLDHwL+j+hCJcmQnFM8englL3jN/KrhI/MAE
K1vvkKJXMHw/sN8CLeWWwiCEUNCPYN7N8bfxjSYSrbJdfCVhEDwBiKupmBRSF6DI
/nCBTUHlZjbMiHXiNYkB/MN3rivpVmYsXEA8iDeUGy1LxqQ4o4xyJos5MajtzExi
SsJFsgUrS4ZIKuc8R5+ANHu/9elp+714dTfOOYZFJ8itvfZbCcQnB3biaCxW7Dal
926hbClmoAV/snc/4Gno9k633DwYbrI7lmVqin+1ZVzz9F0/r9iWiFDKZD9blBIE
zJFSLBnOs5Klge7pC/z98GlwphAQrC+2KDPFpseDEpxXWWtGxxqqvy6643B5/uWa
jyapwwsBnEXFNl/Mf7ZMQe4lbXQ78uRLg8I5UMYI30GO2e5QdFTTNWLrSplbomgf
cb92DwEFNuMqVKFJ45e/
=XZLU
-----END PGP SIGNATURE-----

--sMZCuqyhuhd4ycTi--
