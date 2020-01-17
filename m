Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC10C33CB6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1382072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MWTL91rX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1382072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isQmZ-0004pR-C5
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 07:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1isQiJ-0007n3-Jj
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1isQiG-0005pA-4E
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:26:59 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:53563 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1isQiF-0005hi-BW; Fri, 17 Jan 2020 07:26:56 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47zgKf6Pdbz9sRQ; Fri, 17 Jan 2020 23:26:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579264006;
 bh=KgWpzFbaeXyZVc1fSymlRjrq3D9BvRNQka4C6afKfLM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MWTL91rXNA0VaK0il8PhSPZAnomlWqhZ1kM6a7QhzaZtFD5fU2moFZD6qnU3NusfY
 A3mWCanSF0qtlKWuoH+0/WOMDRthX//46k+ArbJg+Bd78lpFVgC1IXTuwoiSgw5iCU
 D5nf/TC0vcGs8D4qU0anGgYBAAJb/8fHEyUQd+EA=
Date: Fri, 17 Jan 2020 19:16:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr: Migrate CAS reboot flag
Message-ID: <20200117091608.GV54439@umbus>
References: <157911051688.345768.16136592081655557565.stgit@bahia.lan>
 <ed2df775-b4d5-4ea7-ccf6-637c037f897b@redhat.com>
 <20200116094848.555c170d@bahia.lan>
 <2dda458a-dfa1-ab23-4a97-d27d9266226b@redhat.com>
 <20200116131435.3985e86e@bahia.lan>
 <20200116192902.63674769@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wfgmFf0LjPE7xkRl"
Content-Disposition: inline
In-Reply-To: <20200116192902.63674769@bahia.lan>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--wfgmFf0LjPE7xkRl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2020 at 07:29:02PM +0100, Greg Kurz wrote:
> On Thu, 16 Jan 2020 13:14:35 +0100
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Thu, 16 Jan 2020 11:37:24 +0100
> > Laurent Vivier <lvivier@redhat.com> wrote:
> >=20
> > > On 16/01/2020 09:48, Greg Kurz wrote:
> > > > On Wed, 15 Jan 2020 19:10:37 +0100
> > > > Laurent Vivier <lvivier@redhat.com> wrote:
> > > >=20
> > > >> Hi,
> > > >>
> > > >> On 15/01/2020 18:48, Greg Kurz wrote:
> > > >>> Migration can potentially race with CAS reboot. If the migration =
thread
> > > >>> completes migration after CAS has set spapr->cas_reboot but befor=
e the
> > > >>> mainloop could pick up the reset request and reset the machine, t=
he
> > > >>> guest is migrated unrebooted and the destination doesn't reboot it
> > > >>> either because it isn't aware a CAS reboot was needed (eg, becaus=
e a
> > > >>> device was added before CAS). This likely result in a broken or h=
ung
> > > >>> guest.
> > > >>>
> > > >>> Even if it is small, the window between CAS and CAS reboot is eno=
ugh to
> > > >>> re-qualify spapr->cas_reboot as state that we should migrate. Add=
 a new
> > > >>> subsection for that and always send it when a CAS reboot is pendi=
ng.
> > > >>> This may cause migration to older QEMUs to fail but it is still b=
etter
> > > >>> than end up with a broken guest.
> > > >>>
> > > >>> The destination cannot honour the CAS reboot request from a post =
load
> > > >>> handler because this must be done after the guest is fully restor=
ed.
> > > >>> It is thus done from a VM change state handler.
> > > >>>
> > > >>> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> > > >>> Signed-off-by: Greg Kurz <groug@kaod.org>
> > > >>> ---
> > > >>>
> > > >>
> > > >> I'm wondering if the problem can be related with the fact that
> > > >> main_loop_should_exit() could release qemu_global_mutex in
> > > >> pause_all_vcpus() in the reset case?
> > > >>
> > > >> 1602 static bool main_loop_should_exit(void)
> > > >> 1603 {
> > > >> ...
> > > >> 1633     request =3D qemu_reset_requested();
> > > >> 1634     if (request) {
> > > >> 1635         pause_all_vcpus();
> > > >> 1636         qemu_system_reset(request);
> > > >> 1637         resume_all_vcpus();
> > > >> 1638         if (!runstate_check(RUN_STATE_RUNNING) &&
> > > >> 1639                 !runstate_check(RUN_STATE_INMIGRATE)) {
> > > >> 1640             runstate_set(RUN_STATE_PRELAUNCH);
> > > >> 1641         }
> > > >> 1642     }
> > > >> ...
> > > >>
> > > >> I already sent a patch for this kind of problem (in current Juan p=
ull
> > > >> request):
> > > >>
> > > >> "runstate: ignore finishmigrate -> prelaunch transition"
> > > >>
> > > >=20
> > > > IIUC your patch avoids an invalid 'prelaunch' -> 'postmigrate' runs=
tate
> > > > transition that can happen if the migration thread sets the runstat=
e to
> > > > 'finishmigrate' when pause_all_vcpus() releases the main loop mutex.
> > > >=20
> > > > ie. symptom of the problem is QEMU aborting, correct ? The issue I'm
> > > > trying to fix is a guest breakage caused by a discrepancy between
> > > > QEMU and the guest after migration has succeeded.
> > > >=20
> > > >> but I don't know if it could fix this one.
> > > >>
> > > >=20
> > > > I don't think so and your patch kinda illustrates it. If the runsta=
te
> > > > is 'finishmigrate' when returning from pause_all_vcpus(), this means
> > > > that state was sent to the destination before we could actually res=
et
> > > > the machine.
> > >=20
> > > Yes, you're right.
> > >=20
> > > But the question behind my comment was: is it expected to have a pend=
ing
> > > reset while we are migrating?
> > >=20
> >=20
> > Nothing prevents qemu_system_reset_request() to be called when migration
> > is active.=20
> >=20
> > > Perhaps H_CAS can return H_BUSY and wait the end of the migration and
> > > then be fully executed on destination?
> > >=20
> >=20
> > And so we would need to teach SLOF to try H_CAS again until it stops
> > returning H_BUSY ? It seems safer to migrate the CAS reboot flag IMHO.
> >=20
>=20
> Ok I've tried that with a patched SLOF that sleeps 500ms and tries CAS
> again if H_BUSY was returned. It fixes the issue but it looks a bit
> ugly because of the polling with an arbitrary timeout in SLOF... I'm
> not very comfortable either with calling migration_is_active() from
> the CAS code in QEMU.
>=20
> David,
>=20
> Any suggestion ?

Yeah, I think looping in SLOF is a worse idea than migrating the
cas_reboot flag.

But.. a better solution still might be to just remove the remaining
causes for CAS reboot entirely.  CAS reboots pretty much suck when
they happen, anyway.

With the irq changeover condition removed, I think the remaining
causes are more theoretical than practical situations at this point.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wfgmFf0LjPE7xkRl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4he1gACgkQbDjKyiDZ
s5KNEA//VZxcFssYEbcqpo/9wPRaBG9Q147hY8MwPM4hcH0LoVdR0h9GH2rOzM3h
6D2t4a4Wvy8AWqh4+5vpKciOOKANu3pxe4I6dAj42py8NTcN7fP8vqHn3W/RLvHf
V1XMGjV2KanWszaa+9ocFIm1aaLmg7dd/Xcd5wuAu45geaSCWh5fWzAVj5Rf+IY0
PBj4IaBr4itakeROSdLAA+8eOwiPiZJXKSM9nGygUmgUI820Ukm9/7/HZiY96PB6
a09ERzQi32bGAMeTuNICrtbAbn5hNecDx4Gq0l/14CPScPj3GlpPR3FoLoHtOiSU
qrNSpmqDTT+fQYXlEShaO/ANNZe1ETPbhGHXuR79XuXD4xo3wHUD7JQaLz5K7Rr2
oY0MKdB0oPiKLSUeruLcykIulJKu3yeKvK6SXC832EeaRjW52gO4FZ5t62NnTwv4
Xu/Rh3PwBGpPU8F3sFN1ATA/YrJdQtIip19rEvx91mXDDNVeXTm4/cskRapEOuCJ
u+tuxUQPyMLsMnUX7wh3nXiMtDQ1p2T+FS6SOVTYpq+bWNQQ8rkSj8tUnvNKoRAz
ZrdGkMPIKclNsfMeI94KvoUM2SPcbM5upxbDhuEBnzetoEjbIeV55rO+/UzP7Yx1
xtE7Jg9A5ecp4yE4/udlQ86ctRS/5ExD3oZBWnNmN+mYGAgeS3g=
=+Qcj
-----END PGP SIGNATURE-----

--wfgmFf0LjPE7xkRl--

