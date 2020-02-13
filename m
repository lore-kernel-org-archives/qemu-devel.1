Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34775C3B18F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BDD20873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bJ1/ODC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BDD20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NSj-0000nV-56
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j2NR1-0007AA-UL
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j2NQz-0006aU-T4
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:58:15 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46405 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j2NQx-0006GV-TS; Thu, 13 Feb 2020 17:58:13 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48JX3Z5b02z9sP7; Fri, 14 Feb 2020 09:58:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581634682;
 bh=WQlYSVKRGWDSj87N/x/yhjpwmzbiqCDiI4HB9xSRDZM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bJ1/ODC7B+OkHHmeeqajkMAij69yghN9DKKKPXlafWqcon88CCR2h37kNAW43qj1B
 J9No6hPjOXM//QvpiuZvAEGwd3QZPOvGOnt/aPwxhtpcQ3lPXML0IWG9/hipIZicRo
 chdJTsY8Z3l1AtfXIfVIZJi5y+Koqpem2DMjLcug=
Date: Fri, 14 Feb 2020 09:28:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr: Rework hash<->radix transitions at CAS
Message-ID: <20200213222835.GG124369@umbus.fritz.box>
References: <158160831807.3339719.7059822505220975954.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline
In-Reply-To: <158160831807.3339719.7059822505220975954.stgit@bahia.lan>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 04:38:38PM +0100, Greg Kurz wrote:
> Until the CAS negotiation is over, an HPT can be allocated on three
> different paths:
>=20
> 1) during machine reset if the host doesn't support radix,
>=20
> 2) during CAS if the guest wants hash and doesn't support HPT resizing,
>    in which case we pre-emptively resize the HPT to accomodate maxram,
>=20
> 3) during CAS if no CAS reboot was requested, the guest wants hash but
>    we're currently configured for radix.
>=20
> Depending on the various combinations of host or guest MMU support,
> HPT resizing guest support and the possibility of a CAS reboot, it
> is quite hard to know which of these allocates the HPT that will
> be ultimately used by the guest that wants to do hash. Also, some of
> them have bugs:
>=20
> - 2) calls spapr_reallocate_hpt() instead of spapr_setup_hpt_and_vrma()
>   and thus doesn't update the VRMA size, even though we've just extended
>   the HPT. Not sure what issues this can cause,
>=20
> - 3) doesn't check for HPT resizing support and will always allocate a
>   small HPT based on the initial RAM size. This caps the total amount of
>   RAM the guest can see, especially if maxram is much higher than the
>   initial ram.
>=20
> We only support guests that do CAS and we already assume that the HPT
> isn't being used when we do the pre-emptive resizing at CAS. It thus
> seems reasonable to only allocate the HPT at the end of CAS, when no
> CAS reboot was requested.
>=20
> Consolidate the logic so that we only create the HPT during 3), ie.
> when we're done with the CAS reboot cycles, and ensure HPT resizing
> is taken into account. This fixes the radix->hash transition for
> all cases.

Uh.. I'm pretty sure this can't work for KVM on a POWER8 host.  We
need the HPT at all times there, or there's nowhere to put VRMA
entries, so we can't run even in real mode.

> The guest can theoretically call CAS several times, without a CAS
> reboot in between. Linux guests don't do that, but better safe than
> sorry, let's ensure we can also handle the symmetrical hash->radix
> transition correctly: free the HPT and set the GR bit in PATE.
> An helper is introduced for the latter since this is already what
> we do during machine reset when going for radix.
>=20
> As a bonus, this removes one user of spapr->cas_reboot, which we
> want to get rid of in the future.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c         |   25 +++++++++++++++-----
>  hw/ppc/spapr_hcall.c   |   59 ++++++++++++++++++++----------------------=
------
>  include/hw/ppc/spapr.h |    1 +
>  3 files changed, 44 insertions(+), 41 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 828e2cc1359a..88bc0e4e3ca1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1573,9 +1573,19 @@ void spapr_setup_hpt_and_vrma(SpaprMachineState *s=
papr)
>  {
>      int hpt_shift;
> =20
> +    /*
> +     * HPT resizing is a bit of a special case, because when enabled
> +     * we assume an HPT guest will support it until it says it
> +     * doesn't, instead of assuming it won't support it until it says
> +     * it does.  Strictly speaking that approach could break for
> +     * guests which don't make a CAS call, but those are so old we
> +     * don't care about them.  Without that assumption we'd have to
> +     * make at least a temporary allocation of an HPT sized for max
> +     * memory, which could be impossibly difficult under KVM HV if
> +     * maxram is large.
> +     */
>      if ((spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DISABLED)
> -        || (spapr->cas_reboot
> -            && !spapr_ovec_test(spapr->ov5_cas, OV5_HPT_RESIZE))) {
> +        || !spapr_ovec_test(spapr->ov5_cas, OV5_HPT_RESIZE)) {
>          hpt_shift =3D spapr_hpt_shift_for_ramsize(MACHINE(spapr)->maxram=
_size);
>      } else {
>          uint64_t current_ram_size;
> @@ -1604,6 +1614,12 @@ static int spapr_reset_drcs(Object *child, void *o=
paque)
>      return 0;
>  }
> =20
> +void spapr_reset_patb_entry(SpaprMachineState *spapr)
> +{
> +    spapr->patb_entry =3D PATE1_GR;
> +    spapr_set_all_lpcrs(LPCR_HR | LPCR_UPRT, LPCR_HR | LPCR_UPRT);
> +}
> +
>  static void spapr_machine_reset(MachineState *machine)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(machine);
> @@ -1624,10 +1640,7 @@ static void spapr_machine_reset(MachineState *mach=
ine)
>           * without a HPT because KVM will start them in radix mode.
>           * Set the GR bit in PATE so that we know there is no HPT.
>           */
> -        spapr->patb_entry =3D PATE1_GR;
> -        spapr_set_all_lpcrs(LPCR_HR | LPCR_UPRT, LPCR_HR | LPCR_UPRT);
> -    } else {
> -        spapr_setup_hpt_and_vrma(spapr);
> +        spapr_reset_patb_entry(spapr);
>      }
> =20
>      qemu_devices_reset();
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index b8bb66b5c0d4..57ddf0fa6d05 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1677,6 +1677,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      bool raw_mode_supported =3D false;
>      bool guest_xive;
>      CPUState *cs;
> +    int maxshift =3D spapr_hpt_shift_for_ramsize(MACHINE(spapr)->maxram_=
size);
> =20
>      /* CAS is supposed to be called early when only the boot vCPU is act=
ive. */
>      CPU_FOREACH(cs) {
> @@ -1739,36 +1740,6 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
> =20
>      guest_xive =3D spapr_ovec_test(ov5_guest, OV5_XIVE_EXPLOIT);
> =20
> -    /*
> -     * HPT resizing is a bit of a special case, because when enabled
> -     * we assume an HPT guest will support it until it says it
> -     * doesn't, instead of assuming it won't support it until it says
> -     * it does.  Strictly speaking that approach could break for
> -     * guests which don't make a CAS call, but those are so old we
> -     * don't care about them.  Without that assumption we'd have to
> -     * make at least a temporary allocation of an HPT sized for max
> -     * memory, which could be impossibly difficult under KVM HV if
> -     * maxram is large.
> -     */
> -    if (!guest_radix && !spapr_ovec_test(ov5_guest, OV5_HPT_RESIZE)) {
> -        int maxshift =3D spapr_hpt_shift_for_ramsize(MACHINE(spapr)->max=
ram_size);
> -
> -        if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_REQUIRED) {
> -            error_report(
> -                "h_client_architecture_support: Guest doesn't support HP=
T resizing, but resize-hpt=3Drequired");
> -            exit(1);
> -        }
> -
> -        if (spapr->htab_shift < maxshift) {
> -            /* Guest doesn't know about HPT resizing, so we
> -             * pre-emptively resize for the maximum permitted RAM.  At
> -             * the point this is called, nothing should have been
> -             * entered into the existing HPT */
> -            spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
> -            push_sregs_to_kvm_pr(spapr);
> -        }
> -    }
> -
>      /* NOTE: there are actually a number of ov5 bits where input from the
>       * guest is always zero, and the platform/QEMU enables them independ=
ently
>       * of guest input. To model these properly we'd want some sort of ma=
sk,
> @@ -1806,6 +1777,12 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>              error_report("Guest requested unavailable MMU mode (hash).");
>              exit(EXIT_FAILURE);
>          }
> +        if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_REQUIRED &&
> +            !spapr_ovec_test(ov5_guest, OV5_HPT_RESIZE)) {
> +            error_report(
> +                "h_client_architecture_support: Guest doesn't support HP=
T resizing, but resize-hpt=3Drequired");
> +            exit(1);
> +        }
>      }
>      spapr->cas_pre_isa3_guest =3D !spapr_ovec_test(ov1_guest, OV1_PPC_3_=
00);
>      spapr_ovec_cleanup(ov1_guest);
> @@ -1838,11 +1815,23 @@ static target_ulong h_client_architecture_support=
(PowerPCCPU *cpu,
>          void *fdt;
>          SpaprDeviceTreeUpdateHeader hdr =3D { .version_id =3D 1 };
> =20
> -        /* If spapr_machine_reset() did not set up a HPT but one is nece=
ssary
> -         * (because the guest isn't going to use radix) then set it up h=
ere. */
> -        if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
> -            /* legacy hash or new hash: */
> -            spapr_setup_hpt_and_vrma(spapr);
> +        if (!guest_radix) {
> +            /*
> +             * Either spapr_machine_reset() did not set up a HPT but one
> +             * is necessary (because the guest isn't going to use radix),
> +             * or the guest doesn't know about HPT resizing and we need =
to
> +             * pre-emptively resize for the maximum permitted RAM. Set it
> +             * up here. At the point this is called, nothing should have
> +             * been entered into the existing HPT.
> +             */
> +            if (spapr->patb_entry & PATE1_GR || spapr->htab_shift < maxs=
hift) {
> +                /* legacy hash or new hash: */
> +                spapr_setup_hpt_and_vrma(spapr);
> +                push_sregs_to_kvm_pr(spapr);
> +            }
> +        } else {
> +            spapr_free_hpt(spapr);
> +            spapr_reset_patb_entry(spapr);
>          }
> =20
>          if (fdt_bufsize < sizeof(hdr)) {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 09110961a589..9d88b5596481 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -919,4 +919,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, h=
waddr pagesize,
> =20
>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>  hwaddr spapr_get_rtas_addr(void);
> +void spapr_reset_patb_entry(SpaprMachineState *spapr);
>  #endif /* HW_SPAPR_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5FzZAACgkQbDjKyiDZ
s5KBSw//ZWGtOY0RCkDzUFoUoE91x1RN7tuG+HCV8BggbbUL0XLGLVJ10uOPP/b4
WNX+InjOqdTdW8d2pzY2zVbVmB/EHWSEThYnwkttSHJFFh8hvj/oYcQYy7tt3AWG
SngOj0ecn//Z3QP3JAkDrw6PI6veMFPbvJKiGpY6eCkI6qrXvSPT2Kzt5eYsVbgY
BI0FFmqvy1TTihq2X3kR1Zh0G7Uo3QDoQ8/dvwEFHrE+0wey1tryBWt7Guzlnk5J
BpeFamK/Gxspp+XRxTjEmU3HcfIVpUVVnMRYJ69a1mRZX3r8TM6GLemdYHPdsmSs
MTKfWHaGkMZifAK3DqounHdUK007jdCrRwVXx2siy4ngv3Ywh23oEJ6Wc0XAx0ut
DV7gF01el0gu9hOjxAZ79bEqQxMQdFM47959zyCT2EIUu7StADuPyMCEdnZPSwML
CLVrUd0XQa25e0LbdteXDpW5hxV/EY5NuNNnlCmjhkWBXOPFVb0xJEIGHeJ9qNce
YI4LdUPscbMf2MzcOX4zgWasnoh0g5+OWzMO8FqSsGfSzepNl2Z+cbE6YnMjPkA4
2Km4xTt2M0KftVbaLcR5GyaRI9blPXf8eRisHTTfz53XbmmhNyiz/FEIHu44eG71
mNhy+o8a3sfR3a7LIl4ctJQv/80IaLu1zdLcMRzhHrDwoxxno2Y=
=rrGp
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--

