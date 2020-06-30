Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C81C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 21:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A32452053B
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 21:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5LbJGU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32452053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqNSS-0005fB-Tl
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 17:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqNRl-0004zo-Bd; Tue, 30 Jun 2020 17:05:41 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:36865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqNRj-00064q-La; Tue, 30 Jun 2020 17:05:41 -0400
Received: by mail-io1-xd44.google.com with SMTP id v6so8909318iob.4;
 Tue, 30 Jun 2020 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AkVgbj2SVV7S0xqA22+uHgxrGpa6j1wryT4d5Xv/0w0=;
 b=O5LbJGU/0Rujb38vqhTNoXlukQgTsfjnH2M7cJR+kmEKgecsjQMnyYcKTDbh/ahrrx
 ND0pjXrkYvQZCzZv0Az9On1z7PNrLrVJJ8+RvuiTttL38/Ji8js/tbX3tVPvvAneaSbp
 wP9dI3UQJVggs7JOozIEyh/aZ5MiEkicYjBSCR0ei/B6fRrS6/HHWLDyr12YYo5hEjZ8
 XvsQ/2G2zSf6+CMPkoXttylngojyEe3mFlN0jOElKnewy+x3ZHoTXO8d8de5n+mYG/ba
 FypSvY01mHR3CcCpgVF8Xuf0FWCjKEa2kS8lKPdkVVKxyt2I+DWmJOdD9yB/eqSylTMS
 y83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AkVgbj2SVV7S0xqA22+uHgxrGpa6j1wryT4d5Xv/0w0=;
 b=shWcB5Oi/bUwdgrmMCdQy/tkzQi71vhbH/PX9xv26qG4tiNGkWUae9yhw7xXgn1UUV
 e/42v1XuRSzWW8mhQKIBUiOh2lPHYTVETJTNBtEXRKcA5CYRH6KqnWek+8MYGpALER0H
 2mOcHj1Jy6mgB7ovzUUcTmDJ/3Uiyw6rVLe9X21/p6uzVDo4omucpSdqyHgJ8eIo7wbh
 AUaTSzgLvt4wBXv/RpSAtpEdqMoW+oxj6niC+j9BobvBq28qA01nhSW8r5RR0rFMe9Ag
 /FJedV5U5xvCrXKIOzOjSV3qQ6UqYnkbolnkPIB5415FTpbpRM78vz41536qFygvSCjw
 ZggA==
X-Gm-Message-State: AOAM532qiXuNPvyy6Eg8MMCSSKFIfwX+U+1qG38vpgAyFsLO64xzfcPu
 LdW5L04S0ew4bquveg7DWMUURM3yJYV6Acya6Dc=
X-Google-Smtp-Source: ABdhPJwPanBGaAFFxJcwBc8kG/3SHx22A9FkpaewxQVSHIMPV5AjhBpXO+LJ3/Oc1joIBUJtOFT/ZJG93xik11fHiNA=
X-Received: by 2002:a05:6638:dd3:: with SMTP id
 m19mr25753448jaj.106.1593551138063; 
 Tue, 30 Jun 2020 14:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-9-peter.maydell@linaro.org>
In-Reply-To: <20200628142429.17111-9-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jun 2020 13:55:54 -0700
Message-ID: <CAKmqyKNfBsG3k=ryC954D5Q6g3Ese86rODr23iRmc70MCBAJiQ@mail.gmail.com>
Subject: Re: [PATCH 08/17] ssi: Add ssi_realize_and_unref()
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 28, 2020 at 7:27 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Add an ssi_realize_and_unref(), for the benefit of callers
> who want to be able to create an SSI device, set QOM properties
> on it, and then do the realize-and-unref afterwards.
>
> The API works on the same principle as the recently added
> qdev_realize_and_undef(), sysbus_realize_and_undef(), etc.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> --
> 2.20.1
>
>

