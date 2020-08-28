Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877B4C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B15208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgw7/aCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B15208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBbI8-00052R-JO
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kBbHQ-0004UT-4T; Fri, 28 Aug 2020 06:06:44 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kBbHL-0001BE-Ro; Fri, 28 Aug 2020 06:06:41 -0400
Received: by mail-oi1-x243.google.com with SMTP id e6so360694oii.4;
 Fri, 28 Aug 2020 03:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OJ/Sw/nO7mzhvLU0NW6HbEGvF0Tn1VBA7xT+OrqH9Jc=;
 b=fgw7/aCQYTGjT/1lW5I3haK6DiIN4xpdCvuci5Jb84AyIbafWaMIXNyhoZnRdEBtBx
 HIW/Epwsob8MgZUo95AAR7UpCRFIvqsIpKLw0/jaw4ofEm2u0Fsl6rnXMmSONRZ1PPC7
 ISuch/wB5ePNzat9UJw7icZQIWJOa084modswmsOVIymmpGNzTqDMi146AGF+64WWSqJ
 8Kqk+dmcZTgP0JTXcXCFIURXQH0JJLojwTo3AIZrvfiQ6yo0uUyXvQgsDXc9077TNFTW
 jaSIXqQuB1HvQ7no++Hg8LXspiSuPVUruKEBKKm4lv5Oj73Jpz4pV5Jd97AcMVAEdvFo
 RHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OJ/Sw/nO7mzhvLU0NW6HbEGvF0Tn1VBA7xT+OrqH9Jc=;
 b=lJD1E/W+7gLDT9jSZC0M9/dzQZeDVlgTd3kEND4xo77DfwIXe7ikPvj1XgQ0n9Oe3r
 UZxRk2t+5Yac4rybQI20Cv+SKIwh6hNzAhecMZMVuJ8ctFsxfRIN3cNwyWRHKZIGlOVg
 BTsEEUDO7M6Np2hbblpnH5npgke3mwJYOsY/kDYovJOukfx4pRLHTZ9rH4AZmIvbB40W
 7oZKwUMzRX5l80yqpU93vxwPPzhQtWGvGUTassCXv3H4r4gh1gnrh+5hzmPOwUd9N7Ie
 DabLyO8u8CdGVzUaU4L5vxmGxnW5UOm8gbMhZjwt657kxaiCfPg76ubk7DkRjI2x424S
 02pw==
X-Gm-Message-State: AOAM533lrAfIiKWaBk0aGoi8tHF1QVmWPGxJTPqqkxS3fdkNBCMQZsvf
 yQChQ7VeCq5Id7ZaWu3s5WbjMkj6+CNHsjsYxqc=
X-Google-Smtp-Source: ABdhPJxKPBEA4NphiiTLvhbz8MJC+fzLeHC7+VfMo8iTT/xJ5IokukfCuGdQkz+e8AdedIYIUX7Ef6ilUMCCDSE19R4=
X-Received: by 2002:a54:400a:: with SMTP id x10mr471653oie.150.1598609198232; 
 Fri, 28 Aug 2020 03:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200820171006.1140228-1-philmd@redhat.com>
In-Reply-To: <20200820171006.1140228-1-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 28 Aug 2020 18:06:02 +0800
Message-ID: <CAKXe6SKk-9t1P3_5zHKXj4hufTSruPzf4AjGHtqSEZS1Vv4AmQ@mail.gmail.com>
Subject: Re: [PATCH] util/vfio-helpers: Unify trace-events size format
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: qemu-trivial@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=
=9C=8821=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:11=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Some 'qemu_vfio_*' trace events sizes are displayed using
> decimal notation, other using hexadecimal notation:
>
>   qemu_vfio_ram_block_added s 0xaaaaf2448d90 host 0xffff5bc00000 size 0x4=
000000
>   qemu_vfio_dma_map s 0xaaaaf2448d90 host 0xffff5bc00000 size 67108864 te=
mporary 0 iova (nil)
>   qemu_vfio_find_mapping s 0xaaaaf2448d90 host 0xffff5bc00000
>   qemu_vfio_new_mapping s 0xaaaaf2448d90 host 0xffff5bc00000 size 6710886=
4 index 4 iova 0x114000
>   qemu_vfio_do_mapping s 0xaaaaf2448d90 host 0xffff5bc00000 size 67108864=
 iova 0x114000
>
> As it is hard to follow, unify using hexadecimal for all sizes:
>
>   qemu_vfio_ram_block_added s 0xaaaaf1c60d90 host 0xffff2bc00000 size 0x4=
000000
>   qemu_vfio_dma_map s 0xaaaaf1c60d90 host 0xffff2bc00000 size 0x4000000 t=
emporary 0 iova (nil)
>   qemu_vfio_find_mapping s 0xaaaaf1c60d90 host 0xffff2bc00000
>   qemu_vfio_new_mapping s 0xaaaaf1c60d90 host 0xffff2bc00000 size 0x40000=
00 index 4 iova 0x114000
>   qemu_vfio_do_mapping s 0xaaaaf1c60d90 host 0xffff2bc00000 size 0x400000=
0 iova 0x114000
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  util/trace-events | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/util/trace-events b/util/trace-events
> index 0ce42822eba..d9a0b4f8c63 100644
> --- a/util/trace-events
> +++ b/util/trace-events
> @@ -79,7 +79,7 @@ qemu_vfio_dma_reset_temporary(void *s) "s %p"
>  qemu_vfio_ram_block_added(void *s, void *p, size_t size) "s %p host %p s=
ize 0x%zx"
>  qemu_vfio_ram_block_removed(void *s, void *p, size_t size) "s %p host %p=
 size 0x%zx"
>  qemu_vfio_find_mapping(void *s, void *p) "s %p host %p"
> -qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint6=
4_t iova) "s %p host %p size %zu index %d iova 0x%"PRIx64
> -qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s=
 %p host %p size %zu iova 0x%"PRIx64
> -qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint=
64_t *iova) "s %p host %p size %zu temporary %d iova %p"
> +qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint6=
4_t iova) "s %p host %p size 0x%zx index %d iova 0x%"PRIx64
> +qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s=
 %p host %p size 0x%zx iova 0x%"PRIx64
> +qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint=
64_t *iova) "s %p host %p size 0x%zx temporary %d iova %p"
>  qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
> --
> 2.26.2
>
>

