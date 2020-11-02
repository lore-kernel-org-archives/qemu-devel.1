Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE8CC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 378A3206C1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRZJLcl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378A3206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZXnZ-0003Om-3w
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZXlN-0001Rg-OK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:12:42 -0500
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:37758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZXlK-0003Pa-Pf
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:12:37 -0500
Received: by mail-ed1-x542.google.com with SMTP id o18so13966740edq.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 03:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hfeX/a+AchVjQcqP2lFZDZCdUFs184FjMKpBV84t+OQ=;
 b=QRZJLcl6pdKHSN9sVIN/iG5OGl3VAp56elkA1F3YYDXnjWUbs6rcRAR7Vsh2M36h1/
 SFA2i5fC6RNH+/V6/W1to7YoGdk8w2rPSjjTKC0DShEs4MLMWCu+05+qdOc71g6ONwg7
 Scbw6hbEVmdXB6Px7zSztVYWq4mtt6BgqZ9fTZ67ghvY7c6Q3rZpl3bQ+8/2STD6OCAI
 SshHiHNpMVAZ3J+HQoGSjhd8wA2LeIe2IbHKUNLNow32cRLSp+Tcj039E+GY6UCIxA7w
 EI25+coDsHyHJizGI2MaChV4i1qkeh0pD7QAbO5TSUu2QxBPYwX/lHYX4hrYWQoabmuF
 Z2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hfeX/a+AchVjQcqP2lFZDZCdUFs184FjMKpBV84t+OQ=;
 b=K+H7cjJiRdcEFAcGkLjwLqSIYXpnoesmZ60tauzR6jjSz/txx5iD9TTzkO+XnGIKhe
 qlvvFxfGKG1BVoVsuK2gY/6Cl9ypIRpb+203aFR+xZT5teQbHZHlibUCkDh0IL/U+oni
 YHk2BAeBhTeKW2FMNq1nRbEJ0Nx2GV8++qLHvIASGzfMkmeHqZF2f3IkZ8mLEeuphnLb
 SVQt9HlQjhze4jRpnb8NBSD8Mcmi7S6oBls6DT7AALP5ORWLbF7hFfYS8o7oz+6/eR/i
 bcpITkTBoICeXO/mju/KYNubWqeaT4cDfj8Wc53LFS+rW5oI0ZrzA18ChiiGIvt7VP0V
 Dd0g==
X-Gm-Message-State: AOAM531usQPqHER1QX4yj1bLsOjXTzAxjt+ZbcoKRMQRVbeUq7bfvfW/
 iBIw0UVUdlpExFiJWv/SsF9S7Scoham5apb3X7qYOw==
X-Google-Smtp-Source: ABdhPJwsbj4na2nrTjWJ/nslbm1VtvEND29/y7qyxS4kDKfWrCHfKEwL6mKKcQnCSuLASDYPn+fF9o0z6QZ9DrK3qYI=
X-Received: by 2002:a05:6402:4c6:: with SMTP id
 n6mr16341518edw.204.1604315553097; 
 Mon, 02 Nov 2020 03:12:33 -0800 (PST)
MIME-Version: 1.0
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <20200921221045.699690-17-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-17-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 11:12:21 +0000
Message-ID: <CAFEAcA-hBRcOXmNbHPaPCuE94_g8dS61mPYyQL_JnYPCrBOZsw@mail.gmail.com>
Subject: Re: [PATCH 16/24] virt: Register "its" as class property
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Sep 2020 at 23:11, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Class properties make QOM introspection simpler and easier, as
> they don't require an object to be instantiated.
>
> Note: "its" is currently registered conditionally, but this makes
> the feature be registered unconditionally.  The only side effect
> is that it will be now possible to set its=on on virt-2.7 and
> older.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/arm/virt.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index d1ab660fa60..986b75a6b89 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2484,6 +2484,13 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>                                            "Set on/off to enable/disable emulating a "
>                                            "guest CPU which implements the ARM "
>                                            "Memory Tagging Extension");
> +
> +    object_class_property_add_bool(oc, "its", virt_get_its,
> +                                   virt_set_its);
> +    object_class_property_set_description(oc, "its",
> +                                          "Set on/off to enable/disable "
> +                                          "ITS instantiation");
> +
>  }
>
>  static void virt_instance_init(Object *obj)
> @@ -2511,11 +2518,6 @@ static void virt_instance_init(Object *obj)
>      } else {
>          /* Default allows ITS instantiation */
>          vms->its = true;
> -        object_property_add_bool(obj, "its", virt_get_its,
> -                                 virt_set_its);
> -        object_property_set_description(obj, "its",
> -                                        "Set on/off to enable/disable "
> -                                        "ITS instantiation");
>      }

This leaves the code reading
  if (vmc->no_its) {
      vms->its = false;
  } else {
      vms->its = true;
  }

which is more simply written "vms->its = !vmc->no_its;"

thanks
-- PMM

