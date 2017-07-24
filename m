Received: from eggs.gnu.org ([2001:4830:134:3::10]:51720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZUR9-0007Ri-Iq
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZUR6-00045Z-JB
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:53:39 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dZUR6-000450-A2
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:53:36 -0400
Received: by mail-pg0-x243.google.com with SMTP id d193so10541428pgc.2
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 20:53:34 -0700 (PDT)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
	<1500436938.3350.11.camel@kernel.crashing.org>
	<20170721075015.GE3717@umbus.fritz.box>
	<1500625291.10674.22.camel@kernel.crashing.org>
	<20170724032853.GB17228@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <efb76aaa-5dd6-ef8e-91b6-ce4a534f9cff@ozlabs.ru>
Date: Mon, 24 Jul 2017 13:53:27 +1000
MIME-Version: 1.0
In-Reply-To: <20170724032853.GB17228@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="K8lIw8NsP7sWKc0lTX4sLEC53vcMoJw8C"
Subject: Re: [Qemu-devel] [RFC PATCH 04/26] ppc/xive: introduce a skeleton
 for the XIVE interrupt controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Alexander Graf <agraf@suse.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K8lIw8NsP7sWKc0lTX4sLEC53vcMoJw8C
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Alexander Graf <agraf@suse.de>
Message-ID: <efb76aaa-5dd6-ef8e-91b6-ce4a534f9cff@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH 04/26] ppc/xive: introduce a skeleton for
 the XIVE interrupt controller model
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
 <1499274819-15607-5-git-send-email-clg@kaod.org>
 <20170719030849.GQ3140@umbus.fritz.box>
 <1500436938.3350.11.camel@kernel.crashing.org>
 <20170721075015.GE3717@umbus.fritz.box>
 <1500625291.10674.22.camel@kernel.crashing.org>
 <20170724032853.GB17228@umbus.fritz.box>
In-Reply-To: <20170724032853.GB17228@umbus.fritz.box>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 24/07/17 13:28, David Gibson wrote:
> On Fri, Jul 21, 2017 at 06:21:31PM +1000, Benjamin Herrenschmidt wrote:=

>> On Fri, 2017-07-21 at 17:50 +1000, David Gibson wrote:
>>> On Wed, Jul 19, 2017 at 02:02:18PM +1000, Benjamin Herrenschmidt wrot=
e:
>>>> On Wed, 2017-07-19 at 13:08 +1000, David Gibson wrote:
>>>>>
>>>>> I'm somewhat uncomfortable with an irq allocater here in the intc
>>>>> code.  As a rule, irq allocation is the responsibility of the machi=
ne,
>>>>> not any sub-component.  Furthermore, it should allocate in a way wh=
ich
>>>>> is repeatable, since they need to stay stable across reboots and
>>>>> migrations.
>>>>>
>>>>> And, yes, we have an allocator of sorts in XICS - it has caused a
>>>>> number of problems in the past.
>>>>
>>>> So....
>>>>
>>>> For a bare metal model (which we don't have yet) of XIVE, the IRQ
>>>> numbering is entirely an artifact of how the HW is configured. There=

>>>> should thus be no interrupt numbers visible to qemu.
>>>
>>> Uh.. I don't entirely follow.  Do you mean that during boot the guest=

>>> programs the irq numbers into the various components?
>>
>> I said a "bare metal model" but yes. Pretty much.=20
>=20
> Right, by "guest" I meant the kernel running under qemu, even if its
> running on a bare-metal equivalent platform.
>=20
>>> In that case this allocator stuff definitely doesn't belong on the
>>> xive code.
>>>
>>>> For a PAPR model things are a bit different, but if we want to
>>>> maximize code re-use between the two, we probably need to make sure
>>>> the interrupts "allocated" by the machine for XIVE can be represente=
d
>>>> by the HW model.
>>>>
>>>> That means:
>>>>
>>>>  - Each chip has a range (high bits are the block ID, which maps to =
a
>>>> chip, low bits, around 512K to 1M interrupts is the per-chip space).=

>>>>
>>>>  - Interrupts 0...N of that range (N depends on how much backing
>>>> memory and MMIO space is provisioned for each chip) are "generic IPI=
s"
>>>> which are somewhat generic interrupt source that can be triggered wi=
th
>>>> an MMIO store and routed to any target. Those are used in PAPR for
>>>> things like IPIs and some type of accelerator interrupts.
>>>>
>>>>  - Portions of that range (which may or may not overlap the 0...N
>>>> above, if they do they "shadow" the generic interrupts) can be
>>>> configured to be the HW sources from the various PCIe bridges and
>>>> the PSI controller.
>>>
>>> Err.. I'm confused how this not sure this relates to spapr.  There ar=
e
>>> no chips or PSI there, and the PCI bridges aren't really the same
>>> thing.
>>
>> The above is the HW model, sorry for the confusion. With a few comment=
s
>> about how they are used in PAPR.
>>
>> So yes, in PAPR there's an "allocator" because the hypervisor will
>> create a guest "virtual" (or logical to use PAPR terminology) interrup=
t
>> number space, in order to represents the various interrupts into the
>> guest.
>=20
> Ok, but are each of those logical irqs bound to a specific device/PHB
> line/whatever, or can they be configured by the guest?
>=20
>> Those numbers however are just tokens, they don't have to represent an=
y
>> real HW concept. So they can be "allocated" in a rather fixed way, for=

>> example, you could have something like a fixed map where you put all
>> the PCI interrupts at a certain number (a factor of the PHB# with room=

>> or a fix number per PHB, maybe 16K or so, the HW does 4K max). Another=

>> based would have a chunk of "general purpose" IPIs (for use for actual=

>> IPIs and for other things to come). And a range for the virtual device=

>> interrupts for example. Or you can just use an allocator.
>=20
> Hm.  So what I'm meaning by an "allocator" is something at least
> partially dynamic.  Something you say "give me an irq" and it gives
> you the next available or similar.  As opposed to any mapping from
> devices to (logical) irqs, which the machine will need to supply one
> way or another.

I am probably reading it wrong but the XIVE's allocator allocates IRQ
ranges for interrupt source controls (which are CPU cores, PHBs, PSI - in=

bare metal - so they allocate just once per machine creation). Individual=

interrupts are still allocated via spapr_ics_alloc_block().



>=20
>> But it's fundamentally an allocator that sits in the hypervisor, so in=

>> our case, I would say in the spapr "component" of XIVE, rather than th=
e
>> XIVE HW model itself.
>=20
> Maybe..
>=20
>> Now what Cedric did, because XIVE is very complex and we need somethin=
g
>> for PAPR quickly, is not a complete HW model, but a somewhat simplifie=
d
>> one that only handles what PAPR exposes. So in that case where the
>> allocator sits is a bit of a TBD...
>=20
> Hm, ok.  My concern here is that "dynamic" allocation of irqs at the
> machine type level needs extreme caution, or the irqs may not be
> stable which will generally break migration.
>=20


--=20
Alexey


--K8lIw8NsP7sWKc0lTX4sLEC53vcMoJw8C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZdW84DhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5I6EQALfO
YC8Gg8+OOAN7rWPp91S08D/J++SBM/0KJ35UQT8FnoW3k2Qzlzclgp05vHdM7nyM
pUxPUQXAfkjagXd3HwfCFozG4MADib/nFmfL4yeWyLRkCGLhKPKcawZlQZlMUjrm
V5wgGnm3TXbN0VvR/A7HIFzVQdPypCpIsDKbV5cUcJdEtQpHOMC+dqHPHs+EkENR
ysmbbGzWWpUC+A2wlh23TQpj3/ooAKtnE6F0la9uqyo8QYTLN0Eha50ZYp1jZSpR
ekP/xWRw4nmK+YESSuKSBgdV+mHXG0hgfI4Eoz4x2kjLXdI7Q9l6ycYDjX+IB2h8
ybyWhVkE4P7pe3BYDKFhSJwY0mflsurvYwk4m/3Wnw0UmeKHgOcwBkRsF3Y26DUq
eWY6puj+948OsO+g+MRlE323iknmfLVfUG4yVPfxGDhlyA29oKpQjG6qy78NPgeG
ZPzBkKhWrupvCbiwN/Qqe/s8v71xWUMxXZumgqgg7DApoig+uTaVLtDhjhav+bPS
DyJaqpNgvIP8hSWocDA55snjqfn/CQPLEl3YL/Gj5DuYQj/vSTYX/ArUUKeEjDKu
ztKvwpU873rxjaQam6XicVRh+imXe7u6YUi/LF8JcB2JhVpV9tv4Jij8hax8AJDc
0+92ysHUF3RreZzDhvggNBApMQWR6cpvaRxlRb11
=H/ro
-----END PGP SIGNATURE-----

--K8lIw8NsP7sWKc0lTX4sLEC53vcMoJw8C--
