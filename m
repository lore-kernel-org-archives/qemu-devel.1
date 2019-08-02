Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E2BC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC14D2087C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC14D2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36225 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hta7n-0007GZ-6G
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hta79-0005zP-IA
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hta78-0003Ik-GQ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:09:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hta78-0003IC-Ah
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:09:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id x19so66911080eda.12
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TU0O2D2g8vyGPUyjEM/MYVfipxX/tAxh/1WrwX5hpsM=;
 b=bkKpTEhes3zaO4Sa1FiS9huvbM2BYlMp62b50utfZXt3KXUiMlNszsuyguQ93NQBmM
 jiHyrtj9HKUK1Qv8LRy0Tid7vLG3gr2NVceS65ofovhwm5J4SCdLNbmXhUv0mfZVXhrq
 Hb68rA1uGfAWqjigxQhm6r3QJj1bxLotWl590Cq62AT0NuXvtgEhPCG/5hq9EgbLHOnD
 dLuXCpQ0n4MEff4LpxgLMnI3CZwcOGqtncFdWcab1Ej+6c+btNt9wiUTu6a9TfnuztOG
 tOFjENKt+a+YW6rcKCZe0mzjjs3Xb5LaFtpPtODYTK5AZeJitDwqnbMty79PwXNoq8WI
 gU4w==
X-Gm-Message-State: APjAAAVPe8LMty7Guhq+96Np7Pl/ejalh55hgx9swyYEzi1bTAl2vAbz
 MB8faTfcbzTohEFWHmsmMB7KlA==
X-Google-Smtp-Source: APXvYqzq91svCa5lRHKjICLn3BO9pWeJKaUxQfzBmR4Dyi6D9cXja64PxBnQCDUg7zdgMmrdbSp3MQ==
X-Received: by 2002:a17:906:114d:: with SMTP id
 i13mr106225033eja.252.1564762145256; 
 Fri, 02 Aug 2019 09:09:05 -0700 (PDT)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id k10sm18398756eda.9.2019.08.02.09.09.03
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 09:09:04 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1564677923-23173-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1564677923-23173-8-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c9e0849e-05d4-75c0-b904-b934d4b95c9b@redhat.com>
Date: Fri, 2 Aug 2019 18:09:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564677923-23173-8-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.65
Subject: Re: [Qemu-devel] [PATCH for 4.2 v5 07/12] target/mips: Style
 improvements in cpu.c
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/1/19 6:45 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Fixes mostly errors and warings reported by 'checkpatch.pl -f'.

"warnings"

> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/mips/cpu.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 39eafaf..3ffa342 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -57,9 +57,11 @@ static bool mips_cpu_has_work(CPUState *cs)
>      CPUMIPSState *env = &cpu->env;
>      bool has_work = false;
>  
> -    /* Prior to MIPS Release 6 it is implementation dependent if non-enabled
> -       interrupts wake-up the CPU, however most of the implementations only
> -       check for interrupts that can be taken. */
> +    /*
> +     * Prior to MIPS Release 6 it is implementation dependent if non-enabled
> +     * interrupts wake-up the CPU, however most of the implementations only
> +     * check for interrupts that can be taken.
> +     */
>      if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
>          cpu_mips_hw_interrupts_pending(env)) {
>          if (cpu_mips_hw_interrupts_enabled(env) ||
> @@ -70,8 +72,10 @@ static bool mips_cpu_has_work(CPUState *cs)
>  
>      /* MIPS-MT has the ability to halt the CPU.  */
>      if (env->CP0_Config3 & (1 << CP0C3_MT)) {
> -        /* The QEMU model will issue an _WAKE request whenever the CPUs
> -           should be woken up.  */
> +        /*
> +         * The QEMU model will issue an _WAKE request whenever the CPUs
> +         * should be woken up.
> +         */
>          if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
>              has_work = true;
>          }
> @@ -112,7 +116,8 @@ static void mips_cpu_reset(CPUState *s)
>  #endif
>  }
>  
> -static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info) {
> +static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
> +{
>      MIPSCPU *cpu = MIPS_CPU(s);
>      CPUMIPSState *env = &cpu->env;
>  
> 

