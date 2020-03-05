Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BA4C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F35B2073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NswhO6+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F35B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mNW-0006qT-HF
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9mMF-0005zX-Ns
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9mME-0005I1-DK
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:59:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48606
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9mME-0005HP-A1
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583398794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nf3IzAsfWpRltOKV69pNDXqv9U6O1CXT0dJjE821guM=;
 b=NswhO6+ACf0iGEoM5MsJha/12QONsPogNMvP/aygYc89GqDLQ86uMra2XLn04f94QM6QBO
 wSQkeyTDaGBcqmpxArqXlmjpZGMS46VPPZWqy2obVFtkklhfJLfVCcUeE4+KwFxPvENC8W
 684j1KxDbw6Wp5Gj3RUKU3CbIB25IYQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-d6KZh1FKMaS1ZbRx_j1UZQ-1; Thu, 05 Mar 2020 03:59:50 -0500
X-MC-Unique: d6KZh1FKMaS1ZbRx_j1UZQ-1
Received: by mail-ed1-f70.google.com with SMTP id f13so3815312edy.21
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 00:59:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RzzfNNrAnfTG7m5PXfkWNiMAOxASmMaeWOk50HkuWwo=;
 b=boZF3auIDb8Gk7cqPcL3e/gVIhknE+G1rQ2cpnLAX5xStHng+zj7wxQVr5iGbaeAMo
 iHgzUI2RKTGtd8McQYXIyZMKrIGpzlpnENhx9j+Zpn2vBWd5ukWachiqWWJNFtBDTwp+
 fNw0NZ1Rv3FX8DrYnxXinFu7K50SUKGgFwKVeAAJyNXKnOdRkXqxDyKAIYHLzeN79VpI
 a2oLWlyEQpj//1aAjkYqWYN/iV5ruE88z1yGtBZih+7To9AKua2N2ne402JaWwlNTXeE
 1v4sr3rk1Tlc9cgh210jIU0+74l4BLTnCZHgbCp0mUQfuxgqg9YvzA0/RQ2ieydIF8E2
 TeFQ==
X-Gm-Message-State: ANhLgQ2/5IFR6ISy7N8Mh7RZfyRZwFFrfN1VcsmD4VWz4maeOJ+OnjQu
 H+u3fDCcx5i/gI7quhQOtK7MjxJg4v8b/XJCZ17USKTM1l2FuNATlkvdgb0UvgoZFus9xD7kwiX
 xnCfpzCXBnBctKKM=
X-Received: by 2002:aa7:d704:: with SMTP id t4mr6957001edq.46.1583398789165;
 Thu, 05 Mar 2020 00:59:49 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtGT4SHi7j5arFOZz8U72uVIdKE8e1ytfk0klEo0pZX8TSV3YFLVwId8inGVdwzJ1RVRV6o9w==
X-Received: by 2002:aa7:d704:: with SMTP id t4mr6956967edq.46.1583398788900;
 Thu, 05 Mar 2020 00:59:48 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id i14sm339169edk.16.2020.03.05.00.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 00:59:48 -0800 (PST)
Subject: Re: [PATCH v7 04/17] target/ppc: Introduce ppc_hash64_use_vrma()
 helper
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org, groug@kaod.org
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-5-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9ad055c0-aaeb-8645-ec2b-7f9956c5bf1a@redhat.com>
Date: Thu, 5 Mar 2020 09:59:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303034351.333043-5-david@gibson.dropbear.id.au>
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
> When running guests under a hypervisor, the hypervisor obviously needs to
> be protected from guest accesses even if those are in what the guest
> considers real mode (translation off).  The POWER hardware provides two
> ways of doing that: The old way has guest real mode accesses simply offse=
t
> and bounds checked into host addresses.  It works, but requires that a
> significant chunk of the guest's memory - the RMA - be physically
> contiguous in the host, which is pretty inconvenient.  The new way, known
> as VRMA, has guest real mode accesses translated in roughly the normal wa=
y
> but with some special parameters.
>=20
> In POWER7 and POWER8 the LPCR[VPM0] bit selected between the two modes, b=
ut
> in POWER9 only VRMA mode is supported and LPCR[VPM0] no longer exists.  W=
e
> handle that difference in behaviour in ppc_hash64_set_isi().. but not in
> other places that we blindly check LPCR[VPM0].
>=20
> Correct those instances with a new helper to tell if we should be in VRMA
> mode.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>   target/ppc/mmu-hash64.c | 43 ++++++++++++++++++++---------------------
>   1 file changed, 21 insertions(+), 22 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 392f90e0ae..e372c42add 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -668,6 +668,21 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU=
 *cpu,
>       return 0;
>   }
>  =20
> +static bool ppc_hash64_use_vrma(CPUPPCState *env)
> +{
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_3_00:
> +        /*
> +         * ISAv3.0 (POWER9) always uses VRMA, the VPM0 field and RMOR
> +         * register no longer exist
> +         */
> +        return true;
> +
> +    default:
> +        return !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> +    }
> +}
> +
>   static void ppc_hash64_set_isi(CPUState *cs, uint64_t error_code)
>   {
>       CPUPPCState *env =3D &POWERPC_CPU(cs)->env;
> @@ -676,15 +691,7 @@ static void ppc_hash64_set_isi(CPUState *cs, uint64_=
t error_code)
>       if (msr_ir) {
>           vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
>       } else {
> -        switch (env->mmu_model) {
> -        case POWERPC_MMU_3_00:
> -            /* Field deprecated in ISAv3.00 - interrupts always go to hy=
perv */
> -            vpm =3D true;
> -            break;
> -        default:
> -            vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> -            break;
> -        }
> +        vpm =3D ppc_hash64_use_vrma(env);
>       }
>       if (vpm && !msr_hv) {
>           cs->exception_index =3D POWERPC_EXCP_HISI;
> @@ -702,15 +709,7 @@ static void ppc_hash64_set_dsi(CPUState *cs, uint64_=
t dar, uint64_t dsisr)
>       if (msr_dr) {
>           vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM1);
>       } else {
> -        switch (env->mmu_model) {
> -        case POWERPC_MMU_3_00:
> -            /* Field deprecated in ISAv3.00 - interrupts always go to hy=
perv */
> -            vpm =3D true;
> -            break;
> -        default:
> -            vpm =3D !!(env->spr[SPR_LPCR] & LPCR_VPM0);
> -            break;
> -        }
> +        vpm =3D ppc_hash64_use_vrma(env);
>       }
>       if (vpm && !msr_hv) {
>           cs->exception_index =3D POWERPC_EXCP_HDSI;
> @@ -799,7 +798,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr,
>               if (!(eaddr >> 63)) {
>                   raddr |=3D env->spr[SPR_HRMOR];
>               }
> -        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +        } else if (ppc_hash64_use_vrma(env)) {
>               /* Emulated VRMA mode */
>               slb =3D &env->vrma_slb;
>               if (!slb->sps) {
> @@ -967,7 +966,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu=
, target_ulong addr)
>           } else if ((msr_hv || !env->has_hv_mode) && !(addr >> 63)) {
>               /* In HV mode, add HRMOR if top EA bit is clear */
>               return raddr | env->spr[SPR_HRMOR];
> -        } else if (env->spr[SPR_LPCR] & LPCR_VPM0) {
> +        } else if (ppc_hash64_use_vrma(env)) {
>               /* Emulated VRMA mode */
>               slb =3D &env->vrma_slb;
>               if (!slb->sps) {
> @@ -1056,8 +1055,7 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>       slb->sps =3D NULL;
>  =20
>       /* Is VRMA enabled ? */
> -    lpcr =3D env->spr[SPR_LPCR];
> -    if (!(lpcr & LPCR_VPM0)) {
> +    if (!ppc_hash64_use_vrma(env)) {
>           return;
>       }
>  =20
> @@ -1065,6 +1063,7 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>        * Make one up. Mostly ignore the ESID which will not be needed
>        * for translation
>        */
> +    lpcr =3D env->spr[SPR_LPCR];
>       vsid =3D SLB_VSID_VRMA;
>       vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
>       vsid |=3D (vrmasd << 4) & (SLB_VSID_L | SLB_VSID_LP);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


