Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75413C48BD9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE3C2064A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE3C2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgY7N-0007AU-3H
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 13:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60759)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgY2F-0003d3-6L
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgY2D-0000TX-7V
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:18:11 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:35111)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hgY2C-0000SM-8G
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:18:09 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MTfgb-1i8DNj2imj-00U4oc; Thu, 27 Jun 2019 19:17:50 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1561649510-21183-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1561649510-21183-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <72e3d1bb-4f30-71a3-f343-71f7bd4d93e2@vivier.eu>
Date: Thu, 27 Jun 2019 19:17:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561649510-21183-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dFrw0A6px0UWcKigWbAvvt8cr16KkYLIaK/AzTvWlO5TDH4Ia46
 CYFgOoNKN/KVz54oB8gAOJ7hzTWx1sQSc6IKR6XIgp6Ev161jxQCg0QtKMQqkhpRS9ck8uD
 tEn3C9mlxxgALcydo7Sq7zUO7o829FvEx9Y9cMJo/i8apjWRnZc7Ijgv+Q0o3fWsgzKx+9k
 kw/Vl3uqP+O+PfyA8IoaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oBEU53nsMro=:KJHMapwswCUUs9D19dbHYS
 O9S1CrJRGcl3KnsL/21X7tVlsgUoXNUiry7cAkKEui3tgmxzMayulsD6VzTImtec9SpBDgNgV
 yKSUxne9/Q3uMGCLaDj2g5pdNrhjZHJ/N0/Z4/4ujTzEtoVf+fBFUcmOerIMx2ZCiK634c/iX
 I/zn389npMaMgS26Nq/ok0YK5hNsv90hCUVRrwN++UEFWPp/0f5+B7+uynsmVNkvqNouBaamH
 zaFkq9+xh0eG4EVmKgdWSHYaTA2qp03jroJaTaez0Zbhr7xbDzX+lVC2YpUE5FQst6A1Ng8eJ
 0vjK1RnDJy+tL550ihviKh6bgWsdWP5MjLQdqdIXxuvJvbMLwt8N4TpzuFeZOf5CauxyDa6ZR
 +VDUSOswGHuyo51/sqva1C2hccvf3AD2dj7jntptWM38MViSL2JlbwYSwq6669OgQleX9RhdH
 QoE63BZgEYqz2BVYKb20FS7htsz+fvGNUCsQX9JxUU+D7h2XMpZxLHsOWSTohrEjviAoea7xo
 crscoD1hRVL53UBt0aztybPa5cItOdqKAbE2mQyq+zHqU/wr71T16Xy/oqiAs9XsAwT/rLLYY
 29qYD5WiMoMcTT64V69V4eJiVcsd0RHqciJg2mYm/mTi3n8Hwnd6Ie1nO12WB7Om+cggFIuRU
 N+Tz26msofybED8TB7dLalyLMmxVPG5qtw2he0weJJec5LaiORAXcKhv9USzsnbKkKVMrAYVA
 Mt4HX+O0w8ooFf1encsTsQGn+0Zjo5LHt0qh6ILp+Jmnl5GqIt3FVsr3C14=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: Re: [Qemu-devel] [PATCH v14 5/5] linux-user: Handle EXCP_FPE
 properly for MIPS
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 27/06/2019 à 17:31, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Handle EXCP_FPE properly for MIPS in cpu loop.
> 
> Note that a vast majority of FP instructions are not affected by
> the absence of the code in this patch, as they use alternative code
> paths for handling floating point exceptions (see, for example,
> invocations of update_fcr31()) - they rely on softfloat library for
> keeping track on exceptions that needs to be raised. However, there
> are few MIPS FP instructions (an example is CTC1) that use function
> do_raise_exception() directly, and they need the case that is added
> in this patch to propagate the FPE exception as designed.
> 
> Reported-by: Yunqiang Su <ysu@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/mips/cpu_loop.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
> index 43ba267..7d3c6b9 100644
> --- a/linux-user/mips/cpu_loop.c
> +++ b/linux-user/mips/cpu_loop.c
> @@ -540,6 +540,12 @@ done_syscall:
>              info.si_code = TARGET_ILL_ILLOPC;
>              queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
>              break;
> +        case EXCP_FPE:
> +            info.si_signo = TARGET_SIGFPE;
> +            info.si_errno = 0;
> +            info.si_code = 0;
> +            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +            break;
>          /* The code below was inspired by the MIPS Linux kernel trap
>           * handling code in arch/mips/kernel/traps.c.
>           */
> 

I think you should set si_code according to FCSR Cause bits.
See force_fcr31_sig() in arch/mips/kernel/traps.c.

Thanks,
Laurent

