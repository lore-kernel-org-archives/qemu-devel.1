Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A7BC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7830D2087C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7830D2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hta8Q-00006o-R2
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33352)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hta7z-0007yp-B1
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hta7v-0003s5-Qf
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:09:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hta7v-0003rP-KV
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:09:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id s49so38027074edb.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B3tFhL16YMGiSf5yeDk3MRj1S1UesQ0v+X2qOXYchns=;
 b=F7XjefTOf/otPOkRakyOKLJ0ZVDT3Fum8/iHVAr1c8NfCebs+AW9fA5/R2cyhC802H
 97fUH5pVLkq37XXryiFDZqvPpg+rncFNY8nKmJeMUbdg2Z+mX1r4tstlJLK8GciXo3fZ
 HbTRgiT0DjqSV4Kn0VDR4meajJH9FNyjhWuNth23reR4y/epCA+q0FuLIvdNwqcEZyJ7
 jGIrzViMIqETSoJgVU2G1BkZiTk2UPy/rTlnYUi421gPeBaGtDtn00VuOwQ+mCYEAp9z
 C480TWmQQkZvMFhj3PiWf+N52sXYyW7QkoxzfUGak32vyl8sVgQs3uCWjrGTFQbflpHF
 Rtdw==
X-Gm-Message-State: APjAAAW6hUbCHKCpHLjbp0+aXh24d1FiKAwjLouEiw4UgMbAyczV8+A1
 0piUoMSSaqU846ONd5INiACeXg==
X-Google-Smtp-Source: APXvYqzd/xlS4DGHz11Hz742gjhEHnqZ1n4xHnB6usEVviaPT43oe3UqTySPpYgyFg0vXdJpfKHSPg==
X-Received: by 2002:a17:906:ece1:: with SMTP id
 qt1mr108683902ejb.171.1564762194794; 
 Fri, 02 Aug 2019 09:09:54 -0700 (PDT)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id oo19sm12941722ejb.38.2019.08.02.09.09.53
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 09:09:54 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1564677923-23173-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1564677923-23173-10-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7e99749e-c534-a9e1-34c9-5db3d6f4a3c3@redhat.com>
Date: Fri, 2 Aug 2019 18:09:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564677923-23173-10-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.65
Subject: Re: [Qemu-devel] [PATCH for 4.2 v5 09/12] target/mips: Style
 improvements in internal.h
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/1/19 6:45 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Fixes mostly errors and warings reported by 'checkpatch.pl -f'.

"warnings"

> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/mips/internal.h | 57 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 22 deletions(-)
> 
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index d9216fb..836de7a 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -1,4 +1,5 @@
> -/* mips internal definitions and helpers
> +/*
> + * MIPS internal definitions and helpers
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>   * See the COPYING file in the top-level directory.
> @@ -8,8 +9,10 @@
>  #define MIPS_INTERNAL_H
>  
>  
> -/* MMU types, the first four entries have the same layout as the
> -   CP0C0_MT field.  */
> +/*
> + * MMU types, the first four entries have the same layout as the
> + * CP0C0_MT field.
> + */
>  enum mips_mmu_types {
>      MMU_TYPE_NONE,
>      MMU_TYPE_R4000,
> @@ -159,9 +162,11 @@ static inline bool cpu_mips_hw_interrupts_enabled(CPUMIPSState *env)
>          !(env->CP0_Status & (1 << CP0St_EXL)) &&
>          !(env->CP0_Status & (1 << CP0St_ERL)) &&
>          !(env->hflags & MIPS_HFLAG_DM) &&
> -        /* Note that the TCStatus IXMT field is initialized to zero,
> -           and only MT capable cores can set it to one. So we don't
> -           need to check for MT capabilities here.  */
> +        /*
> +         * Note that the TCStatus IXMT field is initialized to zero,
> +         * and only MT capable cores can set it to one. So we don't
> +         * need to check for MT capabilities here.
> +         */
>          !(env->active_tc.CP0_TCStatus & (1 << CP0TCSt_IXMT));
>  }
>  
> @@ -176,14 +181,18 @@ static inline bool cpu_mips_hw_interrupts_pending(CPUMIPSState *env)
>      status = env->CP0_Status & CP0Ca_IP_mask;
>  
>      if (env->CP0_Config3 & (1 << CP0C3_VEIC)) {
> -        /* A MIPS configured with a vectorizing external interrupt controller
> -           will feed a vector into the Cause pending lines. The core treats
> -           the status lines as a vector level, not as indiviual masks.  */
> +        /*
> +         * A MIPS configured with a vectorizing external interrupt controller
> +         * will feed a vector into the Cause pending lines. The core treats
> +         * the status lines as a vector level, not as indiviual masks.
> +         */
>          r = pending > status;
>      } else {
> -        /* A MIPS configured with compatibility or VInt (Vectored Interrupts)
> -           treats the pending lines as individual interrupt lines, the status
> -           lines are individual masks.  */
> +        /*
> +         * A MIPS configured with compatibility or VInt (Vectored Interrupts)
> +         * treats the pending lines as individual interrupt lines, the status
> +         * lines are individual masks.
> +         */
>          r = (pending & status) != 0;
>      }
>      return r;
> @@ -268,12 +277,14 @@ static inline int mips_vpe_active(CPUMIPSState *env)
>          active = 0;
>      }
>  
> -    /* Now verify that there are active thread contexts in the VPE.
> -
> -       This assumes the CPU model will internally reschedule threads
> -       if the active one goes to sleep. If there are no threads available
> -       the active one will be in a sleeping state, and we can turn off
> -       the entire VPE.  */
> +    /*
> +     * Now verify that there are active thread contexts in the VPE.
> +     *
> +     * This assumes the CPU model will internally reschedule threads
> +     * if the active one goes to sleep. If there are no threads available
> +     * the active one will be in a sleeping state, and we can turn off
> +     * the entire VPE.
> +     */
>      if (!(env->active_tc.CP0_TCStatus & (1 << CP0TCSt_A))) {
>          /* TC is not activated.  */
>          active = 0;
> @@ -396,10 +407,12 @@ static inline void compute_hflags(CPUMIPSState *env)
>              env->hflags |= MIPS_HFLAG_COP1X;
>          }
>      } else if (env->insn_flags & ISA_MIPS4) {
> -        /* All supported MIPS IV CPUs use the XX (CU3) to enable
> -           and disable the MIPS IV extensions to the MIPS III ISA.
> -           Some other MIPS IV CPUs ignore the bit, so the check here
> -           would be too restrictive for them.  */
> +        /*
> +         * All supported MIPS IV CPUs use the XX (CU3) to enable
> +         * and disable the MIPS IV extensions to the MIPS III ISA.
> +         * Some other MIPS IV CPUs ignore the bit, so the check here
> +         * would be too restrictive for them.
> +         */
>          if (env->CP0_Status & (1U << CP0St_CU3)) {
>              env->hflags |= MIPS_HFLAG_COP1X;
>          }
> 

