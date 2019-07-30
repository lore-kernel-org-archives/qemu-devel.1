Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565B7C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 15:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7CC206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 15:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7CC206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsU6q-00071p-Gz
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 11:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44795)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hsU5q-0006Ng-Bt
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hsU5o-0002mX-Vi
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:31:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hsU5o-0002io-Pr
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:31:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so66248502wrl.7
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 08:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8J3NE8IIlpYqZdQ6IG202nyQ8353ntqIWj2xg30dRhw=;
 b=F8GQzq3YFwtwTGb9ToKRzgJdSv0QEjIUXRUcWC4exmyh5qjwCBiuf+FSt+R5hbCCn1
 K+HrvRgDZ6joPlGiDSFf/XMDqyoClqPlK57WFGk0fNPlzf5b6UoSE9LwHTj2us32tOcF
 D75ParKQWuyLhPBaJacUnVGbiLfTOWFBh4byt5t7foPHHz9FFGoC51smnMwXKCbkkMb5
 fij2RlAoiNQFiso8pUqdEkuF9WV7zD6E7hV761kf/0+1zni1TNCZuomT3UR6j8pZQLzT
 W54qMKV58C7MnHzOKMSykArWcGxgNHKcBPoBR4N1H4m30quwbqlemmSeuUp8tPd5KYs5
 KovA==
X-Gm-Message-State: APjAAAXg+Sbn1wDNU/1amGJdh/QslugVbcMmoRBwduzVAwTYGYonbuxo
 l0Bm5jWelU1EapbSdBhcmYQUvQ==
X-Google-Smtp-Source: APXvYqw3WgMSeg7XBhU7eFym5HuqYb7GgcWUJyL6k4foIGyEBDgkjxa9FLW7drasgo7uQpcFdxmGuw==
X-Received: by 2002:a5d:6a84:: with SMTP id s4mr50866969wru.125.1564500671769; 
 Tue, 30 Jul 2019 08:31:11 -0700 (PDT)
Received: from [192.168.43.238] (63.red-95-127-155.staticip.rima-tde.net.
 [95.127.155.63])
 by smtp.gmail.com with ESMTPSA id n8sm53148891wro.89.2019.07.30.08.31.10
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jul 2019 08:31:11 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190730132522.27086-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c8d89a39-a711-a416-b069-5710d672b4e7@redhat.com>
Date: Tue, 30 Jul 2019 17:31:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190730132522.27086-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH for-4.1?] target/arm: Deliver BKPT/BRK
 exceptions to correct exception level
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/19 3:25 PM, Peter Maydell wrote:
> Most Arm architectural debug exceptions (eg watchpoints) are ignored
> if the configured "debug exception level" is below the current
> exception level (so for example EL1 can't arrange to get debug exceptions
> for EL2 execution). Exceptions generated by the BRK or BPKT instructions
> are a special case -- they must always cause an exception, so if
> we're executing above the debug exception level then we
> must take them to the current exception level.
> 
> This fixes a bug where executing BRK at EL2 could result in an
> exception being taken at EL1 (which is strictly forbidden by the
> architecture).
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1838277
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> At this point in the release cycle I'm not sure we should put this
> into 4.1 -- it is definitely a bug but it's not a regression as
> we've been wrong like this for multiple releases, pretty much
> since we put in the debug handling code I suspect.

The fix is quite trivial, and the user reported using a release, so
having it in the next release would be nice.
Or as usual, wait for 'last-minute-bugfix-that-postpone-another-rc' and
squeeze this fix in.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
>  target/arm/op_helper.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 1ab91f915e4..5e1625a1c8a 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -370,6 +370,9 @@ void HELPER(exception_with_syndrome)(CPUARMState *env, uint32_t excp,
>   */
>  void HELPER(exception_bkpt_insn)(CPUARMState *env, uint32_t syndrome)
>  {
> +    int debug_el = arm_debug_target_el(env);
> +    int cur_el = arm_current_el(env);
> +
>      /* FSR will only be used if the debug target EL is AArch32. */
>      env->exception.fsr = arm_debug_exception_fsr(env);
>      /* FAR is UNKNOWN: clear vaddress to avoid potentially exposing
> @@ -377,7 +380,18 @@ void HELPER(exception_bkpt_insn)(CPUARMState *env, uint32_t syndrome)
>       * exception/security level.
>       */
>      env->exception.vaddress = 0;
> -    raise_exception(env, EXCP_BKPT, syndrome, arm_debug_target_el(env));
> +    /*
> +     * Other kinds of architectural debug exception are ignored if
> +     * they target an exception level below the current one (in QEMU
> +     * this is checked by arm_generate_debug_exceptions()). Breakpoint
> +     * instructions are special because they always generate an exception
> +     * to somewhere: if they can't go to the configured debug exception
> +     * level they are taken to the current exception level.
> +     */
> +    if (debug_el < cur_el) {
> +        debug_el = cur_el;
> +    }
> +    raise_exception(env, EXCP_BKPT, syndrome, debug_el);
>  }
>  
>  uint32_t HELPER(cpsr_read)(CPUARMState *env)
> 

