Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83B5C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC9D22522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC9D22522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itpvc-00015y-LO
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 04:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1itpuT-0000ch-Mt
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1itpuP-0003jE-15
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:33:21 -0500
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:51517)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1itpuO-0003fn-NP
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:33:16 -0500
Received: from player726.ha.ovh.net (unknown [10.109.146.166])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id C4B23268A87
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 10:33:07 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player726.ha.ovh.net (Postfix) with ESMTPSA id E6382E5E2A0B;
 Tue, 21 Jan 2020 09:32:57 +0000 (UTC)
Date: Tue, 21 Jan 2020 10:32:55 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr: Migrate CAS reboot flag
Message-ID: <20200121103255.6a25aaa9@bahia.lan>
In-Reply-To: <20200121034332.GC265522@umbus.fritz.box>
References: <157911051688.345768.16136592081655557565.stgit@bahia.lan>
 <ed2df775-b4d5-4ea7-ccf6-637c037f897b@redhat.com>
 <20200116094848.555c170d@bahia.lan>
 <2dda458a-dfa1-ab23-4a97-d27d9266226b@redhat.com>
 <20200116131435.3985e86e@bahia.lan>
 <20200116192902.63674769@bahia.lan> <20200117091608.GV54439@umbus>
 <20200117164427.2c238412@bahia.lan>
 <20200120090438.75ff9e65@bahia.lan>
 <20200121034332.GC265522@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/578btjyBBbawmx1OQRBuzVH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 14218708451905149414
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudekgddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.39.65
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

--Sig_/578btjyBBbawmx1OQRBuzVH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jan 2020 14:43:32 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Jan 20, 2020 at 09:04:38AM +0100, Greg Kurz wrote:
> > On Fri, 17 Jan 2020 16:44:27 +0100
> > Greg Kurz <groug@kaod.org> wrote:
> >=20
> > > On Fri, 17 Jan 2020 19:16:08 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > > On Thu, Jan 16, 2020 at 07:29:02PM +0100, Greg Kurz wrote:
> > > > > On Thu, 16 Jan 2020 13:14:35 +0100
> > > > > Greg Kurz <groug@kaod.org> wrote:
> > > > >=20
> > > > > > On Thu, 16 Jan 2020 11:37:24 +0100
> > > > > > Laurent Vivier <lvivier@redhat.com> wrote:
> > > > > >=20
> > > > > > > On 16/01/2020 09:48, Greg Kurz wrote:
> > > > > > > > On Wed, 15 Jan 2020 19:10:37 +0100
> > > > > > > > Laurent Vivier <lvivier@redhat.com> wrote:
> > > > > > > >=20
> > > > > > > >> Hi,
> > > > > > > >>
> > > > > > > >> On 15/01/2020 18:48, Greg Kurz wrote:
> > > > > > > >>> Migration can potentially race with CAS reboot. If the mi=
gration thread
> > > > > > > >>> completes migration after CAS has set spapr->cas_reboot b=
ut before the
> > > > > > > >>> mainloop could pick up the reset request and reset the ma=
chine, the
> > > > > > > >>> guest is migrated unrebooted and the destination doesn't =
reboot it
> > > > > > > >>> either because it isn't aware a CAS reboot was needed (eg=
, because a
> > > > > > > >>> device was added before CAS). This likely result in a bro=
ken or hung
> > > > > > > >>> guest.
> > > > > > > >>>
> > > > > > > >>> Even if it is small, the window between CAS and CAS reboo=
t is enough to
> > > > > > > >>> re-qualify spapr->cas_reboot as state that we should migr=
ate. Add a new
> > > > > > > >>> subsection for that and always send it when a CAS reboot =
is pending.
> > > > > > > >>> This may cause migration to older QEMUs to fail but it is=
 still better
> > > > > > > >>> than end up with a broken guest.
> > > > > > > >>>
> > > > > > > >>> The destination cannot honour the CAS reboot request from=
 a post load
> > > > > > > >>> handler because this must be done after the guest is full=
y restored.
> > > > > > > >>> It is thus done from a VM change state handler.
> > > > > > > >>>
> > > > > > > >>> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> > > > > > > >>> Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > > > >>> ---
> > > > > > > >>>
> > > > > > > >>
> > > > > > > >> I'm wondering if the problem can be related with the fact =
that
> > > > > > > >> main_loop_should_exit() could release qemu_global_mutex in
> > > > > > > >> pause_all_vcpus() in the reset case?
> > > > > > > >>
> > > > > > > >> 1602 static bool main_loop_should_exit(void)
> > > > > > > >> 1603 {
> > > > > > > >> ...
> > > > > > > >> 1633     request =3D qemu_reset_requested();
> > > > > > > >> 1634     if (request) {
> > > > > > > >> 1635         pause_all_vcpus();
> > > > > > > >> 1636         qemu_system_reset(request);
> > > > > > > >> 1637         resume_all_vcpus();
> > > > > > > >> 1638         if (!runstate_check(RUN_STATE_RUNNING) &&
> > > > > > > >> 1639                 !runstate_check(RUN_STATE_INMIGRATE))=
 {
> > > > > > > >> 1640             runstate_set(RUN_STATE_PRELAUNCH);
> > > > > > > >> 1641         }
> > > > > > > >> 1642     }
> > > > > > > >> ...
> > > > > > > >>
> > > > > > > >> I already sent a patch for this kind of problem (in curren=
t Juan pull
> > > > > > > >> request):
> > > > > > > >>
> > > > > > > >> "runstate: ignore finishmigrate -> prelaunch transition"
> > > > > > > >>
> > > > > > > >=20
> > > > > > > > IIUC your patch avoids an invalid 'prelaunch' -> 'postmigra=
te' runstate
> > > > > > > > transition that can happen if the migration thread sets the=
 runstate to
> > > > > > > > 'finishmigrate' when pause_all_vcpus() releases the main lo=
op mutex.
> > > > > > > >=20
> > > > > > > > ie. symptom of the problem is QEMU aborting, correct ? The =
issue I'm
> > > > > > > > trying to fix is a guest breakage caused by a discrepancy b=
etween
> > > > > > > > QEMU and the guest after migration has succeeded.
> > > > > > > >=20
> > > > > > > >> but I don't know if it could fix this one.
> > > > > > > >>
> > > > > > > >=20
> > > > > > > > I don't think so and your patch kinda illustrates it. If th=
e runstate
> > > > > > > > is 'finishmigrate' when returning from pause_all_vcpus(), t=
his means
> > > > > > > > that state was sent to the destination before we could actu=
ally reset
> > > > > > > > the machine.
> > > > > > >=20
> > > > > > > Yes, you're right.
> > > > > > >=20
> > > > > > > But the question behind my comment was: is it expected to hav=
e a pending
> > > > > > > reset while we are migrating?
> > > > > > >=20
> > > > > >=20
> > > > > > Nothing prevents qemu_system_reset_request() to be called when =
migration
> > > > > > is active.=20
> > > > > >=20
> > > > > > > Perhaps H_CAS can return H_BUSY and wait the end of the migra=
tion and
> > > > > > > then be fully executed on destination?
> > > > > > >=20
> > > > > >=20
> > > > > > And so we would need to teach SLOF to try H_CAS again until it =
stops
> > > > > > returning H_BUSY ? It seems safer to migrate the CAS reboot fla=
g IMHO.
> > > > > >=20
> > > > >=20
> > > > > Ok I've tried that with a patched SLOF that sleeps 500ms and trie=
s CAS
> > > > > again if H_BUSY was returned. It fixes the issue but it looks a b=
it
> > > > > ugly because of the polling with an arbitrary timeout in SLOF... =
I'm
> > > > > not very comfortable either with calling migration_is_active() fr=
om
> > > > > the CAS code in QEMU.
> > > > >=20
> > > > > David,
> > > > >=20
> > > > > Any suggestion ?
> > > >=20
> > > > Yeah, I think looping in SLOF is a worse idea than migrating the
> > > > cas_reboot flag.
> > > >=20
> > > > But.. a better solution still might be to just remove the remaining
> > > > causes for CAS reboot entirely.  CAS reboots pretty much suck when
> > > > they happen, anyway.
> > > >=20
> > >=20
> > > I Agree.
> > >=20
> > > > With the irq changeover condition removed, I think the remaining
> > > > causes are more theoretical than practical situations at this point.
> > > >=20
> > >=20
> > > FWIW, hotpluggging a PCI device before CAS result in a hung guest (no=
t yet
> > > investigated the details).
> >=20
> > commit 10f12e6450407b18b4d5a6b50d3852dcfd7fff75
> > Author: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > Date:   Wed Aug 30 15:21:41 2017 -0300
> >=20
> >     hw/ppc: CAS reset on early device hotplug
> >=20
> > I'll have a look to see what can be done here.
>=20
> Ah.. yes, that one might be a bit tricky.
>=20

So far it seems to be related to SLOF not being able to create
new nodes in the DT when parsing the FDT returned by CAS. SLOF
stops the parsing and returns an error. The guest ends up with
a broken DT and eventually hangs later (in my case the kernel
believes it is going to do hash while radix was negotiated with
QEMU). I need to dig some more.

> > But I agree the other check is more theoretical:
> >=20
> >     /* capabilities that have been added since CAS-generated guest rese=
t.
> >      * if capabilities have since been removed, generate another reset
> >      */
> >     spapr->cas_reboot =3D !spapr_ovec_subset(ov5_cas_old, spapr->ov5_ca=
s);
> >=20
> > Unless changing kernels or tempering with the kernel command line, I do=
n't
> > see how some capabilities could change between the two CAS in practice.
>=20
> Well, we want to be robust and it's at least theoretically possible
> that the guest will request different things on subsequent reboots.

Yes but in the latter case a full machine reset occurs and
spapr->ov5_cas gets cleared, ie. spapr_ovec_subset() returns
true in the check above no matter what.

> However I believe that the original rationale for this check was that
> while we could add things to the device tree for added capabilities,
> we didn't have a way to roll back the changes for removed
> capabilities.
>=20

IIUC this is specifically for "removed capabilities since last
CAS". This can happen if:
1) we're already processing a CAS reboot or,
2) a freshly rebooted guest calls CAS twice without being rebooted
   in between.

Since a freshly booted or rebooted guest can only trigger a CAS
reboot because of a "hotplug-before-CAS", if we manage to get rid
of this limitation, 1) cannot happen anymore.

The linux kernel seems to be only calling "ibm,client-architecture-support"
once during early boot so 2) should _never_ happen. Do we care to support
this scenario anyway ?

> Now that we fully rebuild the device tree at CAS, I think this test
> can probably just go, although there's some double checking to do.
>=20

I tend to agree.

--Sig_/578btjyBBbawmx1OQRBuzVH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl4mxUcACgkQcdTV5YIv
c9aOGQ//W0+aUR9HRIbFBNUlDui5dfup6048TfmEz99ezsTKYWVS6YT5KcueKc7v
ECZfK5BZ3oy64Fq/EkdrAM6Wpn121A7o8sdcCWn7qqXYCkCzmlXhbjM0FXKXQmHz
Vtg4mipbNKDng2MJb0GvfCyE8X624Y+pC3HlUzvJpc4Tgo0sEqtRHvLNYFeacnYh
2aRzHXiPrTViX07El4ikxeSHaKLonKcPTdgGemj+bsDXpaOeLJlFckE+PLpgXnrB
2ysu3O1f1Q4zQ61OHfvtdfrdJJ4gXj1HYN/mdfeJO1a6GQZ0QKflkVKCH8QMs30F
iwNt6yG4aM3qv2hvjX1yi5XgGegUO536kecPZp0R9IO7DW4o3T0lAAWyk0DOsDKk
z+CIAD4VmI0NKjuU0yXr8W9SB4076lj/09u+Ovni4QirF1GOFituy7JUB7UgYJ6Z
KRcsSZWASKKjKkDBIvTsGylWgS5eHWMWJ5S9rFfB2JwyQXTf+MTseRARW/j9um6X
cY92avy5ruz7A44XdxLrOHRUelInSf8rPS+lKw0vOE8uwDLFqSRmmyNXfQf6iqZ6
BDngKiGVBVINaV3ooqjBnoJv/wj7YT9IC2aXLR9OLDnXNU+TP4V/5Y9msXMJAjCG
RQvKo2IoqnGp9Uy/WU8NIwsZ2PWrK6IlX+xstGRlDjn1uAMd154=
=B4fg
-----END PGP SIGNATURE-----

--Sig_/578btjyBBbawmx1OQRBuzVH--

