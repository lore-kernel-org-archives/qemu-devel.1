Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C41ACA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E782070B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E782070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMUOQ-0008RC-Ch
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 05:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMUNV-0007SR-Bo
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMUNS-0005J0-S0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:53:29 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:35611)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMUNS-0005IZ-Ey
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:53:26 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MPooN-1iiqsx33tD-00MvUi; Mon, 21 Oct 2019 11:53:16 +0200
Subject: Re: [PATCH v7 7/9] linux-user/strace: Improve bind() output
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190915213924.22223-1-f4bug@amsat.org>
 <20190915213924.22223-8-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e88c0ef4-0f06-3300-a55c-292882ac86f4@vivier.eu>
Date: Mon, 21 Oct 2019 11:53:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190915213924.22223-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:my8xDItOgDjQ4d3PV/sTjD/j0yFE/x++7tvrG8EzBfJr9bDkXp4
 VDKn0ruyPzyTkzm2GfZoXbArmd6tTsXp3CqqYSIsw0cfIV3FXD8tB/wRwXFskxg41wNSfdx
 DwXsFHACVpdOI1+YGrfrXnVpS6AOy4AQ/rGEy0rTG/fRri3ytkbeu4/76FZtcrlAUEXPS26
 TNXHnYT9w5f9mh+8dn2fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hIpnoKy7Sr4=:SrWTdcmykRmQZskixDsh8V
 7J7tl3BlJsMEjv/m8lpa4B4KNv1oj6Hi63oNmoTw1FNAPiFO/HNNl/j3BabrudxyxahIum2h7
 BZoQulqPsChjfkqwP4Qp8vpvQKDEBBs9TeLETtkrgtKtbisd0ZCxOojV9rI06531LWec1ke6o
 KLXh5PcA1zxc4VvDVHW+VPOnwfTX+q8WFF9XIiMcgcoBHOqJ22BwWFiryp5OMoMJFK8jzPoJ/
 X5fbBHfMMVqAqutWDqF0WibT7unMWmWdtUF1ecJqm5Y7ozeGS70jMM4P4TL5F2QHdeYyGoWvz
 52F4n3hvm1nexn4FO+wbKQG5vJcEcnIxvaihP8CJq0Y4eW5GmbegPm+8o8AkXcSKRuUWZpQPz
 0tSq7aJP800C05c93ZyHzbew/G5lkKx9wjgrp9yz3phOWJVeeAYlhfIFr1FXalIvp0PczFWU5
 TLXSY5LgKUZaSTJ95CQfgItk3KCiHkQw0Zoqs9mEsWI36qTVR/EkZugrm4HagjXRFs5uyqPPT
 84oqACNuaxVHuETTZAGsaRDrGvsPqeEmu9tY3hSyK6djUpkaBFoAewNyW44Czi5P70z1NGn8E
 rRS+e61Toi2pLZ+kDUxUapso3WIBpZZbSCh3z5Dw5l5sZndXjx9ltQ0tHAcl5DJ8hF1vghXSj
 fX070Rz1cgpd8ks9B632bsWLsUKxp26u6a13uci5YoEZIO4WosDozPH6xDDyXs/yH+OcJ08UM
 GGIKNuNVji5nCqBpLn1/T35qJ+3JwVhVR7aKePUDcBwNfPV9Fiv5XpNBjnbrp/HDS/VTO9OPa
 nWRfB0H0VWeGhJLMEAIqk6wYMV10GwcL+esMu7FCchMjT6K+lRY+4f8pUJFSfiLRaHGHM/fG6
 LoJIpmBXirIzuo8gR1bJ8D31q0mvlCChyfzfH5GzY=
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

Le 15/09/2019 à 23:39, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-By: Guido Günther <agx@sigxcpu.org>
> ---
> v6: use TARGET_NR_socketcall || TARGET_NR_bind (lvivier)
> ---
>  linux-user/strace.c    | 15 ++++++++++++++-
>  linux-user/strace.list |  2 +-
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 01c802c4e3..6e82f6197a 100644
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


