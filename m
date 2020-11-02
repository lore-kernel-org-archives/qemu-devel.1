Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BBCC63697
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199A0222EC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFZQMkgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199A0222EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdyS-0005Sh-Vm
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdxG-0004WG-7j
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:49:18 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:35098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdxE-0002oY-B3
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:49:17 -0500
Received: by mail-ej1-x62c.google.com with SMTP id p5so20096693ejj.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z9lQPUng9Rd08wCHtEAGZksDuvuO8w8CeJ/qkKUWbMQ=;
 b=XFZQMkgpb9lUXYqy1jRC5kTyOv0N/wOfBJ7TYMHN69p0DBQ60/zVsVSKjhEZWthA0V
 aaPZZ9F8MKvf4aLqHOn8qM3bCTxorz+6LsPK8gIvXzCrJ4YpnRe+F6ZJtRY8CP6sHJam
 yrQLtiqq9ELjzoPl75+C/cQTyP39GjgIePi4Ty7sACTljCU9hVfkSrCWkCJ1qjKwCYxB
 l07FAkVrBbofSTRmQx74pDK3Uxtiloavd+GlrZI+WtUpHajxPuqvwr8L6Lxwv1kSHMSH
 TI5gTwAjz/P3MZfeTpIODfZje5zL5pBz//EhLNThXFpj3d3Vaqf/jGrEL5iFeKS66IhB
 vdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z9lQPUng9Rd08wCHtEAGZksDuvuO8w8CeJ/qkKUWbMQ=;
 b=cN3oOhESZOJDzuDi6oVu5pu7Amb92M+O3oZmImUDxkvv8VWI+8O+6SQJrt7JQl1Kaf
 J0xdtJUdZd4FsZr0S0erkoWGumsEp6jhc4FLV41bDNOlpJWtbTC+kYz3YiGWRSPPpym7
 wwpSBAkGPcrEtvGkJ4vI0cwsgWxRSF5sjybEPYbbaBdz1lilfi9wDc8msXBjfyD4PhpP
 htJSn8sEr48G/GBdy7XXYMu+JIsmdLHsCr5kcdsMYs0RgMhjPUZnZxUfSm07N9cWXX/t
 +g3dHON42MksdA1anct+ZpHEVBj//DH7TDzen/hUTri+iUPjH1pVAwdDByRIuMHBfbJN
 rRQA==
X-Gm-Message-State: AOAM532arWSfI8AV6XTeC7zSt7dQ1CKlb+aFJ/qoWS5V4Vf7UE3Uc5z0
 3ga9T/Q2Eug/afdktWvi88Ryy2uRE0e350ihBYxO+w==
X-Google-Smtp-Source: ABdhPJxHhuHs3v6FQDk5EkIlMH2xJmqCo1V4vJqNp5fcUQX8CmItzlZzNFHoQnGnPFc2NyaZJNl/ZSd6CChOU+3oKfg=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr16419733ejd.250.1604339354532; 
 Mon, 02 Nov 2020 09:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20201023151619.3175155-1-alistair.francis@wdc.com>
 <20201023151619.3175155-13-alistair.francis@wdc.com>
In-Reply-To: <20201023151619.3175155-13-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 17:49:03 +0000
Message-ID: <CAFEAcA9MEG_g_YTFdnfjAp6U9zwqKmQWD8UnPYwbGj0c7WnOUg@mail.gmail.com>
Subject: Re: [PULL 12/12] hw/misc/sifive_u_otp: Add backend drive support
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Alistair Francis <alistair23@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Green Wan <green.wan@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Oct 2020 at 16:27, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> From: Green Wan <green.wan@sifive.com>
>
> Add '-drive' support to OTP device. Allow users to assign a raw file
> as OTP image.

Hi; Coverity reports some issues with this code (CID 1435959,
CID 1435960, CID 1435961). They're all basically the same thing:
in read, write and reset functions this code calls blk_pread()
or blk_pwrite() but doesn't check the return value, so if the
underlying file operation fails then the guest will be
returned garbage data or have its write thrown away without
either the guest or the user being warned about that.

> @@ -54,6 +57,16 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
>          if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
>              (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
>              (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
> +
> +            /* read from backend */
> +            if (s->blk) {
> +                int32_t buf;
> +
> +                blk_pread(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &buf,
> +                          SIFIVE_U_OTP_FUSE_WORD);
> +                return buf;
> +            }
> +
>              return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
>          } else {
>              return 0xff;
> @@ -145,6 +158,12 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
>              /* write bit data */
>              SET_FUSEARRAY_BIT(s->fuse, s->pa, s->paio, s->pdin);
>
> +            /* write to backend */
> +            if (s->blk) {
> +                blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD,
> +                           &s->fuse[s->pa], SIFIVE_U_OTP_FUSE_WORD, 0);
> +            }
> +
>              /* update written bit */
>              SET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio, WRITTEN_BIT_ON);
>          }
> @@ -168,16 +187,48 @@ static const MemoryRegionOps sifive_u_otp_ops = {

>  static void sifive_u_otp_reset(DeviceState *dev)
> @@ -191,6 +242,20 @@ static void sifive_u_otp_reset(DeviceState *dev)
>      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
>      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
>
> +    if (s->blk) {
> +        /* Put serial number to backend as well*/
> +        uint32_t serial_data;
> +        int index = SIFIVE_U_OTP_SERIAL_ADDR;
> +
> +        serial_data = s->serial;
> +        blk_pwrite(s->blk, index * SIFIVE_U_OTP_FUSE_WORD,
> +                   &serial_data, SIFIVE_U_OTP_FUSE_WORD, 0);
> +
> +        serial_data = ~(s->serial);
> +        blk_pwrite(s->blk, (index + 1) * SIFIVE_U_OTP_FUSE_WORD,
> +                   &serial_data, SIFIVE_U_OTP_FUSE_WORD, 0);
> +    }
> +
>      /* Initialize write-once map */
>      memset(s->fuse_wo, 0x00, sizeof(s->fuse_wo));
>  }
> --
> 2.28.0

thanks
-- PMM

