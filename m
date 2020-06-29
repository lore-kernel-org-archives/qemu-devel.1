Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D6EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7DB22AAE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7O2sUbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7DB22AAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jppaA-0007dW-TE
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 04:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppZb-00071K-0K; Mon, 29 Jun 2020 04:55:31 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppZZ-0001LY-Am; Mon, 29 Jun 2020 04:55:30 -0400
Received: by mail-wm1-x344.google.com with SMTP id 22so14593997wmg.1;
 Mon, 29 Jun 2020 01:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vGSxZbZNapytdPlgJFBV49YfysjrDAm5hxn08wPrw3I=;
 b=r7O2sUbVDgJpThpmC1zCe9mFLfRKF48D6iU5no0fVIzzGYpVjJ7bsC+vjeBTzi0Xp7
 YxJsf6mEe41eXfS9KoEbKjJb9tKLohOTOKzLj8nBawvIf1O7/jXHhHeDXV/lKre8/Vu/
 k/x9haVKFAUDCdbeTd/ksa5VoqjVmHQBL2gBo2M6zW8HGBfhDA6Hha3pjLvY2cmelSqW
 mMeZ7ek113gZhM7ClGtFiTK1TgPxRnPB41h9poypBlDY6eygZfV9IJyUK/zpvaglPBJu
 xGm2XBwuwRvYC7XQtc5QxC0JYM5RpBcTBVOJZCcv7d/cCmwu5aqFC+chuB4YDcUEWNJD
 ISEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vGSxZbZNapytdPlgJFBV49YfysjrDAm5hxn08wPrw3I=;
 b=kLmWSP5Yhg4TOqfmUzbZx2xuPf/TICcAHFqzW4gdzGkSHTBmd8q5JdF7SyONu21arx
 Q/jSF2E5HJG19Y1/rVb7OYwEyEu+IsvVTAcRUv8eFxFdCMpYvYIeZFZnWujPXaMkobT5
 dr8dauyUodYmWcsOwi2UWfFkonrnX6oh7cO0I1UZKb4Rjty0g1r2SmHQIrYmMi6XT3Ot
 +RirWH5V9+Qj9rZBipCfP99F/0kzrA8tQGOMPKNV97otsL/GDTbsYH/cD7YsD2JXOAOI
 GrOhD53/QzbkYY9U0pI7gpsqqpzrsalrwCDOKebL2mR7nWMn7vEx8mwaGG42HRNyvD/4
 Pltw==
X-Gm-Message-State: AOAM531XvhetuQ+xMr3bHQRTBtzDAG53wq2RMWaC4GT4EpFa/JKc1x+6
 f+eggSz/9nWhTVAnj+kb0EA=
X-Google-Smtp-Source: ABdhPJygmSGW8Qc9SDwQt3SDbpjIlxD3/+9y0CxBW/46Hmq6dPexO/3aU5X4z/luhC6nAPvW+I978g==
X-Received: by 2002:a1c:e143:: with SMTP id y64mr15547699wmg.90.1593420927142; 
 Mon, 29 Jun 2020 01:55:27 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l18sm19662503wrm.52.2020.06.29.01.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 01:55:25 -0700 (PDT)
Subject: Re: [PATCH 02/17] hw/arm/spitz: Create SpitzMachineClass abstract
 base class
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <115c9299-8694-469d-e787-d03f12dc417c@amsat.org>
Date: Mon, 29 Jun 2020 10:55:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200628142429.17111-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/20 4:24 PM, Peter Maydell wrote:
> For the four Spitz-family machines (akita, borzoi, spitz, terrier)
> create a proper abstract class SpitzMachineClass which encapsulates
> the common behaviour, rather than having them all derive directly
> from TYPE_MACHINE:
>  * instead of each machine class setting mc->init to a wrapper
>    function which calls spitz_common_init() with parameters,
>    put that data in the SpitzMachineClass and make spitz_common_init
>    the SpitzMachineClass machine-init function
>  * move the settings of mc->block_default_type and
>    mc->ignore_memory_transaction_failures into the SpitzMachineClass
>    class init rather than repeating them in each machine's class init
> 
> (The motivation is that we're going to want to keep some state in
> the SpitzMachineState so we can connect GPIOs between devices created
> in one sub-function of the machine init to devices created in a
> different sub-function.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/spitz.c | 91 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 55 insertions(+), 36 deletions(-)
> 
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index 9eaedab79b5..c70e912a33d 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -33,6 +33,26 @@
>  #include "exec/address-spaces.h"
>  #include "cpu.h"
>  
> +enum spitz_model_e { spitz, akita, borzoi, terrier };
> +
> +typedef struct {
> +    MachineClass parent;
> +    enum spitz_model_e model;

Nitpick, I'd drop the not very useful typedef and use
directly ...:

       enum { spitz, akita, borzoi, terrier } model

> +    int arm_id;
> +} SpitzMachineClass;
> +
> +typedef struct {
> +    MachineState parent;
> +} SpitzMachineState;
> +
> +#define TYPE_SPITZ_MACHINE "spitz-common"
> +#define SPITZ_MACHINE(obj) \
> +    OBJECT_CHECK(SpitzMachineState, obj, TYPE_SPITZ_MACHINE)
> +#define SPITZ_MACHINE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(SpitzMachineClass, obj, TYPE_SPITZ_MACHINE)
> +#define SPITZ_MACHINE_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(SpitzMachineClass, klass, TYPE_SPITZ_MACHINE)
> +
>  #undef REG_FMT
>  #define REG_FMT                         "0x%02lx"
>  
> @@ -905,8 +925,6 @@ static void spitz_gpio_setup(PXA2xxState *cpu, int slots)
>  }
>  
>  /* Board init.  */
> -enum spitz_model_e { spitz, akita, borzoi, terrier };
> -
>  #define SPITZ_RAM       0x04000000
>  #define SPITZ_ROM       0x00800000
>  
> @@ -915,9 +933,10 @@ static struct arm_boot_info spitz_binfo = {
>      .ram_size = 0x04000000,
>  };
>  
> -static void spitz_common_init(MachineState *machine,
> -                              enum spitz_model_e model, int arm_id)
> +static void spitz_common_init(MachineState *machine)
>  {
> +    SpitzMachineClass *smc = SPITZ_MACHINE_GET_CLASS(machine);
> +    enum spitz_model_e model = smc->model;

... and use 'smc->model' in place.

Patch easier to review with 'git-diff -W' [*].

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

[*] Content of my .gitattributes:

$ cat .gitattributes
*.c         diff=c
*.cpp       diff=cpp
*.m         text diff=objc
*.h         diff=c
*.py        diff=python
*.json      text
*.pl        text diff=perl
*.sh        text eol=lf
*.xml       text
*.yml       text
*.bz2       binary

