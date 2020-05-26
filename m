Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65407C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34ABD2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfkMh/xF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34ABD2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jddTY-0005Kx-Ck
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jddQr-0002U2-MR; Tue, 26 May 2020 13:32:05 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:36484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jddQp-00010i-TV; Tue, 26 May 2020 13:32:05 -0400
Received: by mail-qk1-x742.google.com with SMTP id 205so8323936qkg.3;
 Tue, 26 May 2020 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PN6K5e1tyvrYhrCtBaGYgmQsUJa63MJXQBwAz/mTpnA=;
 b=KfkMh/xFWIimZxCOVVkpGTvqaonAkkcOHs+oK7834EsMXUPFiCjnOUnZs4UP4jhTGE
 nzvCl9pPaap2Wv6hNo66ox1hLn+9Xmh23ZCDzDvRZDZAGMdjHIfQbKh4VdBDhn1LVac3
 d5ZOsSjOL9JIfrrvbzP8A0jFJP+dsaSJtURPYCtGdnQBhuiY8JCDObVfjyqsRHTsTlUq
 ypGog6Pfb6wFxjMKNCHhyb+ShF1248l0ywoGbrQkkq6phhAZ6F30pJh0zMgS34MjXIml
 joSsw99vi3JybQc5JOR5L2KRP8ASs+fRBU2rNUh8G0NyIKdAbEfq7K5Jb6IWf/YSiuBr
 Lqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PN6K5e1tyvrYhrCtBaGYgmQsUJa63MJXQBwAz/mTpnA=;
 b=N0gOQnDo9m25VKRMo4LZ68S1jFPx2rqmtNB0urDJfok7UmNyK0GBBfebQ8wdhzoyte
 xYCN8ZHgBrCjS+YuBuvP8CZlOm24Ga14GuYt3cFOjYuKPJtiWXk1aLB4syvGf0kkKEDn
 iJA5k+hRNm4cKq9bESJ6431KwdYlO2dnn0+KWKfZiNWkKKlrNu4qPbyxsOAq8Jrd/Eyf
 5dB5uIBnTMr5CFIfMTRF9s46JWAPmnH9gBACuTfXJ8gYHQrUN847HwBioj+QXXJTY+WK
 Z/HlldxQyNu0if1N0/smOro0sN/OVi79FvdMksSAbCi4qD+7Q2+3qM1R8GX+kQULcV8X
 rJJQ==
X-Gm-Message-State: AOAM530cU2k7bND0TvnJyGzXjqApQBNSyFCI8+jBhv3A4080zXkFW/jg
 5xOAOCv+HrQKtH01kDwXIcaJWveHVQEHv25eR/I=
X-Google-Smtp-Source: ABdhPJxdI/1eBoBFFXQiAA55TlaOXRIFWZVxubtUpZ/hFSBOz2VuGJ2XoBND3j1Ebn0PFWERTx+6mcWuPbMnzUdHG7s=
X-Received: by 2002:a37:96c4:: with SMTP id y187mr2573316qkd.126.1590514316837; 
 Tue, 26 May 2020 10:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200526062252.19852-1-f4bug@amsat.org>
 <20200526062252.19852-8-f4bug@amsat.org>
In-Reply-To: <20200526062252.19852-8-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 10:22:57 -0700
Message-ID: <CAKmqyKNdWM5hwv0aK3tjFh6LSXdgZrUud-idSBp=mhapkkgO-A@mail.gmail.com>
Subject: Re: [PATCH 07/14] hw/display/dpcd: Fix memory region size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 11:27 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> The memory region size is 512K.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/dpcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/dpcd.c b/hw/display/dpcd.c
> index 170545c605..0c1b7b35fb 100644
> --- a/hw/display/dpcd.c
> +++ b/hw/display/dpcd.c
> @@ -1,5 +1,5 @@
>  /*
> - * dpcd.c
> + * Xilinx Display Port Control Data
>   *
>   *  Copyright (C) 2015 : GreenSocs Ltd
>   *      http://www.greensocs.com/ , email: info@greensocs.com
> @@ -137,7 +137,7 @@ static void dpcd_init(Object *obj)
>  {
>      DPCDState *s =3D DPCD(obj);
>
> -    memory_region_init_io(&s->iomem, obj, &aux_ops, s, TYPE_DPCD, 0x7FFF=
F);
> +    memory_region_init_io(&s->iomem, obj, &aux_ops, s, TYPE_DPCD, 0x8000=
0);
>      aux_init_mmio(AUX_SLAVE(obj), &s->iomem);
>  }
>
> --
> 2.21.3
>
>

