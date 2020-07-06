Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9716C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97629206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhIKZBJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97629206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsU9g-0007cZ-R9
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsU8b-0006u0-KA; Mon, 06 Jul 2020 12:38:37 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:39177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsU8a-0002Jo-4q; Mon, 06 Jul 2020 12:38:37 -0400
Received: by mail-io1-xd42.google.com with SMTP id f23so40055600iof.6;
 Mon, 06 Jul 2020 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+l1I5Xhqc3P5XsCU1iMZrdJvHp91GJhclyJOEo05Ans=;
 b=DhIKZBJyT0h4aBgfTkz9ed6wgHWMi/c9EctHnzviNqb85bLSPU9B8/9RKItcFBhxog
 mBFXK6K7TvBlJakhBo9GC7WxZIPe2kJuXmgDxSpJV+jyUASU3a7EPyoSslKkt1YOiYHp
 4CMYVjcZZDim6hzpgcE63gRYfZdePGhCmQ/7uwpmClH6R/KmXlhgVCUoeaWi+2dYUomV
 QQJnXaL5tBrib/mnPFHUthtDXmqJmxZhSk/pYqZq+sCL8/ENZLNFo1OKUgOsF9LQVH3m
 w8Tcp+3CWW23BcnaZr7oU1a6mBtGRA9OcIfjQ1uh5rpF7+pRVcvgI/vr3CZFuapzwyfc
 Tgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+l1I5Xhqc3P5XsCU1iMZrdJvHp91GJhclyJOEo05Ans=;
 b=j8oEuNEOAeGLy5otOAC43fdmPF6K3MV2H9yHkm+EaCBt6VoIH382JQA3A6Hy7oUNRP
 wih8JyXnapPnMOZVLaVCaFY8O7hWxYiIJAsnrvEWrvztw1ExzMz02qAGB+KpnIy0NtXi
 MAZSSkGxX3PaI5Se4D5C0PI9H9d8QQOmGvgcWMtZ+CGJOsv/JWucAi6XymyZwttkZ1mG
 iK9d++B7P4lWHkgLNgCpZ+MPfxhxJky9aTaCOXVGNiMeUJhC6dp0RNb09Pm0EmifERWl
 8QBRlJJmioOWDI9qBoxMXUlqxXqkr548VE5TkcTdrLAAhwfrEl1ywHuy9gvqUXzENwph
 lL3A==
X-Gm-Message-State: AOAM533xR69wk2fgzXNbnGpNT2z61M5Ix2YsD/VZrsSfy50DGGJ4O1Sb
 XuSEXLp1JD71qffdHaj0ltXUPZYzK2FlfILEFWs=
X-Google-Smtp-Source: ABdhPJxunMkFJfOO79X9Fz3k5QWzOtwhj6JfN5F6Kp1Gq6Ki9bpW50S6tdx0FQMrGzI7SDsewD5dFu8crdpWR3/XtTU=
X-Received: by 2002:a6b:8dd1:: with SMTP id
 p200mr26301536iod.118.1594053514892; 
 Mon, 06 Jul 2020 09:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-12-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-12-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:28:46 -0700
Message-ID: <CAKmqyKNHCAyG6p+jjtcBpxoo04Nih91MDdMW_8Rh4kn-OwK0MQ@mail.gmail.com>
Subject: Re: [PATCH v7 11/17] hw/sd/sdcard: Update the SDState documentation
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

On Tue, Jun 30, 2020 at 6:45 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Add more descriptive comments to keep a clear separation
> between static property vs runtime changeable.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/sd/sd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 5d1b314a32..723e66bbf2 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -103,11 +103,14 @@ struct SDState {
>      uint32_t card_status;
>      uint8_t sd_status[64];
>
> -    /* Configurable properties */
> +    /* Static properties */
> +
>      uint8_t spec_version;
>      BlockBackend *blk;
>      bool spi;
>
> +    /* Runtime changeables */
> +
>      uint32_t mode;    /* current card mode, one of SDCardModes */
>      int32_t state;    /* current card state, one of SDCardStates */
>      uint32_t vhs;
> --
> 2.21.3
>
>

