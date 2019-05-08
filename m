Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC32C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1148E21530
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1148E21530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35064 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOKct-0000CW-5L
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 07:20:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKZv-0006fW-7Z
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKZt-0003cY-Vv
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:17:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOKZt-0003bR-ON
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:17:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id h11so2727406wmb.5
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 04:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=7wcbMivpEC1kXzOH42NIe5PKKmvVwN8V7gR7A/dWHZM=;
	b=WPVlK5bR/p7AaF4rO+/mU2dO71jDTojVvcwniNMpK6OC5SSt4pTeeq0Jd1fE+T+98s
	/qroz02z7ptDk3MP0Cl6nw5AffIy1LCBrpWM4pQ0Aw3YJ9Js2zIImZAG4Eih7JEOUr2j
	m+heGLiCB0poGAW/scwIpdfLkvzbVKxEDVvo0GhXyDmWWFL13EMYry+GZVF4DMM13w2B
	C0wb2kBLZiuE+dxf0+vLJFt0p0cGxNQ29hVHjQuWFYPsl40BWAvCHC6RRWGyB4LL4paV
	mdgAHSHgRUD8yEZPie0SgSu0DSw3O2XO/r2ZyXaf+awQ06+1QuzPe3jl9Zt0inMxIuel
	Q+wg==
X-Gm-Message-State: APjAAAWAfVJDg5HIJ9Jtp60JsgSUB6nKO8MdL2wDUBCFZ/6SxZIuHMhn
	4hUBLudNHaUunw2zxWJN/jzbnw==
X-Google-Smtp-Source: APXvYqy6HTqhbM/8WxdotJEIWVBPcJuRA9ocBQilK/VARxOYUKHLhBp3osItBcfUjmSKb+652rfhtw==
X-Received: by 2002:a1c:5fd4:: with SMTP id t203mr2614356wmb.56.1557314256764; 
	Wed, 08 May 2019 04:17:36 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id
	m17sm4474087wmi.27.2019.05.08.04.17.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 04:17:36 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-12-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b6f98cd-541d-538b-f1df-fbf215d01f52@redhat.com>
Date: Wed, 8 May 2019 13:17:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507163416.24647-12-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 11/16] hw/microblaze/zynqmp: Move the
 IPI state into the PMUSoC state
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Paul Burton <pburton@wavecomp.com>, Andrew Jeffery <andrew@aj.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
	Aurelien Jarno <aurelien@aurel32.net>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/05/19 11:34, Philippe Mathieu-Daudé wrote:
> The Inter Processor Interrupt is a block part of the SoC, not the
> "machine" (talking about machine is borderline with the PMU, since
> it is embedded into the ZynqMP SoC, but currentl QEMU doesn't
> support multi-arch cores).
> 
> Move the IPI state to the SoC state, this will simplify the review
> of the next patch.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/microblaze/xlnx-zynqmp-pmu.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
> index 57dc1ccd429..eba9945c19b 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -55,6 +55,7 @@ typedef struct XlnxZynqMPPMUSoCState {
>      /*< public >*/
>      MicroBlazeCPU cpu;
>      XlnxPMUIOIntc intc;
> +    XlnxZynqMPIPI ipi[XLNX_ZYNQMP_PMU_NUM_IPIS];
>  }  XlnxZynqMPPMUSoCState;
>  
>  
> @@ -144,7 +145,6 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
>      MemoryRegion *address_space_mem = get_system_memory();
>      MemoryRegion *pmu_rom = g_new(MemoryRegion, 1);
>      MemoryRegion *pmu_ram = g_new(MemoryRegion, 1);
> -    XlnxZynqMPIPI *ipi[XLNX_ZYNQMP_PMU_NUM_IPIS];
>      qemu_irq irq[32];
>      int i;
>  
> @@ -172,16 +172,16 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
>  
>      /* Create and connect the IPI device */
>      for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
> -        ipi[i] = g_new0(XlnxZynqMPIPI, 1);
> -        object_initialize(ipi[i], sizeof(XlnxZynqMPIPI), TYPE_XLNX_ZYNQMP_IPI);
> -        qdev_set_parent_bus(DEVICE(ipi[i]), sysbus_get_default());
> +        object_initialize(&pmu->ipi[i], sizeof(XlnxZynqMPIPI),
> +                          TYPE_XLNX_ZYNQMP_IPI);
> +        qdev_set_parent_bus(DEVICE(&pmu->ipi[i]), sysbus_get_default());
>      }
>  
>      for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
> -        object_property_set_bool(OBJECT(ipi[i]), true, "realized",
> +        object_property_set_bool(OBJECT(&pmu->ipi[i]), true, "realized",
>                                   &error_abort);
> -        sysbus_mmio_map(SYS_BUS_DEVICE(ipi[i]), 0, ipi_addr[i]);
> -        sysbus_connect_irq(SYS_BUS_DEVICE(ipi[i]), 0, irq[ipi_irq[i]]);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&pmu->ipi[i]), 0, ipi_addr[i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&pmu->ipi[i]), 0, irq[ipi_irq[i]]);
>      }
>  
>      /* Load the kernel */
> 

Seems to be useful for debugging too, since the XlnxZynqMPIPIs'
addresses are not lost after xlnx_zynqmp_pmu_init.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

