Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26990C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A1B207C3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRQLor72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A1B207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHhur-00071R-KN
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 02:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHhu3-0006ZR-Ut
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 02:23:52 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHhu2-0004Gy-GH
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 02:23:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id g4so17313785wrs.5
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 23:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tuvIrGROWABN6gKfCqKO0BicgkDuRo4EV7Zg8Se2CZA=;
 b=uRQLor72aHc899i1Z7OQapSMbxiq1YFXUUU4Bvw3NNhp5uzChP8RBcXBnWTnQxZdWs
 eyFaT1UnR41gp3l1haxuVNa2gTNeVFgS4K/o5vlHmRRIbz7hWW923Hw4eKGTLIFNWXgB
 7A8g8yD2mzsqCMkfvJwS7bP5xbhoTE855zJcEOlFqvf1AzGeMP1yAc6MOrlGKXuthGB7
 CqbJlb/2t97rsSmy3uFhWAYnSy2hLr2+qWGz+AHzl8hYZavNlE98VK+5EpRyb8PjSEtS
 5sRhVesHLo964mT8qYD9IPhcDF1XQ7n+VkPuSZle8Ae2WKe4M2G7Jb7eTNBMo/TvIlOS
 1WNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=tuvIrGROWABN6gKfCqKO0BicgkDuRo4EV7Zg8Se2CZA=;
 b=iEEJb4w5sWin2sd7vCuyWLeI1tKJT0tJgvYbqjxRGhF4Hg7kqeG9iVZkwc/WEUJSF3
 S7FmeIJtqOJI1s66TVuP9sw8Rf82OxRDrOTI5SGx+lgoAGoiBJh/lmx/j5zEUDIRrI++
 mc+VO20GpvhM/W/W4sUk4msTXIPkJtGY7Fv2XX8wykV073IfgJu3/E71z5Fv3brRiAR5
 uIvAE/SQAdPdGaSaf1Tg/mJUAjzejFFh2Cha0PIHZbWA2GoQjl+LkIj5agmsREgfoa9K
 atbMrnHtHp9yglfjTd3UI+GHZO+VrJt7LVqXuyiztWd9G0p4gV3GUZUZwaQK+O5X7tAS
 nihQ==
X-Gm-Message-State: AOAM531kYUsQfJdZZ+sQQ9sTsTtNisi6akU+E0btpLSnI9jM2L8kEgyO
 pF3ZvHgJ5vMnmpRfIMT4ihI=
X-Google-Smtp-Source: ABdhPJxlNq63+7rigTkCS2cvs6gcj8ktfrzHujm9gfliJ1RpsyPX0Hdth8Hl5+aTNAa5Mgb9amogCw==
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr13841894wrm.216.1600064628447; 
 Sun, 13 Sep 2020 23:23:48 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k4sm19279016wrx.51.2020.09.13.23.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 23:23:47 -0700 (PDT)
Subject: Re: [PATCH 11/11] disas: Enable capstone disassembly for sparc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200914000153.1725632-1-richard.henderson@linaro.org>
 <20200914000153.1725632-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <85136547-9be9-f89e-eabb-fb4a0117c46e@amsat.org>
Date: Mon, 14 Sep 2020 08:23:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914000153.1725632-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, luoyonggang@gmail.com,
 alex.bennee@linaro.org, thuth@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+SPARC maintainers

On 9/14/20 2:01 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  disas.c            |  2 ++
>  target/sparc/cpu.c |  4 ++++
>  meson.build        | 10 ++++++++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/disas.c b/disas.c
> index 5e943181d8..b71d06d890 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -196,6 +196,8 @@ static void initialize_debug_host(CPUDebug *s)
>  #elif defined(__sparc__)
>      s->info.print_insn = print_insn_sparc;
>      s->info.mach = bfd_mach_sparc_v9b;
> +    s->info.cap_arch = CS_ARCH_SPARC;
> +    s->info.cap_mode = CS_MODE_V9;
>  #elif defined(__arm__)
>      /* TCG only generates code for arm mode.  */
>      s->info.print_insn = print_insn_arm;
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index cf21efd85f..e0b0a88d26 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -25,6 +25,8 @@
>  #include "exec/exec-all.h"
>  #include "hw/qdev-properties.h"
>  #include "qapi/visitor.h"
> +#include "disas/capstone.h"
> +
>  
>  //#define DEBUG_FEATURES
>  
> @@ -100,8 +102,10 @@ static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  static void cpu_sparc_disas_set_info(CPUState *cpu, disassemble_info *info)
>  {
>      info->print_insn = print_insn_sparc;
> +    info->cap_arch = CS_ARCH_SPARC;
>  #ifdef TARGET_SPARC64
>      info->mach = bfd_mach_sparc_v9b;
> +    info->cap_mode = CS_MODE_V9;
>  #endif
>  }
>  
> diff --git a/meson.build b/meson.build
> index 82cf4a9258..b1c54024ac 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -661,6 +661,16 @@ else
>      )
>    endif
>  
> +  if 'CONFIG_SPARC_DIS' in config_all_disas
> +    capstone_data.set('CAPSTONE_HAS_SPARC', '1')
> +    capstone_files += files(
> +      'capstone/arch/Sparc/SparcDisassembler.c',
> +      'capstone/arch/Sparc/SparcInstPrinter.c',
> +      'capstone/arch/Sparc/SparcMapping.c',
> +      'capstone/arch/Sparc/SparcModule.c'
> +    )
> +  endif
> +
>    if 'CONFIG_S390_DIS' in config_all_disas
>      capstone_data.set('CAPSTONE_HAS_SYSZ', '1')
>      capstone_files += files(
> 

The old disassembler is easier to follow:

 ----------------
 IN:
-0x4000d214:  lda  [ %g3 ] #ASI_M_FLUSH_PROBE, %g6
-0x4000d218:  sta  %g6, [ %g4 ] #ASI_M_FLUSH_PROBE
+0x4000d214:  cc80c060  .byte    0xcc, 0x80, 0xc0, 0x60
+0x4000d218:  cca10060  .byte    0xcc, 0xa1, 0x00, 0x60

^ lda/sta opcodes not supported (there might be more).

 ----------------
 IN:
-0x4000d22c:  sethi  %hi(0xf01f0000), %g1
-0x4000d230:  mov  %g1, %g1     ! 0xf01f0000
-0x4000d234:  jmp  %g1
-0x4000d238:  nop
+0x4000d22c:  033c07c0  sethi    0x3c07c0, %g1
+0x4000d230:  82106000  or       %g1, 0, %g1
+0x4000d234:  81c04000  jmp      %g1
+0x4000d238:  01000000  nop

^ hi()/lo() macros not expanded (easier to read!)

Can we restrict dumping the encoded hex content for debug
profile only?

Anyhow:
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

