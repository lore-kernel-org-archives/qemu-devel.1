Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D557CC35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990C62082F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990C62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Blu-0001Kk-M8
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 06:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6BlG-0000po-Vf
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6BlD-0003xc-56
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:18:54 -0500
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:53226)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6BlC-0003ul-S7
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:18:51 -0500
Received: from player715.ha.ovh.net (unknown [10.108.35.59])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id D4438132F8B
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 12:18:39 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id AAB11F829FE3;
 Mon, 24 Feb 2020 11:18:30 +0000 (UTC)
Date: Mon, 24 Feb 2020 12:18:27 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr: Rework hash<->radix transitions at CAS
Message-ID: <20200224121827.59f85580@bahia.home>
In-Reply-To: <20200218232105.GG1764@umbus.fritz.box>
References: <158160831807.3339719.7059822505220975954.stgit@bahia.lan>
 <20200213222835.GG124369@umbus.fritz.box>
 <20200214191900.7e4f91fc@bahia.lan>
 <20200218232105.GG1764@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zW3.meU.GWePijvInP=YCFy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 12758416272353958374
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrledtgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.72.44
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/zW3.meU.GWePijvInP=YCFy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Feb 2020 10:21:05 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Feb 14, 2020 at 07:19:00PM +0100, Greg Kurz wrote:
> > On Fri, 14 Feb 2020 09:28:35 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Thu, Feb 13, 2020 at 04:38:38PM +0100, Greg Kurz wrote:
> > > > Until the CAS negotiation is over, an HPT can be allocated on three
> > > > different paths:
> > > >=20
> > > > 1) during machine reset if the host doesn't support radix,
> > > >=20
> > > > 2) during CAS if the guest wants hash and doesn't support HPT resiz=
ing,
> > > >    in which case we pre-emptively resize the HPT to accomodate maxr=
am,
> > > >=20
> > > > 3) during CAS if no CAS reboot was requested, the guest wants hash =
but
> > > >    we're currently configured for radix.
> > > >=20
> > > > Depending on the various combinations of host or guest MMU support,
> > > > HPT resizing guest support and the possibility of a CAS reboot, it
> > > > is quite hard to know which of these allocates the HPT that will
> > > > be ultimately used by the guest that wants to do hash. Also, some of
> > > > them have bugs:
> > > >=20
> > > > - 2) calls spapr_reallocate_hpt() instead of spapr_setup_hpt_and_vr=
ma()
> > > >   and thus doesn't update the VRMA size, even though we've just ext=
ended
> > > >   the HPT. Not sure what issues this can cause,
> > > >=20
> > > > - 3) doesn't check for HPT resizing support and will always allocat=
e a
> > > >   small HPT based on the initial RAM size. This caps the total amou=
nt of
> > > >   RAM the guest can see, especially if maxram is much higher than t=
he
> > > >   initial ram.
> > > >=20
> > > > We only support guests that do CAS and we already assume that the H=
PT
> > > > isn't being used when we do the pre-emptive resizing at CAS. It thus
> > > > seems reasonable to only allocate the HPT at the end of CAS, when no
> > > > CAS reboot was requested.
> > > >=20
> > > > Consolidate the logic so that we only create the HPT during 3), ie.
> > > > when we're done with the CAS reboot cycles, and ensure HPT resizing
> > > > is taken into account. This fixes the radix->hash transition for
> > > > all cases.
> > >=20
> > > Uh.. I'm pretty sure this can't work for KVM on a POWER8 host.  We
> > > need the HPT at all times there, or there's nowhere to put VRMA
> > > entries, so we can't run even in real mode.
> > >=20
> >=20
> > Well it happens to be working anyway because KVM automatically
> > creates an HPT (default size 16MB) in kvmppc_hv_setup_htab_rma()
> > if QEMU didn't do so already... Would a comment to emphasize this
> > be enough or do you prefer I don't drop the HPT allocation currently
> > performed at machine reset ?
>=20
> Relying on the automatic allocation is not a good idea.  With host
> kernels before HPT resizing, once that automatic allocation happens,
> we can't change the HPT size *at all*, even with a reset or CAS.
>=20

Ah ok I see. With these older host kernels, we need QEMU to allocate the
HPT to fit ms->maxram_size, which KVM doesn't know about, or we'll have
troubles with VMs that would need a bigger HPT. And I guess we want to
support bigger VMs with pre-4.11 host kernels.

> So, yes, the current code is annoyingly complex, but it's that way for
> a reason.
>=20

My motivation here is to get rid of CAS reboot... it definitely needs more
thinking on my side.

> > > > The guest can theoretically call CAS several times, without a CAS
> > > > reboot in between. Linux guests don't do that, but better safe than
> > > > sorry, let's ensure we can also handle the symmetrical hash->radix
> > > > transition correctly: free the HPT and set the GR bit in PATE.
> > > > An helper is introduced for the latter since this is already what
> > > > we do during machine reset when going for radix.
> > > >=20
> > > > As a bonus, this removes one user of spapr->cas_reboot, which we
> > > > want to get rid of in the future.
> > > >=20
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > >  hw/ppc/spapr.c         |   25 +++++++++++++++-----
> > > >  hw/ppc/spapr_hcall.c   |   59 ++++++++++++++++++++----------------=
------------
> > > >  include/hw/ppc/spapr.h |    1 +
> > > >  3 files changed, 44 insertions(+), 41 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index 828e2cc1359a..88bc0e4e3ca1 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -1573,9 +1573,19 @@ void spapr_setup_hpt_and_vrma(SpaprMachineSt=
ate *spapr)
> > > >  {
> > > >      int hpt_shift;
> > > > =20
> > > > +    /*
> > > > +     * HPT resizing is a bit of a special case, because when enabl=
ed
> > > > +     * we assume an HPT guest will support it until it says it
> > > > +     * doesn't, instead of assuming it won't support it until it s=
ays
> > > > +     * it does.  Strictly speaking that approach could break for
> > > > +     * guests which don't make a CAS call, but those are so old we
> > > > +     * don't care about them.  Without that assumption we'd have to
> > > > +     * make at least a temporary allocation of an HPT sized for max
> > > > +     * memory, which could be impossibly difficult under KVM HV if
> > > > +     * maxram is large.
> > > > +     */
> > > >      if ((spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED)
> > > > -        || (spapr->cas_reboot
> > > > -            && !spapr_ovec_test(spapr->ov5_cas, OV5_HPT_RESIZE))) {
> > > > +        || !spapr_ovec_test(spapr->ov5_cas, OV5_HPT_RESIZE)) {
> > > >          hpt_shift =3D spapr_hpt_shift_for_ramsize(MACHINE(spapr)->=
maxram_size);
> > > >      } else {
> > > >          uint64_t current_ram_size;
> > > > @@ -1604,6 +1614,12 @@ static int spapr_reset_drcs(Object *child, v=
oid *opaque)
> > > >      return 0;
> > > >  }
> > > > =20
> > > > +void spapr_reset_patb_entry(SpaprMachineState *spapr)
> > > > +{
> > > > +    spapr->patb_entry =3D PATE1_GR;
> > > > +    spapr_set_all_lpcrs(LPCR_HR | LPCR_UPRT, LPCR_HR | LPCR_UPRT);
> > > > +}
> > > > +
> > > >  static void spapr_machine_reset(MachineState *machine)
> > > >  {
> > > >      SpaprMachineState *spapr =3D SPAPR_MACHINE(machine);
> > > > @@ -1624,10 +1640,7 @@ static void spapr_machine_reset(MachineState=
 *machine)
> > > >           * without a HPT because KVM will start them in radix mode.
> > > >           * Set the GR bit in PATE so that we know there is no HPT.
> > > >           */
> > > > -        spapr->patb_entry =3D PATE1_GR;
> > > > -        spapr_set_all_lpcrs(LPCR_HR | LPCR_UPRT, LPCR_HR | LPCR_UP=
RT);
> > > > -    } else {
> > > > -        spapr_setup_hpt_and_vrma(spapr);
> > > > +        spapr_reset_patb_entry(spapr);
> > > >      }
> > > > =20
> > > >      qemu_devices_reset();
> > > > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > > > index b8bb66b5c0d4..57ddf0fa6d05 100644
> > > > --- a/hw/ppc/spapr_hcall.c
> > > > +++ b/hw/ppc/spapr_hcall.c
> > > > @@ -1677,6 +1677,7 @@ static target_ulong h_client_architecture_sup=
port(PowerPCCPU *cpu,
> > > >      bool raw_mode_supported =3D false;
> > > >      bool guest_xive;
> > > >      CPUState *cs;
> > > > +    int maxshift =3D spapr_hpt_shift_for_ramsize(MACHINE(spapr)->m=
axram_size);
> > > > =20
> > > >      /* CAS is supposed to be called early when only the boot vCPU =
is active. */
> > > >      CPU_FOREACH(cs) {
> > > > @@ -1739,36 +1740,6 @@ static target_ulong h_client_architecture_su=
pport(PowerPCCPU *cpu,
> > > > =20
> > > >      guest_xive =3D spapr_ovec_test(ov5_guest, OV5_XIVE_EXPLOIT);
> > > > =20
> > > > -    /*
> > > > -     * HPT resizing is a bit of a special case, because when enabl=
ed
> > > > -     * we assume an HPT guest will support it until it says it
> > > > -     * doesn't, instead of assuming it won't support it until it s=
ays
> > > > -     * it does.  Strictly speaking that approach could break for
> > > > -     * guests which don't make a CAS call, but those are so old we
> > > > -     * don't care about them.  Without that assumption we'd have to
> > > > -     * make at least a temporary allocation of an HPT sized for max
> > > > -     * memory, which could be impossibly difficult under KVM HV if
> > > > -     * maxram is large.
> > > > -     */
> > > > -    if (!guest_radix && !spapr_ovec_test(ov5_guest, OV5_HPT_RESIZE=
)) {
> > > > -        int maxshift =3D spapr_hpt_shift_for_ramsize(MACHINE(spapr=
)->maxram_size);
> > > > -
> > > > -        if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_REQUIRED) {
> > > > -            error_report(
> > > > -                "h_client_architecture_support: Guest doesn't supp=
ort HPT resizing, but resize-hpt=3Drequired");
> > > > -            exit(1);
> > > > -        }
> > > > -
> > > > -        if (spapr->htab_shift < maxshift) {
> > > > -            /* Guest doesn't know about HPT resizing, so we
> > > > -             * pre-emptively resize for the maximum permitted RAM.=
  At
> > > > -             * the point this is called, nothing should have been
> > > > -             * entered into the existing HPT */
> > > > -            spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
> > > > -            push_sregs_to_kvm_pr(spapr);
> > > > -        }
> > > > -    }
> > > > -
> > > >      /* NOTE: there are actually a number of ov5 bits where input f=
rom the
> > > >       * guest is always zero, and the platform/QEMU enables them in=
dependently
> > > >       * of guest input. To model these properly we'd want some sort=
 of mask,
> > > > @@ -1806,6 +1777,12 @@ static target_ulong h_client_architecture_su=
pport(PowerPCCPU *cpu,
> > > >              error_report("Guest requested unavailable MMU mode (ha=
sh).");
> > > >              exit(EXIT_FAILURE);
> > > >          }
> > > > +        if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_REQUIRED &&
> > > > +            !spapr_ovec_test(ov5_guest, OV5_HPT_RESIZE)) {
> > > > +            error_report(
> > > > +                "h_client_architecture_support: Guest doesn't supp=
ort HPT resizing, but resize-hpt=3Drequired");
> > > > +            exit(1);
> > > > +        }
> > > >      }
> > > >      spapr->cas_pre_isa3_guest =3D !spapr_ovec_test(ov1_guest, OV1_=
PPC_3_00);
> > > >      spapr_ovec_cleanup(ov1_guest);
> > > > @@ -1838,11 +1815,23 @@ static target_ulong h_client_architecture_s=
upport(PowerPCCPU *cpu,
> > > >          void *fdt;
> > > >          SpaprDeviceTreeUpdateHeader hdr =3D { .version_id =3D 1 };
> > > > =20
> > > > -        /* If spapr_machine_reset() did not set up a HPT but one i=
s necessary
> > > > -         * (because the guest isn't going to use radix) then set i=
t up here. */
> > > > -        if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
> > > > -            /* legacy hash or new hash: */
> > > > -            spapr_setup_hpt_and_vrma(spapr);
> > > > +        if (!guest_radix) {
> > > > +            /*
> > > > +             * Either spapr_machine_reset() did not set up a HPT b=
ut one
> > > > +             * is necessary (because the guest isn't going to use =
radix),
> > > > +             * or the guest doesn't know about HPT resizing and we=
 need to
> > > > +             * pre-emptively resize for the maximum permitted RAM.=
 Set it
> > > > +             * up here. At the point this is called, nothing shoul=
d have
> > > > +             * been entered into the existing HPT.
> > > > +             */
> > > > +            if (spapr->patb_entry & PATE1_GR || spapr->htab_shift =
< maxshift) {
> > > > +                /* legacy hash or new hash: */
> > > > +                spapr_setup_hpt_and_vrma(spapr);
> > > > +                push_sregs_to_kvm_pr(spapr);
> > > > +            }
> > > > +        } else {
> > > > +            spapr_free_hpt(spapr);
> > > > +            spapr_reset_patb_entry(spapr);
> > > >          }
> > > > =20
> > > >          if (fdt_bufsize < sizeof(hdr)) {
> > > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > > index 09110961a589..9d88b5596481 100644
> > > > --- a/include/hw/ppc/spapr.h
> > > > +++ b/include/hw/ppc/spapr.h
> > > > @@ -919,4 +919,5 @@ void spapr_check_pagesize(SpaprMachineState *sp=
apr, hwaddr pagesize,
> > > > =20
> > > >  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
> > > >  hwaddr spapr_get_rtas_addr(void);
> > > > +void spapr_reset_patb_entry(SpaprMachineState *spapr);
> > > >  #endif /* HW_SPAPR_H */
> > > >=20
> > >=20
> >=20
>=20
>=20
>=20


--Sig_/zW3.meU.GWePijvInP=YCFy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl5TsQMACgkQcdTV5YIv
c9a1ohAAm/v5I4UCdmQsJcF1ThxfQT+9mLXlorIRvTW/vC/cTv5wjoM0VYBrSQZc
PER2HxKxZyADjCRoM7o9g/AmkkT6TO5P26bOFsKTeDGnEKILcYgetuN1tenvGtxx
o+x+YVroexr438gI1L7Jb7zJHCWFJcKBP2abLB+oVXsdCQwJE7feJUnqJpWs8jFt
7Vz39AwYucPrjka2hOgZJsA3NUzIXbhUJiN06+lHVP+3XH4+D4Afe80Xc1e5xghl
4c4ICrJN7HA7+IZVXtDspC+Hri1Ok4E8k/a1vYhu46dG4g9jw/trmAIO+VN059ls
rfB3vob2Z1QmlV53UaLEyHLawYVh6wbe4+rtcSAZ8MUiUripdgI2HybtqSuQZ5vz
WZM0OBllYa/ckGIlwWP/6ofNhkrzerlUWbtr5sG3T6yWBb9QnzLCzxYygD156cUs
ns4Xx8Sox4GKd9BF5xYjZzB+hGLunlv429ljJ5LAKdS2ctD39nU4hYrEhSVc2VBn
Aicwzf3Jp7VvluR7znGU6Ck3L0WXGsMTdKhosb/sDm7T693ztpPJYZLYU86pzR2y
B6FmkMy0h7GehzSDVFL0RxHYM8/J9Hp0U2ZZ2am3nuhs1vEJJJdkUVlqPT+15H72
b6iNekX/67pya2ieAvWf2Y9HgDtfYZ49tfHYoE9md7xYCUYZUV0=
=Qt71
-----END PGP SIGNATURE-----

--Sig_/zW3.meU.GWePijvInP=YCFy--

