Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CB9C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDAE2187F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDAE2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiiEb-0002Kn-Tq
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34899)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hii9K-0006wa-8j
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hii9H-0004PW-C3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:30:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hii9H-0004LW-3f
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:30:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id u8so3100230wmm.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 09:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fAgKoVc5rJpOBso8YWvFvQkqXAsIN6gxNQmHw50/uC0=;
 b=AR9VyPg147uiNuI/B1dE/wjyC978Yz+4obOouzdM/Eqp+i4pkNdZFcnFPV8qVbHSeG
 XnYknxNamywqkXqo1xJ3DUT1RPhb85/05+cuksJ5H83yGEcfcS7BH3VC4ZV3rtW7jdRD
 gaCA++rzlyZ4pcD5i2n8ZXLOOKvXl7NZG/LDu+fZO8mKYRzh1/Uebj9Z6Vw23cOFARxt
 an1CmK3i/KKC5s5hgTYKQ+aODcwh1VCMAOkdBihTlRCHJZ+ElMZfVaoHfDPjx7ybq5uL
 +WTqhpnGlnAox9Ji9l3GP1anC6Z7S4Kn+UFdtAOPpQLFWeRvMttafuWi3bZM18TZG6Kg
 UVeg==
X-Gm-Message-State: APjAAAX47MvZ8cE9bL68cmwNaNUM3CdmGa4psYwEgHUwsq/eLgn78S64
 jqqvd/vgTBMjI4rtPVF6TnNDKw==
X-Google-Smtp-Source: APXvYqwLi2R9eXlhAMaOttzbzkRGUsyUXAOfFnwFk0BXbgzimxRufBFJ2yYLXY2Ns3+3oP0tFxT+ug==
X-Received: by 2002:a1c:411:: with SMTP id 17mr7862812wme.74.1562171415654;
 Wed, 03 Jul 2019 09:30:15 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id h6sm3323312wre.82.2019.07.03.09.30.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 09:30:14 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190703155244.28166-1-alex.bennee@linaro.org>
 <20190703155244.28166-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2c0b9e7f-f4d1-b52b-1f3a-4100bf50c151@redhat.com>
Date: Wed, 3 Jul 2019 18:30:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703155244.28166-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v1 4/4] target/arm: remove run time
 semihosting checks
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex, Peter.

On 7/3/19 5:52 PM, Alex Bennée wrote:
> Now we do all our checking and use a common EXCP_SEMIHOST for
> semihosting operations we can make helper code a lot simpler.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/helper.c | 84 +++++++++------------------------------------
>  1 file changed, 17 insertions(+), 67 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ad29dc4072..5c1f741380 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10364,83 +10364,33 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>                    new_el, env->pc, pstate_read(env));
>  }
>  
> -static inline bool check_for_semihosting(CPUState *cs)
> +/*
> + * Check whether this exception is a semihosting call; if so
> + * then handle it and return true; otherwise return false.
> + *
> + * All the permission and validity checks are done at translate time.
> + */
> +static inline bool handle_semihosting(CPUState *cs)
>  {
> -    /* Check whether this exception is a semihosting call; if so
> -     * then handle it and return true; otherwise return false.
> -     */
>      ARMCPU *cpu = ARM_CPU(cs);
>      CPUARMState *env = &cpu->env;
>  
> -    if (is_a64(env)) {
> -        if (cs->exception_index == EXCP_SEMIHOST) {
> -            /* This is always the 64-bit semihosting exception.
> -             * The "is this usermode" and "is semihosting enabled"
> -             * checks have been done at translate time.
> -             */
> +    if (cs->exception_index == EXCP_SEMIHOST) {
> +        if (is_a64(env)) {
>              qemu_log_mask(CPU_LOG_INT,
>                            "...handling as semihosting call 0x%" PRIx64 "\n",
>                            env->xregs[0]);
>              env->xregs[0] = do_arm_semihosting(env);
> -            return true;
> -        }
> -        return false;
> -    } else {
> -        uint32_t imm;
> -
> -        /* Only intercept calls from privileged modes, to provide some
> -         * semblance of security.
> -         */
> -        if (cs->exception_index != EXCP_SEMIHOST &&
> -            (!semihosting_enabled() ||
> -             ((env->uncached_cpsr & CPSR_M) == ARM_CPU_MODE_USR))) {
> -            return false;
> -        }
> -
> -        switch (cs->exception_index) {
> -        case EXCP_SEMIHOST:
> -            /* This is always a semihosting call; the "is this usermode"
> -             * and "is semihosting enabled" checks have been done at
> -             * translate time.
> -             */
> -            break;
> -        case EXCP_SWI:
> -            /* Check for semihosting interrupt.  */
> -            if (env->thumb) {
> -                imm = arm_lduw_code(env, env->regs[15] - 2, arm_sctlr_b(env))
> -                    & 0xff;
> -                if (imm == 0xab) {
> -                    break;
> -                }
> -            } else {
> -                imm = arm_ldl_code(env, env->regs[15] - 4, arm_sctlr_b(env))
> -                    & 0xffffff;
> -                if (imm == 0x123456) {
> -                    break;
> -                }
> -            }
> -            return false;
> -        case EXCP_BKPT:
> -            /* See if this is a semihosting syscall.  */
> -            if (env->thumb) {
> -                imm = arm_lduw_code(env, env->regs[15], arm_sctlr_b(env))
> -                    & 0xff;
> -                if (imm == 0xab) {
> -                    env->regs[15] += 2;
> -                    break;
> -                }
> -            }
> -            return false;
> -        default:
> -            return false;
> +        } else {
> +            qemu_log_mask(CPU_LOG_INT,
> +                          "...handling as semihosting call 0x%x\n",
> +                          env->regs[0]);
> +            env->regs[0] = do_arm_semihosting(env);
>          }
> -
> -        qemu_log_mask(CPU_LOG_INT,
> -                      "...handling as semihosting call 0x%x\n",
> -                      env->regs[0]);
> -        env->regs[0] = do_arm_semihosting(env);
>          return true;
>      }
> +
> +    return false;
>  }
>  
>  /* Handle a CPU exception for A and R profile CPUs.
> @@ -10476,7 +10426,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
>       * code that caused the exception, not the target exception level,
>       * so must be handled here.
>       */
> -    if (check_for_semihosting(cs)) {
> +    if (handle_semihosting(cs)) {
>          return;
>      }
>  
> 

This patch clashes with this one:
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00343.html
that Peter already queued:
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00692.html

Peter, if you want this for 4.1, it might be easier to dequeue "Restrict
semi-hosting to TCG", apply Alex series, and re-apply "Restrict
semi-hosting to TCG", the conflicts should be trivial (function name
changed check_for_semihosting -> handle_semihosting).

Thanks,

Phil.

