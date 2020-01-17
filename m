Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17420C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECA72072E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECA72072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isTol-0004UH-W0
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 10:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1isTnf-0003u2-KE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1isTnd-0005t7-SM
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:44:43 -0500
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:55026)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1isTnd-0005r0-Jc
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:44:41 -0500
Received: from player796.ha.ovh.net (unknown [10.108.16.203])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 3BD6D1FA10A
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 16:44:38 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player796.ha.ovh.net (Postfix) with ESMTPSA id B5F21E4A4279;
 Fri, 17 Jan 2020 15:44:28 +0000 (UTC)
Date: Fri, 17 Jan 2020 16:44:27 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr: Migrate CAS reboot flag
Message-ID: <20200117164427.2c238412@bahia.lan>
In-Reply-To: <20200117091608.GV54439@umbus>
References: <157911051688.345768.16136592081655557565.stgit@bahia.lan>
 <ed2df775-b4d5-4ea7-ccf6-637c037f897b@redhat.com>
 <20200116094848.555c170d@bahia.lan>
 <2dda458a-dfa1-ab23-4a97-d27d9266226b@redhat.com>
 <20200116131435.3985e86e@bahia.lan>
 <20200116192902.63674769@bahia.lan> <20200117091608.GV54439@umbus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pwVveb2E1TcYaxkyy0J/0ef";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 15449035572701338086
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtdejgdejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeliedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.124.17
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

--Sig_/pwVveb2E1TcYaxkyy0J/0ef
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Jan 2020 19:16:08 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jan 16, 2020 at 07:29:02PM +0100, Greg Kurz wrote:
> > On Thu, 16 Jan 2020 13:14:35 +0100
> > Greg Kurz <groug@kaod.org> wrote:
> >=20
> > > On Thu, 16 Jan 2020 11:37:24 +0100
> > > Laurent Vivier <lvivier@redhat.com> wrote:
> > >=20
> > > > On 16/01/2020 09:48, Greg Kurz wrote:
> > > > > On Wed, 15 Jan 2020 19:10:37 +0100
> > > > > Laurent Vivier <lvivier@redhat.com> wrote:
> > > > >=20
> > > > >> Hi,
> > > > >>
> > > > >> On 15/01/2020 18:48, Greg Kurz wrote:
> > > > >>> Migration can potentially race with CAS reboot. If the migratio=
n thread
> > > > >>> completes migration after CAS has set spapr->cas_reboot but bef=
ore the
> > > > >>> mainloop could pick up the reset request and reset the machine,=
 the
> > > > >>> guest is migrated unrebooted and the destination doesn't reboot=
 it
> > > > >>> either because it isn't aware a CAS reboot was needed (eg, beca=
use a
> > > > >>> device was added before CAS). This likely result in a broken or=
 hung
> > > > >>> guest.
> > > > >>>
> > > > >>> Even if it is small, the window between CAS and CAS reboot is e=
nough to
> > > > >>> re-qualify spapr->cas_reboot as state that we should migrate. A=
dd a new
> > > > >>> subsection for that and always send it when a CAS reboot is pen=
ding.
> > > > >>> This may cause migration to older QEMUs to fail but it is still=
 better
> > > > >>> than end up with a broken guest.
> > > > >>>
> > > > >>> The destination cannot honour the CAS reboot request from a pos=
t load
> > > > >>> handler because this must be done after the guest is fully rest=
ored.
> > > > >>> It is thus done from a VM change state handler.
> > > > >>>
> > > > >>> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> > > > >>> Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > >>> ---
> > > > >>>
> > > > >>
> > > > >> I'm wondering if the problem can be related with the fact that
> > > > >> main_loop_should_exit() could release qemu_global_mutex in
> > > > >> pause_all_vcpus() in the reset case?
> > > > >>
> > > > >> 1602 static bool main_loop_should_exit(void)
> > > > >> 1603 {
> > > > >> ...
> > > > >> 1633     request =3D qemu_reset_requested();
> > > > >> 1634     if (request) {
> > > > >> 1635         pause_all_vcpus();
> > > > >> 1636         qemu_system_reset(request);
> > > > >> 1637         resume_all_vcpus();
> > > > >> 1638         if (!runstate_check(RUN_STATE_RUNNING) &&
> > > > >> 1639                 !runstate_check(RUN_STATE_INMIGRATE)) {
> > > > >> 1640             runstate_set(RUN_STATE_PRELAUNCH);
> > > > >> 1641         }
> > > > >> 1642     }
> > > > >> ...
> > > > >>
> > > > >> I already sent a patch for this kind of problem (in current Juan=
 pull
> > > > >> request):
> > > > >>
> > > > >> "runstate: ignore finishmigrate -> prelaunch transition"
> > > > >>
> > > > >=20
> > > > > IIUC your patch avoids an invalid 'prelaunch' -> 'postmigrate' ru=
nstate
> > > > > transition that can happen if the migration thread sets the runst=
ate to
> > > > > 'finishmigrate' when pause_all_vcpus() releases the main loop mut=
ex.
> > > > >=20
> > > > > ie. symptom of the problem is QEMU aborting, correct ? The issue =
I'm
> > > > > trying to fix is a guest breakage caused by a discrepancy between
> > > > > QEMU and the guest after migration has succeeded.
> > > > >=20
> > > > >> but I don't know if it could fix this one.
> > > > >>
> > > > >=20
> > > > > I don't think so and your patch kinda illustrates it. If the runs=
tate
> > > > > is 'finishmigrate' when returning from pause_all_vcpus(), this me=
ans
> > > > > that state was sent to the destination before we could actually r=
eset
> > > > > the machine.
> > > >=20
> > > > Yes, you're right.
> > > >=20
> > > > But the question behind my comment was: is it expected to have a pe=
nding
> > > > reset while we are migrating?
> > > >=20
> > >=20
> > > Nothing prevents qemu_system_reset_request() to be called when migrat=
ion
> > > is active.=20
> > >=20
> > > > Perhaps H_CAS can return H_BUSY and wait the end of the migration a=
nd
> > > > then be fully executed on destination?
> > > >=20
> > >=20
> > > And so we would need to teach SLOF to try H_CAS again until it stops
> > > returning H_BUSY ? It seems safer to migrate the CAS reboot flag IMHO.
> > >=20
> >=20
> > Ok I've tried that with a patched SLOF that sleeps 500ms and tries CAS
> > again if H_BUSY was returned. It fixes the issue but it looks a bit
> > ugly because of the polling with an arbitrary timeout in SLOF... I'm
> > not very comfortable either with calling migration_is_active() from
> > the CAS code in QEMU.
> >=20
> > David,
> >=20
> > Any suggestion ?
>=20
> Yeah, I think looping in SLOF is a worse idea than migrating the
> cas_reboot flag.
>=20
> But.. a better solution still might be to just remove the remaining
> causes for CAS reboot entirely.  CAS reboots pretty much suck when
> they happen, anyway.
>=20

I Agree.

> With the irq changeover condition removed, I think the remaining
> causes are more theoretical than practical situations at this point.
>=20

FWIW, hotpluggging a PCI device before CAS result in a hung guest (not yet
investigated the details).

--Sig_/pwVveb2E1TcYaxkyy0J/0ef
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl4h1lsACgkQcdTV5YIv
c9ZzBQ//bNjTV/MfRCafKUe+dVTmpDWaM1khXYRHzrzuR4zO+4QQypMHmjBgyKxZ
ssGgW9StoTGKgcMMMCrv+Ox91Q6SsPYkJOyeBt1hUEDXV1eF7434ai7jnf4ZN9Pt
UokJ4CXL8uj96lIR20rIMxjMIWsU9jPPIo/7nNzpAsj9Hath3O4JHTgFKhl0u0Ig
XZq92lkr9A5rOflhhZ/3Bcy0aVAjPHDmTf6FrhjQkkYYAkCzWPMyATcedjohSzQX
KXSOm0n7x/gU9GOvR7uphaP8gBBP1o133O9oFVa3KKbxJwSwy3rpQu2DAh2ixyzE
E/uqNjWz79p1/DBr4vTBx1G76l02NDKwVde3ke1x+oLOWt6jQ7By/LZSvem3KMUf
+tNweuLMsKAAxeX9BHWtCW4+BZqd/8W9iNL5B7okjnZyp4kKCh35VqhZf/JIDWjK
yHZq/YRCMLym6njAcYqJJGt3+HesCntvRNvca67EJUlIzUwxyubdNWoVdxI+Pf85
4tnvoSnmHs9HPBiC3trKRnfY3FZdHo4RXr2sOXPqxIZzF0LJlEaefh0FOU6VpjhC
FfdNQPIClNJCEibXLKT9gx34+VdrQqW99peBTncFw/MVt4npUkajf//wrt0ovTJu
MkdcRShQWUN8WoIebVrqf/cQH5ZIL50zresc9sZrEw54OGl0oW4=
=i6EA
-----END PGP SIGNATURE-----

--Sig_/pwVveb2E1TcYaxkyy0J/0ef--

