Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A786C282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE392171F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZjpbA6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE392171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33292 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHamb-00074X-Af
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 17:10:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHalo-0006fr-4l
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHaln-0006ad-4v
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:10:04 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:42289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hHalm-0006aA-Tn; Fri, 19 Apr 2019 17:10:03 -0400
Received: by mail-lj1-x244.google.com with SMTP id v22so5559562lje.9;
	Fri, 19 Apr 2019 14:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=8y3JnOn2sysVarRFf8sASNkXiG0BxOMAm2gvZWbagI0=;
	b=LZjpbA6f062KcgcjmSdk853IYlk071eXrP37ONYNMvqGCPsg00bRd9lG99WV+iyaSn
	0fcz8TPCFrxfmYqqfW/uP18wdYgcJEGZKiFzISgrYxDqmw9JEsnWPY61mO/X4kZ3Sl5G
	/otapp+3jI5QLPinz74i3PQXpeTwQ81WEmrsy1Smzp6bEz+MEGHg8f7iXZBhpGBpidrV
	VyJxnrmWiCuVmH/ZXTd4Xaos8xfu24lMR1+Gor99+QnS12Qb0qZhLUgElkkHYONKoJJ8
	fFz79ShQCp2jPt+k+eo44An5Kmo0K9yyG3TBfd9MnhiT2FBL/+TSLyyFkQQ0yut0Tne9
	qRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=8y3JnOn2sysVarRFf8sASNkXiG0BxOMAm2gvZWbagI0=;
	b=nos08m/L4A5nx9Bze+mSTzgZ8acQOd0kpavNiayy1Gryfljrz8ljDGtmjL9fwHcJHF
	KFwYJTux2Z2PClNPfLX7n/g5iII2HsGkpk7+3vXW5fJE+uPgZKnEZhTOdZcaH87oqWXs
	ClhhTZNfdEEI1vDW4PkfYAyXvdgooi/OQZhFshcpzyelc7cQfzZnmx69tPxM7v5n9379
	nLrO7CjH0oIP3MoA6TcjbKZhAH6TeI1AYLPNEaon79JhF1+8UywEw0Ox7iVRUQSlF+c4
	ImqISsZTYMAfeYLHg638IuwJm5FQxpLeISku2CSHtawR2tc/Oun+ens5vnEvEwHFK5AJ
	L/sQ==
X-Gm-Message-State: APjAAAXgzo72/IcVFQ8TbPI0/sRwzYSGXmWom7U/ozm547YiSmkrJ75E
	YcRnZydhFhmO6GpOx+VmOYab6DJocmPl1bNT0I8=
X-Google-Smtp-Source: APXvYqzNRmuU2ID0z1fzLXX+LsTLnDQu4gAOW70825ALsK/fjSfZSWhrJyuxPof2o/vyasBaJhD6/Tdb+STtE2Lg0zs=
X-Received: by 2002:a2e:895a:: with SMTP id b26mr3259208ljk.89.1555708201361; 
	Fri, 19 Apr 2019 14:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-14-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-14-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Apr 2019 14:09:34 -0700
Message-ID:
 <CAKmqyKObGO3+s6QsF7TQBTxEx4DRm-GjM9gorv+tvJzC=YsTqQ@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 13/29] hw/arm: Express
 dependencies of xilinx-zynq with Kconfig
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Yang Zhong <yang.zhong@intel.com>, Rob Herring <robh@kernel.org>,
	Qemu-block <qemu-block@nongnu.org>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Antony Pavlov <antonynpavlov@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>,
	Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419210934.t6-YiVXNlaKHXZHcPZqfCcLokfdJIWULWuiaXRPnW2g@z>

On Thu, Apr 18, 2019 at 11:18 AM Thomas Huth <thuth@redhat.com> wrote:
>
> Add Kconfig dependencies for the xilinx-zynq-a9 board.
> This patch is based on earlier work by =C3=81kos Kov=C3=A1cs (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  default-configs/arm-softmmu.mak |  7 +------
>  hw/arm/Kconfig                  | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
> index f39a854f2e..af78e7c892 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -19,6 +19,7 @@ CONFIG_STELLARIS=3Dy
>  CONFIG_REALVIEW=3Dy
>  CONFIG_VERSATILE=3Dy
>  CONFIG_VEXPRESS=3Dy
> +CONFIG_ZYNQ=3Dy
>  CONFIG_MAINSTONE=3Dy
>  CONFIG_GUMSTIX=3Dy
>  CONFIG_SPITZ=3Dy
> @@ -38,16 +39,11 @@ CONFIG_VIRTIO_MMIO=3Dy
>
>  CONFIG_NETDUINO2=3Dy
>
> -CONFIG_PL330=3Dy
> -CONFIG_CADENCE=3Dy
>  CONFIG_FRAMEBUFFER=3Dy
> -CONFIG_XILINX_SPIPS=3Dy
> -CONFIG_ZYNQ_DEVCFG=3Dy
>
>  CONFIG_DIGIC=3Dy
>  CONFIG_MPS2=3Dy
>  CONFIG_RASPI=3Dy
> -CONFIG_ZYNQ=3Dy
>  CONFIG_STM32F2XX_TIMER=3Dy
>  CONFIG_STM32F2XX_USART=3Dy
>  CONFIG_STM32F2XX_SYSCFG=3Dy
> @@ -100,7 +96,6 @@ CONFIG_SMBUS_EEPROM=3Dy
>  CONFIG_GPIO_KEY=3Dy
>  CONFIG_MSF2=3Dy
>  CONFIG_FW_CFG_DMA=3Dy
> -CONFIG_XILINX_AXI=3Dy
>  CONFIG_PCI_EXPRESS_DESIGNWARE=3Dy
>
>  CONFIG_STRONGARM=3Dy
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 101de74260..785e383411 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -201,6 +201,18 @@ config VEXPRESS
>
>  config ZYNQ
>      bool
> +    select A9MPCORE
> +    select CADENCE # UART
> +    select PFLASH_CFI02
> +    select PL330
> +    select SDHCI
> +    select SSI_M25P80
> +    select USB_EHCI_SYSBUS
> +    select XILINX # UART
> +    select XILINX_AXI
> +    select XILINX_SPI
> +    select XILINX_SPIPS
> +    select ZYNQ_DEVCFG
>
>  config ARM_V7M
>      bool
> --
> 2.21.0
>
>

