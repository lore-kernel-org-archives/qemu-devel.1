Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E01C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C5C206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C5C206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3dHq-0003oP-Jy
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 05:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j3dH0-00033L-8W
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j3dGw-0001ty-J6
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:05:06 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:39705)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j3dGw-0001sr-AL; Mon, 17 Feb 2020 05:05:02 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MYehP-1iysAm2xpz-00VegS; Mon, 17 Feb 2020 11:04:55 +0100
Subject: Re: [PATCH v2] configure: Avoid compiling system tools on user build
 by default
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200217095955.11140-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <916878d0-18b4-0c47-4645-9fcbd9260891@vivier.eu>
Date: Mon, 17 Feb 2020 11:04:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217095955.11140-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3oXiR4koQL+sWDpDlpEBb6gcbvI7MxQt22OEk+HAx9R6xt2lGLX
 uqLJvk0+RtN/NAU0qkdI89gqRr2GfLlw6c4DPhdy+VWYjvrDh4vg3gGEr0Sr69hSiYcVxYt
 /b2Wmuuz9gegM265A8K7Eie8iD6LYhdZ2t7yQdKn7DCBm+Bxu77YsHpqPdAeIhrTXUL6non
 Ac/2M3EPye5Jlw3cojkKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HEw6H2qbSwM=:wueYH7485X+3ZJhPgYzXvU
 fymX+0+qYhEgtCOYDLJFT8GRFQqgfmkRF3IAczxMOHzbsTtCe5ziGyx8RU9n/wx0c8hE2AXga
 bO0AxvVGu3oOwUQHAp4crBOwNHC3TANvVW4EcZBM9AWJLFjDSn9vUIvpcrcCGwgGOrUdTe1uj
 6F50XQzgMF+/K1uoHFfxBQ8FWUcZcNFndDJfvMsR7U89tgvzS54n0RNNlGq5JYZQjp8WUPySR
 ojvDB4h1us0drv972AxPV6hYKlm7hN/hPJ6cgBn2VlqExNRiDt00Yhc4+PvQCoWFC+sRkkr3V
 U3qpyOVkkhCJBOsu+fYPTD9zYgGc4G0DsuZHgO19iS+DivB4gOEymE1gaaYIF2PcnClwvs3ZL
 R4yUt+whSHGdAZirX1NPDsbNeyBGx9jXwEB5p3fVXOaHdt5srnLSJc/QWDPh4LfY+HzhSiYuy
 b5+91cLakghj34eVLUEMFSpB7b+wLLGou/OeEw8WqjEiXeZ5VWReWDM9ttNFSn3DWPVCO85/c
 mpRJiU0X4w9QtXLHkoA/tAmuGhj9R016xie/t3cGrjZZ2/figTcMrstx5tFsH3AFhk+u7b75x
 2Hz8WkhSNPFKh/c95xUshaxKYf+HabsElFs/bT4aLf3UXYIrb0WHn3ASoPtweKCBDSrveFCRK
 uDatGjOD1Ffq6R9HqcHj89uKkIR8E4+uFUH4m+ubkYHy6CG8KG8ZRMP6TKVRLCcdDJsg8Qslu
 B++2nLbQx8/sY+KPpQoWZyxtABJWW2P87BlaG9hAP+kelGwwVNJcBFbUL7Ms0eHHJ6Nk1yNCW
 KO3xCQ9fpiCbLnR5LCeinDBJFxz1zcJq9jd60cYE0m5wg+vG37LfqsAp90VAaygzs5tR6VH
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/02/2020 à 10:59, Philippe Mathieu-Daudé a écrit :
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> User-mode does not need the sytem tools. Do not build them by
> default if user specified --disable-system.
> 
> This disables building the following binary on a user-only build:
> 
> - elf2dmp
> - qemu-edid
> - qemu-ga
> - qemu-img
> - qemu-io
> - qemu-nbd
> - ivshmem-client
> - ivshmem-server
> 
> The qemu-user binary is not affected by this change.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2:
> - use simpler if/else statement (therefore not adding Richard R-b)
> - improved description (Aleksandar)
> ---
>  configure | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 16f94cd96b..d1877a60f5 100755
> --- a/configure
> +++ b/configure
> @@ -455,7 +455,7 @@ guest_agent_ntddscsi="no"
>  guest_agent_msi=""
>  vss_win32_sdk=""
>  win_sdk="no"
> -want_tools="yes"
> +want_tools=""
>  libiscsi=""
>  libnfs=""
>  coroutine=""
> @@ -2199,6 +2199,16 @@ else
>      echo big/little test failed
>  fi
>  
> +##########################################
> +# system tools
> +if test -z "$want_tools"; then
> +    if test "$softmmu" = "no"; then
> +        want_tools=no
> +    else
> +        want_tools=yes
> +    fi
> +fi
> +
>  ##########################################
>  # cocoa implies not SDL or GTK
>  # (the cocoa UI code currently assumes it is always the active UI
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

