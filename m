Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA037C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7B620665
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7B620665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFX6-0000nG-PB
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 05:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41186)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiFUD-0005vo-EX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiFUB-0001b8-CW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:54:05 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45953)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hiFU9-0001ak-GL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:54:03 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MXGak-1i2eAi42Ag-00Ylyu; Tue, 02 Jul 2019 11:53:59 +0200
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>, qemu-devel@nongnu.org
References: <20190616142300.GA71207@localhost.localdomain>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5f7da60a-959a-4d8c-2c8f-300e32c7be4a@vivier.eu>
Date: Tue, 2 Jul 2019 11:53:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190616142300.GA71207@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QuZljtiyJiiv18JPmzLore/VWoHfckqVgq8pF5t55YRzaiZYRXo
 qld8yFuDiUEAEUD58+rPaah5eJvF7MGUxZaAz97o9GOz8al2cOvl1w1BfPxW4tfBg/cD6LN
 TaHewRfPd3OyELH6DFnC4ji8pxQ5YHbUlX3+vtrO9p0PCvqPSv7CaCQJCrj/ATSChNZiHFT
 3WkW05nhINeJwdCHFxEwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:myEnNz0XFcU=:tNBlSqH7ja671yQxWedCYZ
 nmey8jjRxPbwajxEZD59oXhFjvXLIhNFfg15LVcT6TSitbBz5+RtmENEn4wBGu2wS6KOcNFVw
 Bp9TU+kdMMd4cpvymr8+/Rg084R5oPWdLWoozNGCbrXywNdTgFloxUoiMlAQq8Sv5p5m9etW9
 6KREijbCM1WMFq/nSKjXF9QFPGkAJjrC+9TDviy33PsJR0nGaDyyX5KvmYFRAGZTXB9TYlPrV
 8Q8LqCvIJiakyXiV1EtoGR533l2gr6PQ139MNNxsGkJPGBWDPbWef9sl57lg3v3ljonx2ii+m
 9RFGtAY9ajRZ0cD26GjftxiyxeIeAtWu7URLrOI8A+Lw0GAEVcszyM9ZRFdJlc08EK1XvUd7f
 XCxFK9PT8N8u3QcAHeJVXV7+Yf8MYQwCfDHHgUxfKeLpWebe1iwtZ9fnvdrASJPE/hDuM/drI
 L6Jk/bediLutv4yTodCgVwdGVT8oaRNGmTqs2RfPTu901J+jgJV32+AKwPzz1tDLeZRNGatz3
 2zKM9WeRjUAmo9NUpCpFaczeA2ricQYTRbfn/fzmDfjadBickbsLPmA4o5TSogFAoS7f2newa
 ThBTcxfOpB1EsE/arcxAM63r1ztFIuqg68Vu9nOPlgrhZyf5tHk71XgjSPihgdSRrnMgj36Ug
 0J2X5D7ph7QXB7G7iS3lswsR7YsUlk4Zd1nU+GJbtoGSqCHB8fGSh4MxBKCjeq6nrHhe1mu24
 Igf0Ow86F76Vmkewp9AbvVraUCuksxzn/lIdR6KBrjyMYLIcjcXuTCKTqNc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: Re: [Qemu-devel] [PATCH 4/6] Add missing BUSCR/PCR CR defines,
 and BUSCR/PCR/CAAR CR to m68k_move_to/from
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

Le 16/06/2019 à 16:23, Lucien Murray-Pitts a écrit :
> The BUSCR/PCR CR defines were missing for 68060, and the move_to/from helper
> functions were also missing a decode for the 68060 M68K_CR_CAAR CR register.
> 
> Added missing defines, and respective decodes for all three CR registers to
> the helpers.
> 
> Although this patch defines them, the implementation is empty in this patch
> and these registers will result in a cpu abort - which is the default prior
> to this patch.
> 
> This patch aims to reach full coverage of all CR registers within the helpers.
> 
> Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
> ---
>  target/m68k/cpu.h    |  4 ++++
>  target/m68k/helper.c | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index b5b3db01c9..2386419c42 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -411,6 +411,10 @@ typedef enum {
>  #define M68K_CR_DACR0    0x006
>  #define M68K_CR_DACR1    0x007
>  
> +/* MC68060 */
> +#define M68K_CR_BUSCR    0x008
> +#define M68K_CR_PCR      0x808
> +
>  #define M68K_FPIAR_SHIFT  0
>  #define M68K_FPIAR        (1 << M68K_FPIAR_SHIFT)
>  #define M68K_FPSR_SHIFT   1
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 5483ce9837..47b352c9c9 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -257,6 +257,14 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
>      case M68K_CR_DTT1:
>          env->mmu.ttr[M68K_DTTR1] = val;
>          return;
> +    /* Unimplemented Registers */
> +    case M68K_CR_CAAR:
> +    case M68K_CR_PCR:
> +    case M68K_CR_BUSCR:
> +        cpu_abort(CPU(cpu),
> +                  "Unimplemented control register write 0x%x = 0x%x\n",
> +                  reg, val);
> +        return;
>      }
>      cpu_abort(CPU(cpu), "Unimplemented control register write 0x%x = 0x%x\n",
>                reg, val);
> @@ -312,6 +320,12 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
>      /* MC68040/MC68LC040 */
>      case M68K_CR_DTT1: /* MC68EC040 only: M68K_CR_DACR1 */
>          return env->mmu.ttr[M68K_DTTR1];
> +    /* Unimplemented Registers */
> +    case M68K_CR_CAAR:
> +    case M68K_CR_PCR:
> +    case M68K_CR_BUSCR:
> +        cpu_abort(CPU(cpu), "Unimplemented control register read 0x%x\n",
> +                  reg);
>      }
>      cpu_abort(CPU(cpu), "Unimplemented control register read 0x%x\n",
>                reg);
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

