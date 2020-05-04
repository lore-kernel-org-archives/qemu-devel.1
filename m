Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66783C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE3F206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE3F206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXIC-0003WM-DO
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVXHS-0002yH-Vh; Mon, 04 May 2020 05:20:54 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40539)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVXHQ-0004Zl-8g; Mon, 04 May 2020 05:20:54 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MJn8J-1jkaDf0UeX-00K5AA; Mon, 04 May 2020 11:20:22 +0200
Subject: Re: [PATCH v2] MAINTAINERS: Mark the LatticeMico32 target as orphan
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?=
 <akoskovacs@gmx.com>, qemu-devel@nongnu.org
References: <20200316142827.20867-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <aaa6f467-be8d-df10-9124-2a16d52c3d46@vivier.eu>
Date: Mon, 4 May 2020 11:20:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200316142827.20867-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JGuZRSSVJ11i3o7Q9JdiaCyhgxGObSuG19ZZkb8klvHBjlixWHE
 pq1T9KuIrGEytT3CJmqRHvmaojtWOI6reITN45ZWKBxpkk/kNHcep67CyzGoPjM6/frAVjd
 MRTAUwABuBn4WLy76WL8OiJC67UHljlOpKtifcYwGrKIjZiBhKXghk5eeM777kCzvqM1Vlj
 KJ7wbs2mvL8r75z0oWRUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QcZr/dS+lUw=:lMT7aFMaBKqW2dsfIREeP4
 70aoEAsdKnqrmkpdI8vJgyqPjtMCBVM+Iq/LQEoJ6aKfhsmGjIhJixbJFVKRucjEr+aP2aaar
 K01hGQ1vupBDRYZESLUpHYb4/cKZUI8uDBzKuLAcua6O12suowoRR5R+oDIJa46P4M3NwehYy
 8CmbZKpPRADW1wkMJ5Bo3QpxqYJMWfH1rw61/slCY9AK3YLeQF1CH7C2ebfrjPkqC78U+6DUM
 P3VlOORvTJgF+ro6PSXPdJ+pI7bsTMPU/zS5YXROaD20wW25yYFxYtEMiAKu9YdBJddqoxBZ8
 NjMWOlgjG6B4OEQJCox8UGT7hYiWpSsCX7kFrTf9j+8eJr09SH/D9tFL/7vJ2ETBDFcBNl8UV
 1EnseD0ZZFQ5NYDybrNAIPdX5GQ5CnIpAEPYH5Bf1kqOMeWMKV1E4ZYvGbm50r1A9PhQlCTML
 Z134+M9egTJODI3urAi0yOLnvA+EAZzJbJ96WA2MPVcfW8N96yqURiisGYLC+BrHArSi0rQOg
 ADWSLZB/546oda+4wm3ORypG1rCp0JNwqgUuevePbhzrjVDbVAlX/6M3zJbVSD6raSyPGNIL0
 MahO7/ZoExdg9NUZkWN2SaDK8UJAtD/bbitYvvbWs0BMwaeOLcPBxNrhjQJVZzaXsGr7ugJlr
 ZCUrwNcmfcdOIaQflAD6feJChzISeYOfnQK/H9FYysyVVULqKFKIIm/hBlQiUiQoXcJ6yoilp
 7fP2DwMURNmm+VzfUiXVebMTSlSmGSjSpia/AGblNgd8pmOv8fVAGbekmfHMb43n8me+s/Q4I
 B9VLu5uIDMSznrJdvGkfSNN9oaBwtW6dBTN0pBdiRK+0nGGBwtr+TKNwrYvDqa5AjzTtZyt
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:20:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, "Emilio G . Cota" <cota@braap.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 16/03/2020 à 15:28, Philippe Mathieu-Daudé a écrit :
> Michael Walle expressed his desire to orphan the lm32 target [*]:
> 
>   I guess it is time to pull the plug. Mainly, because I have
>   no time for this anymore. I've always worked on this on my
>   spare time and life changed. And secondly, I guess RISC-V is
>   taking over ;) It has a far better ecosystem. Also, to my
>   knowledge the only (public) user of LM32 is milkymist and this
>   project is dead for years now..
> 
>   So time to say goodbye. It was fun and I've learned a lot -
>   technically and also how a huge open source project works.
>   Thank you everyone for that :)
> 
>   Basically everything still works and there are even TCG test
>   cases which covers all instructions the processor has.
> 
> Many thanks to Michael for his substantial contributions to QEMU,
> and for maintaining the LM32 target for various years!
> 
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg605024.html
> 
> Acked-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: Also orphan machines, added Michael A-b tag
> ---
>  MAINTAINERS | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32867bc636..c89bf61989 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -183,8 +183,8 @@ F: hw/net/*i82596*
>  F: include/hw/net/lasi_82596.h
>  
>  LM32 TCG CPUs
> -M: Michael Walle <michael@walle.cc>
> -S: Maintained
> +R: Michael Walle <michael@walle.cc>
> +S: Orphan
>  F: target/lm32/
>  F: disas/lm32.c
>  F: hw/lm32/
> @@ -945,13 +945,13 @@ F: pc-bios/hppa-firmware.img
>  LM32 Machines
>  -------------
>  EVR32 and uclinux BSP
> -M: Michael Walle <michael@walle.cc>
> -S: Maintained
> +R: Michael Walle <michael@walle.cc>
> +S: Orphan
>  F: hw/lm32/lm32_boards.c
>  
>  milkymist
> -M: Michael Walle <michael@walle.cc>
> -S: Maintained
> +R: Michael Walle <michael@walle.cc>
> +S: Orphan
>  F: hw/lm32/milkymist.c
>  
>  M68K Machines
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

