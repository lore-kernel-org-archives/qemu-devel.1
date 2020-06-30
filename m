Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CFEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4839206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A548/eaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4839206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqC38-0006ux-0N
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqC27-00065T-G9
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:54:27 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:40549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqC25-0001Cj-Uj
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:54:27 -0400
Received: by mail-ej1-x644.google.com with SMTP id o18so15251941eje.7
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 01:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WswOOi4ehL1Ija5hc62OdGuHf+nHDybF+lZmkF7JL5g=;
 b=A548/eaNhy4jbU0ruIVu7GHmwxvJ6tmFdZCdLpQH0ZMODhqbTydFq686bWbrgfaZ/c
 sO7M4BQ4sixAasH1+azLJb869RrMwj79possyOMe9nBConM1SI7M0O94/eDd2k99n/zC
 tCvPZnbXbd67o7pe/Yn9M9ktgEf1C2PJx8btkliXt9EatOTXZIjpIC3QeN5J2JOt+51x
 UV/j/2MtGep6Q3NTeQxbfGmywElPWmJbYl/0kmGE1mh55e5LIAFqc80pTctjvi6kyaWq
 YQNICE+drPILBB0lUBxchWJG2zMZmvPSzw24ZacfgchMOUz378znPNid4sjWo0S7jGIn
 Zaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WswOOi4ehL1Ija5hc62OdGuHf+nHDybF+lZmkF7JL5g=;
 b=QN/Hu8o6a+pT35P1EtoaS7M7Z3B4l0QcBGqZ3ZEA+vXxH3SaHm7SinKSeoEICcjLrN
 0SutwCPf9sIqvmBCGLpmOPkQefau3Ggswwcq7XTprJcxxZkbDYpTtlG6w32cWmruSQfB
 KXZMzmsxXryqjy0SHbdMA+aEIROAopetTT71gnfKyF+g0DEu3sgYf3vNVhwBmamEw9sQ
 KHXA506HHBoqTcsUkx1jCc4xLpEkEaGvM0fBTPIFrb8GfKYP4lE/8V8pKNlao03xEV7r
 XIyJ9+tTFvhmeeis29+GeHAcumU3+wv017ImFr2WyTKs00HVPCESGTxFamBX3jMmTD2P
 nojQ==
X-Gm-Message-State: AOAM530vdhZTX7b6u2p12xoIHginUv8zTNaXKuzFwM2ssAIzzwyzXiFl
 MUJ2gXUAonAmM5My0SDTE4Q=
X-Google-Smtp-Source: ABdhPJycFtNU+iDidaBe6ugVyZrJVYNv43P8bvSiBQfP9DELOSJQTEWJkEmCkb74ezl3CH5ewx5NoA==
X-Received: by 2002:a17:906:3fd2:: with SMTP id
 k18mr18371181ejj.387.1593507264491; 
 Tue, 30 Jun 2020 01:54:24 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id da20sm2052176edb.27.2020.06.30.01.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 01:54:23 -0700 (PDT)
Subject: Re: [PATCH 5/7] hw/mips/malta: Introduce the 'malta-phys' machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Yunqiang Su <ysu@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-devel@nongnu.org
References: <20200630081322.19146-1-f4bug@amsat.org>
 <20200630081322.19146-6-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <73404e5a-5c41-5f17-89d9-64cc1f943d1c@amsat.org>
Date: Tue, 30 Jun 2020 10:54:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630081322.19146-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 10:13 AM, Philippe Mathieu-Daudé wrote:
> Introduce the 'malta-phys' machine, aiming to have the same
> limitations as real hardware. Start by restricting the RAM
> to 1GB, which is the maximum amount of memory the GT-64120A
> north bridge can address.

Oops wrong comment, it ended mixed from previous patch while
rebasing. Corrected:

"Start with 32 MB which is the default on the CoreLV, and
allow up to 256 MB which is the maximum this card can
accept. See MIPS Document Number: MD00051 Revision 01.07"

> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/mips/malta.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/hw/mips/malta.c b/hw/mips/malta.c
> index 1ca41b44db..013bf9272c 100644
> --- a/hw/mips/malta.c
> +++ b/hw/mips/malta.c
> @@ -1479,11 +1479,32 @@ static void malta_machine_virt_class_init(ObjectClass *oc, void *data)
>      mmc->max_ramsize = 2 * GiB;
>  }
>  
> +static void malta_machine_phys_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    MaltaMachineClass *mmc = MALTA_MACHINE_CLASS(oc);
> +
> +    mc->desc = "MIPS Malta Core LV (physically limited as real hardware)";
> +    mc->block_default_type = IF_PFLASH;
> +    mc->max_cpus = 1;
> +#ifdef TARGET_MIPS64
> +    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("5Kc");
> +#else
> +    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("4Kc");
> +#endif
> +    mc->default_ram_size = 32 * MiB;
> +    mmc->max_ramsize = 256 * MiB; /* 32 MByte PC100 SDRAM DIMMs x 4 slots */
> +};
> +
>  static const TypeInfo malta_machine_types[] = {
>      {
>          .name          = MACHINE_TYPE_NAME("malta-virt"),
>          .parent        = TYPE_MALTA_MACHINE,
>          .class_init    = malta_machine_virt_class_init,
> +    }, {
> +        .name          = MACHINE_TYPE_NAME("malta-phys"),
> +        .parent        = TYPE_MALTA_MACHINE,
> +        .class_init    = malta_machine_phys_class_init,
>      }, {
>          .name          = TYPE_MALTA_MACHINE,
>          .parent        = TYPE_MACHINE,
> 


