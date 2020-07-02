Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565A3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B7620720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B7620720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2fx-0005tK-F9
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr2f8-0004cu-JN
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:06:14 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:37353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr2f6-0008Qi-AR
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:06:14 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mpkwn-1j1mn10fs5-00qBCk; Thu, 02 Jul 2020 19:06:02 +0200
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200626213937.20333-1-Filip.Bozuta@syrmia.com>
 <20200626213937.20333-2-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 1/3] linux-user: Add strace support for printing arguments
 of truncate()/ftruncate() and getsid()
Message-ID: <ad578ccc-1a25-c13e-eefd-b3e0070112ef@vivier.eu>
Date: Thu, 2 Jul 2020 19:06:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626213937.20333-2-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Uz9Q/Wcd0ub35MGIP279AWOrI9JCTOxlITMo4NjMVBZbazYw9gR
 1siVL9k38Xfyy4Dwoq5WwqWiHK/QPNQijXmLbEKsl4BLbw6RnIQPoLlXDCTxEmG/Mt43xtI
 TrNZsnlmQGdPfVwRSwCnlBj26thEA5jWPt0W7agvbkRJi7/SobBSK8wLWTx68Py8ZjxCXQK
 qjQv1K0je9ZfznN0Wwzaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AzXn2M4xAQg=:JymLyPakOYVlbbOSqYP6cB
 cB51odekgb/+vq+P5N/ThCw5R5Q+9gLZlFxBR31D56B57TW/e+KsVtYy2OUit/ZbFSE/UOaq9
 U5UfLLU67Hn5cypZLy0dkFkTm0FR7S2OLCuPRvtvqlAFbmMwEj4JcfWLbKYLDyMwVB0PMPdB+
 nSVJ39tTBG4UlPIF8ZzBEMk5QYTHh5k9bva9zpnMjftFbNsAQMAoYyxvhuXdWT+TWVHF7ltLy
 tplVjYTEr2LJjlgeXXwB1X/92Uy+hwgW5UEjG6yqsz1+UsmqLxK1fTvqPVLZYXDSdgi91zdKs
 MkVM/fc3tH+9wDMg+R38wWTLXtm88ah3wh+HVFY9iKPItoQNx+UWGtq/gzV+9X9o0FslV1JvH
 2AfENsxmIpM/5TM9Mv41OLZVsNA33H1E/mS/XJvddihUcaRmSMQscI7h7SEXUqPM0LkCLLRIZ
 lDhEDPNQcHnxfMsmGhoe+3MVMBZNXF//+gM3Fh+kP4b7XOhCWD/XFHLBEN74R2V4LmP/W6nOQ
 cd+Adkw6YK+O5BHgZLGIlQDSLM2ghYVSgKNC8hEoe8XVS+EiTrJI5wtmydSaVjL9zj3Wc5Fjs
 bWZ5bdmF9piZ3SvVFEkW3fy63DdZW6qS/lZvjLW8Zbk4ihabalJksnEy5QI1q03VKXBOzs5AI
 vq9ib8Lms3UFW37fz+JebZ0eArmafNpNtj2BxIc/JWENW+0nE4+Gc4DNqWKKq5qql7LljXHoD
 XIAhgGZ0sOt044t0c/XJslTJJdtUA6OMhJDW0iAbjQ1qc1AUsy0f+KdcBEnHOGsOpVm91Zbve
 fuTVUSKO22WJ4sQBrI4p1QgPygapIjIgtkHphboVcqNGbJdhCU=
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 10:57:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/06/2020 à 23:39, Filip Bozuta a écrit :
> This patch implements strace argument printing functionality for following syscalls:
> 
>     * truncate, ftruncate - truncate a file to a specified length
> 
>         int truncate(const char *path, off_t length)
>         int ftruncate(int fd, off_t length)
>         man page: https://man7.org/linux/man-pages/man2/truncate.2.html
> 
>     * getsid - get session ID
> 
>         pid_t getsid(pid_t pid)
>         man page: https://man7.org/linux/man-pages/man2/getsid.2.html
> 
> Implementation notes:
> 
>     Syscalls truncate/truncate64 takes string as argument type and thus a
>     separate print function "print_truncate/print_truncate64" is stated in
>     file "strace.list". This function is defined and implemented in "strace.c"
>     by using an existing function used to print string arguments: "print_string()".
>     The other syscalls have only primitive argument types, so the rest of the
>     implementation was handled by stating an appropriate printing format in file
>     "strace.list".
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/strace.c    | 14 ++++++++++++++
>  linux-user/strace.list | 10 +++++-----
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 6044c66954..dccfbc46e9 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1925,6 +1925,20 @@ print_lseek(const struct syscallname *name,
>  }
>  #endif
>  
> +#ifdef TARGET_NR_truncate
> +static void
> +print_truncate(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_string(arg0, 0);
> +    print_raw_param(TARGET_ABI_FMT_ld, arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#define print_truncate64     print_truncate
> +#endif
> +
>  #if defined(TARGET_NR_socket)
>  static void
>  print_socket(const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 10e3e4a814..3b77b22daf 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -258,10 +258,10 @@
>  { TARGET_NR_ftime, "ftime" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_ftruncate
> -{ TARGET_NR_ftruncate, "ftruncate" , NULL, NULL, NULL },
> +{ TARGET_NR_ftruncate, "ftruncate" , "%s(%d," TARGET_ABI_FMT_ld ")", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_ftruncate64
> -{ TARGET_NR_ftruncate64, "ftruncate64" , NULL, NULL, NULL },
> +{ TARGET_NR_ftruncate64, "ftruncate64" , "%s(%d," TARGET_ABI_FMT_ld ")", NULL, NULL },

This a little bit more complicated, see function target_ftruncate64().

>  #endif
>  #ifdef TARGET_NR_futex
>  { TARGET_NR_futex, "futex" , NULL, print_futex, NULL },
> @@ -372,7 +372,7 @@
>  { TARGET_NR_getrusage, "getrusage" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getsid
> -{ TARGET_NR_getsid, "getsid" , NULL, NULL, NULL },
> +{ TARGET_NR_getsid, "getsid" , "%s(%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getsockname
>  { TARGET_NR_getsockname, "getsockname" , NULL, NULL, NULL },
> @@ -1534,10 +1534,10 @@
>  { TARGET_NR_tkill, "tkill" , NULL, print_tkill, NULL },
>  #endif
>  #ifdef TARGET_NR_truncate
> -{ TARGET_NR_truncate, "truncate" , NULL, NULL, NULL },
> +{ TARGET_NR_truncate, "truncate" , NULL, print_truncate, NULL },
>  #endif
>  #ifdef TARGET_NR_truncate64
> -{ TARGET_NR_truncate64, "truncate64" , NULL, NULL, NULL },
> +{ TARGET_NR_truncate64, "truncate64" , NULL, print_truncate64, NULL },

See target_truncate64() for the arguments decoding.

>  #endif
>  #ifdef TARGET_NR_tuxcall
>  { TARGET_NR_tuxcall, "tuxcall" , NULL, NULL, NULL },
> 

Thanks,
Laurent

