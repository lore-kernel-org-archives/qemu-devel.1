Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75722C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A62F20828
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A62F20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuDES-00037l-Sm
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 05:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iuDBa-0008G1-NU
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iuDBY-00011Y-K9
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:24:34 -0500
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:44524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iuDBY-0000Sp-78
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:24:32 -0500
Received: from player776.ha.ovh.net (unknown [10.109.143.238])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id C6B6E1207BC
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 11:06:36 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player776.ha.ovh.net (Postfix) with ESMTPSA id E6815E8CC264;
 Wed, 22 Jan 2020 10:06:22 +0000 (UTC)
Date: Wed, 22 Jan 2020 11:06:18 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr: Migrate CAS reboot flag
Message-ID: <20200122110618.755dc504@bahia.lan>
In-Reply-To: <20200122065028.GK2347@umbus.fritz.box>
References: <ed2df775-b4d5-4ea7-ccf6-637c037f897b@redhat.com>
 <20200116094848.555c170d@bahia.lan>
 <2dda458a-dfa1-ab23-4a97-d27d9266226b@redhat.com>
 <20200116131435.3985e86e@bahia.lan>
 <20200116192902.63674769@bahia.lan> <20200117091608.GV54439@umbus>
 <20200117164427.2c238412@bahia.lan>
 <20200120090438.75ff9e65@bahia.lan>
 <20200121034332.GC265522@umbus.fritz.box>
 <20200121103255.6a25aaa9@bahia.lan>
 <20200122065028.GK2347@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U4xqLZ9qfK2+Wi=EDlbe_S8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 2208452671290776038
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrvddtgddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.37.72
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Lukas Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/U4xqLZ9qfK2+Wi=EDlbe_S8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jan 2020 17:50:28 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jan 21, 2020 at 10:32:55AM +0100, Greg Kurz wrote:
> > On Tue, 21 Jan 2020 14:43:32 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Mon, Jan 20, 2020 at 09:04:38AM +0100, Greg Kurz wrote:
> > > > On Fri, 17 Jan 2020 16:44:27 +0100
> > > > Greg Kurz <groug@kaod.org> wrote:
> > > >=20
> > > > > On Fri, 17 Jan 2020 19:16:08 +1000
> > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >=20
> > > > > > On Thu, Jan 16, 2020 at 07:29:02PM +0100, Greg Kurz wrote:
> > > > > > > On Thu, 16 Jan 2020 13:14:35 +0100
> > > > > > > Greg Kurz <groug@kaod.org> wrote:
> > > > > > >=20
> > > > > > > > On Thu, 16 Jan 2020 11:37:24 +0100
> > > > > > > > Laurent Vivier <lvivier@redhat.com> wrote:
> > > > > > > >=20
> > > > > > > > > On 16/01/2020 09:48, Greg Kurz wrote:
> > > > > > > > > > On Wed, 15 Jan 2020 19:10:37 +0100
> > > > > > > > > > Laurent Vivier <lvivier@redhat.com> wrote:
> > > > > > > > > >=20
> > > > > > > > > >> Hi,
> > > > > > > > > >>
> > > > > > > > > >> On 15/01/2020 18:48, Greg Kurz wrote:
> > > > > > > > > >>> Migration can potentially race with CAS reboot. If th=
e migration thread
> > > > > > > > > >>> completes migration after CAS has set spapr->cas_rebo=
ot but before the
> > > > > > > > > >>> mainloop could pick up the reset request and reset th=
e machine, the
> > > > > > > > > >>> guest is migrated unrebooted and the destination does=
n't reboot it
> > > > > > > > > >>> either because it isn't aware a CAS reboot was needed=
 (eg, because a
> > > > > > > > > >>> device was added before CAS). This likely result in a=
 broken or hung
> > > > > > > > > >>> guest.
> > > > > > > > > >>>
> > > > > > > > > >>> Even if it is small, the window between CAS and CAS r=
eboot is enough to
> > > > > > > > > >>> re-qualify spapr->cas_reboot as state that we should =
migrate. Add a new
> > > > > > > > > >>> subsection for that and always send it when a CAS reb=
oot is pending.
> > > > > > > > > >>> This may cause migration to older QEMUs to fail but i=
t is still better
> > > > > > > > > >>> than end up with a broken guest.
> > > > > > > > > >>>
> > > > > > > > > >>> The destination cannot honour the CAS reboot request =
from a post load
> > > > > > > > > >>> handler because this must be done after the guest is =
fully restored.
> > > > > > > > > >>> It is thus done from a VM change state handler.
> > > > > > > > > >>>
> > > > > > > > > >>> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.c=
om>
> > > > > > > > > >>> Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > > > > > >>> ---
> > > > > > > > > >>>
> > > > > > > > > >>
> > > > > > > > > >> I'm wondering if the problem can be related with the f=
act that
> > > > > > > > > >> main_loop_should_exit() could release qemu_global_mute=
x in
> > > > > > > > > >> pause_all_vcpus() in the reset case?
> > > > > > > > > >>
> > > > > > > > > >> 1602 static bool main_loop_should_exit(void)
> > > > > > > > > >> 1603 {
> > > > > > > > > >> ...
> > > > > > > > > >> 1633     request =3D qemu_reset_requested();
> > > > > > > > > >> 1634     if (request) {
> > > > > > > > > >> 1635         pause_all_vcpus();
> > > > > > > > > >> 1636         qemu_system_reset(request);
> > > > > > > > > >> 1637         resume_all_vcpus();
> > > > > > > > > >> 1638         if (!runstate_check(RUN_STATE_RUNNING) &&
> > > > > > > > > >> 1639                 !runstate_check(RUN_STATE_INMIGRA=
TE)) {
> > > > > > > > > >> 1640             runstate_set(RUN_STATE_PRELAUNCH);
> > > > > > > > > >> 1641         }
> > > > > > > > > >> 1642     }
> > > > > > > > > >> ...
> > > > > > > > > >>
> > > > > > > > > >> I already sent a patch for this kind of problem (in cu=
rrent Juan pull
> > > > > > > > > >> request):
> > > > > > > > > >>
> > > > > > > > > >> "runstate: ignore finishmigrate -> prelaunch transitio=
n"
> > > > > > > > > >>
> > > > > > > > > >=20
> > > > > > > > > > IIUC your patch avoids an invalid 'prelaunch' -> 'postm=
igrate' runstate
> > > > > > > > > > transition that can happen if the migration thread sets=
 the runstate to
> > > > > > > > > > 'finishmigrate' when pause_all_vcpus() releases the mai=
n loop mutex.
> > > > > > > > > >=20
> > > > > > > > > > ie. symptom of the problem is QEMU aborting, correct ? =
The issue I'm
> > > > > > > > > > trying to fix is a guest breakage caused by a discrepan=
cy between
> > > > > > > > > > QEMU and the guest after migration has succeeded.
> > > > > > > > > >=20
> > > > > > > > > >> but I don't know if it could fix this one.
> > > > > > > > > >>
> > > > > > > > > >=20
> > > > > > > > > > I don't think so and your patch kinda illustrates it. I=
f the runstate
> > > > > > > > > > is 'finishmigrate' when returning from pause_all_vcpus(=
), this means
> > > > > > > > > > that state was sent to the destination before we could =
actually reset
> > > > > > > > > > the machine.
> > > > > > > > >=20
> > > > > > > > > Yes, you're right.
> > > > > > > > >=20
> > > > > > > > > But the question behind my comment was: is it expected to=
 have a pending
> > > > > > > > > reset while we are migrating?
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Nothing prevents qemu_system_reset_request() to be called w=
hen migration
> > > > > > > > is active.=20
> > > > > > > >=20
> > > > > > > > > Perhaps H_CAS can return H_BUSY and wait the end of the m=
igration and
> > > > > > > > > then be fully executed on destination?
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > And so we would need to teach SLOF to try H_CAS again until=
 it stops
> > > > > > > > returning H_BUSY ? It seems safer to migrate the CAS reboot=
 flag IMHO.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > Ok I've tried that with a patched SLOF that sleeps 500ms and =
tries CAS
> > > > > > > again if H_BUSY was returned. It fixes the issue but it looks=
 a bit
> > > > > > > ugly because of the polling with an arbitrary timeout in SLOF=
... I'm
> > > > > > > not very comfortable either with calling migration_is_active(=
) from
> > > > > > > the CAS code in QEMU.
> > > > > > >=20
> > > > > > > David,
> > > > > > >=20
> > > > > > > Any suggestion ?
> > > > > >=20
> > > > > > Yeah, I think looping in SLOF is a worse idea than migrating the
> > > > > > cas_reboot flag.
> > > > > >=20
> > > > > > But.. a better solution still might be to just remove the remai=
ning
> > > > > > causes for CAS reboot entirely.  CAS reboots pretty much suck w=
hen
> > > > > > they happen, anyway.
> > > > > >=20
> > > > >=20
> > > > > I Agree.
> > > > >=20
> > > > > > With the irq changeover condition removed, I think the remaining
> > > > > > causes are more theoretical than practical situations at this p=
oint.
> > > > > >=20
> > > > >=20
> > > > > FWIW, hotpluggging a PCI device before CAS result in a hung guest=
 (not yet
> > > > > investigated the details).
> > > >=20
> > > > commit 10f12e6450407b18b4d5a6b50d3852dcfd7fff75
> > > > Author: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > > > Date:   Wed Aug 30 15:21:41 2017 -0300
> > > >=20
> > > >     hw/ppc: CAS reset on early device hotplug
> > > >=20
> > > > I'll have a look to see what can be done here.
> > >=20
> > > Ah.. yes, that one might be a bit tricky.
> > >=20
> >=20
> > So far it seems to be related to SLOF not being able to create
> > new nodes in the DT when parsing the FDT returned by CAS. SLOF
> > stops the parsing and returns an error. The guest ends up with
> > a broken DT and eventually hangs later (in my case the kernel
> > believes it is going to do hash while radix was negotiated with
> > QEMU). I need to dig some more.
>=20
> Uh... I don't think this is right.  I'm pretty sure SLOF *does* create
> new nodes when parsing the CAS FDT, it will need to for
> "ibm,dynamic-reconfiguration-memory" at least.
>=20

It can create "memory@" or "ibm,dynamic-reconfiguration-memory" nodes but
explicitly rejects all others.

> I've done some looking and I think the actual reasons here are a bit
> more complicated (but also possibly easier to handle).
>=20
>   1. We can't send hotplug events to the guest until after CAS,
>      because before then we don't know if it can process them, or if
>      it can, which interrupt it uses for them.
>=20
>   2. Queueing hotplug events across CAS for delivery afterwards
>      introduces other complications
>=20
>   3. We need to make sure that each device appears exactly once in
>      either the  initial device tree that the guest OS sees, *or* in a
>      hotplug event, not both or neither.
>=20
> Now that we rebuild the DT at CAS time, I think we mightd be able toy
> handle this by converting such devices to "cold plugged" at CAS time
> (similarly to what we already do at reset).  Since they're in the
> CAS-time DT which is what the OS will consume, cold plugged is
> effectively how the OS will see them.
>=20

I have tried hacking around to achieve that. Basically calling
spapr_drc_reset() for all DRCs for which spapr_drc_needed()
returns true.

> A remaining problem is that new PCI devices won't get BARs assigned by
> SLOF in this scenario.  We'll probably get away with it because of the
> linux,pci-probe-only property, but I don't know we want to rely on

We currently only expose this property for pseries-4.2 and newer
machine types... this could be a problem.

> that.  PCI bridges hotplugged introduce further complications, because
> they won't get enumerated.
>=20
> > > > But I agree the other check is more theoretical:
> > > >=20
> > > >     /* capabilities that have been added since CAS-generated guest =
reset.
> > > >      * if capabilities have since been removed, generate another re=
set
> > > >      */
> > > >     spapr->cas_reboot =3D !spapr_ovec_subset(ov5_cas_old, spapr->ov=
5_cas);
> > > >=20
> > > > Unless changing kernels or tempering with the kernel command line, =
I don't
> > > > see how some capabilities could change between the two CAS in pract=
ice.
> > >=20
> > > Well, we want to be robust and it's at least theoretically possible
> > > that the guest will request different things on subsequent reboots.
> >=20
> > Yes but in the latter case a full machine reset occurs and
>=20
> Not necessarily.  A guest could ask for something on one CAS cycle,
> then reject it on another, without doing a full reboot.  It'd be a
> pointless thing for the guest to do, but it's possible.
>=20

Ok, I was asking later on if we want to support the scenario of
multiple CAS without an intermediate full reboot. I now have the
answer :)

> > spapr->ov5_cas gets cleared, ie. spapr_ovec_subset() returns
> > true in the check above no matter what.
>=20
> Well, also it could happen if the guest rejects something we put in
> the initial value of ov5_cas (which is populated from spapr->ov5, so
> it's not entirely empty).
>=20

AFAICT the initial value of ov5_cas after a full machine reset is
all zeroes until CAS does:

    /* full range of negotiated ov5 capabilities */
    spapr_ovec_intersect(spapr->ov5_cas, spapr->ov5, ov5_guest);

which is done between:

    ov5_cas_old =3D spapr_ovec_clone(spapr->ov5_cas);

and

    spapr->cas_reboot =3D !spapr_ovec_subset(ov5_cas_old, spapr->ov5_cas);

So I don't quite understand how ov5_cas_old, ie. spapr->ov5_cas at the
time the guest calls CAS, could have an "initial value not entirely
empty"... This can only happen if the guest calls CAS several times
without doing a full reboot in between. My initial thought was to
refuse this scenario and fail any subsequent CAS attempt made by
the guest before a full reboot.

> > > However I believe that the original rationale for this check was that
> > > while we could add things to the device tree for added capabilities,
> > > we didn't have a way to roll back the changes for removed
> > > capabilities.
> > >=20
> >=20
> > IIUC this is specifically for "removed capabilities since last
> > CAS". This can happen if:
> > 1) we're already processing a CAS reboot or,
> > 2) a freshly rebooted guest calls CAS twice without being rebooted
> >    in between.
> >=20
> > Since a freshly booted or rebooted guest can only trigger a CAS
> > reboot because of a "hotplug-before-CAS", if we manage to get rid
> > of this limitation, 1) cannot happen anymore.
> >=20
> > The linux kernel seems to be only calling "ibm,client-architecture-supp=
ort"
> > once during early boot so 2) should _never_ happen. Do we care to suppo=
rt
> > this scenario anyway ?
>=20
> I think you've missed some things in your reasoning.  But it doesn't
> really matter because the full dt rebuilt should handle it anyway.  I
> have a draft patch which removes this cause for CAS reboots.
>=20
> Still grappling with the hotplug-before-CAS case.
>=20

Same here actually. I was struggling with SLOF to have it create new nodes
for hotplugged-before-CAS devices without crashing :-\

I think I'll wait for your patches to arrive :) Please Cc: me.

> > > Now that we fully rebuild the device tree at CAS, I think this test
> > > can probably just go, although there's some double checking to do.
> > >=20
> >=20
> > I tend to agree.
>=20


--Sig_/U4xqLZ9qfK2+Wi=EDlbe_S8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl4oHpoACgkQcdTV5YIv
c9YT3Q//W/9+RGybtCYZ4I/JVC1gAshQEtOGKTf4DhWvAuiM7+LqTOxI4K+qMBgR
twV37ni6Bidv0xaYGg4LtMO6h/dzfWQT31AeEoQxtDzffeQMSWfy6t7qDAGoXR85
LoErHdCaaRTgrirdGSGr/GQNlR/tO38soolLgiI7QXUjyzo6rS9gI4CO3kiwBVzl
wGPWDnv3jhkTAeCGT1wDXYDf0+isWN7JOZ1QsZlEz9etBS3RBhNTev0jncS0ucM7
7H5hAcApjbCetTMwIle9ukykriSQttkkxvJUSc52R3o+IvTMfYt7O5vMJPhay7sU
4wJ/Td0dkPsNfWf9Q/76GqbtDM5nONji8augTM8SVAQ5UOqjXzDs0LmFNzE+JhPX
GSAsojRQlI6YY2Hhb0RjfXpP3n7vWlNAgld1ha/VgprIuPREMXXHjs3bGqQwORRD
eAREFZnzHQRyoc+jTOU3JrS1aYCZt+p6eCD5SmFyhSNnrFowTW01QI58OTmOk7Eg
Az0T8Pk1UV2FRqC/dLw0hXqKZErbdjmEAjYx+nve4He3N3PNqRK61QLlhW+G798f
2AcyCIsVTxLY6qEv+B5hMTDDrR6GLWtjzDL6I0C88GKxZUyn4y1uyKRBTgMVpCLJ
bHcjHlKFZFUVmLQ/thb+W078EVGulZMmryFWEAD+XxYDFDUDg8M=
=tuXj
-----END PGP SIGNATURE-----

--Sig_/U4xqLZ9qfK2+Wi=EDlbe_S8--

