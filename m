Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AF4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0329206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDPiUjnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0329206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUGb-00038d-09
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUBr-0002rz-7V; Mon, 06 Jul 2020 12:41:59 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:39188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUBp-000325-GT; Mon, 06 Jul 2020 12:41:58 -0400
Received: by mail-il1-x144.google.com with SMTP id k6so33446563ili.6;
 Mon, 06 Jul 2020 09:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=w/d/5b5xefKkNvFqhM+1+fgyJ1+zynXovt0HSYwZYpg=;
 b=CDPiUjnuoKK4BsBH5+kw78S3TSS8HsgzrMjB5ztHrXfYSAJyVeSz/3N77Xo8Z1gUN8
 /QV84LxIGkz0jSlVgi45cyTO41DNw33ZrYOowj9MPvIRmXL5+pGdrDHG0vNd0ebKAeQY
 9joodCUIyZ0CpmKSUm25rW5jteyRa/b4sjGWZPablpz0FRtgNVnFkh4gM4T78bdpK8he
 vZCT9gTFHBv0gRoafBXKd5nd8R/wRXwTe/VCrI4bC7oGEW66PYPhjg6yIz46AFtyI0PR
 coR6UB65UT4HzZX2o2X68N3oXVTpueXj888gAlY8Er0eT1fvho67X9E/JScI0G6cipEt
 DeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=w/d/5b5xefKkNvFqhM+1+fgyJ1+zynXovt0HSYwZYpg=;
 b=H9Hr7/E045KSk+il0UbBXBjujrp6VnzKKLtoYUnoAAyHNXmVGdbE68xcjunCpWpfVX
 3VvLCtJPVcyzMo808GnNfVVxtpAWKTNRhZ/mIaL+s4Bu9GjR3w4UNj5uhaPyfBQ94zNX
 mf9x2n1ns0clmARCv3qdD4PrjGXtGpbuB4h7Ri76J2IHPHHFbosjJaI3i83X6dc5L4+A
 qm8SOH/v3Lyn3aGK0SWXJ8GbI6t3tzBSkclHkcqRbdp/3+RV8TZ7g78MAc9dui0hGYmf
 MDh/2jTz6N4jRpwWEKuH54QvsT4beZM+c1Fa4lk8x9YPpBhENLJAHwd9/2xugQSiX0OM
 451A==
X-Gm-Message-State: AOAM530prKuYMFiAHWR7Ukl2evBFFY1LUaUkeWjJ7SVfWxOSasOMTr/o
 CBsihy5R60462ELsBgnlXBBxpAYb5G4OdYbIkgM=
X-Google-Smtp-Source: ABdhPJzghXHRhI4t30tRIgaeJ71dbDmfeiuEPFnrvJlRvO73GUxvAdCUQFcsvXSiW38GR+ZjCm+gDZDJ8VgsXzXYTmg=
X-Received: by 2002:a92:d186:: with SMTP id z6mr33168144ilz.227.1594053716133; 
 Mon, 06 Jul 2020 09:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-15-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-15-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:32:09 -0700
Message-ID: <CAKmqyKMbn5ybfG9ZyT-OcsppFBv8gPE103GYmvYBqGsszFw5EA@mail.gmail.com>
Subject: Re: [PATCH v7 14/17] hw/sd/sdcard: Make iolen unsigned
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 6:51 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> I/O request length can not be negative.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v4: Use uint32_t (pm215)
> ---
>  hw/sd/sd.c         | 2 +-
>  hw/sd/trace-events | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 364a6d1fcd..3e9faa8add 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1981,7 +1981,7 @@ uint8_t sd_read_data(SDState *sd)
>  {
>      /* TODO: Append CRCs */
>      uint8_t ret;
> -    int io_len;
> +    uint32_t io_len;
>
>      if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable)
>          return 0x00;
> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> index 5f09d32eb2..d0cd7c6ec4 100644
> --- a/hw/sd/trace-events
> +++ b/hw/sd/trace-events
> @@ -52,7 +52,7 @@ sdcard_unlock(void) ""
>  sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size =
0x%x"
>  sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size=
 0x%x"
>  sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, =
uint8_t value) "%s %20s/ CMD%02d value 0x%02x"
> -sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, i=
nt length) "%s %20s/ CMD%02d len %d"
> +sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, u=
int32_t length) "%s %20s/ CMD%02d len %" PRIu32
>  sdcard_set_voltage(uint16_t millivolts) "%u mV"
>
>  # milkymist-memcard.c
> --
> 2.21.3
>
>

