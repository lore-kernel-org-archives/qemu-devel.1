Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B010C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CABF62313C
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgZs0SAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABF62313C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jppjl-0005oP-4E
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppgr-0002NM-AK; Mon, 29 Jun 2020 05:03:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppgp-0002gE-M7; Mon, 29 Jun 2020 05:03:01 -0400
Received: by mail-wr1-x441.google.com with SMTP id f18so7661459wrs.0;
 Mon, 29 Jun 2020 02:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=b+1it6LB/AbbY/JNv5oIBLgCzZ+qzVQM3tu1Ac4upgU=;
 b=sgZs0SANfQWqiUg0hTxh/N1nLuY9YtkLAgDlcfQW3iYUnBPbw3Ro1v34KWoOx6ehMg
 5tkf4+twXBfZWesL4HctTQHK0Fp74C+n1S6DkIKUsUE3mFO+lScB5n9b/a3s8S47TKzp
 aFbdz375b62Cb6IxqIXa9/CIKjeY2OMGB0P+bXKK/KllwlKpe86LUgui/6ni5rUzHZxy
 b8iib93eVQbkU5ev5lMWZGmGpIcriITZHe2aZJqx2k2rh79/3SiEydCtip2WG9bUBQ8M
 K/qB45rwFQglyBLfGCjVK1oBGCw6Rg8PQRQh0gEwPYuIxEW08yEPxP15v7d2+XecQq/G
 oT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b+1it6LB/AbbY/JNv5oIBLgCzZ+qzVQM3tu1Ac4upgU=;
 b=r1Y/eWQVAHOZTm6RO/pcia9ZOIFGLs+so1GlH/otgArb7ScsiPAxhdFZyE/v6w9mp+
 2RmHdG8JzU950v6iFXgtSmu/xMxQL3rABWnRytZ99qEsmGLTx/8rvkgDdT3wtVxPfbBh
 HVjfhdVN4gGtfoLs6AsMrqie/tqAixVqAlspgw1d8+X8XF+c+TIw4ts8CUYlbh4hlONX
 rZcoox75DjUcb5WrcbVdK3ZdrJb/h2Y7GgHe7zM3QZesMl1Kzof2GKz7wNuRQ1mtI3Ux
 2obxs8kOhzRQHau0+lzWoHRnE8T0UUGATR6TrlTYpGRVpxF8GIwsLTmtfeFQoVZYgqDG
 TuMg==
X-Gm-Message-State: AOAM5320UhxuXTGi54LKz1oImxc3LAIxi4+xYkoB0WNK5j3NcxY8JNni
 R7XjMZvbRLFx/C0JsOFfQiA=
X-Google-Smtp-Source: ABdhPJz4t4tSW82wiWw1w1/5V/eZKXPkWMRaMP9fROk/yL3039IJYpNpi/vdA/UipsPk0Xg8msOjTQ==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr15318753wrc.377.1593421377870; 
 Mon, 29 Jun 2020 02:02:57 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id a4sm40925182wrg.80.2020.06.29.02.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 02:02:57 -0700 (PDT)
Subject: Re: [PATCH 08/17] ssi: Add ssi_realize_and_unref()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-9-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <19e2c63a-9aff-6d90-8f8a-9053dc7e41e9@amsat.org>
Date: Mon, 29 Jun 2020 11:02:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200628142429.17111-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Alistair Francis <alistair@alistair23.me>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/20 4:24 PM, Peter Maydell wrote:
> Add an ssi_realize_and_unref(), for the benefit of callers
> who want to be able to create an SSI device, set QOM properties
> on it, and then do the realize-and-unref afterwards.
> 
> The API works on the same principle as the recently added
> qdev_realize_and_undef(), sysbus_realize_and_undef(), etc.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/ssi/ssi.h | 26 ++++++++++++++++++++++++++
>  hw/ssi/ssi.c         |  7 ++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
> index 93f2b8b0beb..4be5325e654 100644
> --- a/include/hw/ssi/ssi.h
> +++ b/include/hw/ssi/ssi.h
> @@ -79,6 +79,32 @@ extern const VMStateDescription vmstate_ssi_slave;
>  }
>  
>  DeviceState *ssi_create_slave(SSIBus *bus, const char *name);
> +/**
> + * ssi_realize_and_unref: realize and unref an SSI slave device
> + * @dev: SSI slave device to realize
> + * @bus: SSI bus to put it on
> + * @errp: error pointer
> + *
> + * Call 'realize' on @dev, put it on the specified @bus, and drop the
> + * reference to it. Errors are reported via @errp and by returning
> + * false.
> + *
> + * This function is useful if you have created @dev via qdev_new()
> + * (which takes a reference to the device it returns to you), so that
> + * you can set properties on it before realizing it. If you don't need
> + * to set properties then ssi_create_slave() is probably better (as it
> + * does the create, init and realize in one step).
> + *
> + * If you are embedding the SSI slave into another QOM device and
> + * initialized it via some variant on object_initialize_child() then
> + * do not use this function, because that family of functions arrange
> + * for the only reference to the child device to be held by the parent
> + * via the child<> property, and so the reference-count-drop done here
> + * would be incorrect.  (Instead you would want ssi_realize(), which
> + * doesn't currently exist but would be trivial to create if we had
> + * any code that wanted it.)
> + */
> +bool ssi_realize_and_unref(DeviceState *dev, SSIBus *bus, Error **errp);
>  
>  /* Master interface.  */
>  SSIBus *ssi_create_bus(DeviceState *parent, const char *name);
> diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
> index 67b48c31cd6..a35d7ebb266 100644
> --- a/hw/ssi/ssi.c
> +++ b/hw/ssi/ssi.c
> @@ -90,11 +90,16 @@ static const TypeInfo ssi_slave_info = {
>      .abstract = true,
>  };
>  
> +bool ssi_realize_and_unref(DeviceState *dev, SSIBus *bus, Error **errp)
> +{
> +    return qdev_realize_and_unref(dev, &bus->parent_obj, errp);
> +}
> +
>  DeviceState *ssi_create_slave(SSIBus *bus, const char *name)
>  {
>      DeviceState *dev = qdev_new(name);
>  
> -    qdev_realize_and_unref(dev, &bus->parent_obj, &error_fatal);
> +    ssi_realize_and_unref(dev, bus, &error_fatal);
>      return dev;
>  }
>  

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>



