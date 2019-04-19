Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275A9C282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73D421736
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eroCTibE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73D421736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33511 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHb6m-0003BV-5k
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 17:31:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHb2U-0000ba-25
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHaoR-0007gV-Dk
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:12:48 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:38470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hHaoR-0007gF-58; Fri, 19 Apr 2019 17:12:47 -0400
Received: by mail-lj1-x244.google.com with SMTP id p14so5585175ljg.5;
	Fri, 19 Apr 2019 14:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=eb5DEXGoCSsZ7cnYJcHMgq+7a4adPduEpTVlJLKF0ZE=;
	b=eroCTibEcr5RzSXC6xFT6ttJsSa+N3NwR4MAMpnr80ZvOlHt+KWSsqxwpFNe2tl6M3
	JY0L41odnroutgDJ8uADcD6Zk7EqPmQMu+Z2QsRhTnBQOWIFfwSVcRWJ5cxb4fwe8h5T
	ZkU4qakDNTiR7Gkgs/gkzKo0otpL8Iggjm6WeRiuU9AXbp+XGB7rUU7DoBuqd1lQkSRA
	H+MMtdiFIJEZ83xnmm1llowjSoMdcRATsUoyLmZGlhTCmD4ApjdLXcJVEsNqXnD2gnZ0
	+H94LqDdkPoXqeUcbvAtBK+NoKb6pYXrpnw0+NybJD+dVRXNesj6K3wCjzrZajFfD0rj
	kJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=eb5DEXGoCSsZ7cnYJcHMgq+7a4adPduEpTVlJLKF0ZE=;
	b=QR6zmR4air5GP70gagu4RfarxTyk+abOZuEQUNYh+bYzEhQw6cna19z3bKlyanegvS
	ZUdtkhp/xWRoSvJTx76HEMYeLWI8lTdFZdGo5/jB8E7XDDqgvAznrV/r0xIGWOo1njg7
	Ac2ydSvMRGN+y/7GQMbkrbolTm851lY4udCCKYSN9G0ghC6bGCPGppZCgdV/ltOG8gYx
	KlanrTW45h/FK2ne2m3sLpfQymVqTjwy296m3G3wSBzsdln/JUIv0j6aajROueeKEisH
	ZtqIJRrmV1jwWOaniVefqbhrq6gFeCYgJdRgCF5gPHqFlsnQgfmlRaqj8CrOq/9zDArC
	U2kQ==
X-Gm-Message-State: APjAAAUd9t22Vi0/omG7MxJdshHIRn3T8lXIoAqw+y216ulWEa6wiPel
	17iVfXS9KgxCY74/akI8uAoyqy+gVNgG+PdlK0Y=
X-Google-Smtp-Source: APXvYqyLvyVEHNMTYhj3Ux6FwUoHBEtz/YO1Ne1dtsCudABpfJHoajH/tVAnlp6Yqz7JIVhyEe7QGAfT3I+6Siqd5OI=
X-Received: by 2002:a2e:9ed3:: with SMTP id h19mr3375143ljk.129.1555708366068; 
	Fri, 19 Apr 2019 14:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-27-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-27-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Apr 2019 14:12:19 -0700
Message-ID:
 <CAKmqyKM-G06FAJ1AJ4Cp0MRV+0oYPbpAbLtZPM9xWFuZ9MBQQA@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 26/29] hw/arm: Express
 dependencies of the ZynqMP zcu102 machine with Kconfig
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
Message-ID: <20190419211219.yA3oOv3Abk1NSPOQ-VTikKw4B5MMprBY-w-Qobn1mrs@z>

On Thu, Apr 18, 2019 at 11:15 AM Thomas Huth <thuth@redhat.com> wrote:
>
> This cleans up most settings in default-configs/aarch64-softmmu.mak.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  default-configs/aarch64-softmmu.mak |  4 ----
>  hw/arm/Kconfig                      | 11 +++++++++++
>  hw/display/Kconfig                  |  1 +
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
> index 4ea9add003..3a4b15e7e8 100644
> --- a/default-configs/aarch64-softmmu.mak
> +++ b/default-configs/aarch64-softmmu.mak
> @@ -3,10 +3,6 @@
>  # We support all the 32 bit boards so need all their config
>  include arm-softmmu.mak
>
> -CONFIG_AUX=y
> -CONFIG_DDC=y
> -CONFIG_DPCD=y
> -CONFIG_XLNX_ZYNQMP=y
>  CONFIG_XLNX_ZYNQMP_ARM=y
>  CONFIG_XLNX_VERSAL=y
>  CONFIG_ARM_SMMUV3=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 708eae19e5..32e4cc50e5 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -277,6 +277,17 @@ config STM32F205_SOC
>
>  config XLNX_ZYNQMP_ARM
>      bool
> +    select AHCI
> +    select ARM_GIC
> +    select CADENCE
> +    select DDC
> +    select DPCD
> +    select SDHCI
> +    select SSI
> +    select SSI_M25P80
> +    select XILINX_AXI
> +    select XILINX_SPIPS
> +    select XLNX_ZYNQMP
>
>  config XLNX_VERSAL
>      bool
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 0577e68c8e..bb95f8d6a4 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -108,6 +108,7 @@ config VIRTIO_VGA
>
>  config DPCD
>      bool
> +    select AUX
>
>  config ATI_VGA
>      bool
> --
> 2.21.0
>
>

