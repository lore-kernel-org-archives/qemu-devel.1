Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026A3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF9F207DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CbrnhV/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF9F207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8YxM-0000Ly-0k
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 21:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8YvF-00064x-HL; Wed, 19 Aug 2020 20:59:17 -0400
Received: from ozlabs.org ([203.11.71.1]:46077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8YvC-0007Lo-JZ; Wed, 19 Aug 2020 20:59:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BX5rR5HKJz9sTR; Thu, 20 Aug 2020 10:59:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597885143;
 bh=lOdCllw5foFsRrgj6ngZELDRcqFJQJa9cDlbmzK6yhs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CbrnhV/Zjh4KAk3S4f2rYmYUBw9WxvuTjTroyU+tSjeHDPpkp1AY3d7QaWAhkNTwn
 Tb+CqqZdVBGI0KuAQ+JhO/q2k2Vr/b4BjNRnTbXsLF9BXJ4T3tC1ZOeB+LiPW3ULQI
 gZWowTvxLwdca6TFeCcrJAWTDQL//5b10SUJ68MQ=
Date: Thu, 20 Aug 2020 10:58:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/8] spapr/xive: Add a 'hv-prio' property to represent
 the KVM escalation priority
Message-ID: <20200820005811.GD271315@yekko.fritz.box>
References: <20200819130843.2230799-1-clg@kaod.org>
 <20200819130843.2230799-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <20200819130843.2230799-2-clg@kaod.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:59:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2020 at 03:08:36PM +0200, C=E9dric Le Goater wrote:
> On POWER9, the KVM XIVE device uses priority 7 for the escalation
> interrupts. On POWER10, the host can use a reduced set of priorities
> and KVM will configure the escalation priority to a lower number. In
> any case, the guest is allowed to use priorities in a single range :
>=20
>     [ 0 .. (maxprio - 1) ].
>=20
> Introduce a 'hv-prio' property to represent the escalation priority
> number and use it to compute the "ibm,plat-res-int-priorities"
> property defining the priority ranges reserved by the hypervisor.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.2.

> ---
>  include/hw/ppc/spapr_xive.h |  2 ++
>  hw/intc/spapr_xive.c        | 33 ++++++++++++++-------------------
>  2 files changed, 16 insertions(+), 19 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 0ffbe0be0280..1dddcbcb9cdd 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -49,6 +49,8 @@ typedef struct SpaprXive {
>      void          *tm_mmap;
>      MemoryRegion  tm_mmio_kvm;
>      VMChangeStateEntry *change;
> +
> +    uint8_t       hv_prio;
>  } SpaprXive;
> =20
>  typedef struct SpaprXiveClass {
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 4bd0d606ba17..1fa09f287ac0 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -595,6 +595,7 @@ static Property spapr_xive_properties[] =3D {
>      DEFINE_PROP_UINT32("nr-ends", SpaprXive, nr_ends, 0),
>      DEFINE_PROP_UINT64("vc-base", SpaprXive, vc_base, SPAPR_XIVE_VC_BASE=
),
>      DEFINE_PROP_UINT64("tm-base", SpaprXive, tm_base, SPAPR_XIVE_TM_BASE=
),
> +    DEFINE_PROP_UINT8("hv-prio", SpaprXive, hv_prio, 7),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> @@ -692,12 +693,13 @@ static void spapr_xive_dt(SpaprInterruptController =
*intc, uint32_t nr_servers,
>          cpu_to_be32(16), /* 64K */
>      };
>      /*
> -     * The following array is in sync with the reserved priorities
> -     * defined by the 'spapr_xive_priority_is_reserved' routine.
> +     * QEMU/KVM only needs to define a single range to reserve the
> +     * escalation priority. A priority bitmask would have been more
> +     * appropriate.
>       */
>      uint32_t plat_res_int_priorities[] =3D {
> -        cpu_to_be32(7),    /* start */
> -        cpu_to_be32(0xf8), /* count */
> +        cpu_to_be32(xive->hv_prio),    /* start */
> +        cpu_to_be32(0xff - xive->hv_prio), /* count */
>      };
> =20
>      /* Thread Interrupt Management Area : User (ring 3) and OS (ring 2) =
*/
> @@ -844,19 +846,12 @@ type_init(spapr_xive_register_types)
>   */
> =20
>  /*
> - * Linux hosts under OPAL reserve priority 7 for their own escalation
> - * interrupts (DD2.X POWER9). So we only allow the guest to use
> - * priorities [0..6].
> + * On POWER9, the KVM XIVE device uses priority 7 for the escalation
> + * interrupts. So we only allow the guest to use priorities [0..6].
>   */
> -static bool spapr_xive_priority_is_reserved(uint8_t priority)
> +static bool spapr_xive_priority_is_reserved(SpaprXive *xive, uint8_t pri=
ority)
>  {
> -    switch (priority) {
> -    case 0 ... 6:
> -        return false;
> -    case 7: /* OPAL escalation queue */
> -    default:
> -        return true;
> -    }
> +    return priority >=3D xive->hv_prio;
>  }
> =20
>  /*
> @@ -1053,7 +1048,7 @@ static target_ulong h_int_set_source_config(PowerPC=
CPU *cpu,
>          new_eas.w =3D eas.w & cpu_to_be64(~EAS_MASKED);
>      }
> =20
> -    if (spapr_xive_priority_is_reserved(priority)) {
> +    if (spapr_xive_priority_is_reserved(xive, priority)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
>                        " is reserved\n", priority);
>          return H_P4;
> @@ -1212,7 +1207,7 @@ static target_ulong h_int_get_queue_info(PowerPCCPU=
 *cpu,
>       * This is not needed when running the emulation under QEMU
>       */
> =20
> -    if (spapr_xive_priority_is_reserved(priority)) {
> +    if (spapr_xive_priority_is_reserved(xive, priority)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
>                        " is reserved\n", priority);
>          return H_P3;
> @@ -1299,7 +1294,7 @@ static target_ulong h_int_set_queue_config(PowerPCC=
PU *cpu,
>       * This is not needed when running the emulation under QEMU
>       */
> =20
> -    if (spapr_xive_priority_is_reserved(priority)) {
> +    if (spapr_xive_priority_is_reserved(xive, priority)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
>                        " is reserved\n", priority);
>          return H_P3;
> @@ -1466,7 +1461,7 @@ static target_ulong h_int_get_queue_config(PowerPCC=
PU *cpu,
>       * This is not needed when running the emulation under QEMU
>       */
> =20
> -    if (spapr_xive_priority_is_reserved(priority)) {
> +    if (spapr_xive_priority_is_reserved(xive, priority)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
>                        " is reserved\n", priority);
>          return H_P3;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl89yqMACgkQbDjKyiDZ
s5Io2hAA2uNi4FOno+tP8bkETzoBzL8lnz0IusEAS8PZ3PwTn4z7W4x8xK8XMPvP
INQiS/suZddOf35vFOw2EVDa5iHwhFZE2+OOxrSn6Xko40HKlymOSXKLFgFmxbBn
S7neSM0wL9S035JWzOd648+4N0Cz5D36lXoJ7U20IBfW/ANx/tb7z0LHzaxn4inf
8QwMWNRR3hfRlnrQ9PkDzoKzTl0kF4se27ByqoFl/D7oaeOrK1l1YaHG7ikH8pBx
YMALMXnO/FPm+l/Eu1dcCQN6VXPPvb1kXtRRfzOautn6JXLHhcfiupycrkfOOMxY
qpDXJ5Ed5fjNKJH78Ym1HrdQTewbIE9uyE9Wtuz4G/9xdd63oe4cnQeDz6H8UxCc
fYVGADGeDF6FrSYtk7VktbtzyqsyhPPAeZ3LzX50JMJep44LEh4u7TNf7n0/BWR9
KKwq2hOi59lGswtwJ8qBrbapXRKbfHW+LTy/hMscuOMxAs8oQK06IX8bv9fC5VLB
hSg6lBWloF7AQ3O6KvAFmm/k0ODNZ3oUPkg5ThgWgarca+VHwEbvmxyFLhw4i4BC
tTjBoYmuH6Ey7pzm8Ky/bfTOMFVjOlgpKH3HMtcT4bXIJkJlLMFt60Z3FPjPR2yK
s5QeAuwVh7618NizNIDAF9aLP/l7EKElTxRT4+soAex6fOmbJL0=
=QjUH
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--

