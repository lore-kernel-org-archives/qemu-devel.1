Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5CCC31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6858C2147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6858C2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbSTd-00038P-MW
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57661)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hbRdu-0003v3-6n
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hbRdr-0005Oz-UQ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:27:57 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:37289)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hbRdo-0005JW-LF
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:27:54 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MYvTy-1i69hp3DQ8-00UpoQ; Thu, 13 Jun 2019 17:22:41 +0200
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190519201953.20161-1-richard.henderson@linaro.org>
 <20190519201953.20161-11-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7ba0aa43-5050-9d4b-5067-e51282d7ed82@vivier.eu>
Date: Thu, 13 Jun 2019 17:22:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190519201953.20161-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qVzPkOxWwEr/1AOV6ihyD2ewpDTuvowQTmTFVIm8qmNVmxgL3lH
 kIOX3NOgRKnI+H3BRUaa+aeLXu1dh9a+/gVs2FjFYuO3BEza/cIivie3bZE4THXA2QYvOMz
 jpLzM39nkjBzG3OPW/14s457hP7C1MOREs0zzEnqdGSduInP3oMCLiA4Zx8wh4l1sOrl/3q
 v3bjDtyzt2fkFmNXKvxog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zuh2O1fTF2Y=:eAj3tprLEdo8VanFu5HYDt
 /Yjo1dyyHnn4ZkgYgmiys4pVTx9MpJrDZjhFPzX3T6YuOoCYBiMxdIScCKi5urMSL2/EaL/VH
 cYq6ORZbcicBGx8JOpy56x9d/w+LPsqFAeZfAucedVsHEQJwkI6oRhqItYGn0J4yHN+pHNFbV
 2Y8X2xcRX0wheEDxK1A6qqkNy10lEU9rEmRuYOGdRPBVafNGP1VJ2Tk0BM5RrxCsBxu4L1AjB
 vDZvsmoAXpkZTxxyjp6bWVHueNHA8zQwyBOcKRz8qU/48yetyutwcT/3NuHBmclrRxMZ5QUz4
 eBMWb3CbkcOsIBWNo5RtAV8Oxxfdts8E9BG/dxNz4XDKEuOiLZ/bdx8SwVK80RNuOGnKokdcb
 +XkdG87UqCgQ9J10Yykw4zSQxYP+yUPe/SBZPkjG1EvMP44czwrKGkCAz9Lr3bq/m56lZxzKQ
 k63royCSF6TSd/9LQElmhGIEiloIVupU6ZUT22KQ3mst9fA1lzgHIcIqNS4t/cOOpBjcfrN7W
 7lJzFXdQxInc/+MUN3nCWu+98NWF6taH45xPrLJolTHefeO/qxijcTQtPkToYp7IIrdyEpUtp
 cQCWDR1uh1eMZm4oOstxTqQazzKMS9lv3p44eKplBR9m/NaMkKllv6P4GFFlwt9fNyp0NVg2z
 wgRmyflT8md7nG9VgFuNCwTzLyeZxhdo7R0XYFFlZBm6aDQAsCoYtpikHwGtjU7KJbICceJBN
 KtFVE2b6DHQElttsLW4bgzGWuG9CxOEnpRYSMt7b6IkSzmeEug/+7KgK9cdmM8ZSriAkLMBmK
 n+6k28BeuiLNkQC9qCgCl+gkFkztA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH 10/13] scripts/qemu-binfmt-conf: Update for
 sparc64
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/05/2019 à 22:19, Richard Henderson a écrit :
> Also note that we were missing the qemu_target_list entry
> for plain sparc; fix that at the same time.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  scripts/qemu-binfmt-conf.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index b5a16742a1..9f1580a91c 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -1,8 +1,8 @@
>  #!/bin/sh
>  # Enable automatic program execution by the kernel.
>  
> -qemu_target_list="i386 i486 alpha arm armeb sparc32plus ppc ppc64 ppc64le m68k \
> -mips mipsel mipsn32 mipsn32el mips64 mips64el \
> +qemu_target_list="i386 i486 alpha arm armeb sparc sparc32plus sparc64 \
> +ppc ppc64 ppc64le m68k mips mipsel mipsn32 mipsn32el mips64 mips64el \
>  sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
>  microblaze microblazeel or1k x86_64"
>  
> @@ -38,6 +38,10 @@ sparc32plus_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x
>  sparc32plus_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
>  sparc32plus_family=sparc
>  
> +sparc64_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x2b'
> +sparc64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
> +sparc64_family=sparc
> +
>  ppc_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14'
>  ppc_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
>  ppc_family=ppc
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>

