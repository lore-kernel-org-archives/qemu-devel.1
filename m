Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94FAC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9122073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9122073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itS4O-00035U-OQ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 03:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1itS3W-0002Tm-44
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1itS3S-0003VC-3z
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:05:05 -0500
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:46506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1itS3R-0003PU-T9
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:05:02 -0500
Received: from player688.ha.ovh.net (unknown [10.108.16.55])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 757701A9049
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 09:04:52 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id BC088E4E495F;
 Mon, 20 Jan 2020 08:04:39 +0000 (UTC)
Date: Mon, 20 Jan 2020 09:04:38 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr: Migrate CAS reboot flag
Message-ID: <20200120090438.75ff9e65@bahia.lan>
In-Reply-To: <20200117164427.2c238412@bahia.lan>
References: <157911051688.345768.16136592081655557565.stgit@bahia.lan>
 <ed2df775-b4d5-4ea7-ccf6-637c037f897b@redhat.com>
 <20200116094848.555c170d@bahia.lan>
 <2dda458a-dfa1-ab23-4a97-d27d9266226b@redhat.com>
 <20200116131435.3985e86e@bahia.lan>
 <20200116192902.63674769@bahia.lan> <20200117091608.GV54439@umbus>
 <20200117164427.2c238412@bahia.lan>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b82WDh=9nYwK+d3J2eRYp3N";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 6855604533199739366
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeggdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.38.232
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

--Sig_/b82WDh=9nYwK+d3J2eRYp3N
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Jan 2020 16:44:27 +0100
Greg Kurz <groug@kaod.org> wrote:

> On Fri, 17 Jan 2020 19:16:08 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Jan 16, 2020 at 07:29:02PM +0100, Greg Kurz wrote:
> > > On Thu, 16 Jan 2020 13:14:35 +0100
> > > Greg Kurz <groug@kaod.org> wrote:
> > >=20
> > > > On Thu, 16 Jan 2020 11:37:24 +0100
> > > > Laurent Vivier <lvivier@redhat.com> wrote:
> > > >=20
> > > > > On 16/01/2020 09:48, Greg Kurz wrote:
> > > > > > On Wed, 15 Jan 2020 19:10:37 +0100
> > > > > > Laurent Vivier <lvivier@redhat.com> wrote:
> > > > > >=20
> > > > > >> Hi,
> > > > > >>
> > > > > >> On 15/01/2020 18:48, Greg Kurz wrote:
> > > > > >>> Migration can potentially race with CAS reboot. If the migrat=
ion thread
> > > > > >>> completes migration after CAS has set spapr->cas_reboot but b=
efore the
> > > > > >>> mainloop could pick up the reset request and reset the machin=
e, the
> > > > > >>> guest is migrated unrebooted and the destination doesn't rebo=
ot it
> > > > > >>> either because it isn't aware a CAS reboot was needed (eg, be=
cause a
> > > > > >>> device was added before CAS). This likely result in a broken =
or hung
> > > > > >>> guest.
> > > > > >>>
> > > > > >>> Even if it is small, the window between CAS and CAS reboot is=
 enough to
> > > > > >>> re-qualify spapr->cas_reboot as state that we should migrate.=
 Add a new
> > > > > >>> subsection for that and always send it when a CAS reboot is p=
ending.
> > > > > >>> This may cause migration to older QEMUs to fail but it is sti=
ll better
> > > > > >>> than end up with a broken guest.
> > > > > >>>
> > > > > >>> The destination cannot honour the CAS reboot request from a p=
ost load
> > > > > >>> handler because this must be done after the guest is fully re=
stored.
> > > > > >>> It is thus done from a VM change state handler.
> > > > > >>>
> > > > > >>> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> > > > > >>> Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > >>> ---
> > > > > >>>
> > > > > >>
> > > > > >> I'm wondering if the problem can be related with the fact that
> > > > > >> main_loop_should_exit() could release qemu_global_mutex in
> > > > > >> pause_all_vcpus() in the reset case?
> > > > > >>
> > > > > >> 1602 static bool main_loop_should_exit(void)
> > > > > >> 1603 {
> > > > > >> ...
> > > > > >> 1633     request =3D qemu_reset_requested();
> > > > > >> 1634     if (request) {
> > > > > >> 1635         pause_all_vcpus();
> > > > > >> 1636         qemu_system_reset(request);
> > > > > >> 1637         resume_all_vcpus();
> > > > > >> 1638         if (!runstate_check(RUN_STATE_RUNNING) &&
> > > > > >> 1639                 !runstate_check(RUN_STATE_INMIGRATE)) {
> > > > > >> 1640             runstate_set(RUN_STATE_PRELAUNCH);
> > > > > >> 1641         }
> > > > > >> 1642     }
> > > > > >> ...
> > > > > >>
> > > > > >> I already sent a patch for this kind of problem (in current Ju=
an pull
> > > > > >> request):
> > > > > >>
> > > > > >> "runstate: ignore finishmigrate -> prelaunch transition"
> > > > > >>
> > > > > >=20
> > > > > > IIUC your patch avoids an invalid 'prelaunch' -> 'postmigrate' =
runstate
> > > > > > transition that can happen if the migration thread sets the run=
state to
> > > > > > 'finishmigrate' when pause_all_vcpus() releases the main loop m=
utex.
> > > > > >=20
> > > > > > ie. symptom of the problem is QEMU aborting, correct ? The issu=
e I'm
> > > > > > trying to fix is a guest breakage caused by a discrepancy betwe=
en
> > > > > > QEMU and the guest after migration has succeeded.
> > > > > >=20
> > > > > >> but I don't know if it could fix this one.
> > > > > >>
> > > > > >=20
> > > > > > I don't think so and your patch kinda illustrates it. If the ru=
nstate
> > > > > > is 'finishmigrate' when returning from pause_all_vcpus(), this =
means
> > > > > > that state was sent to the destination before we could actually=
 reset
> > > > > > the machine.
> > > > >=20
> > > > > Yes, you're right.
> > > > >=20
> > > > > But the question behind my comment was: is it expected to have a =
pending
> > > > > reset while we are migrating?
> > > > >=20
> > > >=20
> > > > Nothing prevents qemu_system_reset_request() to be called when migr=
ation
> > > > is active.=20
> > > >=20
> > > > > Perhaps H_CAS can return H_BUSY and wait the end of the migration=
 and
> > > > > then be fully executed on destination?
> > > > >=20
> > > >=20
> > > > And so we would need to teach SLOF to try H_CAS again until it stops
> > > > returning H_BUSY ? It seems safer to migrate the CAS reboot flag IM=
HO.
> > > >=20
> > >=20
> > > Ok I've tried that with a patched SLOF that sleeps 500ms and tries CAS
> > > again if H_BUSY was returned. It fixes the issue but it looks a bit
> > > ugly because of the polling with an arbitrary timeout in SLOF... I'm
> > > not very comfortable either with calling migration_is_active() from
> > > the CAS code in QEMU.
> > >=20
> > > David,
> > >=20
> > > Any suggestion ?
> >=20
> > Yeah, I think looping in SLOF is a worse idea than migrating the
> > cas_reboot flag.
> >=20
> > But.. a better solution still might be to just remove the remaining
> > causes for CAS reboot entirely.  CAS reboots pretty much suck when
> > they happen, anyway.
> >=20
>=20
> I Agree.
>=20
> > With the irq changeover condition removed, I think the remaining
> > causes are more theoretical than practical situations at this point.
> >=20
>=20
> FWIW, hotpluggging a PCI device before CAS result in a hung guest (not yet
> investigated the details).

commit 10f12e6450407b18b4d5a6b50d3852dcfd7fff75
Author: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date:   Wed Aug 30 15:21:41 2017 -0300

    hw/ppc: CAS reset on early device hotplug

I'll have a look to see what can be done here.

But I agree the other check is more theoretical:

    /* capabilities that have been added since CAS-generated guest reset.
     * if capabilities have since been removed, generate another reset
     */
    spapr->cas_reboot =3D !spapr_ovec_subset(ov5_cas_old, spapr->ov5_cas);

Unless changing kernels or tempering with the kernel command line, I don't
see how some capabilities could change between the two CAS in practice.

--Sig_/b82WDh=9nYwK+d3J2eRYp3N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl4lXxYACgkQcdTV5YIv
c9b7RxAAuYqb3V62eFLhNGeshqdK3XDoayzcTZZYmCslY5qW2I2pTa8cmVDAbqqZ
wjTNzlbZ2eOJdavV2qLesZntINGT+R+1SRi22IIrgdqT3f3h5Lv2VoxRzr3PBFen
G1GqE4fAHgjSnIqcmmOeRlmM14hIgM4GVX/XX1EK50CM0kDxv9tEu6/6Lx6O3IVL
91aGHH8cPxa02ZSz3b1bAjyXC7mTcCWaVjpmdSB1ssLE68SVxGHJd/IBF6Osn6Br
+Z7RX22dz+UdOdg5qss/fuFyPpxAGlW6mnb/vEZRHNMSfoj7IPniFP4+QmtaiRSd
67kuF2KnSZzQ0R2ipldCMPIeTLnGRrA3yy7HiHviBZXdD7kS+8vx+qNas+Zdrs8w
trhZl5aHZOOz3Zt23mz2FljfSEzxcnnKXIAhFpmguSnDe98PbfkqrbOvy4cGV/dP
G6nJnHCaScxbyfBi8RtRJ73gb0tpXfo+zuWgSK0TtJM9i2ncnZK81FCIj8JMIS9T
FRnnSXYpDon5iiciRKCK33/PBNIgaSLe6VsicFRb15cZPfU8Iqc++qURTXetNnpq
CdL1jbCvtPfSpd2AaJynglfVkFsK+199F6xpzOFic1q/VyfGzU3bIWVW9KOASbqp
cAeID2AYDzIN2Eyx16GXJPUv63gdjXpY1eMqlcPycuD1cu0aziU=
=mC4I
-----END PGP SIGNATURE-----

--Sig_/b82WDh=9nYwK+d3J2eRYp3N--

