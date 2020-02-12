Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68181C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316472073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvznW50n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316472073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1lhK-0006Tg-DL
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 01:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j1lgX-0005wt-Oy
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j1lgW-00074E-31
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:39:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41228
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j1lgV-00072r-VG
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581489582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9357b9GEhhzGix2MX/8lNh81fBlwakg/V0dBaEag0Sw=;
 b=hvznW50nDs69xyGRhwAz+/huaghwqTJUnM9Jypd1acC3HZEsAYifL1T3LVqNiPaByeGJWR
 FJIhVdN0qGfszFXZnYZIrrPrAQD5RE47oah+ernQzBKSF8j4LK5rQI0owjt/uTQ4NoKPfW
 5IAYNGdC5oBvrbhsJoxeMlXbkZqBbAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-uCmCG7nQNdiqskOO2LQBXg-1; Wed, 12 Feb 2020 01:39:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 529C2800D4E;
 Wed, 12 Feb 2020 06:39:39 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-85.bne.redhat.com [10.64.54.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 751BA87B34;
 Wed, 12 Feb 2020 06:39:33 +0000 (UTC)
Subject: Re: [RESEND RFC PATCH v2 1/2] target/arm: Allow to inject SError
 interrupt
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20200205110541.37811-2-gshan@redhat.com>
Message-ID: <8dce7dbe-c6c1-122a-f960-0fc29257dd1c@redhat.com>
Date: Wed, 12 Feb 2020 17:39:31 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200205110541.37811-2-gshan@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: uCmCG7nQNdiqskOO2LQBXg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 aik@ozlabs.ru, maz@kernel.org, eric.auger@redhat.com, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 10:05 PM, Gavin Shan wrote:
> This allows to inject SError interrupt, which will be used on receiving
> QMP/HMP "nmi" command in next patch.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/arm/cpu.c    | 11 +++++++++++
>   target/arm/cpu.h    | 12 +++++++++---
>   target/arm/helper.c |  4 ++++
>   3 files changed, 24 insertions(+), 3 deletions(-)
> 

Hi Peter, could you please take a look when you get a chance? I'm not sure
the implementation is good enough to inject SError. If there are somebody
else who can help to review, please let me know so that I can copy her/him
either.

Thanks,
Gavin

> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index f86e71a260..24fd77437b 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -461,6 +461,17 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>           }
>       }
>   
> +    if (interrupt_request & CPU_INTERRUPT_SERROR) {
> +        excp_idx = EXCP_SERROR;
> +        target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
> +        if (arm_excp_unmasked(cs, excp_idx, target_el)) {
> +            cs->exception_index = excp_idx;
> +            env->exception.target_el = target_el;
> +            cc->do_interrupt(cs);
> +            ret = true;
> +        }
> +    }
> +
>       return ret;
>   }
>   
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 608fcbd0b7..0bbc46ff6d 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -49,6 +49,7 @@
>   #define EXCP_LAZYFP         20   /* v7M fault during lazy FP stacking */
>   #define EXCP_LSERR          21   /* v8M LSERR SecureFault */
>   #define EXCP_UNALIGNED      22   /* v7M UNALIGNED UsageFault */
> +#define EXCP_SERROR         23   /* SError Interrupt */
>   /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
>   
>   #define ARMV7M_EXCP_RESET   1
> @@ -79,9 +80,10 @@ enum {
>   };
>   
>   /* ARM-specific interrupt pending bits.  */
> -#define CPU_INTERRUPT_FIQ   CPU_INTERRUPT_TGT_EXT_1
> -#define CPU_INTERRUPT_VIRQ  CPU_INTERRUPT_TGT_EXT_2
> -#define CPU_INTERRUPT_VFIQ  CPU_INTERRUPT_TGT_EXT_3
> +#define CPU_INTERRUPT_FIQ    CPU_INTERRUPT_TGT_EXT_1
> +#define CPU_INTERRUPT_VIRQ   CPU_INTERRUPT_TGT_EXT_2
> +#define CPU_INTERRUPT_VFIQ   CPU_INTERRUPT_TGT_EXT_3
> +#define CPU_INTERRUPT_SERROR CPU_INTERRUPT_TGT_EXT_4
>   
>   /* The usual mapping for an AArch64 system register to its AArch32
>    * counterpart is for the 32 bit world to have access to the lower
> @@ -2731,6 +2733,10 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>           pstate_unmasked = !(env->daif & PSTATE_I);
>           break;
>   
> +    case EXCP_SERROR:
> +       pstate_unmasked = !(env->daif & PSTATE_A);
> +       break;
> +
>       case EXCP_VFIQ:
>           if (secure || !(hcr_el2 & HCR_FMO) || (hcr_el2 & HCR_TGE)) {
>               /* VFIQs are only taken when hypervized and non-secure.  */
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 19a57a17da..622a1d8796 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7980,6 +7980,7 @@ void arm_log_exception(int idx)
>               [EXCP_LAZYFP] = "v7M exception during lazy FP stacking",
>               [EXCP_LSERR] = "v8M LSERR UsageFault",
>               [EXCP_UNALIGNED] = "v7M UNALIGNED UsageFault",
> +            [EXCP_SERROR] = "SError Interrupt",
>           };
>   
>           if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
> @@ -8566,6 +8567,9 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>       case EXCP_VFIQ:
>           addr += 0x100;
>           break;
> +    case EXCP_SERROR:
> +        addr += 0x180;
> +        break;
>       default:
>           cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
>       }
> 


