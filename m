Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6798C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B108720674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x8oz22uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B108720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiPx-0006vQ-RH
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jaiNE-000335-Pe
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:12:16 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jaiND-0006Hv-0A
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:12:16 -0400
Received: by mail-oi1-x243.google.com with SMTP id s198so9459384oie.6
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BPSGc1YOAbwiDqGSIPUq/PBsbDFhhz8vXhf0ZS70vnA=;
 b=x8oz22uumUoP6A+CO8dA0XbrRX4DdTY7++0C960rhAkQL2bAmiDeWn+k9dqlQx8vil
 QjF56wGpVk39pfx8nwVkKxFVEawv5sscJ6b1bmbuxrOZx9dShf4cTORkwiJj12Ap8Uv1
 ILQGhn5zxKW/QFP5Ia7FB2r2/sWd8OyItfveA825sCZ2wmgJG/Bu9FyjK85ehN48sWrp
 WWgub6JxfJ14Hiwr3X4tCVWj7iIkzfnvytYnVkOXlCtlx4E2VlqwHp4FakUMEbaYghxF
 ZNEVeJFzBG2t+MW/nUPCezcPI5HZ+U9LGkXkhXlioPQcSl8pXJdChfOYM4cRUtLo9xwF
 HAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BPSGc1YOAbwiDqGSIPUq/PBsbDFhhz8vXhf0ZS70vnA=;
 b=AvTuZeGBVc7X9vyYlO81wr5iD7czy9QQ8nW0sZJO3NSJRU/Xec++5lXpSQJ3myubc0
 PXRY4Pv/P6jKzbhikE2gVlNMcaTbwttMmWpxjltCYZQcYeUpG3C3PHKcrj7bAkwtHTfx
 rd1Kg8GkJzPeqmruzIAOPzyAnX8p506TO1WniqEIW1pnrWzXLirOOu33Y7TGLlHrhkRJ
 E2LGSBe4ba0DozHBdGDNb0ww8nXFdtZXp/IUT6ShjX/27U3qOsXNSAqZY2fZNCAx7Ret
 asbY4sEVf10q6i9Cj0bvEoB0QN8I2fDHPJP7DyvjaVh7HRnPmMLfsr3PJ4eOvOdZ7G49
 a/Zw==
X-Gm-Message-State: AOAM533faBSc0Wl6C+NY82ZN8pANPfRtdu7WcZZxc9vT6Qzi2uTm3hjI
 PmRTAr28wNt+h1nIQHgBgzmxZG3o3Ksc8jHChedDEw==
X-Google-Smtp-Source: ABdhPJwVPkvmnyBFGfSqQO36dYU4yQaoMbq8NJKMnZxBnOljQTUxrKffpT9sNkKNu0DVXBGl/i/3CwmM9KVFbSqsw8I=
X-Received: by 2002:aca:895:: with SMTP id 143mr66214oii.163.1589818333787;
 Mon, 18 May 2020 09:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200518155308.15851-1-f4bug@amsat.org>
 <20200518155308.15851-8-f4bug@amsat.org>
In-Reply-To: <20200518155308.15851-8-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 17:12:02 +0100
Message-ID: <CAFEAcA97bYXyN-GSXUk_OetroaHFExXFwYH1bhexHwRW0+NEVw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 7/7] hw/core/loader: Assert loading ROM regions
 succeeds at reset
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 16:53, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> If we are unable to load a blob in a ROM region, we should not
> ignore it and let the machine boot.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> RFC: Maybe more polite with user to use hw_error()?
> ---
>  hw/core/loader.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 8bbb1797a4..4e046388b4 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1146,8 +1146,12 @@ static void rom_reset(void *unused)
>              void *host =3D memory_region_get_ram_ptr(rom->mr);
>              memcpy(host, rom->data, rom->datasize);
>          } else {
> -            address_space_write_rom(rom->as, rom->addr, MEMTXATTRS_UNSPE=
CIFIED,
> -                                    rom->data, rom->datasize);
> +            MemTxResult res;
> +
> +            res =3D address_space_write_rom(rom->as, rom->addr,
> +                                          MEMTXATTRS_UNSPECIFIED,
> +                                          rom->data, rom->datasize);
> +            assert(res =3D=3D MEMTX_OK);

We shouln't assert(), because this is easy for a user to trigger
by loading an ELF file that's been linked to the wrong address.
Something helpful that ideally includes the name of the ELF file
and perhaps the address might be nice.

(But overall I'm a bit wary of this and other patches in the series
just because they add checks that were previously not there, and
I'm not sure whether users might be accidentally relying on
the continues-anyway behaviour.)

thanks
-- PMM

