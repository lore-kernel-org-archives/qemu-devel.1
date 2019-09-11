Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BF7ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BB921D79
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BB921D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wsR-0001qy-J5
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i7wlF-0003Cw-N1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i7wlE-0007Qi-0i
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:09:53 -0400
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:57269)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i7wlD-0007Pn-Qy
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:09:51 -0400
Received: from player734.ha.ovh.net (unknown [10.108.42.23])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 889F310FAAE
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 09:09:48 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id D364599CC69E;
 Wed, 11 Sep 2019 07:09:39 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20190911040452.8341-1-david@gibson.dropbear.id.au>
 <20190911040452.8341-2-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cf4fd712-1130-a977-6adc-9eccd31b55a4@kaod.org>
Date: Wed, 11 Sep 2019 09:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911040452.8341-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 11365959560230308646
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtddugdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.34.1
Subject: Re: [Qemu-devel] [PATCH 1/7] spapr: Simplify handling of pre ISA
 3.0 guest workaround handling
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
Cc: aik@ozlabs.ru, lvivier@redhat.com, philmd@redhat.com, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/09/2019 06:04, David Gibson wrote:
> Certain old guest versions don't understand the radix MMU introduced wi=
th
> POWER ISA 3.0, but incorrectly select it if presented with the option a=
t
> CAS time.  We workaround this in qemu by explicitly excluding the radix
> (and other ISA 3.0 linked) options if the guest doesn't explicitly note
> support for ISA 3.0.
>=20
> This is handled by the 'cas_legacy_guest_workaround' flag, which is pre=
tty
> vague.  Rename it to 'cas_pre_isa3_guest' to be clearer about what it's=
 for.
>=20
> In addition, we unnecessarily call spapr_populate_pa_features() with
> different options when initially constructing the device tree and when
> adjusting it at CAS time.  At the initial construct time cas_pre_isa3_g=
uest
> is already false, so we can still use the flag, rather than explicitly
> overriding it to be false at the callsite.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/spapr.c         | 10 ++++------
>  hw/ppc/spapr_hcall.c   |  3 +--
>  include/hw/ppc/spapr.h |  2 +-
>  3 files changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7124053b43..c551001f86 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -218,8 +218,7 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int o=
ffset, PowerPCCPU *cpu)
>  /* Populate the "ibm,pa-features" property */
>  static void spapr_populate_pa_features(SpaprMachineState *spapr,
>                                         PowerPCCPU *cpu,
> -                                       void *fdt, int offset,
> -                                       bool legacy_guest)
> +                                       void *fdt, int offset)
>  {
>      uint8_t pa_features_206[] =3D { 6, 0,
>          0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
> @@ -285,7 +284,7 @@ static void spapr_populate_pa_features(SpaprMachine=
State *spapr,
>      if ((spapr_get_cap(spapr, SPAPR_CAP_HTM) !=3D 0) && pa_size > 24) =
{
>          pa_features[24] |=3D 0x80;    /* Transactional memory support =
*/
>      }
> -    if (legacy_guest && pa_size > 40) {
> +    if (spapr->cas_pre_isa3_guest && pa_size > 40) {
>          /* Workaround for broken kernels that attempt (guest) radix
>           * mode when they can't handle it, if they see the radix bit s=
et
>           * in pa-features. So hide it from them. */
> @@ -348,8 +347,7 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachi=
neState *spapr)
>              return ret;
>          }
> =20
> -        spapr_populate_pa_features(spapr, cpu, fdt, offset,
> -                                   spapr->cas_legacy_guest_workaround)=
;
> +        spapr_populate_pa_features(spapr, cpu, fdt, offset);
>      }
>      return ret;
>  }
> @@ -551,7 +549,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, voi=
d *fdt, int offset,
>                            page_sizes_prop, page_sizes_prop_size)));
>      }
> =20
> -    spapr_populate_pa_features(spapr, cpu, fdt, offset, false);
> +    spapr_populate_pa_features(spapr, cpu, fdt, offset);
> =20
>      _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
>                             cs->cpu_index / vcpus_per_socket)));
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 23e4bdb829..3d3a67149a 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1765,8 +1765,7 @@ static target_ulong h_client_architecture_support=
(PowerPCCPU *cpu,
>              exit(EXIT_FAILURE);
>          }
>      }
> -    spapr->cas_legacy_guest_workaround =3D !spapr_ovec_test(ov1_guest,
> -                                                          OV1_PPC_3_00=
);
> +    spapr->cas_pre_isa3_guest =3D !spapr_ovec_test(ov1_guest, OV1_PPC_=
3_00);
>      spapr_ovec_cleanup(ov1_guest);
>      if (!spapr->cas_reboot) {
>          /* If spapr_machine_reset() did not set up a HPT but one is ne=
cessary
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 03111fd55b..dfec8e8e76 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -175,7 +175,7 @@ struct SpaprMachineState {
> =20
>      /* ibm,client-architecture-support option negotiation */
>      bool cas_reboot;
> -    bool cas_legacy_guest_workaround;
> +    bool cas_pre_isa3_guest;
>      SpaprOptionVector *ov5;         /* QEMU-supported option vectors *=
/
>      SpaprOptionVector *ov5_cas;     /* negotiated (via CAS) option vec=
tors */
>      uint32_t max_compat_pvr;
>=20


