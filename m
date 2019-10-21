Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A4DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8EAE2077C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHzpFrby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EAE2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbUO-0006OV-Rr
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbSx-0005CA-Gf
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbSw-0004yn-9W
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:27:35 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMbSv-0004wy-MV
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:27:34 -0400
Received: by mail-pg1-x543.google.com with SMTP id l24so3277251pgh.10
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uHOeIskfuKSRRfkvxylgp3thln5uOHC3zxwjYo9bmPI=;
 b=mHzpFrbyhHbJLwsRuaaSJY1pvpzNxeAdqASeE6qHENBxinMyXWk81UMUlLKVzuh8jD
 QmCyXc1uujTPkY58o05NGghyCZSjz+dmZQGB0rN3aN2h2a77dl+600TKlmUtWMXOHfUV
 PnQF4y4Uq8d/0qLAcqavOZgwhdZKnIuk9w/WiADNUGRW/3zZFPX0BeXrl8rwP3IrB7ZO
 kgXvcoV52Y5ybVpMdIU4OfIKX2iBtjgTIiaSgcOsdOXyKyBN7Gl3JmFiRCUH4WGlKJoN
 xMZuJmj3mMGAdMzoo02YqsWLTNYs7kLzAimvWTGsXaEdj5ylR4iH64EXQu2zMHaD59FV
 xXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uHOeIskfuKSRRfkvxylgp3thln5uOHC3zxwjYo9bmPI=;
 b=mgrsZEYG9NsSanA41EN8tbXyUMaVMYqZzKzoNhXEBQbffQHR/hXDuEOGH9m25rVs7z
 cO2diM988tFOCqxouoVJOnXUJ2mwsYLxc0dtf3ECGV0KJOvRINfpN+B3Hb3NGhaStd5f
 49/Dgdd5iBOnfi0/CvGpTD1uSImc7qKDqf63vRSNJJ/FPgRXCxF8Z6ah/dC6ADUUYfv1
 sP4udGlm3OyMBQOyRhhYbYrDOHTWJLTNcmfptOGfSg1avHy6AhFGi5UXLmzRR07nfdOS
 2Pkj1yIIWtHzhZO736NNX2RvsjCAO9tb9avpCbDI2D40PsJ3aAt10P5cg6vrdfGBg9sZ
 A30Q==
X-Gm-Message-State: APjAAAWdXE1LwXWHsxYAWExcd5I4MOU6ESVuPERaigcGPa8+HRc7olGv
 Lqs5H0GQkl7/+v1vJOkl8g9uDg==
X-Google-Smtp-Source: APXvYqz8UZpGVegnd0uI/fVMX0dRHp51JbVD6ZGKJPMOY7120cv3l0Evknvy0CToWxVu4aWRGpsV5g==
X-Received: by 2002:aa7:9295:: with SMTP id j21mr23892413pfa.87.1571678848073; 
 Mon, 21 Oct 2019 10:27:28 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v8sm27124002pje.6.2019.10.21.10.27.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 10:27:27 -0700 (PDT)
Subject: Re: [PATCH 08/21] hw/alpha/dp264: Create the RAM in the board
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-9-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <708cda0d-4e05-4f15-5131-288567e91a4d@linaro.org>
Date: Mon, 21 Oct 2019 10:27:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020225650.3671-9-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/19 3:56 PM, Philippe Mathieu-Daudé wrote:
> @@ -73,8 +74,16 @@ static void clipper_init(MachineState *machine)
>      cpus[0]->env.trap_arg1 = 0;
>      cpus[0]->env.trap_arg2 = smp_cpus;
>  
> +    /*
> +     * Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
> +     * but the address space hole reserved at this point is 8TB.
> +     */
> +    memory_region_allocate_system_memory(&ram_region, NULL, "ram",
> +                                         ram_size);
> +    memory_region_add_subregion(get_system_memory(), 0, &ram_region);

The thing that I don't like about this is that ...

> @@ -849,12 +848,6 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
>  
>      *p_rtc_irq = qemu_allocate_irq(typhoon_set_timer_irq, s, 0);
>  
> -    /* Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
> -       but the address space hole reserved at this point is 8TB.  */
> -    memory_region_allocate_system_memory(&s->ram_region, NULL, "ram",
> -                                         ram_size);
> -    memory_region_add_subregion(addr_space, 0, &s->ram_region);
> -
>      /* TIGbus, 0x801.0000.0000, 1GB.  */
>      /* ??? The TIGbus is used for delivering interrupts, and access to
>         the flash ROM.  I'm not sure that we need to implement it at all.  */

... previously, it was clear that Typhoon owns the entire address space layout.
 With this moved to dp264.c, the "address space hole" comment is out of context
and makes no sense.

Would it be too weird to pass in a MemoryRegion* to typhoon_init and leave the
memory_region_add_subregion() call where it is?


r~



