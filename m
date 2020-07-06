Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC699C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B297206BE
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vpdjrgtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B297206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUWN-0003VP-LQ
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUE9-0007Kd-RF; Mon, 06 Jul 2020 12:44:21 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:44674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUE8-0003SB-7s; Mon, 06 Jul 2020 12:44:21 -0400
Received: by mail-io1-xd44.google.com with SMTP id i4so39988311iov.11;
 Mon, 06 Jul 2020 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=O6xR90kF1/jlLd+j49QMII3+ONPI0moClE7lxfOoPws=;
 b=VpdjrgtnE9Ngz33BjS1dG/4aeexs75n1WlHtbprSmEtL/8azN3E8kl6TP4pSIauHJD
 t40IgR77dF8gwcd4bhHESMNeqrNou3NSoHKwbztPXkLqE8SM3LW+CgPn3eHZrUUIpSUD
 gpDKl1AkV8eahuKe2/kkZjkVRdqGSakzj0IrQ0Ac7ntP7ew1Nf9N0xCfbqxdg0nlE/Ay
 LaoMeoROWfM/1ba0bihNuN1LSOSj1LZYvcXukKYFzXx5PVHsKdqjL9aMuzyWKHTSLjuH
 0IP9wdPPNZapeNM9pdHifWKJEi/O/HnYH88IfCBJMXObkvk0ZChUuN78ShQBeQBqZ9Ku
 F0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=O6xR90kF1/jlLd+j49QMII3+ONPI0moClE7lxfOoPws=;
 b=rD7C2GMzlhoP5iQEQrQhED9SgoJIXfWHVWmEUDzZqrHnuPF8q03PmjJiNzHNKGHqfj
 BaNgkGky1RQCpmm9BtPV9sg9IjET7wxPzAVutFjkzNr0bes8luE5yaY9T4zatph7VaNG
 +kerCjhShziD4WPn5sDyiKcppLp9m1Hr1Vak+Lpka+nkOKvkO5METVQGbW6DV5MeKht+
 48bDI8GOhhVMHQv50iipAN4weeEFCGFcQtbAJiHzN5xtS/TMzpatSDI7rhRS1x4GXT2p
 YN04d1eDDcjrx0b2qDRBiPHum6wv03Oypyf5Lo8zS809uGeEE8BAujsE6uN2dA8AMPS+
 k/aw==
X-Gm-Message-State: AOAM5333RjdlykZw6ncN7Ywr8q/sND22fLqV0R6jJ43U21l3e2CQUVqs
 40rm1IfYyPBlblYsKVMLDaTUg7J/7IA28PXK/A4iR8m5
X-Google-Smtp-Source: ABdhPJwCYJCFtlRgj8hNZpSvUa5pr3DJbej2G6KOAGbuB6Z75OTTdLRTpIqz+y9gJsIry1411cjqWqQxybAkUG0MYQo=
X-Received: by 2002:a5d:9ed0:: with SMTP id a16mr26167291ioe.176.1594053858909; 
 Mon, 06 Jul 2020 09:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-18-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-18-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:34:32 -0700
Message-ID: <CAKmqyKPUh2+tzr-EimhyUZgZdp4Eexs7B-AKtOS-Fu5w8gKh5w@mail.gmail.com>
Subject: Re: [PATCH v7 17/17] hw/sd/sdcard: Simplify realize() a bit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 6:46 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> We don't need to check if sd->blk is set twice.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/sd/sd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 304fa4143a..8ef6715665 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2154,12 +2154,12 @@ static void sd_realize(DeviceState *dev, Error **=
errp)
>          return;
>      }
>
> -    if (sd->blk && blk_is_read_only(sd->blk)) {
> -        error_setg(errp, "Cannot use read-only drive as SD card");
> -        return;
> -    }
> -
>      if (sd->blk) {
> +        if (blk_is_read_only(sd->blk)) {
> +            error_setg(errp, "Cannot use read-only drive as SD card");
> +            return;
> +        }
> +
>          ret =3D blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PER=
M_WRITE,
>                             BLK_PERM_ALL, errp);
>          if (ret < 0) {
> --
> 2.21.3
>
>

