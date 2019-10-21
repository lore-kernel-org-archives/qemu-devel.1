Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31E9CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A5D20873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A5D20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXmR-0004vV-OV
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMXjK-0002JD-IL
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMXjJ-0004Dr-Dh
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:28:14 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:41837)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMXjJ-0004DV-4W
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:28:13 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MG9Pg-1iEnxV1VJk-00GaMT; Mon, 21 Oct 2019 15:28:01 +0200
Subject: Re: [PATCH v8 7/9] linux-user/strace: Improve bind() output
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20191021114857.20538-1-f4bug@amsat.org>
 <20191021114857.20538-8-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b7b846a5-9f34-5db8-789d-0080a9ede29b@vivier.eu>
Date: Mon, 21 Oct 2019 15:27:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191021114857.20538-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XbGCrvgv2oYm9nf0ztG73LH44xsJyKHEUkrrruXrFXpkJT2TGPl
 jKCyZZBvBm/PIQ+7zUO8wKjKt0noUZuTfEJGzNq44Qg89/7OUgTo+lIlX4JgTRKCUa/RB6o
 ZhxM3RNPz14f4qtpU32kGhZvaWmtMVRPwFK7/o4LyJ8R9RS+tvgF675Ee1XR04dQiuUwi4I
 36FCOfnSBc+W3SWlOVPSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g9ycD2UmXWw=:rVdjpvHj5Oo8siKiFywk+u
 o9OA8EfjOhKSoBoObzyKJf6jS0qM8ZjnWxZyAPg0gz2hReWHj9z/TBlnx5z7Flw/pOyIQsgyL
 gvboQ4UcoTHiAMShIkDS/A+kqInhxdrJ3LjuW9O14EGxs8/MAiSzwOTNsyi7eUqNgLq2g3Zbj
 C6q2DqqBwkRU9HJuMDKmHMPvu1nPR6L6zWN9X5c9wEf2tqw5ygCOMEZE++Y7k121LWMhNavb9
 Byqy0YV+tdsOeFLm/9/zx8JnL4pfjidMmUXs3G7/Sa7ml1ICYIW6zhtcDyasUiVjDf0g79YPu
 JKTG4YHX8h5Udtptu7QiP+8sPc2itQtbw7+bDIgsrSK4e7Fm2ffVwNWYMbuS+kTG88YiFmTXd
 hppX4/+3zE3jPSnHaubYo/DzUZ6HrCSQXgR3rf44CqBAl3850G/8ieLRXhxl9ExMhm7OecUMr
 x5xNNJEaWlj4U0X/YPzvHYG/k5TZeUJqHRcM8GPwtfg0he8fQohxrsDNCyG2STatV7PNnAY9f
 wLfvL7GMxI8gHpW5JDVfWQfMRGijkGflZ7w1VrCuv5HwfM1Edlt+Hn3xK1tmkYCd2jSnqCkjB
 Uy9fqv0OffjkgmXuheMAhgrB9mElCYvg09i4SA2jpS113/TlOioIfvit/71AVB4RkutOT3Mpv
 Sx4+OLDzfyWQjhyXgo7nByq0Ly9sk2ACutISlaX+ScTLIKbQDA6VMId/m22TvgUSnY4OW7Xml
 3mefdJqe62KGDzZUegX3VbPZtHb8EuuREO5x2f7q/CUUOn+jgkYKAOTlS25RXRgRju61G1VLz
 fbymkniTqFCwSmT+v+UZL9SYKEmEbeFe6/E9CeOILl62l7dHIOTuXceycssY3M33TJfHFctl8
 0BXcsh0Za3916zgFxV6cx46TyF37MtcYLafCC3EXI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
Cc: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 21/10/2019 à 13:48, Philippe Mathieu-Daudé a écrit :
> Tested-By: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v6: use TARGET_NR_socketcall || TARGET_NR_bind (lvivier)
> ---
>  linux-user/strace.c    | 15 ++++++++++++++-
>  linux-user/strace.list |  2 +-
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 0ce2b658a5..cd92c77d33 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1707,7 +1707,7 @@ print_socket(const struct syscallname *name,
>  
>  #endif
>  
> -#if defined(TARGET_NR_socketcall)
> +#if defined(TARGET_NR_socketcall) || defined(TARGET_NR_bind)
>  
>  static void print_sockfd(abi_long sockfd, int last)
>  {
> @@ -2054,6 +2054,19 @@ print_socketcall(const struct syscallname *name,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_bind)
> +static void
> +print_bind(const struct syscallname *name,
> +           abi_long arg0, abi_long arg1, abi_long arg2,
> +           abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_sockfd(arg0, 0);
> +    print_sockaddr(arg1, arg2, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) || \
>      defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64)
>  static void
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 1ff9168369..957aa720af 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -41,7 +41,7 @@
>  { TARGET_NR_bdflush, "bdflush" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_bind
> -{ TARGET_NR_bind, "bind" , NULL, NULL, NULL },
> +{ TARGET_NR_bind, "bind" , NULL, print_bind, NULL },
>  #endif
>  #ifdef TARGET_NR_bpf
>  { TARGET_NR_bpf, "bpf" , NULL, NULL, NULL },
> 

Applied to my linux-user branch.

Thanks,
Laurent

