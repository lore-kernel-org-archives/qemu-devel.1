Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FFAC282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B524C21736
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zls6RsCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B524C21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33469 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHb5K-0002Kp-TO
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 17:30:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHb2T-0000hW-CF
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHap4-0007vF-P6
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:13:27 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:36821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hHap4-0007uk-HO; Fri, 19 Apr 2019 17:13:26 -0400
Received: by mail-lf1-x143.google.com with SMTP id u17so4835259lfi.3;
	Fri, 19 Apr 2019 14:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=+aKxKnKb7ZcgKc8QDdoeGMCgP5CFxqd0kerv4gVEqc4=;
	b=Zls6RsCz2fsfOm8bhOEj61sRoISMZu6Mi9Inwnr8h06LUpsT66+Hiwb2trywOKeJnT
	J71YyF+s0KKK5hxN0rm91MU8MY8U2+lmriE3962TpXLmu930Slcdpr87dbtJ8lT470fi
	+hl1gdyElJz0/mQifPu0zNq6+XqHHebkt+pB6A9PNZZruIpWCrTXGg/b3lE1kn++JWvG
	65Km28mL/lHWkVV5j2SVnd4FfxeCL4vLScQfcUJi/oifgW67o1ux9hNVFB2a2bQ8BU9B
	OYjPHKwp1sAXngpsbaq0L/6nGLUex0FLiouhtiJ1YG/iIIeqwK+wFiVY91KydGQ47glG
	33hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=+aKxKnKb7ZcgKc8QDdoeGMCgP5CFxqd0kerv4gVEqc4=;
	b=YsyxIZrhueX77GPYU0/plwYQwQA4fnALxbpM0v95yqtUN70wSUz5kReaulCKRRqzF6
	wh3s9r56C6G+GHM/ys3VXnN09ILxlIDEC1OnfEmBvz/EwFlLnYOxOfeI7A9VHKM8nqr+
	A6Lps4SDV68YDiuzhwO1bgjYoWwAuCnrBopAsvPoFwMhVBi9uxChKZIPoLHbCtUBhFfJ
	Xe42y5iTnP1BeKFlH7Gl0nEiCcelScefTSlO9U5DbIcmgipWfbZEab2+h/TSWTOuPvqw
	Ma0glwQmRs4YnMRStPz5R58Y+YGavzj7foPtdEat4vLHvnKKNG/XgWAv3+pK0tSWnmOB
	9gLw==
X-Gm-Message-State: APjAAAVMg+Kq+ikILF0hmxlfEYtHQYa244vgK8+pqUEKSqXasPtlPVpP
	EHNbIUWL/G7RCsc9sIBjbr1zQ9aDbz5vxgz5e25vRb/R9w8=
X-Google-Smtp-Source: APXvYqyF5D7NmA3QKtltRLXkBru7aEZto0h8lh+ZipqI50Y0ZyLbIDWCqPMO0xPUOUEFHsj+Xz/s/mG4pum/BhUl0oY=
X-Received: by 2002:a19:4b84:: with SMTP id y126mr3258572lfa.15.1555708405250; 
	Fri, 19 Apr 2019 14:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-21-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-21-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Apr 2019 14:12:58 -0700
Message-ID:
 <CAKmqyKMk-346_m5=9Tbk7e_WFHkMe5EdiBX2efGASoQcsWBpTw@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 20/29] hw/arm: Express
 dependencies of the raspi machines with Kconfig
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
Message-ID: <20190419211258.wPvtOFmlKiyp01wy1PE8sRSFCEEBscTHvf0RSaYGiXo@z>

On Thu, Apr 18, 2019 at 11:25 AM Thomas Huth <thuth@redhat.com> wrote:
>
> Most of the code is directly controlled by the CONFIG_RASPI switch,
> so not much to add here additionally.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  default-configs/arm-softmmu.mak | 4 +---
>  hw/arm/Kconfig                  | 3 +++
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 31d31d3f4a..22bff20b32 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -31,15 +31,13 @@ CONFIG_COLLIE=y
>  CONFIG_ASPEED_SOC=y
>  CONFIG_NETDUINO2=y
>  CONFIG_MPS2=y
> +CONFIG_RASPI=y
>
>  CONFIG_VGA=y
>  CONFIG_SSI_M25P80=y
>  CONFIG_IMX_FEC=y
>
> -CONFIG_FRAMEBUFFER=y
> -
>  CONFIG_DIGIC=y
> -CONFIG_RASPI=y
>  CONFIG_NRF51_SOC=y
>
>  CONFIG_FSL_IMX6=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 466b143fdf..e68a29ca2b 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -257,6 +257,9 @@ config ALLWINNER_A10
>
>  config RASPI
>      bool
> +    select FRAMEBUFFER
> +    select PL011 # UART
> +    select SDHCI
>
>  config STM32F205_SOC
>      bool
> --
> 2.21.0
>
>

