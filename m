Received: from eggs.gnu.org ([2001:4830:134:3::10]:49626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ceCLG-0002Tt-FR
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ceCLC-0002fi-NT
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:02:46 -0500
Date: Thu, 16 Feb 2017 13:48:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170216024842.GQ12369@umbus.fritz.box>
References: <20170209041634.GC14524@umbus>
	<95706652-0a80-92fc-951b-7a454d496ddf@redhat.com>
	<20170210003746.GP27610@umbus.fritz.box>
	<5ea3785c-b979-8b8c-3ab0-243d69384697@redhat.com>
	<20170213043307.GT25381@umbus>
	<45446029-e404-77d4-754e-5541a506bb7c@redhat.com>
	<20170214041532.GF2169@umbus.fritz.box>
	<c0e368b1-c89d-ef5a-d475-c92266d3eb41@redhat.com>
	<20170215014544.GC12369@umbus.fritz.box>
	<22b4c89b-bfeb-e196-73c3-927115398e5e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0pkK7MCEo5hACTvx"
Content-Disposition: inline
In-Reply-To: <22b4c89b-bfeb-e196-73c3-927115398e5e@redhat.com>
Subject: Re: [Qemu-devel] [RFC] virtio-pci: Allow PCIe virtio devices on
 root bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, abologna@redhat.com, lvivier@redhat.com, thuth@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, kraxel@redhat.com, Eduardo Habkost <ehabkost@redhat.com>


--0pkK7MCEo5hACTvx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2017 at 04:59:33PM +0200, Marcel Apfelbaum wrote:
> On 02/15/2017 03:45 AM, David Gibson wrote:
> > On Tue, Feb 14, 2017 at 02:53:08PM +0200, Marcel Apfelbaum wrote:
> > > On 02/14/2017 06:15 AM, David Gibson wrote:
> > > > On Mon, Feb 13, 2017 at 12:14:23PM +0200, Marcel Apfelbaum wrote:
> > > > > On 02/13/2017 06:33 AM, David Gibson wrote:
> > > > > > On Sun, Feb 12, 2017 at 09:05:46PM +0200, Marcel Apfelbaum wrot=
e:
> > > > > > > On 02/10/2017 02:37 AM, David Gibson wrote:
> > > > > > > > On Thu, Feb 09, 2017 at 10:04:47AM +0100, Laszlo Ersek wrot=
e:
> > > > > > > > > On 02/09/17 05:16, David Gibson wrote:
> > > > > > > > > > On Wed, Feb 08, 2017 at 11:40:50AM +0100, Laszlo Ersek =
wrote:
> > > > > > > > > > > On 02/08/17 07:16, David Gibson wrote:
> > > > > > > > > > > > Marcel,
> > > > > > > > > > > >=20
> > > > > > > > > > > > Your original patch adding PCIe support to virtio-p=
ci.c has the
> > > > > > > > > > > > limitation noted below that PCIe won't be enabled i=
f the device is on
> > > > > > > > > > > > the root bus (rather than under a root or downstrea=
m port).  As
> > > > > > > > > > > > reasoned below, I think removing the check is corre=
ct, even for x86
> > > > > > > > > > > > (though it would rarely be useful there).  But I co=
uld well have
> > > > > > > > > > > > missed something.  Let me know if so...
> > > > > > > > > > > >=20
> > > > > > > > > > > >=20
> > > > > > > > > > > >=20
> > > > > > > > > > > > Virtio devices can appear as either vanilla PCI or =
PCI-Express devices
> > > > > > > > > > > > depending on the bus they're connected to.  At the =
moment it will only
> > > > > > > > > > > > appear as vanilla PCI if connected to the root bus =
of a PCIe host bridge.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Presumably this is to reflect the fact that PCIe de=
vices usually need to
> > > > > > > > > > > > be connected to a root (or further downstream) port=
 rather than directly
> > > > > > > > > > > > on the root bus.  However, due to the odd requireme=
nts of the PAPR spec on the 'pseries'
> > > > > > > > > > > > machine type, it's normal for PCIe devices to appea=
r on the root bus
> > > > > > > > > > > > without root ports.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Further, even on x86, there's no inherent reason we=
 couldn't present a
> > > > > > > > > > > > virtio device as an "integrated device" (typically =
used for things built
> > > > > > > > > > > > into the PCI chipset), and those devices *do* typic=
ally appear on the root
> > > > > > > > > > > > bus.
> > > > > > > > > > >=20
> > > > > > > > > > > I'm not personally making a counter-argument, just qo=
uting some of
> > > > > > > > > > > the relevant parts of "docs/pcie.txt" ("PCI EXPRESS G=
UIDELINES"):
> > > > > > > > > >=20
> > > > > > > > > > So, an earlier discussion more or less concluded that t=
he PCIe
> > > > > > > > > > guidelines don't really work with PAPR guests.  That co=
mes because
> > > > > > > > > > PAPR was designed with PowerVM in mind which allows PCI=
 passthrough
> > > > > > > > > > but doesn't do any emulated PCI devices.  So they wante=
d to present
> > > > > > > > > > passed through devices (virtual or phyical) to the gues=
t without
> > > > > > > > > > inserting virtual root ports.
> > > > > > > > > >=20
> > > > > > > > > > Now, you can argue that this was a silly decision in PA=
PR, and you
> > > > > > > > > > could well be right, but there it is.
> > > > > > > > >=20
> > > > > > > > > I can totally accept this, but then we should state it as=
 a fact near
> > > > > > > > > the top of "docs/pcie.txt".
> > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > > > Place only the following kinds of devices directly =
on the Root Complex:
> > > > > > > > > > > >     (1) PCI Devices (e.g. network card, graphics ca=
rd, IDE controller),
> > > > > > > > > > > >         not controllers. Place only legacy PCI devi=
ces on
> > > > > > > > > > > >         the Root Complex. These will be considered =
Integrated Endpoints.
> > > > > > > > > > > >         Note: Integrated Endpoints are not hot-plug=
gable.
> > > > > > > > > > > >=20
> > > > > > > > > > > >         Although the PCI Express spec does not forb=
id PCI Express devices as
> > > > > > > > > > > >         Integrated Endpoints, existing hardware mos=
tly integrates legacy PCI
> > > > > > > > > > > >         devices with the Root Complex.
> > > > > > > > > >=20
> > > > > > > > > > "Mostly".. on my laptop at least the GPU shows up as an=
 integrated PCI
> > > > > > > > > > Express endpoint, so it's certainly not the case that *=
all* root bus
> > > > > > > > > > devices are legacy.
> > > > > > > > > >=20
> > > > > > > > > > > Guest OSes are suspected to behave
> > > > > > > > > > > >         strangely when PCI Express devices are inte=
grated
> > > > > > > > > > > >         with the Root Complex.
> > > > > > > > > >=20
> > > > > > > > > > Clearly not that strangely, that often, since my laptop=
 works just fine.
> > > > > > > > > >=20
> > > > > > > > > > > >=20
> > > > > > > > > > > >     [...]
> > > > > > > > > > > >=20
> > > > > > > > > > > > 2.2 PCI Express only hierarchy
> > > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > > > Always use PCI Express Root Ports to start PCI Expr=
ess hierarchies.
> > > > > > > > > > >=20
> > > > > > > > > > > Above you mention "it's normal for PCIe devices to ap=
pear on the root bus without root ports".
> > > > > > > > > >=20
> > > > > > > > > > Well "normal" perhaps wasn't the right word.  Let's say=
 precedented,
> > > > > > > > > > if uncommon.
> > > > > > > > > >=20
> > > > > > > > > > > Let me turn the question around: is it a *problem* fo=
r "pseries" if
> > > > > > > > > > > we require root ports? If so, why exactly?
> > > > > > > > > >=20
> > > > > > > > > > That's.. a complex question.  At least Linux guests (an=
d we don't
> > > > > > > > > > support any others yet) might cope with the addition of=
 root ports.
> > > > > > > > > > Maybe.  I have discussed this option with BenH and othe=
rs.
> > > > > > > > > >=20
> > > > > > > > > > However it is gratuitously different from how PCIe devi=
ces will
> > > > > > > > > > typically appear for the same guest running under Power=
VM.  Although I
> > > > > > > > > > suspect Linux would cope with the "normal standard" rat=
her than "PAPR
> > > > > > > > > > standard" presentation, I'm not as confident about it a=
s I would like.
> > > > > > > > > >=20
> > > > > > > > > > Another consideration here is that other PCIe capable q=
emu emulated
> > > > > > > > > > devices, such as XHCI, will present fine as PCIe integr=
ated endpoints
> > > > > > > > > > when attached to the root bus.  Libvirt won't do that u=
sually, of
> > > > > > > > > > course, and it may not be the recommended way of doing =
things (on PC)
> > > > > > > > > > but it's possible.  I don't see any particular reason t=
hat virtio-pci
> > > > > > > > > > should enforce the root port requirement more so than a=
ny other
> > > > > > > > > > device.
> > > > > > > > > >=20
> > > > > > > > > > > On 02/08/17 07:16, David Gibson wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > pcie_endpoint_cap_init() already automatically adju=
sts to advertise as
> > > > > > > > > > > > an integrated device rather than a "normal" PCIe en=
dpoint when attached to
> > > > > > > > > > > > a root bus.  So we can remove the check for root bu=
s within virtio and
> > > > > > > > > > > > allow (at the user's discretion) a PCIe virtio bus =
to be attached to a
> > > > > > > > > > > > root bus.
> > > > > > > > > > >=20
> > > > > > > > > > > If Marcel thinks this is a good change, then I think =
we should go
> > > > > > > > > > > through "docs/pcie.txt" with a fine-toothed comb, and=
 update all
> > > > > > > > > > > relevant spots. (If Marcel agrees, perhaps you can in=
clude such
> > > > > > > > > > > hunks in your patch at once.)
> > > > > > > > > >=20
> > > > > > > > > > Actually, I think that would be a neverending process. =
 Maybe better
> > > > > > > > > > to put in a whole different spapr-pcie.txt with the ass=
orted ways that
> > > > > > > > > > PAPR violates PCIe conventions.
> > > > > > > > >=20
> > > > > > > > > That works for me too, but I think it would be a lot more=
 work for you
> > > > > > > > > and others.
> > > > > > > > >=20
> > > > > > > > > I plan on consulting "docs/pcie.txt" frequently; among ot=
her things, for
> > > > > > > > > deciding debates. Thus, improving the scope of "docs/pcie=
=2Etxt" is very
> > > > > > > > > welcome IMO.
> > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > > It also may have consequences for libvirt (but I see =
you addressed
> > > > > > > > > > > Andrea at once, which is great).
> > > > > > > > > >=20
> > > > > > > > > > Right, I've been discussed this with Andrea all along. =
 We're working
> > > > > > > > > > on a proposed PAPR specific way of allocating PCI and P=
CIe addresses
> > > > > > > > > > (different from the PCIe normal way, but the same as ea=
ch other).
> > > > > > > > > > That will simplify adding PCIe support to PAPR, and als=
o has some
> > > > > > > > > > other advantages for PAPR guests (related to the platfo=
rm specific
> > > > > > > > > > isolation, hotplug  and error recovery mechanisms - als=
o different
> > > > > > > > > > from the normal PCIe ones).
> > > > > > > > >=20
> > > > > > > > > Great, if Andrea is aware, that's a relief.
> > > > > > > > >=20
> > > > > > > > > Can you resubmit this patch with a small hunk for "docs/p=
cie.txt" that
> > > > > > > > > removes PAPR from the scope?
> > > > > > > >=20
> > > > > > >=20
> > > > > > > Hi David,
> > > > > > > Sorry for the delay, I just came back from PTO.
> > > > > > >=20
> > > > > > > > Well, first I'd like to see if Marcel knows of some reason =
I didn't
> > > > > > > > think of why this test is important for virtio particularly=
 here.  But
> > > > > > > > assuming the basic idea is acceptable, then yes, I'll updat=
e pcie.txt.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > There are two reasons for keeping virtio Integrated Endpoints=
 as PCI devices.
> > > > > > > 1. The first point is generic; even if having PCIe devices as=
 Integrated Endpoints should be OK,
> > > > > > >    is not recommended because some guests may miss-behave (*)=
=2E X86 arch supports a large number
> > > > > > >    of guests and we don't want to check and fix everything if=
 *we don't have to*.
> > > > > > >    Even if is not written anywhere and there are actually som=
e PCI Express Integrated Endpoints,
> > > > > > >    most of them are legacy PCI devices (I actually think this=
 is why we have Integrated Endpoints
> > > > > > >    at all, but I might be wrong).
> > > > > >=20
> > > > > > Hm, ok.  Could we implement that restriction in the pci/pcie co=
re
> > > > > > rather than in the virtio device?
> > > > >=20
> > > > > I am not sure if we should do that. Most of the devices are PCI o=
r PCIe.
> > > > > Only some devices are "hybrid", the virtio devices, XHCI and I am=
 not sure we have more.
> > > >=20
> > > > Ok, I see your point, the pcie core might not be right.  But it sti=
ll
> > > > seems really weird to have it explicitly in each hybrid device, even
> > > > if it's just the two.  As the code stands right now, XHCI and virtio
> > > > have different behaviour, without a clear reason for it.
> > > >=20
> > >=20
> > > I suppose XHCI can behave the same as virtio if Gerd has nothing agai=
nst it
> > > (remain PCI if plugged into the Root Complex), but I don't know how i=
t will help your case.
> >=20
> > > > Maybe a hybrid_setup() helper function?
> > > >=20
> > >=20
> > > How would it help PAPR scenario?
> >=20
> > It doesn't, directly, but it means there would only be a single place
> > to fix with a PAPR hack, instead of both virtio and XHCI and any
> > future hybrid devices.
> >=20
> > > Anyway, Eduardo is working on supplying
> > > new query interfaces for libvirt and he touches this subject, I think
> > > he does plan to mark the hybrid devices in some way.
> > >=20
> > >=20
> > > > > > That would then protect things like
> > > > > > XHCI as well.
> > > > >=20
> > > > > I don't see a reason to have XHCI as Integrated Endpoint, I think=
 it should be always
> > > > > plugged into a root port. (for x86. arm and power)
> > > >=20
> > > > No, not for Power.  Well, ok, yes for most ppc machine types, but n=
ot
> > > > for the paravirtualized 'pseries' machine (which is the one we most
> > > > care about).
> > > >=20
> > > > Well.. I guess it doesn't need to be an Integrated Endpoint per se,
> > > > but we should be able to have it appear on the guest root bus.
> > > >=20
> > > > The thing to realize is that the paravirtualized PCI interfaces in
> > > > PAPR mean there's very little guest visible difference between PCI =
and
> > > > PCIe.  In fact in most ways you could say that the paravirtualized =
bus
> > > > operates like a vanilla PCI bus.. except that it does provide a way=
 to
> > > > access PCIe extended config space.
> > >=20
> > > Maybe we can have a new bus type deriving from PCIBus and sibling of =
the PCIe Bus.
> > > Then we can have the same rules as the PCI bus and add tweaks when
> > > necessary.
> >=20
> > Sounds possible.  I guess it would need to return true for
> > pci_bus_is_express(), so that PCIe devices will attach to it.  In
> > which case I'm not entirely sure how it would differ from a PCIe bus
> > from the qemu side.  AFAICT with the exception of the virtio check and
> > maybe a handful of others, the PCIe placement rules are handled by
> > libvirt, rather than by qemu.
> >=20
> > > This does not solve the virtio problem since the code is actively loo=
king for
> > > a PCIe Root Port and we don't have it for PAPR.
> >=20
> > Technically, it's not even looking for a root port, just excluding
> > being on the root bus itself.  I guess any kind of bridge that has
> > something PCI-ish on the upstream side and PCIe on the downstream side
> > more or less has to be either a root port or a PCIe switch downstream
> > port, though.
> >=20
> > >   Which means that you can use it to
> > > > drive PCIe devices just fine.  "Bus level" PCIe extensions like AER
> > > > and PCIe standard hotplug won't work, but PAPR has its own mechanis=
ms
> > > > for those (common between PCI and PCIe).
> > > >=20
> > > > I did float the idea of having the pseries PCI bus remain plain PCI
> > > > but with a special flag to allow PCIe devices to be attached to it
> > > > anyway.  It wasn't greeted with much enthusiasm..
> > > >=20
> > >=20
> > > Can you point me to the discussion please? It seems similar to what I=
 proposed above.
> >=20
> > Sorry, I was misleading.  I think I just raised that idea with Andrea
> > and a few other people internally, not on one of the lists at large.
> >=20
> > > As you properly described it, is much closer to PCI then PCIe, even t=
he only characteristic
> > > that makes it "a little" PCIe, the Extended Configuration Space suppo=
rt,
> > > is done with an alternative interface.
> > >=20
> > > I agree the PAPR bus is not PCIe.
> >=20
> > Ok, so if we take that direction, the question becomes how do we let
> > PCIe devices plug into this mostly-not-PCIe bus.  Maybe introduce a
> > "pci_bus_accepts_express()" function that will replace many, but not
> > all current uses of "pci_bus_is_express()"?
> >=20
>=20
> Sounds good and I think Eduardo is already working on exactly this
> idea, however he is on PTO now. It is better to synchronize with him.

Ah, right.  Do you know when he'll be back?  This is semi-urgent for
Power.


> > Such a helper could maybe simplify the logic in virtio-pci (and XHCI?)
> > by returning false on an x86 root bus.
> >=20
>=20
> The rule would me more complicated. We don't want to completely remove the
> possibility to have PCIe devices as part of Root Complex. it seems
> like I am contradicting myself, but no).
> This is why we have guidelines and  not hard-coded policies.
> Also ,the QEMU way is to be more permissive. We provide guidelines and sa=
ne
> defaults, but we let the user to chose.
>=20
> Getting back to our problem, the rule would be:
> hybrid devices should be PCI or PCIe for a bus?
> PAPR bus should return 'PCIe' for hybrid devices.
> X86 bus should return 'PCIe' if not root.

Ok.

> > > > >   And for my purposes it would also make it easier to
> > > > > > implement aa machine type specific hook to re-allow that config=
uration
> > > > > > on pseries.
> > > > >=20
> > > > > I agree we need a solution for PAPR.
> > > > >=20
> > > > > What about a pcie_papr() function and then:
> > > > >=20
> > > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > > > index 5ce42af..2c646ae 100644
> > > > > --- a/hw/virtio/virtio-pci.c
> > > > > +++ b/hw/virtio/virtio-pci.c
> > > > > @@ -1804,7 +1804,7 @@ static void virtio_pci_realize(PCIDevice *p=
ci_dev, Error **errp)
> > > > >          return;
> > > > >      }
> > > > >=20
> > > > > -    if (pcie_port && pci_is_express(pci_dev)) {
> > > > > +    if ((pcie_port || pcie_parp()) && pci_is_express(pci_dev)) {
> > > > >          int pos;
> > > > >=20
> > > > >          pos =3D pcie_endpoint_cap_init(pci_dev, 0);
> > > >=20
> > > > That would be sufficient, yes, so I'll take it if we don't come to =
any
> > > > other solutions.
> > >=20
> > > OK
> > >=20
> > >  It still seems weird to me to have this logic within
> > > > a specific device implementation though.
> > > >=20
> > >=20
> > > I suppose you have a point, let's wait for Gerd and maybe Michael to =
comment
> > > on that, but anyway it will not help your case. (it will only make XH=
CI PCI if plugged into Root Complex)
> >=20
> > It won't help directly, but it means we could put that pcie_papr()
> > test in just the common code, rather than having to look at every
> > hybrid and PCIe device.
> >=20
> > > > > >=20
> > > > > > At the moment XHCI and virtio-pci behave differently, which see=
ms less
> > > > > > than ideal.
> > > > > >=20
> > > > > > > 2. The second point is virtio specific. Not all the guests ha=
ve virtio 1.0 support (e.g RHEL 6) and we allow them
> > > > > > >    to use legacy virtio devices as Integrated Endpoints (foll=
owing the thought that this is why we have Integrated Endpoints)
> > > > > > >    Making the virtio devices PCI Express, but not virtio 1.0 =
is also problematic since now we will have too much
> > > > > > >    types of virtio devices. We want to keep it simple: virtio=
 legacy
> > > > > > >    -> PCI, virtio modern -> PCIe.
> > > > > >=20
> > > > > > Ok.. it's not obvious to me why integrated endpoint vs. under a=
 root
> > > > > > port is relevant to this.  Can't we enable/disable PCIe mode ba=
sed
> > > > > > directly on the legacy/modern settings?
> > > > > >=20
> > > > >=20
> > > > > Yes, we can, but we don't want to do that. Previous setups will s=
top working
> > > > > and we will need libvirt to mange the disable-* properties.
> > > > > As a matter of fact the code today is after some discussions with=
 libvirt guys.
> > > >=20
> > > > Uh.. I think I'm missing something.. but it's still not clear to me
> > > > why this would break existing setups or impose more work on libvirt.
> > > >=20
> > >=20
> > > Long story short, libvirt guys don't want to manually set the disable=
-* properties
> > > of virtio devices to make them comply to our goal (legacy -> PCI, mod=
ern PCIe).
> > > They also don't want to look at QEMU version/machine type to make a d=
ecision on the above properties.
> > >=20
> > > I agree the solution is not perfect, but at least it makes our testin=
g matrix smaller
> > > and makes our PCIe guidelines a little easier to understand (e.g. all=
 supported devices are PCIe,
> > > but if want legacy PCI devices put them on the Root Complex)
> >=20
> > Ok.. I'm still missing something.  Are you saying that instead of the
> > legacy/modern status determining PCIe support, that PCIe status is
> > determining legacy/modern support by default?
>=20
> Is more a guideline. We want QEMU to behave like this *by default*.
> The modern spec does not require virtio 1.0 devices to be PCIe.

Ok.  But I'm trying to get a handle on how - even by default - the
linkage between PCI/PCIe and modern/legacy is created:  it's not
obvious to me.

>   That would actually
> > seem to simplify things: whatever method we end up allowing PCIe
> > virtio on PAPR, that should automatically enable modern mode, which is
> > fine.
> >=20
>=20
> Agreed.
>=20
> > Although.. I do wonder about legacy/modern for PAPR in general.
> > Current kernels will support virtio 1.0 fine, but we have older
> > released versions which only support legacy.
>=20
> So, do you want legacy virtio devices to be PCIe ?

TBH, we probably don't care one way or another.

I'm not clear here if you're making a distinction between legacy-only
and legacy+modern virtio instances.

I think we need to keep legacy support on for Power machines, because
we don't have the machine type switchover to let us handle it.  But we
certainly would like to enable modern support so that newer guests can
exploit it.

>   Unlike PC we won't (I
> > hope) have a whole machine type switch to handle this.
>=20
> Good for you!
>=20
>   At this stage
> > I think we want virtio devices (whatever their bus type) on PAPR to
> > default to allowing both legacy and modern for the forseeable future.
> > How does that affect the matrix?
> >=20
>=20
> It adds a legacy virtio PCIe device to the matrix. For X86 we don't need
> this combination because PC machines are PCI and Q35 machines are to be u=
sed
> only on modern setups.
>=20
> Since PARP does not have separate machines for PCi and PCIe, we need to l=
ive with it.
>=20
>=20
> > > XHCI being PCIe on Root Complex is an unintended exception, but we wa=
nt it connected to a
> > > Root Port anyway, we don't have anything to gain from having it as In=
tegrated Endpoint.
> > > We only loose a slot that can be used by 8 Root Ports assembled into =
one multi-function device.
> > >=20
> > > PAPR bus should not be considered PCIe and should have a different se=
t of rules allowing PCIe
> > > devices to be plugged into Root Complex.
> >=20
> > Alright, I can work with that.  Michael, Andrea, how does this idea
> > seem to you?
> >=20
>=20
> We should definitely get more opinions.
> Thanks,
> Marcel
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0pkK7MCEo5hACTvx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYpRMIAAoJEGw4ysog2bOSvksP/275niEmkfVfwb3XCkvm4IMu
OL4cJNpauD90bZ7n1dPTgAPdOaJVdCYLV6w+5orb00yx4s+NAkIJEqQhQA67txcV
dQMP4EXlUtsnSIfIUOPPtFY75MItoMuwIn3XHvTSCnIX6IIUhUlLI7j9vx7n8U/Q
x+2BR+GlWMSO3T4brKx9KgvAuhXrVzXiUoXFMK4ZMp4RMk3noBqoZX4GgmR932ei
aGUMB5AAWiTkreb6eqX7XJgV0sp+qCujbpvvQ2cfLUhL6Gfk7cvX4dUzhCCO2n4W
kJjRz7XRO3uQ/RycJHXaNiRDJfyjjTLD6vcbYOf7/XxpQaelMAXX7Ld51Cp6rwoC
RvDIEhUrJMKGDmBzOdnIzaJLspvvsKcrMXgEXFrxOXYekEEscWh93kUyI9CTxqRL
lR35BaTyKdzM6huWPiNfizRbH6ce3gM5gZv0QgE4MzS82ecrVuKrIjY9AbZCSd17
ciWV3rngn9xdkQLK/KEe1iBNYYsWNC04q086XStMlEgi8Cfa0sAMDAVFY9lv1NMt
rhFUZ8ZMeIZC9X491VMSlFSsDC41k3Qnm/Up6kk/fKEDo6KSKV6DbhyXbhPCGf9s
A7e75K0onNMaqnMndimTGyEkIz0AbO6wT0/9ooU3k0480hJODgZ7pEU0GlqGkwAi
u469dwuCPaNnY9QlDRHz
=15/m
-----END PGP SIGNATURE-----

--0pkK7MCEo5hACTvx--
