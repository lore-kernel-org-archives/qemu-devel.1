Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883AFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6122076B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoAVZ/sX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6122076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59RJ-0003Lu-Gh
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 11:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k59QX-0002Wq-Le; Mon, 10 Aug 2020 11:09:29 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:46039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k59QW-0004eg-2l; Mon, 10 Aug 2020 11:09:29 -0400
Received: by mail-il1-x142.google.com with SMTP id k4so1277696ilr.12;
 Mon, 10 Aug 2020 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=brYuxkoypButTLYNf+SY8PP5oxt4TcdbtFmRF+wRY/I=;
 b=aoAVZ/sXSczM89Yy/rnHuixf/mDh4mzE+E9sHiIdP1wJ9zxny1RHN2mMqhkRii/ZiH
 8FVefTAhRcCyQKlK29B/JtdRZgHe74/xxLAfV6JHcqK7xlnqoYE60RSYua933N70mHyp
 w598nLUvyARdG3w+JcHlWyRJGKPtpL3fKwMNxdb/yObiGcnJ93l0dttklCmtdkDqS3By
 mui6q/9Azwjm4DRu/Q4HR8c31PsMoSnYSHblT5c71Eo0R3HpPT3m8YaLHZMpLF1ZzvXu
 N/JmrsBrU+LD5/dJb3/+9XZ27wmSwGZw3jIbE/G9DvH0d1KPmRpTBdh+2kcHo1BFVHGa
 d3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=brYuxkoypButTLYNf+SY8PP5oxt4TcdbtFmRF+wRY/I=;
 b=nd4VQGNSkG3a9vC5PWUYZ1vE3QCVqg1x9c7RVfdhP/Ns5vhgRF57RRaUV3yzRqQG6z
 rKRD0HfVZ9hafcJT10p0wsPyXSE4vnyjFdLFNqS16PvyMa2ViaYsIkXUukcjISPmmLkc
 2Hk4/at+dWA7vOyhZPQxpyepRM/8Knojl7yRtGCshwt6Fh1KMnxo6zWRivGXDfHCTKhn
 Y7IcXLtNpHvy5cenBl76+VpqaAN60BOmJVCyn+DbQEgFs+QWY9YP1cj+SYf1Mi35DwNO
 ddEn9ejxTla3r/3yurxkR3BNi2HExViammApmzKIxxGOdG/Xhz5FS4hw/lOHzxfk9hU4
 8AnA==
X-Gm-Message-State: AOAM532/s3H7FI5sYlOWMkCW0wdNkonaxnLMwJLrVmvvfHCCby+bfD6z
 h8S6c4LOIhdgX+IYIJKafoVc6LL3fJB1KfxrlI4=
X-Google-Smtp-Source: ABdhPJxDrZpTLNX8c2nqRF7M/+r3jswc8Cj+8pZUkzSMsWc9NM41W7A09bhcM+Roeh8SlV/MEY0ECp0+bx+anujjMkA=
X-Received: by 2002:a92:4989:: with SMTP id k9mr19018456ilg.177.1597072166823; 
 Mon, 10 Aug 2020 08:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200803105647.22223-1-f4bug@amsat.org>
 <20200803105647.22223-4-f4bug@amsat.org>
In-Reply-To: <20200803105647.22223-4-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Aug 2020 07:59:04 -0700
Message-ID: <CAKmqyKPoioMFBPHV_M=T=3uxxyYAiP+s02iHoOWYVPYgGCi4_A@mail.gmail.com>
Subject: Re: [PATCH-for-5.1? 3/4] hw/qdev-clock: Uninline
 qdev_connect_clock_in()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 3, 2020 at 3:57 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> We want to assert the device is not realized. To avoid overloading
> this header including "hw/qdev-core.h", uninline the function first.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/qdev-clock.h | 6 +-----
>  hw/core/qdev-clock.c    | 5 +++++
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
> index a340f65ff9..a897f7c9d0 100644
> --- a/include/hw/qdev-clock.h
> +++ b/include/hw/qdev-clock.h
> @@ -71,11 +71,7 @@ Clock *qdev_get_clock_out(DeviceState *dev, const char=
 *name);
>   * Set the source clock of input clock @name of device @dev to @source.
>   * @source period update will be propagated to @name clock.
>   */
> -static inline void qdev_connect_clock_in(DeviceState *dev, const char *n=
ame,
> -                                         Clock *source)
> -{
> -    clock_set_source(qdev_get_clock_in(dev, name), source);
> -}
> +void qdev_connect_clock_in(DeviceState *dev, const char *name, Clock *so=
urce);
>
>  /**
>   * qdev_alias_clock:
> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> index 5cc1e82e51..f139b68b88 100644
> --- a/hw/core/qdev-clock.c
> +++ b/hw/core/qdev-clock.c
> @@ -183,3 +183,8 @@ Clock *qdev_alias_clock(DeviceState *dev, const char =
*name,
>
>      return ncl->clock;
>  }
> +
> +void qdev_connect_clock_in(DeviceState *dev, const char *name, Clock *so=
urce)
> +{
> +    clock_set_source(qdev_get_clock_in(dev, name), source);
> +}
> --
> 2.21.3
>
>

