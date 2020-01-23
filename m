Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2272C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8304C2467B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SRdbdU7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8304C2467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuUpy-0001F9-Ns
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 00:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iuUn2-0006uZ-Mi
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iuUn0-00083s-7q
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:12:24 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:54419 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iuUmz-00081U-KY; Thu, 23 Jan 2020 00:12:22 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4839PX4mTnz9sSK; Thu, 23 Jan 2020 16:12:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579756336;
 bh=KqXJUqeffjYnCqLiufPAMz0dZDlAYrZOZevxgF0aMnQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SRdbdU7OPPjhWjg6rl5+HPjuXYYFQgc5FAQ+USS/ZDkMcfFNh9F8hz2q/JnSK4/WO
 toteYNpCrMoDCardgDGqUQs+N1OHbTEZNaNCjg/z6tgoOZDohlpMJRWOoxAgQnVkLg
 XxOlWAz+n6acRAx+V0mlw1K2uDq/sT80SjfPrXkM=
Date: Thu, 23 Jan 2020 16:08:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr: Migrate CAS reboot flag
Message-ID: <20200123050840.GN2347@umbus.fritz.box>
References: <2dda458a-dfa1-ab23-4a97-d27d9266226b@redhat.com>
 <20200116131435.3985e86e@bahia.lan>
 <20200116192902.63674769@bahia.lan> <20200117091608.GV54439@umbus>
 <20200117164427.2c238412@bahia.lan>
 <20200120090438.75ff9e65@bahia.lan>
 <20200121034332.GC265522@umbus.fritz.box>
 <20200121103255.6a25aaa9@bahia.lan>
 <20200122065028.GK2347@umbus.fritz.box>
 <20200122110618.755dc504@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U6leaJ20qZQc29iB"
Content-Disposition: inline
In-Reply-To: <20200122110618.755dc504@bahia.lan>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
 qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--U6leaJ20qZQc29iB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2020 at 11:06:18AM +0100, Greg Kurz wrote:
> On Wed, 22 Jan 2020 17:50:28 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Jan 21, 2020 at 10:32:55AM +0100, Greg Kurz wrote:
> > > On Tue, 21 Jan 2020 14:43:32 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > > On Mon, Jan 20, 2020 at 09:04:38AM +0100, Greg Kurz wrote:
> > > > > On Fri, 17 Jan 2020 16:44:27 +0100
> > > > > Greg Kurz <groug@kaod.org> wrote:
> > > > >=20
> > > > > > On Fri, 17 Jan 2020 19:16:08 +1000
> > > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > >=20
> > > > > > > On Thu, Jan 16, 2020 at 07:29:02PM +0100, Greg Kurz wrote:
> > > > > > > > On Thu, 16 Jan 2020 13:14:35 +0100
> > > > > > > > Greg Kurz <groug@kaod.org> wrote:
> > > > > > > >=20
> > > > > > > > > On Thu, 16 Jan 2020 11:37:24 +0100
> > > > > > > > > Laurent Vivier <lvivier@redhat.com> wrote:
> > > > > > > > >=20
> > > > > > > > > > On 16/01/2020 09:48, Greg Kurz wrote:
> > > > > > > > > > > On Wed, 15 Jan 2020 19:10:37 +0100
> > > > > > > > > > > Laurent Vivier <lvivier@redhat.com> wrote:
> > > > > > > > > > >=20
> > > > > > > > > > >> Hi,
> > > > > > > > > > >>
> > > > > > > > > > >> On 15/01/2020 18:48, Greg Kurz wrote:
> > > > > > > > > > >>> Migration can potentially race with CAS reboot. If =
the migration thread
> > > > > > > > > > >>> completes migration after CAS has set spapr->cas_re=
boot but before the
> > > > > > > > > > >>> mainloop could pick up the reset request and reset =
the machine, the
> > > > > > > > > > >>> guest is migrated unrebooted and the destination do=
esn't reboot it
> > > > > > > > > > >>> either because it isn't aware a CAS reboot was need=
ed (eg, because a
> > > > > > > > > > >>> device was added before CAS). This likely result in=
 a broken or hung
> > > > > > > > > > >>> guest.
> > > > > > > > > > >>>
> > > > > > > > > > >>> Even if it is small, the window between CAS and CAS=
 reboot is enough to
> > > > > > > > > > >>> re-qualify spapr->cas_reboot as state that we shoul=
d migrate. Add a new
> > > > > > > > > > >>> subsection for that and always send it when a CAS r=
eboot is pending.
> > > > > > > > > > >>> This may cause migration to older QEMUs to fail but=
 it is still better
> > > > > > > > > > >>> than end up with a broken guest.
> > > > > > > > > > >>>
> > > > > > > > > > >>> The destination cannot honour the CAS reboot reques=
t from a post load
> > > > > > > > > > >>> handler because this must be done after the guest i=
s fully restored.
> > > > > > > > > > >>> It is thus done from a VM change state handler.
> > > > > > > > > > >>>
> > > > > > > > > > >>> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat=
=2Ecom>
> > > > > > > > > > >>> Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > > > > > > >>> ---
> > > > > > > > > > >>>
> > > > > > > > > > >>
> > > > > > > > > > >> I'm wondering if the problem can be related with the=
 fact that
> > > > > > > > > > >> main_loop_should_exit() could release qemu_global_mu=
tex in
> > > > > > > > > > >> pause_all_vcpus() in the reset case?
> > > > > > > > > > >>
> > > > > > > > > > >> 1602 static bool main_loop_should_exit(void)
> > > > > > > > > > >> 1603 {
> > > > > > > > > > >> ...
> > > > > > > > > > >> 1633     request =3D qemu_reset_requested();
> > > > > > > > > > >> 1634     if (request) {
> > > > > > > > > > >> 1635         pause_all_vcpus();
> > > > > > > > > > >> 1636         qemu_system_reset(request);
> > > > > > > > > > >> 1637         resume_all_vcpus();
> > > > > > > > > > >> 1638         if (!runstate_check(RUN_STATE_RUNNING) =
&&
> > > > > > > > > > >> 1639                 !runstate_check(RUN_STATE_INMIG=
RATE)) {
> > > > > > > > > > >> 1640             runstate_set(RUN_STATE_PRELAUNCH);
> > > > > > > > > > >> 1641         }
> > > > > > > > > > >> 1642     }
> > > > > > > > > > >> ...
> > > > > > > > > > >>
> > > > > > > > > > >> I already sent a patch for this kind of problem (in =
current Juan pull
> > > > > > > > > > >> request):
> > > > > > > > > > >>
> > > > > > > > > > >> "runstate: ignore finishmigrate -> prelaunch transit=
ion"
> > > > > > > > > > >>
> > > > > > > > > > >=20
> > > > > > > > > > > IIUC your patch avoids an invalid 'prelaunch' -> 'pos=
tmigrate' runstate
> > > > > > > > > > > transition that can happen if the migration thread se=
ts the runstate to
> > > > > > > > > > > 'finishmigrate' when pause_all_vcpus() releases the m=
ain loop mutex.
> > > > > > > > > > >=20
> > > > > > > > > > > ie. symptom of the problem is QEMU aborting, correct =
? The issue I'm
> > > > > > > > > > > trying to fix is a guest breakage caused by a discrep=
ancy between
> > > > > > > > > > > QEMU and the guest after migration has succeeded.
> > > > > > > > > > >=20
> > > > > > > > > > >> but I don't know if it could fix this one.
> > > > > > > > > > >>
> > > > > > > > > > >=20
> > > > > > > > > > > I don't think so and your patch kinda illustrates it.=
 If the runstate
> > > > > > > > > > > is 'finishmigrate' when returning from pause_all_vcpu=
s(), this means
> > > > > > > > > > > that state was sent to the destination before we coul=
d actually reset
> > > > > > > > > > > the machine.
> > > > > > > > > >=20
> > > > > > > > > > Yes, you're right.
> > > > > > > > > >=20
> > > > > > > > > > But the question behind my comment was: is it expected =
to have a pending
> > > > > > > > > > reset while we are migrating?
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Nothing prevents qemu_system_reset_request() to be called=
 when migration
> > > > > > > > > is active.=20
> > > > > > > > >=20
> > > > > > > > > > Perhaps H_CAS can return H_BUSY and wait the end of the=
 migration and
> > > > > > > > > > then be fully executed on destination?
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > And so we would need to teach SLOF to try H_CAS again unt=
il it stops
> > > > > > > > > returning H_BUSY ? It seems safer to migrate the CAS rebo=
ot flag IMHO.
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Ok I've tried that with a patched SLOF that sleeps 500ms an=
d tries CAS
> > > > > > > > again if H_BUSY was returned. It fixes the issue but it loo=
ks a bit
> > > > > > > > ugly because of the polling with an arbitrary timeout in SL=
OF... I'm
> > > > > > > > not very comfortable either with calling migration_is_activ=
e() from
> > > > > > > > the CAS code in QEMU.
> > > > > > > >=20
> > > > > > > > David,
> > > > > > > >=20
> > > > > > > > Any suggestion ?
> > > > > > >=20
> > > > > > > Yeah, I think looping in SLOF is a worse idea than migrating =
the
> > > > > > > cas_reboot flag.
> > > > > > >=20
> > > > > > > But.. a better solution still might be to just remove the rem=
aining
> > > > > > > causes for CAS reboot entirely.  CAS reboots pretty much suck=
 when
> > > > > > > they happen, anyway.
> > > > > > >=20
> > > > > >=20
> > > > > > I Agree.
> > > > > >=20
> > > > > > > With the irq changeover condition removed, I think the remain=
ing
> > > > > > > causes are more theoretical than practical situations at this=
 point.
> > > > > > >=20
> > > > > >=20
> > > > > > FWIW, hotpluggging a PCI device before CAS result in a hung gue=
st (not yet
> > > > > > investigated the details).
> > > > >=20
> > > > > commit 10f12e6450407b18b4d5a6b50d3852dcfd7fff75
> > > > > Author: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > > > > Date:   Wed Aug 30 15:21:41 2017 -0300
> > > > >=20
> > > > >     hw/ppc: CAS reset on early device hotplug
> > > > >=20
> > > > > I'll have a look to see what can be done here.
> > > >=20
> > > > Ah.. yes, that one might be a bit tricky.
> > > >=20
> > >=20
> > > So far it seems to be related to SLOF not being able to create
> > > new nodes in the DT when parsing the FDT returned by CAS. SLOF
> > > stops the parsing and returns an error. The guest ends up with
> > > a broken DT and eventually hangs later (in my case the kernel
> > > believes it is going to do hash while radix was negotiated with
> > > QEMU). I need to dig some more.
> >=20
> > Uh... I don't think this is right.  I'm pretty sure SLOF *does* create
> > new nodes when parsing the CAS FDT, it will need to for
> > "ibm,dynamic-reconfiguration-memory" at least.
> >=20
>=20
> It can create "memory@" or "ibm,dynamic-reconfiguration-memory" nodes but
> explicitly rejects all others.

Huh.  Well that's certainly not correct now that we're doing a full
tree rebuild.

> > I've done some looking and I think the actual reasons here are a bit
> > more complicated (but also possibly easier to handle).
> >=20
> >   1. We can't send hotplug events to the guest until after CAS,
> >      because before then we don't know if it can process them, or if
> >      it can, which interrupt it uses for them.
> >=20
> >   2. Queueing hotplug events across CAS for delivery afterwards
> >      introduces other complications
> >=20
> >   3. We need to make sure that each device appears exactly once in
> >      either the  initial device tree that the guest OS sees, *or* in a
> >      hotplug event, not both or neither.
> >=20
> > Now that we rebuild the DT at CAS time, I think we mightd be able toy
> > handle this by converting such devices to "cold plugged" at CAS time
> > (similarly to what we already do at reset).  Since they're in the
> > CAS-time DT which is what the OS will consume, cold plugged is
> > effectively how the OS will see them.
> >=20
>=20
> I have tried hacking around to achieve that. Basically calling
> spapr_drc_reset() for all DRCs for which spapr_drc_needed()
> returns true.
>=20
> > A remaining problem is that new PCI devices won't get BARs assigned by
> > SLOF in this scenario.  We'll probably get away with it because of the
> > linux,pci-probe-only property, but I don't know we want to rely on
>=20
> We currently only expose this property for pseries-4.2 and newer
> machine types... this could be a problem.

Right.  I don't like relying on it even for the newer machines, since
it presumably wouldn't work for FreeBSD or AIX.

> > that.  PCI bridges hotplugged introduce further complications, because
> > they won't get enumerated.

Alexey has done some testing and looks like there are already a bunch
of problems with PCI bridges hotplugged during SLOF execution.

> >=20
> > > > > But I agree the other check is more theoretical:
> > > > >=20
> > > > >     /* capabilities that have been added since CAS-generated gues=
t reset.
> > > > >      * if capabilities have since been removed, generate another =
reset
> > > > >      */
> > > > >     spapr->cas_reboot =3D !spapr_ovec_subset(ov5_cas_old, spapr->=
ov5_cas);
> > > > >=20
> > > > > Unless changing kernels or tempering with the kernel command line=
, I don't
> > > > > see how some capabilities could change between the two CAS in pra=
ctice.
> > > >=20
> > > > Well, we want to be robust and it's at least theoretically possible
> > > > that the guest will request different things on subsequent reboots.
> > >=20
> > > Yes but in the latter case a full machine reset occurs and
> >=20
> > Not necessarily.  A guest could ask for something on one CAS cycle,
> > then reject it on another, without doing a full reboot.  It'd be a
> > pointless thing for the guest to do, but it's possible.
> >=20
>=20
> Ok, I was asking later on if we want to support the scenario of
> multiple CAS without an intermediate full reboot. I now have the
> answer :)

Well, "want" might be a bit strong.  PAPR allows for the possibility
so we're trying to support it at this stage.  Obviously this could
happen relatively easily with the hotplug-before-CAS cause.

> > > spapr->ov5_cas gets cleared, ie. spapr_ovec_subset() returns
> > > true in the check above no matter what.
> >=20
> > Well, also it could happen if the guest rejects something we put in
> > the initial value of ov5_cas (which is populated from spapr->ov5, so
> > it's not entirely empty).
> >=20
>=20
> AFAICT the initial value of ov5_cas after a full machine reset is
> all zeroes until CAS does:
>=20
>     /* full range of negotiated ov5 capabilities */
>     spapr_ovec_intersect(spapr->ov5_cas, spapr->ov5, ov5_guest);
>=20
> which is done between:
>=20
>     ov5_cas_old =3D spapr_ovec_clone(spapr->ov5_cas);
>=20
> and
>=20
>     spapr->cas_reboot =3D !spapr_ovec_subset(ov5_cas_old, spapr->ov5_cas);
>=20
> So I don't quite understand how ov5_cas_old, ie. spapr->ov5_cas at the
> time the guest calls CAS, could have an "initial value not entirely
> empty"... This can only happen if the guest calls CAS several times
> without doing a full reboot in between. My initial thought was to
> refuse this scenario and fail any subsequent CAS attempt made by
> the guest before a full reboot.

Oh, sorry, my mistake.  I say the line:
      spapr->ov5_cas =3D spapr_ovec_clone(spapr->ov5);

but only now realized that only happens in the qtest case.  Ok, yes,
looks like this could only happen in the case of multiple CAS reboots
in a row.

>=20
> > > > However I believe that the original rationale for this check was th=
at
> > > > while we could add things to the device tree for added capabilities,
> > > > we didn't have a way to roll back the changes for removed
> > > > capabilities.
> > > >=20
> > >=20
> > > IIUC this is specifically for "removed capabilities since last
> > > CAS". This can happen if:
> > > 1) we're already processing a CAS reboot or,
> > > 2) a freshly rebooted guest calls CAS twice without being rebooted
> > >    in between.
> > >=20
> > > Since a freshly booted or rebooted guest can only trigger a CAS
> > > reboot because of a "hotplug-before-CAS", if we manage to get rid
> > > of this limitation, 1) cannot happen anymore.
> > >=20
> > > The linux kernel seems to be only calling "ibm,client-architecture-su=
pport"
> > > once during early boot so 2) should _never_ happen. Do we care to sup=
port
> > > this scenario anyway ?
> >=20
> > I think you've missed some things in your reasoning.  But it doesn't
> > really matter because the full dt rebuilt should handle it anyway.  I
> > have a draft patch which removes this cause for CAS reboots.
> >=20
> > Still grappling with the hotplug-before-CAS case.
> >=20
>=20
> Same here actually. I was struggling with SLOF to have it create new nodes
> for hotplugged-before-CAS devices without crashing :-\
>=20
> I think I'll wait for your patches to arrive :) Please Cc: me.
>=20
> > > > Now that we fully rebuild the device tree at CAS, I think this test
> > > > can probably just go, although there's some double checking to do.
> > > >=20
> > >=20
> > > I tend to agree.
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U6leaJ20qZQc29iB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4pKlgACgkQbDjKyiDZ
s5L0qA/+Mp7gSc8fekn8Z2iG5I+jpKniHITC6x5pGi3ybYOHzo4S2g63D6xrTZRf
c6//e3yzZhYqNwX4TJZIKsOaLmuqzZCy7CUGHGHKi5E6bVogpSWXG4aZUMNV48D0
D7qzi9IPrA8yEVbuS4zZDYXwTca9VmYOf7SHXMS412SB64FMFzO9+dtXffjQG4it
77+f4yHHTBrfVfqMidOTeLC3XJ/nSCvkOujSidGDGr8tYicygiUJmTjeI0MJIjiY
6oIwqyyJroxn3d04Wy3kKmjveUqsGywTCgIg1/ERjpVhhyFk+LqKjHtSWSz9sZTf
vX7mwlEROHprBS/yaiTUVZMmuCFN8gigR9u/qu0p95DEgocLtEHzQFapYkBnep7u
qtLEmVxgg5XLxek1gBzlYmC5Z0xR5oI/UK3916sjQWcKh0qkWcJ1T/zuXtwjOD+h
c+Dyu9OW5MpMEEAt7cvDBMhAYWflBWYpZzT3kXG+WDMPSuIdOqkCTL/Wh7qVJBq8
lk6puJffoezNRsG4EnVq0KUMuad0wybcBg4v+/w/Ds9RBFHUG16cwmxQLDCqO3kx
Ux0egr3a2fhH96JQ0Nomyr8ONaHjqr+KFr0BOYnKfJQljSocD+P6ad+kFYkxwH4C
ARVaYEcFQoUJc9fRXPnEH8+uxNWC2tu7MkszUYl9T8BwyEcqsEc=
=paSo
-----END PGP SIGNATURE-----

--U6leaJ20qZQc29iB--

