Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCD2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 450B4207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450B4207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwSTg-00065B-DD
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 10:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iwSSz-0005Xp-9t
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iwSSy-0005t5-74
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:07:49 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:36223)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iwSSx-0005sY-UN
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:07:48 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N1fzM-1jgkaB22C8-011xnr; Tue, 28 Jan 2020 16:07:31 +0100
To: Josh Kunz <jkz@google.com>, qemu-devel@nongnu.org
References: <20200117192808.129398-1-jkz@google.com>
 <20200117192808.129398-3-jkz@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 2/4] linux-user: Use `qemu_log' for strace
Message-ID: <ab5d3c15-9060-47be-fdb6-70ab76dfcc06@vivier.eu>
Date: Tue, 28 Jan 2020 16:07:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117192808.129398-3-jkz@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:M2JiKnbEyTiZz+HfH+8Dou4KiNEaLqyPMEivq1U9Nc4SRrX3oLQ
 dNbiZVOsB8xTcZ2yjmp9zfWyXVDMBgDIe22SkTLaT62/nDCc00NsppfgiNn5v+n+OLbLOvp
 p0mqce6hlRqs1YY6y+giFOf//+yUoCgCwN9X7y4u2derxKgZMT8zlpz4jd7Sb5Y6NvJKnTL
 49uWKi2wr9m5FLxIukANQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z2Cg77OVmL0=:AF68hd6i9ssxjn0Xyt6dSQ
 HuF6P7g7GsgifyYGOAt9mpLDXLlQPWafTDzRx6yFz0ny4dEzwyP+l/EeTVcf16pEffR4nkuiW
 YbhnlW3HE98uZ9hQgtVCPTsX7A/xyGZOe/hCWUNsIrsZR9VbBJBtEPltKcss7l3kyfMAHGhSe
 sL+WT6xIfsFJ1jX7WvHbSE72BSaEVFhhJqu3/8kuX1EYzwm6TY7y4MIm1vLw8SirVf349/aLr
 m+WSM/jYpg3RjBOaQgRzMif96zjQLIyccQ0Otw4re/ylNO1puZM4P+OKoZAI5D70C4plCZnue
 dZKrOhIU/lfxILxP430BZr2RfG6tYP5xvTGA/XkUxi1Xb8pQs+iOXPBOJhyPgeuvdCFwG0604
 OeI1X02KSuJcQS8gSGD1qVdyXUFzq69ZwVeOfKeqQySMr36bWqCI4k6GDvVJK3MqdvcCLQXjN
 7sUdTQF6Q3hcy63RRR2gUFNGAFi797MwitRRjnzbC1EcBa7bwHstdVT2wOOnXx/96u4AWOSH0
 sWjHgtIzMaeo5SMSehAS+K7iatoXhKUKGOLoR6W4zS8e14yaeei+OKWVgrxMzs5791//XWt0S
 WN73hE0h7aFOt8kWsP696/dGP0uTA+E/uLd+0C9KOSq7u7EipIF+8SJ+4N25GB8bUIc6zfRv6
 7EGjNMDgJkXSYq88bJ/EVw1FRgJtwxrZ5gxZr+cRc+CGklX+9ec84oz64OdhmUmv4WUbEr6Sw
 VdliwrPLC44BB2raB27W3ITYTMSlkUkJgjM3qx9JukMW6CFOkz06RJF7lrTVOBZ+vbgv7BEG9
 si3iOign7Wjs3cXuRVm6N2sGvkKlxWG1ZIagOEbl1Gfejvt/qvqlJtUnloMSaNOx592LGew
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: riku.voipio@iki.fi, alex.bennee@linaro.org, armbru@redhat.com,
 imp@bsdimp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/01/2020 à 20:28, Josh Kunz a écrit :
> This change switches linux-user strace logging to use the newer `qemu_log`
> logging subsystem rather than the older `gemu_log` (notice the "g")
> logger. `qemu_log` has several advantages, namely that it allows logging
> to a file, and provides a more unified interface for configuration
> of logging (via the QEMU_LOG environment variable or options).
> 
> This change introduces a new log mask: `LOG_STRACE` which is used for
> logging of user-mode strace messages.
> 
> Signed-off-by: Josh Kunz <jkz@google.com>
> ---
>  include/qemu/log.h   |   2 +
>  linux-user/main.c    |  30 ++-
>  linux-user/qemu.h    |   1 -
>  linux-user/signal.c  |   2 +-
>  linux-user/strace.c  | 479 ++++++++++++++++++++++---------------------
>  linux-user/syscall.c |  13 +-
>  util/log.c           |   2 +
>  7 files changed, 278 insertions(+), 251 deletions(-)
> 
...
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 629f3a21b5..54e60f3807 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12098,14 +12098,15 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>      record_syscall_start(cpu, num, arg1,
>                           arg2, arg3, arg4, arg5, arg6, arg7, arg8);
>  
> -    if (unlikely(do_strace)) {
> +    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
>          print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> -        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> -                          arg5, arg6, arg7, arg8);
> +    }
> +
> +    ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> +                      arg5, arg6, arg7, arg8);
> +
> +    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
>          print_syscall_ret(num, ret);
> -    } else {
> -        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> -                          arg5, arg6, arg7, arg8);
>      }
>  
>      record_syscall_return(cpu, num, ret);

In term of performance perhaps it sould be better to only test once for
the mask as it is done before?

For the other parts:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent

