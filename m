Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF68C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3D32332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3D32332A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0MVc-0006KZ-O4
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 05:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0MQD-0007s4-9V
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0MQB-0005d1-9H
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:56:48 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33283)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i0MQ7-0005bE-FD; Wed, 21 Aug 2019 04:56:43 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M7aqD-1hsPGu2gtp-00865F; Wed, 21 Aug 2019 10:56:33 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190719131425.10835-1-philmd@redhat.com>
 <20190719131425.10835-5-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7b1fb7f8-6993-6f7d-6daf-f0ff5314167d@vivier.eu>
Date: Wed, 21 Aug 2019 10:56:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719131425.10835-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QvcYfRir4nfmJWAJNTFbiZgzp8y1o0bpxbSEAiUDwlBuanmLXcO
 4oUjfEVzpf1CJbRF+ShuIVbRi7GleVqr9c3xv2Y4DIbeVEz546NxeZ4DGlG3geIx6fJAXdO
 cNxWoQAiby/OI46S8GGXceL3YiLBAAQePp4kWq5VVqm7WoVl3b0k0sQ2JmJH8AuHuz/8Fh4
 lmqJNmlI7lIxtjuX4LPvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QGlMfj8HnPs=:HOLRctit6y4K2LKKvio+fJ
 AeC8dzh+3Kc37VdP86X57vJrZe4lUEHpQRqV4JXuJigGoIjqG6kefohEvY0/J/Pasa0TpVj5O
 TsUxKeYLAtuFnYS0Jkm39JjYkpkUN2bsxq8+487cg4/jkFQfLQNbMTlepHNQZ/ELvOSy42AVP
 ALdGWNEOLZ5EXK3OcE8BtaGw0r2TF+IKWoUuIeKxt7M2EjjwcKHLNHZdDovHrOVJTWGT16FpO
 cdQ4OXKjkRkL/LPKKurqa/Un+4TLlsZ+SgL9OJjmwhtd1iaOwvQ9zIzR2Nmr0MTJRyCuSyJMw
 491XLsBdOmrmzkt2DEQkGT5nf7uwYoQRdwJiBVTUVnd0YpoCRs+4Vb8UwKC0DQwlrkqpFu9CL
 YZ4GlyAzVA1I7DNZ087TMnZVnovWIchESyNvLStfIKL0Qvzc5X53Wm/w3AkWueMtzx8hEuRiz
 16VzULWXwG+iCmqlo/Z3SbnMWVETCnpNDn2X1IajDL+diHa+CGxYPYh0bh3FXnehBV7hjBb79
 d2UkxIb3y4CflQYKfbNpqpldmENR7yGCSvztX6jLEfAUOdvi9fsegOm6A7RPEalTCCn93+gMi
 rwnA1ZLGLuECMP4iHJ26j2MaMD9CxLhAWya/jwpzCS/pJYYkzkc0292CavgaL3MJJ0EesRIps
 Ce23GS4HP40SS+hXIb/otWQ+yXk6sqO+V8UqDnl9BxbabPN3H5IbEI13p6lKtHACr0yK6ElaH
 5WKoIgCxvPSwDGqV6dlWNeOtKUyv0kWdxf3IZ/VwQeKSLPgZ/jmQJ8/pWCk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH-for-4.1? 4/7] hw/ipmi:
 Rewrite a fall through comment
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/07/2019 à 15:14, Philippe Mathieu-Daudé a écrit :
> GCC9 is confused by this comment when building with CFLAG
> -Wimplicit-fallthrough=2:
> 
>   hw/ipmi/ipmi_bmc_extern.c: In function ‘addchar’:
>   hw/ipmi/ipmi_bmc_extern.c:178:12: error: this statement may fall through [-Werror=implicit-fallthrough=]
>     178 |         ch |= 0x10;
>         |         ~~~^~~~~~~
>   hw/ipmi/ipmi_bmc_extern.c:181:5: note: here
>     181 |     default:
>         |     ^~~~~~~
>   cc1: all warnings being treated as errors
>   make: *** [rules.mak:69: hw/ipmi/ipmi_bmc_extern.o] Error 1
> 
> Rewrite the comment using 'fall through' which is recognized by
> GCC and static analyzers.
> 
> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/ipmi/ipmi_bmc_extern.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index c0a8dac346..d4cbd210c4 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -176,8 +176,7 @@ static void addchar(IPMIBmcExtern *ibe, unsigned char ch)
>          ibe->outbuf[ibe->outlen] = VM_ESCAPE_CHAR;
>          ibe->outlen++;
>          ch |= 0x10;
> -        /* No break */
> -
> +        /* fall through */
>      default:
>          ibe->outbuf[ibe->outlen] = ch;
>          ibe->outlen++;
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

