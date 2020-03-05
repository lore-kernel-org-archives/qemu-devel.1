Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C74C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2D42073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yrpb3A/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2D42073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mLR-0005Tt-Ua
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 03:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9mKm-0004xi-DI
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9mKl-0004GW-2s
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:58:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37077
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9mKk-0004FU-V5
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583398701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b7pCAjGpUN2kZiyEX6tW2SrxhWS/wkFOVl8MErvim7Q=;
 b=Yrpb3A/PLgWqRcTOa/lJFTCV5fxe1ZjUJMd4XsW30dkYs1r395Pa54Du0NwSvhDeizMfMw
 5wD4YiiJ4vaLe2AUU4euQdZ05F/0lqe3iHsgpWKaYiMy+Hi1AA0Qt87wq5AXGpZOGgb9p5
 uWzqxUsmcaRxj9UQD5dOPEWBrMW+edo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-uAq87fy1OpK9ILJEVtd1Kw-1; Thu, 05 Mar 2020 03:58:20 -0500
X-MC-Unique: uAq87fy1OpK9ILJEVtd1Kw-1
Received: by mail-ed1-f71.google.com with SMTP id l8so3884855edq.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 00:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F7409IbmZrm8EY/bbX1VJwzGwZL/Lzq4sVk7B26+AqI=;
 b=jXu0g8mGF6sOHxWuqp7CAthOfjh0HFgpVdwOdEy65W/kWzj9JPF/XgNWyqJsEO9+w7
 20pGu1vdjvp4GFlDtc+jHTGzrN2jukXr27i7Zh5suSKgqPo5YupG5VxDFWFNZhnadUzi
 Bg6ImNXHDVcO0ydM5pD2MHpbkCZ65jeFSVEjNlL+dR8FyRvgPciKztr7TpES3zHREVoU
 WE6x8xSqKmECQvUexO0Q1D7SHXCfcy+7f6IpyFEkJ6Xgi1Fn4i0kmkKbL1neFIfyaois
 q9JohNdEKI/WgZunpET0e2GeGxC6GCKXvJL4+WjJXfGv1O4chenJrW6WxkBqDg/andU8
 BYZQ==
X-Gm-Message-State: ANhLgQ1DCxY9WMHF0mk3Txjc/vb4y2I3044Pyx6+TJUHN/26oM18ygac
 dXglUPsa8HMmiSrf3zfSx3m7czI/vRN8+Y8vXodU8vITqq8nU4MzoUCA0DC5Q03e5WMGxzH/5rH
 UfDeliKU05aIUDg8=
X-Received: by 2002:a17:906:23e2:: with SMTP id
 j2mr6322166ejg.257.1583398698673; 
 Thu, 05 Mar 2020 00:58:18 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvpKZEzRvmew9XnwJX6odn4sxN+QSS5wJ+COPORKfVgNOeNr6hnE5Ve3QiJL7s24NChc+fv+g==
X-Received: by 2002:a17:906:23e2:: with SMTP id
 j2mr6322130ejg.257.1583398698372; 
 Thu, 05 Mar 2020 00:58:18 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id o17sm14272edz.83.2020.03.05.00.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 00:58:17 -0800 (PST)
Subject: Re: [PATCH v7 01/17] ppc: Remove stub support for 32-bit hypervisor
 mode
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org, groug@kaod.org
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-2-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <80ff6c03-68ed-be51-22b9-208ce3a52332@redhat.com>
Date: Thu, 5 Mar 2020 09:58:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303034351.333043-2-david@gibson.dropbear.id.au>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
> a4f30719a8cd, way back in 2007 noted that "PowerPC hypervisor mode is not
> fundamentally available only for PowerPC 64" and added a 32-bit version
> of the MSR[HV] bit.
>=20
> But nothing was ever really done with that; there is no meaningful suppor=
t
> for 32-bit hypervisor mode 13 years later.  Let's stop pretending and jus=
t
> remove the stubs.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>   target/ppc/cpu.h                | 21 +++++++--------------
>   target/ppc/translate_init.inc.c |  6 +++---
>   2 files changed, 10 insertions(+), 17 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index b283042515..8077fdb068 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -24,8 +24,6 @@
>   #include "exec/cpu-defs.h"
>   #include "cpu-qom.h"
>  =20
> -/* #define PPC_EMULATE_32BITS_HYPV */
> -
>   #define TCG_GUEST_DEFAULT_MO 0
>  =20
>   #define TARGET_PAGE_BITS_64K 16
> @@ -300,13 +298,12 @@ typedef struct ppc_v3_pate_t {
>   #define MSR_SF   63 /* Sixty-four-bit mode                            h=
flags */
>   #define MSR_TAG  62 /* Tag-active mode (POWERx ?)                      =
      */
>   #define MSR_ISF  61 /* Sixty-four-bit interrupt mode on 630            =
      */
> -#define MSR_SHV  60 /* hypervisor state                               hf=
lags */
> +#define MSR_HV   60 /* hypervisor state                               hf=
lags */
>   #define MSR_TS0  34 /* Transactional state, 2 bits (Book3s)            =
      */
>   #define MSR_TS1  33
>   #define MSR_TM   32 /* Transactional Memory Available (Book3s)         =
      */
>   #define MSR_CM   31 /* Computation mode for BookE                     h=
flags */
>   #define MSR_ICM  30 /* Interrupt computation mode for BookE            =
      */
> -#define MSR_THV  29 /* hypervisor state for 32 bits PowerPC           hf=
lags */
>   #define MSR_GS   28 /* guest state for BookE                           =
      */
>   #define MSR_UCLE 26 /* User-mode cache lock enable for BookE           =
      */
>   #define MSR_VR   25 /* altivec available                            x h=
flags */
> @@ -401,10 +398,13 @@ typedef struct ppc_v3_pate_t {
>  =20
>   #define msr_sf   ((env->msr >> MSR_SF)   & 1)
>   #define msr_isf  ((env->msr >> MSR_ISF)  & 1)
> -#define msr_shv  ((env->msr >> MSR_SHV)  & 1)
> +#if defined(TARGET_PPC64)
> +#define msr_hv   ((env->msr >> MSR_HV)   & 1)
> +#else
> +#define msr_hv   (0)
> +#endif
>   #define msr_cm   ((env->msr >> MSR_CM)   & 1)
>   #define msr_icm  ((env->msr >> MSR_ICM)  & 1)
> -#define msr_thv  ((env->msr >> MSR_THV)  & 1)
>   #define msr_gs   ((env->msr >> MSR_GS)   & 1)
>   #define msr_ucle ((env->msr >> MSR_UCLE) & 1)
>   #define msr_vr   ((env->msr >> MSR_VR)   & 1)
> @@ -449,16 +449,9 @@ typedef struct ppc_v3_pate_t {
>  =20
>   /* Hypervisor bit is more specific */
>   #if defined(TARGET_PPC64)
> -#define MSR_HVB (1ULL << MSR_SHV)
> -#define msr_hv  msr_shv
> -#else
> -#if defined(PPC_EMULATE_32BITS_HYPV)
> -#define MSR_HVB (1ULL << MSR_THV)
> -#define msr_hv  msr_thv
> +#define MSR_HVB (1ULL << MSR_HV)
>   #else
>   #define MSR_HVB (0ULL)
> -#define msr_hv  (0)
> -#endif
>   #endif
>  =20
>   /* DSISR */
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 2f7125c51f..df3401cf06 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8764,7 +8764,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
>                           PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
>                           PPC2_TM | PPC2_PM_ISA206;
>       pcc->msr_mask =3D (1ull << MSR_SF) |
> -                    (1ull << MSR_SHV) |
> +                    (1ull << MSR_HV) |
>                       (1ull << MSR_TM) |
>                       (1ull << MSR_VR) |
>                       (1ull << MSR_VSX) |
> @@ -8976,7 +8976,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>                           PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
>                           PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
>       pcc->msr_mask =3D (1ull << MSR_SF) |
> -                    (1ull << MSR_SHV) |
> +                    (1ull << MSR_HV) |
>                       (1ull << MSR_TM) |
>                       (1ull << MSR_VR) |
>                       (1ull << MSR_VSX) |
> @@ -9186,7 +9186,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data=
)
>                           PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
>                           PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
>       pcc->msr_mask =3D (1ull << MSR_SF) |
> -                    (1ull << MSR_SHV) |
> +                    (1ull << MSR_HV) |
>                       (1ull << MSR_TM) |
>                       (1ull << MSR_VR) |
>                       (1ull << MSR_VSX) |
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


