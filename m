Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E02AC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 18:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391C0223BD
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 18:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYKG9rg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391C0223BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRJx5-0004yG-1g
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 14:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRJvl-0004Wt-DD
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 14:49:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRJvj-0003Ut-4z
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 14:49:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id h5so3813762wrv.7
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 11:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2vSQ7frWl0kRwMGz4S9XEuABv70sAfdq5CMkewFe560=;
 b=QYKG9rg9+hCxQb1hT1YfFvmdQyfYEyqQ/3FSQpuZb9xoTbT/v7rVXQB/cOFjD7DHO0
 21b6eIenWTH5NMhMyEFwk6t1I4J58yKaB/oWl269DWhBo0k9SY4CuKrNVAlcKvC5vzbu
 ozzKPITWzr75E89qnGOBw0Ua+C+TlBpI0HSAy7/+WQiffMJCzCJ4CXOMpwOT9s4t3Bu9
 QtRNbTYJHJu34iCtGo5oR1AbAQgnDkCOs0YvnemOs7gqYFQJhaus8tYqR/30Z+TtjBwr
 MQiq9rM2U8Ire3aYhCCF2R+/BwVfXF2i8Annc8kjDpy7GFRMhzvXEVDu+vx4aMv/iG8n
 15dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2vSQ7frWl0kRwMGz4S9XEuABv70sAfdq5CMkewFe560=;
 b=SGIHKfLAJr+eJTr++GwgUuYq3Mob42KXQIQAjYVlb/q+42BCDVKbXD9jMuJGR+Ct+o
 YOAG5xm1HuM0Qwzawe8+bb1WQ4Sc/D5yt9RP3qPFf/Me5LnkK398pKPTJgH+/2qHlOYS
 UHpVTcvG/FqSSAesrV3jVDjwjU1LpSQ/wCTr0vLEhRVDzdvJ/Mw+bwG2t8dv5Gh9LxkL
 qfz0O1D/0bsd34Ss8Y03gzk9UDkyFtt5VOJGENINRDfscSimf0zLVa4w+QRuWtfWcFve
 mdfsakRR5CP7BJj2Eig1QQF2jhojoRUOvqzU+s1frt4iI1M/ItLjowHbhXkpLXkNEHU8
 NxPQ==
X-Gm-Message-State: AOAM532ySqERcWMLUhHlFO8CM+9QWWzCqwgSwY3pvXw3Hv1O4UCL9RnZ
 myshmELDw1lNnXoHPYgHSI4=
X-Google-Smtp-Source: ABdhPJwntYp56fy9aoThNphGX4WtH6VUsPBPhfDrHJK+HyJKzWxx0Pt/rqqW/Yi5VoQ1EbxPcEL6pg==
X-Received: by 2002:adf:cc88:: with SMTP id p8mr22860543wrj.201.1602355757559; 
 Sat, 10 Oct 2020 11:49:17 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j13sm17966922wru.86.2020.10.10.11.49.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 11:49:16 -0700 (PDT)
Subject: Re: [PATCH v2 18/20] hw/mips/malta: Set CPU frequency to 320 MHz
To: qemu-devel@nongnu.org
References: <20201010172617.3079633-1-f4bug@amsat.org>
 <20201010172617.3079633-19-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2b2e8f70-a0a8-7408-3d7e-1661de3d8d49@amsat.org>
Date: Sat, 10 Oct 2020 20:49:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201010172617.3079633-19-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.207,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/20 7:26 PM, Philippe Mathieu-Daudé wrote:
> The CoreLV card with ID 0x420's CPU clocked at 320 MHz. Create
> a 'cpuclk' output clock and connect it to the CPU input clock.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/mips/malta.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/mips/malta.c b/hw/mips/malta.c
> index 4019c9dc1a8..c1e8fceeea7 100644
> --- a/hw/mips/malta.c
> +++ b/hw/mips/malta.c
> @@ -57,6 +57,7 @@
>   #include "sysemu/kvm.h"
>   #include "hw/semihosting/semihost.h"
>   #include "hw/mips/cps.h"
> +#include "hw/qdev-clock.h"
>   
>   #define ENVP_ADDR           0x80002000l
>   #define ENVP_NB_ENTRIES     16
> @@ -94,6 +95,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(MaltaState, MIPS_MALTA)
>   struct MaltaState {
>       SysBusDevice parent_obj;
>   
> +    Clock *cpuclk;
>       MIPSCPSState cps;
>       qemu_irq i8259[ISA_NUM_IRQS];
>   };
> @@ -1159,7 +1161,7 @@ static void main_cpu_reset(void *opaque)
>       }
>   }
>   
> -static void create_cpu_without_cps(MachineState *ms,
> +static void create_cpu_without_cps(MachineState *ms, MaltaState *s,
>                                      qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>   {
>       CPUMIPSState *env;
> @@ -1167,7 +1169,9 @@ static void create_cpu_without_cps(MachineState *ms,
>       int i;
>   
>       for (i = 0; i < ms->smp.cpus; i++) {
> -        cpu = MIPS_CPU(cpu_create(ms->cpu_type));
> +        cpu = MIPS_CPU(object_new(ms->cpu_type));
> +        qdev_connect_clock_in(DEVICE(cpu), "clk", s->cpuclk);

I forgot to rename this "clk-in" :(

> +        qdev_realize(DEVICE(cpu), NULL, &error_abort);
>   
>           /* Init internal devices */
>           cpu_mips_irq_init_cpu(cpu);
> @@ -1189,6 +1193,7 @@ static void create_cps(MachineState *ms, MaltaState *s,
>                               &error_fatal);
>       object_property_set_int(OBJECT(&s->cps), "num-vp", ms->smp.cpus,
>                               &error_fatal);
> +    qdev_connect_clock_in(DEVICE(&s->cps), "clk", s->cpuclk);
>       sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
>   
>       sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
> @@ -1203,7 +1208,7 @@ static void mips_create_cpu(MachineState *ms, MaltaState *s,
>       if ((ms->smp.cpus > 1) && cpu_supports_cps_smp(ms->cpu_type)) {
>           create_cps(ms, s, cbus_irq, i8259_irq);
>       } else {
> -        create_cpu_without_cps(ms, cbus_irq, i8259_irq);
> +        create_cpu_without_cps(ms, s, cbus_irq, i8259_irq);
>       }
>   }
>   
> @@ -1421,10 +1426,19 @@ void mips_malta_init(MachineState *machine)
>       pci_vga_init(pci_bus);
>   }
>   
> +static void mips_malta_instance_init(Object *obj)
> +{
> +    MaltaState *s = MIPS_MALTA(obj);
> +
> +    s->cpuclk = qdev_init_clock_out(DEVICE(obj), "cpuclk-out");
> +    clock_set_hz(s->cpuclk, 320000000); /* 320 MHz */
> +}
> +
>   static const TypeInfo mips_malta_device = {
>       .name          = TYPE_MIPS_MALTA,
>       .parent        = TYPE_SYS_BUS_DEVICE,
>       .instance_size = sizeof(MaltaState),
> +    .instance_init = mips_malta_instance_init,
>   };
>   
>   static void mips_malta_machine_init(MachineClass *mc)
> 

