Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238FACA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48DA2064B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LFyeRF+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48DA2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMb3a-0006vs-1p
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMb2H-0005nO-9l
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMb2G-0002EV-4e
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:00:01 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMb2F-0002E8-TJ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:00:00 -0400
Received: by mail-pl1-x642.google.com with SMTP id y24so2962982plr.12
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JCj3ZZhHQtaDCVKyDFMSP4u1l7rUcwXSP2jGz/Ofg8I=;
 b=LFyeRF+1M1/VowDYC32+OIKk3I9DserWoamc8LK/r2P3DN+ESQ5Eb++omrRcugVxj0
 oIaj20RmYHGIa4fjpvl/ii4fPzhQh/d38AraS6C5e97paMXBlhceGN9BJmAUrqsWj9Fc
 O1e6ssc5N5ftA2KpWr0zO881NlpEujeYUmhbPHChX4D4n7KVBpqJxz235ot2sEMJezur
 q2rZgIvC4BiydK7GMIaLpWhIeQm95rrgEf7GRcjwhPqgOzlA4QzF1dgw0v6Gm7d2yPnl
 d5FdFrLqpaFmf4Ia+LEsB/EPwHpjmjMqspOMojX8B/SZKJdMOLDUJgHVgbel86Yifgnj
 Xkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JCj3ZZhHQtaDCVKyDFMSP4u1l7rUcwXSP2jGz/Ofg8I=;
 b=EVk00ygN0Y4b4gevSohRuLtJfWq+R3OzGFSuVWUdczM+01eSTFl8lAB9nVHSVoJ1Ex
 8Qbydx5WgXPA0VnKhkOWidMQC3oWICEkYf0w0Qc3jH+APwKz5fRIiBhU/AxI7R7CKt9q
 bvJiOB9xkV/vmrrFgzs1ffbxemB8dTRq3yDVgZWIrvFpmqVrqP6k2zNY4NhY0PiASVMQ
 pkbfnjU7XGSasKGB2o+yeLDV3Hv1QGVx4HGeV+0TjReDoPaRSaElpkVEmRXujEQlLERq
 Mz1xQbghWXo1Bqqc6/v2FCg5b8IPhqK4u50HJjMZp33JCcqQtjwNpS4fOExrLogifHyo
 /sRQ==
X-Gm-Message-State: APjAAAVK1rjJFpJTm581Zo94CIJllzU8fAdytbcs3Fav3wunlzsnGsWz
 X2VjsmX5lBBbvotnetvh3UZk9Q==
X-Google-Smtp-Source: APXvYqwcCFC5qxBKvysKLjOUCgq6Nr44vD2A929ty6UA66MR2awSeG29FhOGIZTiI7gjYDEkWVKfeg==
X-Received: by 2002:a17:902:fe0d:: with SMTP id
 g13mr7576872plj.253.1571677198569; 
 Mon, 21 Oct 2019 09:59:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f62sm16926558pfg.74.2019.10.21.09.59.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 09:59:57 -0700 (PDT)
Subject: Re: [PATCH 04/21] hw/arm/omap2: Create the RAM in the board
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-5-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ee89a853-46c7-e306-1e49-cd75136428c8@linaro.org>
Date: Mon, 21 Oct 2019 09:59:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020225650.3671-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
>  static void n8x0_init(MachineState *machine,
>                        struct arm_boot_info *binfo, int model)
>  {
> -    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *sdram = g_new(MemoryRegion, 1);
>      struct n800_s *s = (struct n800_s *) g_malloc0(sizeof(*s));
> -    int sdram_size = binfo->ram_size;
> +    uint64_t sdram_size = binfo->ram_size;
>  
> -    s->mpu = omap2420_mpu_init(sysmem, sdram_size, machine->cpu_type);
> +    memory_region_allocate_system_memory(sdram, NULL, "omap2.dram",
> +                                         sdram_size);
> +    memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE, sdram);
> +
> +    s->mpu = omap2420_mpu_init(sdram, machine->cpu_type);

Any reason not to put the MemoryRegion in to the n800_s structure?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



