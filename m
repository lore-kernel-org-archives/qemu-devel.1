Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F377CC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D712077C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D712077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is43q-0002lJ-Nj
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1is433-00024T-QP
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1is42z-0001EL-Vl
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:14:53 -0500
Received: from 8.mo6.mail-out.ovh.net ([178.33.42.204]:47225)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1is42z-0001Cu-QG
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:14:49 -0500
Received: from player696.ha.ovh.net (unknown [10.108.35.110])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 7C1581F9CD3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 13:14:47 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player696.ha.ovh.net (Postfix) with ESMTPSA id 6DFF8E56EDD5;
 Thu, 16 Jan 2020 12:14:37 +0000 (UTC)
Date: Thu, 16 Jan 2020 13:14:35 +0100
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] spapr: Migrate CAS reboot flag
Message-ID: <20200116131435.3985e86e@bahia.lan>
In-Reply-To: <2dda458a-dfa1-ab23-4a97-d27d9266226b@redhat.com>
References: <157911051688.345768.16136592081655557565.stgit@bahia.lan>
 <ed2df775-b4d5-4ea7-ccf6-637c037f897b@redhat.com>
 <20200116094848.555c170d@bahia.lan>
 <2dda458a-dfa1-ab23-4a97-d27d9266226b@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 6032290229908707622
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtdehgdefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.42.204
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
Cc: Lukas Doktor <ldoktor@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 11:37:24 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> On 16/01/2020 09:48, Greg Kurz wrote:
> > On Wed, 15 Jan 2020 19:10:37 +0100
> > Laurent Vivier <lvivier@redhat.com> wrote:
> >=20
> >> Hi,
> >>
> >> On 15/01/2020 18:48, Greg Kurz wrote:
> >>> Migration can potentially race with CAS reboot. If the migration thre=
ad
> >>> completes migration after CAS has set spapr->cas_reboot but before the
> >>> mainloop could pick up the reset request and reset the machine, the
> >>> guest is migrated unrebooted and the destination doesn't reboot it
> >>> either because it isn't aware a CAS reboot was needed (eg, because a
> >>> device was added before CAS). This likely result in a broken or hung
> >>> guest.
> >>>
> >>> Even if it is small, the window between CAS and CAS reboot is enough =
to
> >>> re-qualify spapr->cas_reboot as state that we should migrate. Add a n=
ew
> >>> subsection for that and always send it when a CAS reboot is pending.
> >>> This may cause migration to older QEMUs to fail but it is still better
> >>> than end up with a broken guest.
> >>>
> >>> The destination cannot honour the CAS reboot request from a post load
> >>> handler because this must be done after the guest is fully restored.
> >>> It is thus done from a VM change state handler.
> >>>
> >>> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> >>> Signed-off-by: Greg Kurz <groug@kaod.org>
> >>> ---
> >>>
> >>
> >> I'm wondering if the problem can be related with the fact that
> >> main_loop_should_exit() could release qemu_global_mutex in
> >> pause_all_vcpus() in the reset case?
> >>
> >> 1602 static bool main_loop_should_exit(void)
> >> 1603 {
> >> ...
> >> 1633     request =3D qemu_reset_requested();
> >> 1634     if (request) {
> >> 1635         pause_all_vcpus();
> >> 1636         qemu_system_reset(request);
> >> 1637         resume_all_vcpus();
> >> 1638         if (!runstate_check(RUN_STATE_RUNNING) &&
> >> 1639                 !runstate_check(RUN_STATE_INMIGRATE)) {
> >> 1640             runstate_set(RUN_STATE_PRELAUNCH);
> >> 1641         }
> >> 1642     }
> >> ...
> >>
> >> I already sent a patch for this kind of problem (in current Juan pull
> >> request):
> >>
> >> "runstate: ignore finishmigrate -> prelaunch transition"
> >>
> >=20
> > IIUC your patch avoids an invalid 'prelaunch' -> 'postmigrate' runstate
> > transition that can happen if the migration thread sets the runstate to
> > 'finishmigrate' when pause_all_vcpus() releases the main loop mutex.
> >=20
> > ie. symptom of the problem is QEMU aborting, correct ? The issue I'm
> > trying to fix is a guest breakage caused by a discrepancy between
> > QEMU and the guest after migration has succeeded.
> >=20
> >> but I don't know if it could fix this one.
> >>
> >=20
> > I don't think so and your patch kinda illustrates it. If the runstate
> > is 'finishmigrate' when returning from pause_all_vcpus(), this means
> > that state was sent to the destination before we could actually reset
> > the machine.
>=20
> Yes, you're right.
>=20
> But the question behind my comment was: is it expected to have a pending
> reset while we are migrating?
>=20

Nothing prevents qemu_system_reset_request() to be called when migration
is active.=20

> Perhaps H_CAS can return H_BUSY and wait the end of the migration and
> then be fully executed on destination?
>=20

And so we would need to teach SLOF to try H_CAS again until it stops
returning H_BUSY ? It seems safer to migrate the CAS reboot flag IMHO.

> Thanks,
> Laurent
>=20


