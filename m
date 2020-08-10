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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9F9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3122076B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pD4hIoZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3122076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59RB-0003Bw-VW
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 11:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k59Q5-0001wN-UC; Mon, 10 Aug 2020 11:09:01 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:46227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k59Q4-0004cG-5N; Mon, 10 Aug 2020 11:09:01 -0400
Received: by mail-io1-xd42.google.com with SMTP id a5so9186930ioa.13;
 Mon, 10 Aug 2020 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9Ax6NMtLQMEYdOB0rxNEOdVTD4+sHJCXbLvxGjpCL3w=;
 b=pD4hIoZj55CnKCJD2r77YKxL8rg4xLQo43hZJ+D24KlbFoZ8XW/mrdQWzcymDPLeWb
 LM0vQVb/43lOztk2aodP/T+t4JT8QhxEk1oTZZWHx3NQUKBH0cYb1X1Wp6LRE/XyseJc
 sdksKxR/4qagodB65PzbljitwaQz2J7bvZOBOoijZ3jovGsk22pt96Afn/dN6KJwXMql
 4hVIxA9p++ykrJ8iFVCEmWm7pmiKiyKuSoVzhRRr67tkjpl6TjZe1wff95NV3O0xqfoB
 Ydoges1kpEgp/oBDGAGXSoutdWbKUcYTg84A9+hKDm77Jk3xYpbTQIzrHTHVV3VEYXLJ
 4jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9Ax6NMtLQMEYdOB0rxNEOdVTD4+sHJCXbLvxGjpCL3w=;
 b=ooHARpeI6dYnHLBGbCTyukVmw+XKvy/t93ObuEOYOSKxCV06+tCAxncRcSFAcq0j2E
 oZieQuZJyEYR3CJgofgh3skyKz64R6WHVPA7/KTVzq2GCd57LSLCbbe5bIVrfqTRx68k
 xOw7kzvyvJSfGOzos1Hv/NVr0gNOn9tp+tYrNMPeV7Lzo0oSQKw0qtrNMppfGssv0OyW
 3EE6i9JkQz4iNax2M6efKO1qhL9BXRMuW9FkiVvw+deXNzoW1FffixOpkaYJCbw9Aihe
 r/HrizfZBXCTwYZ1xknzycu/6b3Z1pu1nOOf1E7SdqpxD8HhF7RbnKPhE09WM8FVZmG0
 Wu6g==
X-Gm-Message-State: AOAM530yHDf6GaS2uESxm6q/+31zVzMAeUiGmJWqu9C1P/NdBLi3nd9F
 bXZw+tX8oB+daY3ha+BtD8ErIAzSw97JYjt1TRs1aKcs
X-Google-Smtp-Source: ABdhPJzs6jzlorv1z1A+GgnVNY7zVKolncQyVivvgcXy5f+sAmlAJTTEbqxcGvvKc5/DpiZ8lHAMXYuHZUm6m223xy8=
X-Received: by 2002:a6b:b2cb:: with SMTP id
 b194mr18218078iof.105.1597072138593; 
 Mon, 10 Aug 2020 08:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200803105647.22223-1-f4bug@amsat.org>
 <20200803105647.22223-5-f4bug@amsat.org>
In-Reply-To: <20200803105647.22223-5-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Aug 2020 07:58:36 -0700
Message-ID: <CAKmqyKOCLJhYWEDnUQ=2Q09xFa_CdM87qQatgU=NDk_tM0JH6A@mail.gmail.com>
Subject: Re: [PATCH-for-5.1? 4/4] hw/qdev-clock: Avoid calling
 qdev_connect_clock_in after DeviceRealize
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
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

On Mon, Aug 3, 2020 at 3:59 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Clock canonical name is set in device_set_realized (see the block
> added to hw/core/qdev.c in commit 0e6934f264).
> If we connect a clock after the device is realized, this code is
> not executed. This is currently not a problem as this name is only
> used for trace events, however this disrupt tracing.
>
> Add a comment to document qdev_connect_clock_in() must be called
> before the device is realized, and assert this condition.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/qdev-clock.h | 2 ++
>  hw/core/qdev-clock.c    | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
> index a897f7c9d0..64ca4d266f 100644
> --- a/include/hw/qdev-clock.h
> +++ b/include/hw/qdev-clock.h
> @@ -70,6 +70,8 @@ Clock *qdev_get_clock_out(DeviceState *dev, const char =
*name);
>   *
>   * Set the source clock of input clock @name of device @dev to @source.
>   * @source period update will be propagated to @name clock.
> + *
> + * Must be called before @dev is realized.
>   */
>  void qdev_connect_clock_in(DeviceState *dev, const char *name, Clock *so=
urce);
>
> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> index f139b68b88..47ecb5b4fa 100644
> --- a/hw/core/qdev-clock.c
> +++ b/hw/core/qdev-clock.c
> @@ -186,5 +186,6 @@ Clock *qdev_alias_clock(DeviceState *dev, const char =
*name,
>
>  void qdev_connect_clock_in(DeviceState *dev, const char *name, Clock *so=
urce)
>  {
> +    assert(!dev->realized);
>      clock_set_source(qdev_get_clock_in(dev, name), source);
>  }
> --
> 2.21.3
>
>

