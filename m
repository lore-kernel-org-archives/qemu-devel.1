Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40A8C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993F620881
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqQhDXCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993F620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPCSS-0007Fc-Pq
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 16:49:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCR6-0006ea-JH
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCR5-0007bW-GU
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:48:08 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:47099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hPCR5-0007Zv-8c; Fri, 10 May 2019 16:48:07 -0400
Received: by mail-lj1-x244.google.com with SMTP id h21so4433503ljk.13;
	Fri, 10 May 2019 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=FmDjixwQhU9nkAwdFYTF0HykPupEcoXYxwdLuzkmB/Y=;
	b=cqQhDXCImzNGI3rqG2tXUcys/pr0wnOoOQWiaOh8AR+lQud29R/gm8C3JYwbeP0C7p
	jeghWOIAnlL3uijgXot+n3KJbj+x+1queuKq5miPQ6xUCuCPLrkjcQGM4gUNX9Ki3z0N
	FR6HXqjiW4t7NfDxfhnGh531+7JP5i1u6qcgaSJw6VuuykEmBFvQ/y0R247xZFeX4CRN
	pC8XiBCyGC2B0IkreGkBV82kkN5agssKQh44GWt3ATC4Fh+g2Ank+HEePOJmNzcW4v3B
	R6quVHwAnBU4QZ3IHZsPQmilTmVX8K8qFJFuNqDL5fW5nt3ZNN124tOrkYMpiqEacPrh
	nPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=FmDjixwQhU9nkAwdFYTF0HykPupEcoXYxwdLuzkmB/Y=;
	b=NYXMnJB6GzEPeBw9nDznX6J10F0FavxSDaLklUDxpE1RmuiSFYOyWK0wR8+4+kToU0
	xx1XZPMq2CH2U9JayLo17qe33v6RMSTIsJr1Hxea2EmyuCs5+fJp/ohBlaDo1z5PLuIB
	TgkojZFzYSjzxjMWAeicBMI03oNajk2qzY6q9TZFUou1K+rncJoGxbgVhvvCayvqvkgn
	fgEnoptVU+oLJc4hULs5U+Feaf8JgW8AuR7mAbIXduB51IvDONXua9D8FWt1MgZ62ZWW
	TuKh5BSlL+SKaSVgBGMdqNYz8Sjnl+GhmJjfJW24czxiNt69U6D3Uh0xAGBtREk6vzYU
	nbzw==
X-Gm-Message-State: APjAAAX8F4Awk9AxnfHgDW8eseU+noGG7kVEgT9MhUjf6TafOcVW2hI4
	0ImFq024wQ4aj0SMBWZvG0IuFTeZ8FRtH7tWnMQ=
X-Google-Smtp-Source: APXvYqxNKWSH8odmyb90sq2BvG5zvGKL40SrEJ/j2P39JPOGt9uyYVicJ0uddXPQRc24gKe1FAolwgmeVj/I33DHFUk=
X-Received: by 2002:a2e:9c89:: with SMTP id x9mr6997593lji.28.1557521285772;
	Fri, 10 May 2019 13:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-12-philmd@redhat.com>
In-Reply-To: <20190507163416.24647-12-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 May 2019 13:45:57 -0700
Message-ID: <CAKmqyKPnBM-Xoty5P8=FHgyhSqMU4no3B08FkQeJjVNTuHkrzw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::244
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
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Paul Burton <pburton@wavecomp.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>,
	Antony Pavlov <antonynpavlov@gmail.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	"open list:New World" <qemu-ppc@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 9:43 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> The Inter Processor Interrupt is a block part of the SoC, not the
> "machine" (talking about machine is borderline with the PMU, since
> it is embedded into the ZynqMP SoC, but currentl QEMU doesn't
> support multi-arch cores).
>
> Move the IPI state to the SoC state, this will simplify the review
> of the next patch.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/microblaze/xlnx-zynqmp-pmu.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-=
pmu.c
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
> @@ -144,7 +145,6 @@ static void xlnx_zynqmp_pmu_init(MachineState *machin=
e)
>      MemoryRegion *address_space_mem =3D get_system_memory();
>      MemoryRegion *pmu_rom =3D g_new(MemoryRegion, 1);
>      MemoryRegion *pmu_ram =3D g_new(MemoryRegion, 1);
> -    XlnxZynqMPIPI *ipi[XLNX_ZYNQMP_PMU_NUM_IPIS];
>      qemu_irq irq[32];
>      int i;
>
> @@ -172,16 +172,16 @@ static void xlnx_zynqmp_pmu_init(MachineState *mach=
ine)
>
>      /* Create and connect the IPI device */
>      for (i =3D 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
> -        ipi[i] =3D g_new0(XlnxZynqMPIPI, 1);
> -        object_initialize(ipi[i], sizeof(XlnxZynqMPIPI), TYPE_XLNX_ZYNQM=
P_IPI);
> -        qdev_set_parent_bus(DEVICE(ipi[i]), sysbus_get_default());
> +        object_initialize(&pmu->ipi[i], sizeof(XlnxZynqMPIPI),
> +                          TYPE_XLNX_ZYNQMP_IPI);
> +        qdev_set_parent_bus(DEVICE(&pmu->ipi[i]), sysbus_get_default());
>      }
>
>      for (i =3D 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
> -        object_property_set_bool(OBJECT(ipi[i]), true, "realized",
> +        object_property_set_bool(OBJECT(&pmu->ipi[i]), true, "realized",
>                                   &error_abort);
> -        sysbus_mmio_map(SYS_BUS_DEVICE(ipi[i]), 0, ipi_addr[i]);
> -        sysbus_connect_irq(SYS_BUS_DEVICE(ipi[i]), 0, irq[ipi_irq[i]]);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&pmu->ipi[i]), 0, ipi_addr[i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&pmu->ipi[i]), 0, irq[ipi_irq[=
i]]);
>      }
>
>      /* Load the kernel */
> --
> 2.20.1
>
>

