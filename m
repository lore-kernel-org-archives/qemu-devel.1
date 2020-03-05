Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23574C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4D62073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJ2Mnaey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4D62073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mH3-00023x-TB
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 03:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9mGB-0001R2-RV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9mGA-0001qq-HG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:53:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25172
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9mGA-0001qJ-DI
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583398417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QuD/iIzXJJlyFd4ulk9EBfJ3NiOr4wRhXZ2OC5fnZsM=;
 b=bJ2MnaeyIFBjCwvMlTBJhAbjlhWJFR2n8k7F2x0XiT7E9tcDswALAZAZxOlg8W0Jy/TaG3
 lT0sD5PJqNKf5LNEp9hkefrPNvRCiobxwZBPR+N7OzU9ROOKqqIcRb5giysYb/KBTa0mjS
 bZNR/NU6hYe7CRVM+hI0JJOIqX+6g1A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-xOHCxmmXMOuF3KReF_QrCg-1; Thu, 05 Mar 2020 03:53:34 -0500
X-MC-Unique: xOHCxmmXMOuF3KReF_QrCg-1
Received: by mail-ed1-f71.google.com with SMTP id y35so3837992ede.4
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 00:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8dOeQU13NTXOshoPDXo+wWOVlHIjxInXiVBBGEDP5yw=;
 b=oVFw2TnTwy+Svn3AkgmWAp1KYEXWBG6e4WO/Xc27SeTqedl29RXRBjTt/PLeCYSZuy
 bh91J3bW5KY4tr6dH84qUGt9VQOkS5tZ7MdzjqqH3Bx7mWWomDbqh1j00qzYnwVpvHc7
 rnJIiBcusdkWavJ3LbYh9I2bJpa3sxGswSMfuXU6wST21XQexdFblyW3LXnMdNWCpfDd
 ecr593SVOJpcz0+lRr6rKVpKOQicPkC6LqSi+YlD/Ux2K84x8zNE36NBcloUm8ZT5ihG
 lbBAvp2/MJOGU1PQfFZlBngoewdD6BA+kXX9Va+d4nWGJ1FY/z6sl1W8MOOb0QSwzF33
 4EWg==
X-Gm-Message-State: ANhLgQ2gPieNe4tI83ykka3tT32Dgyy5/Recvbjn8UwNKRBEqaen/tmc
 EAIRIQYiPY791bolIqb5SLWG7oSIELQMKVslTPHlG78Sc1hRsErY21UUm1S56peQwVwsAr6hFuc
 dPkLLjWSnrflH0UY=
X-Received: by 2002:a17:906:a454:: with SMTP id
 cb20mr6495793ejb.205.1583398412741; 
 Thu, 05 Mar 2020 00:53:32 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvSUJUEqzkSNQg5rg8IZHNjvYT47QG5pyYODWm9NAwsYpiyZH0VTeMLe5btt3IRq9b/Q9PnNg==
X-Received: by 2002:a17:906:a454:: with SMTP id
 cb20mr6495759ejb.205.1583398412471; 
 Thu, 05 Mar 2020 00:53:32 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id i17sm563750edj.72.2020.03.05.00.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 00:53:31 -0800 (PST)
Subject: Re: [PATCH v7 08/17] target/ppc: Streamline calculation of RMA limit
 from LPCR[RMLS]
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org, groug@kaod.org
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-9-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a760a28a-c7e5-ad00-544c-57075ffbdd65@redhat.com>
Date: Thu, 5 Mar 2020 09:53:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303034351.333043-9-david@gibson.dropbear.id.au>
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
> Currently we use a big switch statement in ppc_hash64_update_rmls() to wo=
rk
> out what the right RMA limit is based on the LPCR[RMLS] field.  There's n=
o
> formula for this - it's just an arbitrary mapping defined by the existing
> CPU implementations - but we can make it a bit more readable by using a
> lookup table rather than a switch.  In addition we can use the MiB/GiB
> symbols to make it a bit clearer.
>=20
> While there we add a bit of clarity and rationale to the comment about
> what happens if the LPCR[RMLS] doesn't contain a valid value.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>   target/ppc/mmu-hash64.c | 63 ++++++++++++++++++-----------------------
>   1 file changed, 27 insertions(+), 36 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 0ef330a614..934989e6d9 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -18,6 +18,7 @@
>    * License along with this library; if not, see <http://www.gnu.org/lic=
enses/>.
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/units.h"
>   #include "cpu.h"
>   #include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
> @@ -757,6 +758,31 @@ static void ppc_hash64_set_c(PowerPCCPU *cpu, hwaddr=
 ptex, uint64_t pte1)
>       stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
>   }
>  =20
> +static target_ulong rmls_limit(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    /*
> +     * This is the full 4 bits encoding of POWER8. Previous
> +     * CPUs only support a subset of these but the filtering
> +     * is done when writing LPCR.
> +     *
> +     * Unsupported values mean the OS has shot itself in the
> +     * foot. Return a 0-sized RMA in this case, which we expect
> +     * to trigger an immediate DSI or ISI

Maybe use qemu_log(GUEST_ERROR) then? (as a follow-up patch).

> +     */
> +    static const target_ulong rma_sizes[16] =3D {
> +        [1] =3D 16 * GiB,
> +        [2] =3D 1 * GiB,
> +        [3] =3D 64 * MiB,
> +        [4] =3D 256 * MiB,
> +        [7] =3D 128 * MiB,
> +        [8] =3D 32 * MiB,
> +    };
> +    target_ulong rmls =3D (env->spr[SPR_LPCR] & LPCR_RMLS) >> LPCR_RMLS_=
SHIFT;
> +
> +    return rma_sizes[rmls];
> +}
> +
>   int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
>                                   int rwx, int mmu_idx)
>   {
> @@ -1006,41 +1032,6 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, ta=
rget_ulong ptex,
>       cpu->env.tlb_need_flush =3D TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_=
FLUSH;
>   }
>  =20
> -static void ppc_hash64_update_rmls(PowerPCCPU *cpu)
> -{
> -    CPUPPCState *env =3D &cpu->env;
> -    uint64_t lpcr =3D env->spr[SPR_LPCR];
> -
> -    /*
> -     * This is the full 4 bits encoding of POWER8. Previous
> -     * CPUs only support a subset of these but the filtering
> -     * is done when writing LPCR
> -     */
> -    switch ((lpcr & LPCR_RMLS) >> LPCR_RMLS_SHIFT) {
> -    case 0x8: /* 32MB */
> -        env->rmls =3D 0x2000000ull;
> -        break;
> -    case 0x3: /* 64MB */
> -        env->rmls =3D 0x4000000ull;
> -        break;
> -    case 0x7: /* 128MB */
> -        env->rmls =3D 0x8000000ull;
> -        break;
> -    case 0x4: /* 256MB */
> -        env->rmls =3D 0x10000000ull;
> -        break;
> -    case 0x2: /* 1GB */
> -        env->rmls =3D 0x40000000ull;
> -        break;
> -    case 0x1: /* 16GB */
> -        env->rmls =3D 0x400000000ull;
> -        break;
> -    default:
> -        /* What to do here ??? */
> -        env->rmls =3D 0;
> -    }

Good refactor.
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> -}
> -
>   static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>   {
>       CPUPPCState *env =3D &cpu->env;
> @@ -1099,7 +1090,7 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong v=
al)
>       CPUPPCState *env =3D &cpu->env;
>  =20
>       env->spr[SPR_LPCR] =3D val & pcc->lpcr_mask;
> -    ppc_hash64_update_rmls(cpu);
> +    env->rmls =3D rmls_limit(cpu);
>       ppc_hash64_update_vrma(cpu);
>   }
>  =20
>=20


