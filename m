Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725E3C3F2D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502F3214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502F3214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94If-0000P8-Iw
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 04:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j94Hs-0007nq-Iz
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j94Hr-0008Gr-D0
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:56:28 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:56295)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j94Hr-0008Fy-4i; Tue, 03 Mar 2020 04:56:27 -0500
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MkpKR-1jnacb282Z-00mKKs; Tue, 03 Mar 2020 10:56:14 +0100
Subject: Re: [PATCH] hw/unicore32/puv3: Simplify puv3_soc_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200221162325.28194-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <87fde6ef-5579-3539-a35a-ecc3b1661175@vivier.eu>
Date: Tue, 3 Mar 2020 10:56:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221162325.28194-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TVTuFw2zLrsJaTxIWKVSErrc/6nxwFFmVyfj/1T15lIpTsnUF4f
 v8pTO62eMWOXiCf0/jo1fG3LNXfKnnhr9HcDk1LKdD2tBRjBb2w3O3aC6xkoLEk9mBKYZLx
 oPTiuQmREJKBuCvigDVXd1NlqNWiFtJMKFvkF8SMBwZmVKj78zTpjFSQM9p5Xb7tUHGZjNj
 lOSx0sYNnHpHJ7UQh0GJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CE6enpv29Fo=:sMYSLgKPZCbUvelVqX0wj3
 9URyUDftm1OKIK9ky1dI+w88OWmcMLbIWh7c0OnPx14LP0rYfk7FQvFPgkoClC0B2UfU2RtUT
 WQTKLlBzsz/jQ9c952e6jtNzlTqlnzxVu+cQ01ru1TJr2/UzG/sflLJEHBq353tN334BE0ITs
 RXh5JUA7ZY3g1fJ/KaBORyGKT+qO/IU/nkyDkXe/UsmlODMBbdqznSAt54XzraqAaEW9Ef7hc
 7E9pwczKPQsk5cFdgXZC3H9JAN64IGrGLb//dZIk+sCzscqMqvENxvrFCeEvtmQDPGJOYbdnO
 GxXswSbT9Nc7MD1rMBHTryfZLGfgZu0IBYquJjsA9lJaw37sh9Os9l52UJFJkL2mxIsttB1fv
 Y9OzISRzaDp7NEPtHSVEkqNJZ/Kb715P/me2vioyrGfTrU/Qw60Ub+iUYyixCNdQnGEI5wm1h
 jnlTcLlea4zPbVJcbv5aTS+UoMyMPk3HeJmskMnyAVMdZL7D9MlZhMKta47QwZk7QkLjVqfdL
 lKHpoRD64YU7vBn6GiJGNxjujoBof2R+oFNAJdw2/ew3a5SF5T1XiF9cj8eQDvM4gJuGeCZzt
 AGmIhze3j/oR6Jq+wAK02OK2rJWrgZGLTxfz9xBfWvoARdTzP7RR1LXdH13xzDqogGzjM00x2
 NjlwGlHv+sewS9xxTCK2HLC3mqkpuHaoI99AhDDzffB6XDtO7IphvuawAwCEUDbj4Q16bDaKu
 8lIjHWQX0/dQD65gHZ0f2hdk7EcGAzXDJTX+Ctdw5RVBN6AOeh3lXExggplXzErjj8ktDzr8T
 TfLlNlwgy4Z3P11EnmBq9sANkM0cCqKlRVioGTNTDBNiWOlsT77gNnEe+Rp6knleNPb5y4x
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 21/02/2020 à 17:23, Philippe Mathieu-Daudé a écrit :
> Since commit d8ed887bdc, the puv3_intc_cpu_handler handler takes
> a pointer to UniCore32CPU in its opaque argument.  Directly pass
> the cpu pointer.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/unicore32/puv3.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index 7e933de228..eec7f561eb 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -48,7 +48,7 @@ static void puv3_intc_cpu_handler(void *opaque, int irq, int level)
>      }
>  }
>  
> -static void puv3_soc_init(CPUUniCore32State *env)
> +static void puv3_soc_init(UniCore32CPU *cpu)
>  {
>      qemu_irq cpu_intc, irqs[PUV3_IRQS_NR];
>      DeviceState *dev;
> @@ -56,8 +56,7 @@ static void puv3_soc_init(CPUUniCore32State *env)
>      int i;
>  
>      /* Initialize interrupt controller */
> -    cpu_intc = qemu_allocate_irq(puv3_intc_cpu_handler,
> -                                 env_archcpu(env), 0);
> +    cpu_intc = qemu_allocate_irq(puv3_intc_cpu_handler, cpu, 0);
>      dev = sysbus_create_simple("puv3_intc", PUV3_INTC_BASE, cpu_intc);
>      for (i = 0; i < PUV3_IRQS_NR; i++) {
>          irqs[i] = qdev_get_gpio_in(dev, i);
> @@ -131,7 +130,7 @@ static void puv3_init(MachineState *machine)
>      cpu = UNICORE32_CPU(cpu_create(machine->cpu_type));
>      env = &cpu->env;
>  
> -    puv3_soc_init(env);
> +    puv3_soc_init(cpu);
>      puv3_board_init(env, ram_size);
>      puv3_load_kernel(kernel_filename);
>  }
> 

I think you can remove totally env as puv3_board_init() doesn't use it.

Thanks,
Laurent

