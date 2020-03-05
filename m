Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F51C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9EC2073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2cS9qp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9EC2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mKO-0004Sy-Gt
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 03:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9mJO-0003ep-3y
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9mJM-0003Kh-L5
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:56:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29945
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9mJM-0003KK-H2
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583398616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrSlh9ik65tynWPZNMeYBhwd7tP0NflX0IrOMiNYvTs=;
 b=K2cS9qp9JQE4GDEb712oTWM74ED6yx0ofdc6jLkIffiwyKNTLUXzgySmmVa4HtPDfxfKdA
 PeQPuwiT6sUv7ft+cD5uNqkbGBQiEVkIj/kDZe7NJeJXVM2lOnwXH6NAdJaput3lD1mauC
 it1sLyxfxLQsMf9FzcFQ+TLQUhfMA3A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-wzRq6ws_N1iZ9ptimYsH7A-1; Thu, 05 Mar 2020 03:56:54 -0500
X-MC-Unique: wzRq6ws_N1iZ9ptimYsH7A-1
Received: by mail-ed1-f72.google.com with SMTP id p21so3788128edr.22
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 00:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zq9RrC3MbHUMZY3fa+af4p1TCVvaWshvRGf1ipkHZM0=;
 b=FdBqgWdSHv6sH8IcmM10VL9KMlEHkZWTRyo2+XYTGebXW1TvBThHb3mAr9ATf1WMaY
 KjkB5t9pS7KQSKXBwwSiRhT25DsB2rPcIdkRCNaaR4eLyrRmlY0v40G8DpB0Enmmar28
 6MH1+0zlvgRpob+arULBUMOHWsyRWX/UHYVcTejZ7Nq83CdEbpW5LlGBdwDmFNc8wwNq
 VuRQFLOdG3b0RXhQsgvr9aNvlTzvn4ultQ6T1cpjSIN4ie/zGpY9dcTB1IVyRdVTSJTL
 VTFs/l/Qr+csTPL52cM2hklnjkbKioe5CJTtU+Y1H+1193GiOMcS6vqHGSEh5skhPjvf
 gTSQ==
X-Gm-Message-State: ANhLgQ2RZHTsQuaOp31Nujrwe5npDGyZSE6P8MLKLCWp8/tnTBPU7I4z
 EpOLfTcZoCZvMdOtS6hgqqiV35gu0h2EYD3Vi77oE5NSfmZB/XRPIxsP2SwIVemPqBMC8cMsOCZ
 4ef71eRIOwkCNs7o=
X-Received: by 2002:a17:906:4f0b:: with SMTP id
 t11mr785433eju.231.1583398613173; 
 Thu, 05 Mar 2020 00:56:53 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu4a4E/BOY1z1WlIGkQDLNYiDslPJB6kTtgkJHz78jErLjvj4Y3vh18oBc2w5SufBlid4zdmQ==
X-Received: by 2002:a17:906:4f0b:: with SMTP id
 t11mr785410eju.231.1583398612873; 
 Thu, 05 Mar 2020 00:56:52 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id u35sm1521078edc.48.2020.03.05.00.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 00:56:52 -0800 (PST)
Subject: Re: [PATCH v7 07/17] target/ppc: Use class fields to simplify LPCR
 masking
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org, groug@kaod.org
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-8-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0f70320c-3b26-cc9e-d695-170bc50c916b@redhat.com>
Date: Thu, 5 Mar 2020 09:56:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303034351.333043-8-david@gibson.dropbear.id.au>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>, paulus@samba.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/3/20 4:43 AM, David Gibson wrote:
> When we store the Logical Partitioning Control Register (LPCR) we have a
> big switch statement to work out which are valid bits for the cpu model
> we're emulating.
>=20
> As well as being ugly, this isn't really conceptually correct, since it i=
s
> based on the mmu_model variable, whereas the LPCR isn't (only) about the
> MMU, so mmu_model is basically just acting as a proxy for the cpu model.
>=20
> Handle this in a simpler way, by adding a suitable lpcr_mask to the QOM
> class.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>   target/ppc/cpu-qom.h            |  1 +
>   target/ppc/mmu-hash64.c         | 36 ++-------------------------------
>   target/ppc/translate_init.inc.c | 27 +++++++++++++++++++++----
>   3 files changed, 26 insertions(+), 38 deletions(-)
>=20
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index e499575dc8..15d6b54a7d 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -177,6 +177,7 @@ typedef struct PowerPCCPUClass {
>       uint64_t insns_flags;
>       uint64_t insns_flags2;
>       uint64_t msr_mask;
> +    uint64_t lpcr_mask;         /* Available bits in the LPCR */
>       uint64_t lpcr_pm;           /* Power-saving mode Exit Cause Enable =
bits */
>       powerpc_mmu_t   mmu_model;
>       powerpc_excp_t  excp_model;
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index caf47ad6fc..0ef330a614 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1095,42 +1095,10 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cp=
u)
>  =20
>   void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
>   {
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>       CPUPPCState *env =3D &cpu->env;
> -    uint64_t lpcr =3D 0;
>  =20
> -    /* Filter out bits */
> -    switch (env->mmu_model) {
> -    case POWERPC_MMU_2_03: /* P5p */
> -        lpcr =3D val & (LPCR_RMLS | LPCR_ILE |
> -                      LPCR_LPES0 | LPCR_LPES1 |
> -                      LPCR_RMI | LPCR_HDICE);
> -        break;
> -    case POWERPC_MMU_2_06: /* P7 */
> -        lpcr =3D val & (LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_DPFD |
> -                      LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
> -                      LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2 |
> -                      LPCR_MER | LPCR_TC |
> -                      LPCR_LPES0 | LPCR_LPES1 | LPCR_HDICE);
> -        break;
> -    case POWERPC_MMU_2_07: /* P8 */
> -        lpcr =3D val & (LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV |
> -                      LPCR_DPFD | LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
> -                      LPCR_AIL | LPCR_ONL | LPCR_P8_PECE0 | LPCR_P8_PECE=
1 |
> -                      LPCR_P8_PECE2 | LPCR_P8_PECE3 | LPCR_P8_PECE4 |
> -                      LPCR_MER | LPCR_TC | LPCR_LPES0 | LPCR_HDICE);
> -        break;
> -    case POWERPC_MMU_3_00: /* P9 */
> -        lpcr =3D val & (LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
> -                      (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_A=
IL |
> -                      LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR=
_LD |
> -                      (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_=
EEE |
> -                      LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE | LPC=
R_TC |
> -                      LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE);
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -    env->spr[SPR_LPCR] =3D lpcr;
> +    env->spr[SPR_LPCR] =3D val & pcc->lpcr_mask;
>       ppc_hash64_update_rmls(cpu);
>       ppc_hash64_update_vrma(cpu);
>   }
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index f7acd3d61d..68aa4dfad8 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8476,6 +8476,8 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data=
)
>                       (1ull << MSR_DR) |
>                       (1ull << MSR_PMM) |
>                       (1ull << MSR_RI);
> +    pcc->lpcr_mask =3D LPCR_RMLS | LPCR_ILE | LPCR_LPES0 | LPCR_LPES1 |
> +        LPCR_RMI | LPCR_HDICE;
>       pcc->mmu_model =3D POWERPC_MMU_2_03;
>   #if defined(CONFIG_SOFTMMU)
>       pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
> @@ -8614,6 +8616,12 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data=
)
>                       (1ull << MSR_PMM) |
>                       (1ull << MSR_RI) |
>                       (1ull << MSR_LE);
> +    pcc->lpcr_mask =3D LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_DPFD |
> +        LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
> +        LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2 |
> +        LPCR_MER | LPCR_TC |
> +        LPCR_LPES0 | LPCR_LPES1 | LPCR_HDICE;
> +    pcc->lpcr_pm =3D LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2;
>       pcc->mmu_model =3D POWERPC_MMU_2_06;
>   #if defined(CONFIG_SOFTMMU)
>       pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
> @@ -8630,7 +8638,6 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
>       pcc->l1_dcache_size =3D 0x8000;
>       pcc->l1_icache_size =3D 0x8000;
>       pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_lpcr;
> -    pcc->lpcr_pm =3D LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2;
>   }
>  =20
>   static void init_proc_POWER8(CPUPPCState *env)
> @@ -8785,6 +8792,13 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data=
)
>                       (1ull << MSR_TS0) |
>                       (1ull << MSR_TS1) |
>                       (1ull << MSR_LE);
> +    pcc->lpcr_mask =3D LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV |
> +        LPCR_DPFD | LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
> +        LPCR_AIL | LPCR_ONL | LPCR_P8_PECE0 | LPCR_P8_PECE1 |
> +        LPCR_P8_PECE2 | LPCR_P8_PECE3 | LPCR_P8_PECE4 |
> +        LPCR_MER | LPCR_TC | LPCR_LPES0 | LPCR_HDICE;
> +    pcc->lpcr_pm =3D LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8_PECE2 |
> +                   LPCR_P8_PECE3 | LPCR_P8_PECE4;
>       pcc->mmu_model =3D POWERPC_MMU_2_07;
>   #if defined(CONFIG_SOFTMMU)
>       pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
> @@ -8802,8 +8816,6 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
>       pcc->l1_dcache_size =3D 0x8000;
>       pcc->l1_icache_size =3D 0x8000;
>       pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_lpcr;
> -    pcc->lpcr_pm =3D LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8_PECE2 |
> -                   LPCR_P8_PECE3 | LPCR_P8_PECE4;

Moving lpcr_pm in the same patch makes review slightly harder, anyway:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>   }
>  =20
>   #ifdef CONFIG_SOFTMMU
> @@ -8995,6 +9007,14 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data=
)
>                       (1ull << MSR_PMM) |
>                       (1ull << MSR_RI) |
>                       (1ull << MSR_LE);
> +    pcc->lpcr_mask =3D LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
> +        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
> +        LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |
> +        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
> +                             LPCR_DEE | LPCR_OEE))
> +        | LPCR_MER | LPCR_GTSE | LPCR_TC |
> +        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE;
> +    pcc->lpcr_pm =3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_=
OEE;
>       pcc->mmu_model =3D POWERPC_MMU_3_00;
>   #if defined(CONFIG_SOFTMMU)
>       pcc->handle_mmu_fault =3D ppc64_v3_handle_mmu_fault;
> @@ -9014,7 +9034,6 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>       pcc->l1_dcache_size =3D 0x8000;
>       pcc->l1_icache_size =3D 0x8000;
>       pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_lpcr;
> -    pcc->lpcr_pm =3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_=
OEE;
>   }
>  =20
>   #ifdef CONFIG_SOFTMMU
>=20


