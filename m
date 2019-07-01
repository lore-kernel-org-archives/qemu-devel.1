Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BB7C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FE82089C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FE82089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhryq-0008Ho-0p
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 04:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40170)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hhrxF-0007h9-Mz
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hhrxE-0004vr-II
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:46:29 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:48525)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hhrxE-0004v5-6U
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:46:28 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N5mSj-1iaysa3ubz-017HPa; Mon, 01 Jul 2019 10:46:12 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1561718618-20218-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1561718618-20218-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a1d26542-4e78-30cf-8e74-ab9fe9466622@vivier.eu>
Date: Mon, 1 Jul 2019 10:46:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561718618-20218-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Z8ci9peE/BfwBSjxVzl6P286brre4vqk0CXrKTQ6uGMKsmNJCZd
 31JckRpycpWLPBluvW7sFIc/4bi+9z1/hg4BpcCIcMQHdY/+7fKg7ycY2Ua53mW2OjAZ5Gu
 lF/KNWCePJEmbDEaaB5lEGZwUsmyW2RF6jTx9mQ+JxID5PTQmoz1yPKRH7tXt28mdXtNLHS
 9Efnx1r0dsIX1hPW+BeQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LsaFN/Nu518=:dI9xeVqYDS1QEhtdlADO3x
 XtDJpM5Ohqt8oWH5VioKJBPeK2pxcB3PikRlebMA31/A+yu/Zv2EZhYziVyUUvfPjMRafDGMG
 P+WNMr4QfbchO3M/7bFyAf/m/ghQLCdQdfb/14Uxtdv9uKphhfl2HsafF166DMTTSoTX4MSTH
 l3uJJFvDY/bTRcdtJ1XLjgvgaNFLrI51Q9ZLQkB0W4GiGC93RaDbvK/HmlavFsmrj6rQWdfRU
 zqY+sAPnnoGc+O/cQ47OSnTk44yO5j/TOZGR6yDUilD0R8xqj81yCkeZMJMCFaMUvwoHAo+6T
 6jtMZvuOkAn/zsn3MMVp4b0d7cTyJx1OozLWkZcmbW4uGmYSIUcEFWeghWDPEc70xx71I4lZ3
 Kf92cQS42sCahRYjgmFAcdme3G1w+2xSV4MV9V5oyVyMZIMZMZzdrFJ+igeCpMnGO+t+i7vVD
 RGFSCTxrVnk6EmoX8QA8w/ZYyE1s3D0Cpr3UJwmzD9xmYWi9+mFohkwz1rnIH+wuMI82TaWE8
 aMIULKEe69xBK1uOmxaax6XS7PUHNIPcLx6twzNfNv6mG9kDvlgGPVm9QOsnImX/M3JfNYmax
 ZbpoIi5VwxnkOLfPcFRxJFFyw4VokJvu+iq3OBKMVQXnWN01EmdtnLruqlQF4Z7l+fmNQ/D8g
 o7+2RINI7zJSrSFc8Vz6hlLtTn5rr8LHi7nWNL2uYbyGnd3j82KX3fBgcu3qvOG3PslpcSl7P
 oU8c4YCjEn3Pd3NVE6oHgkjzXhP+pe0iFG4Vn3kWTqzrjM+eFSdEtfzGG24=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH v16 5/5] linux-user: Handle EXCP_FPE
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

Le 28/06/2019 à 12:43, Aleksandar Markovic a écrit :
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
> The code is based on kernel's function force_fcr31_sig() in
> arch/mips/kernel.traps.c.
> 
> Reported-by: Yunqiang Su <ysu@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/mips/cpu_loop.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
> index 43ba267..0ba894f 100644
> --- a/linux-user/mips/cpu_loop.c
> +++ b/linux-user/mips/cpu_loop.c
> @@ -540,6 +540,23 @@ done_syscall:
>              info.si_code = TARGET_ILL_ILLOPC;
>              queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
>              break;
> +        case EXCP_FPE:
> +            info.si_signo = TARGET_SIGFPE;
> +            info.si_errno = 0;
> +            info.si_code = TARGET_FPE_FLTUNK;
> +            if (GET_FP_CAUSE(env->active_fpu.fcr31) & FP_INVALID) {
> +                info.si_code = TARGET_FPE_FLTINV;
> +            } else if (GET_FP_CAUSE(env->active_fpu.fcr31) & FP_DIV0) {
> +                info.si_code = TARGET_FPE_FLTDIV;
> +            } else if (GET_FP_CAUSE(env->active_fpu.fcr31) & FP_OVERFLOW) {
> +                info.si_code = TARGET_FPE_FLTOVF;
> +            } else if (GET_FP_CAUSE(env->active_fpu.fcr31) & FP_UNDERFLOW) {
> +                info.si_code = TARGET_FPE_FLTUND;
> +            } else if (GET_FP_CAUSE(env->active_fpu.fcr31) & FP_INEXACT) {
> +                info.si_code = TARGET_FPE_FLTRES;
> +            }
> +            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
> +            break;
>          /* The code below was inspired by the MIPS Linux kernel trap
>           * handling code in arch/mips/kernel/traps.c.
>           */
> 

Applied to my linux-user branch.

Thanks,
Laurent


