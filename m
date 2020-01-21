Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFCBC3F68F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 03:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC29224125
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 03:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JF99jYDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC29224125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itkTb-0003r6-Ga
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 22:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1itkSE-0002ZJ-Lx
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 22:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1itkSC-0006H0-GL
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 22:43:50 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:60707 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1itkSB-00069F-Mk; Mon, 20 Jan 2020 22:43:48 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 481vXF747Rz9sRK; Tue, 21 Jan 2020 14:43:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579578222;
 bh=AORKeOJjd3mN3oqdZy48iMYVh1Af/SllZtLMPwJzK2o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JF99jYDgTum2qO53SbKw2MhYnjRaQnSU5R6ZKF4l22cHX076I3awao5ZXZQLH/wnp
 Hp3s+Ef7lvDg49KvR7CTZCVDfwYM0y8T6TCcfSRPqBvvFhICnpg1p8q6h0iT/S53f1
 FmrEbs8o7pEty7XeBOgPubcvbfj+XYm+bnY+5Vug=
Date: Tue, 21 Jan 2020 14:43:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr: Migrate CAS reboot flag
Message-ID: <20200121034332.GC265522@umbus.fritz.box>
References: <157911051688.345768.16136592081655557565.stgit@bahia.lan>
 <ed2df775-b4d5-4ea7-ccf6-637c037f897b@redhat.com>
 <20200116094848.555c170d@bahia.lan>
 <2dda458a-dfa1-ab23-4a97-d27d9266226b@redhat.com>
 <20200116131435.3985e86e@bahia.lan>
 <20200116192902.63674769@bahia.lan> <20200117091608.GV54439@umbus>
 <20200117164427.2c238412@bahia.lan>
 <20200120090438.75ff9e65@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <20200120090438.75ff9e65@bahia.lan>
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


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2020 at 09:04:38AM +0100, Greg Kurz wrote:
> On Fri, 17 Jan 2020 16:44:27 +0100
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Fri, 17 Jan 2020 19:16:08 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Thu, Jan 16, 2020 at 07:29:02PM +0100, Greg Kurz wrote:
> > > > On Thu, 16 Jan 2020 13:14:35 +0100
> > > > Greg Kurz <groug@kaod.org> wrote:
> > > >=20
> > > > > On Thu, 16 Jan 2020 11:37:24 +0100
> > > > > Laurent Vivier <lvivier@redhat.com> wrote:
> > > > >=20
> > > > > > On 16/01/2020 09:48, Greg Kurz wrote:
> > > > > > > On Wed, 15 Jan 2020 19:10:37 +0100
> > > > > > > Laurent Vivier <lvivier@redhat.com> wrote:
> > > > > > >=20
> > > > > > >> Hi,
> > > > > > >>
> > > > > > >> On 15/01/2020 18:48, Greg Kurz wrote:
> > > > > > >>> Migration can potentially race with CAS reboot. If the migr=
ation thread
> > > > > > >>> completes migration after CAS has set spapr->cas_reboot but=
 before the
> > > > > > >>> mainloop could pick up the reset request and reset the mach=
ine, the
> > > > > > >>> guest is migrated unrebooted and the destination doesn't re=
boot it
> > > > > > >>> either because it isn't aware a CAS reboot was needed (eg, =
because a
> > > > > > >>> device was added before CAS). This likely result in a broke=
n or hung
> > > > > > >>> guest.
> > > > > > >>>
> > > > > > >>> Even if it is small, the window between CAS and CAS reboot =
is enough to
> > > > > > >>> re-qualify spapr->cas_reboot as state that we should migrat=
e. Add a new
> > > > > > >>> subsection for that and always send it when a CAS reboot is=
 pending.
> > > > > > >>> This may cause migration to older QEMUs to fail but it is s=
till better
> > > > > > >>> than end up with a broken guest.
> > > > > > >>>
> > > > > > >>> The destination cannot honour the CAS reboot request from a=
 post load
> > > > > > >>> handler because this must be done after the guest is fully =
restored.
> > > > > > >>> It is thus done from a VM change state handler.
> > > > > > >>>
> > > > > > >>> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> > > > > > >>> Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > > >>> ---
> > > > > > >>>
> > > > > > >>
> > > > > > >> I'm wondering if the problem can be related with the fact th=
at
> > > > > > >> main_loop_should_exit() could release qemu_global_mutex in
> > > > > > >> pause_all_vcpus() in the reset case?
> > > > > > >>
> > > > > > >> 1602 static bool main_loop_should_exit(void)
> > > > > > >> 1603 {
> > > > > > >> ...
> > > > > > >> 1633     request =3D qemu_reset_requested();
> > > > > > >> 1634     if (request) {
> > > > > > >> 1635         pause_all_vcpus();
> > > > > > >> 1636         qemu_system_reset(request);
> > > > > > >> 1637         resume_all_vcpus();
> > > > > > >> 1638         if (!runstate_check(RUN_STATE_RUNNING) &&
> > > > > > >> 1639                 !runstate_check(RUN_STATE_INMIGRATE)) {
> > > > > > >> 1640             runstate_set(RUN_STATE_PRELAUNCH);
> > > > > > >> 1641         }
> > > > > > >> 1642     }
> > > > > > >> ...
> > > > > > >>
> > > > > > >> I already sent a patch for this kind of problem (in current =
Juan pull
> > > > > > >> request):
> > > > > > >>
> > > > > > >> "runstate: ignore finishmigrate -> prelaunch transition"
> > > > > > >>
> > > > > > >=20
> > > > > > > IIUC your patch avoids an invalid 'prelaunch' -> 'postmigrate=
' runstate
> > > > > > > transition that can happen if the migration thread sets the r=
unstate to
> > > > > > > 'finishmigrate' when pause_all_vcpus() releases the main loop=
 mutex.
> > > > > > >=20
> > > > > > > ie. symptom of the problem is QEMU aborting, correct ? The is=
sue I'm
> > > > > > > trying to fix is a guest breakage caused by a discrepancy bet=
ween
> > > > > > > QEMU and the guest after migration has succeeded.
> > > > > > >=20
> > > > > > >> but I don't know if it could fix this one.
> > > > > > >>
> > > > > > >=20
> > > > > > > I don't think so and your patch kinda illustrates it. If the =
runstate
> > > > > > > is 'finishmigrate' when returning from pause_all_vcpus(), thi=
s means
> > > > > > > that state was sent to the destination before we could actual=
ly reset
> > > > > > > the machine.
> > > > > >=20
> > > > > > Yes, you're right.
> > > > > >=20
> > > > > > But the question behind my comment was: is it expected to have =
a pending
> > > > > > reset while we are migrating?
> > > > > >=20
> > > > >=20
> > > > > Nothing prevents qemu_system_reset_request() to be called when mi=
gration
> > > > > is active.=20
> > > > >=20
> > > > > > Perhaps H_CAS can return H_BUSY and wait the end of the migrati=
on and
> > > > > > then be fully executed on destination?
> > > > > >=20
> > > > >=20
> > > > > And so we would need to teach SLOF to try H_CAS again until it st=
ops
> > > > > returning H_BUSY ? It seems safer to migrate the CAS reboot flag =
IMHO.
> > > > >=20
> > > >=20
> > > > Ok I've tried that with a patched SLOF that sleeps 500ms and tries =
CAS
> > > > again if H_BUSY was returned. It fixes the issue but it looks a bit
> > > > ugly because of the polling with an arbitrary timeout in SLOF... I'm
> > > > not very comfortable either with calling migration_is_active() from
> > > > the CAS code in QEMU.
> > > >=20
> > > > David,
> > > >=20
> > > > Any suggestion ?
> > >=20
> > > Yeah, I think looping in SLOF is a worse idea than migrating the
> > > cas_reboot flag.
> > >=20
> > > But.. a better solution still might be to just remove the remaining
> > > causes for CAS reboot entirely.  CAS reboots pretty much suck when
> > > they happen, anyway.
> > >=20
> >=20
> > I Agree.
> >=20
> > > With the irq changeover condition removed, I think the remaining
> > > causes are more theoretical than practical situations at this point.
> > >=20
> >=20
> > FWIW, hotpluggging a PCI device before CAS result in a hung guest (not =
yet
> > investigated the details).
>=20
> commit 10f12e6450407b18b4d5a6b50d3852dcfd7fff75
> Author: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> Date:   Wed Aug 30 15:21:41 2017 -0300
>=20
>     hw/ppc: CAS reset on early device hotplug
>=20
> I'll have a look to see what can be done here.

Ah.. yes, that one might be a bit tricky.

> But I agree the other check is more theoretical:
>=20
>     /* capabilities that have been added since CAS-generated guest reset.
>      * if capabilities have since been removed, generate another reset
>      */
>     spapr->cas_reboot =3D !spapr_ovec_subset(ov5_cas_old, spapr->ov5_cas);
>=20
> Unless changing kernels or tempering with the kernel command line, I don't
> see how some capabilities could change between the two CAS in practice.

Well, we want to be robust and it's at least theoretically possible
that the guest will request different things on subsequent reboots.
However I believe that the original rationale for this check was that
while we could add things to the device tree for added capabilities,
we didn't have a way to roll back the changes for removed
capabilities.

Now that we fully rebuild the device tree at CAS, I think this test
can probably just go, although there's some double checking to do.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4mc2QACgkQbDjKyiDZ
s5L5XA/4lzJNYoTdFSDXIRyWMAv88vRTbduTxF42lAmlk+6ylfz6JKqHuFscaqdH
mueb50aTYCQHuoE4jJ+APw+R8cbWhnR9ok9OQNQf58hfbmfDYB//Av9l+uqo30WB
8jNfPppNmX9nO2Oj4nftLflKewD5+p5uDA3hCXKkl3A0zCq58F2paVGDozaTY685
sjHgCQ533Lqa7qR1AD1OxR//o1yunFMO50sIy+82l0qOkufpQwZwyr5FRfa6TE8T
giEU/nneA+lucRXdLeX/ZqIhEihgdPS8CgY1dEMGXxM5mgtJg/afQID5DHnsTFoc
+SbvqoIak/I+Fl0cmVpjEgwibS64kAMshXYDUSWG65WECL9oRF6+/eVZWVmvOfoE
8p11ntvYQ4D99m13B9O5Yqv2dhKYqdBdkwBg9ORNYtwPmOwSnqx4n2EVfrg/oVCK
DNVZwBSuZQRCws4jDDSXDHScY95OAkZKAXqq6cz1J7Na/qUusvumir737jcMH6GM
7zlcZSBamNVrfauQ4HxIqAaLB0PHn1ZaGDHpHQFJux4Tz25L9+1x/ShueW8kjxqo
ubHyO7zsOpTHS+yrSYUlz0Tz6PbZ5MjEhTQzbktfCL68+8RH99A7Qxg/sJbDtcj5
rrsGsT2VyTxJMjx/yqB33iW6DAcHFaoSqX22QP51DAWJi03rUA==
=ceRl
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--

