Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3105C43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 04:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2751B2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 04:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaWtFzbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2751B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ83L-0005kH-2b
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 00:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kJ82k-0005JE-1z; Fri, 18 Sep 2020 00:30:43 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kJ82h-000617-U5; Fri, 18 Sep 2020 00:30:41 -0400
Received: by mail-ot1-x343.google.com with SMTP id c10so4184984otm.13;
 Thu, 17 Sep 2020 21:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nrZeTwS6kx4cP2NO9b702JeAN19goFAEUjmpcoOvcKk=;
 b=oaWtFzbxq3HleN7VQip9GALosdz9vSxULRcGQ0ojQYRTQ2wVSoDbZ30W5dIgdcNGaL
 wUgA3QuEHVEN8S2P7hTnksyJGYhKHuAX9L/HoKJBRyLwByR56WqnIGY3TiLj4MNkhuai
 OxBilr5t8+wBAt2KnlE3HJ8uH3kW4L+QqUcghXg1wOafDlhOhADvxzWlL/atGv8UtYFE
 OJ8Wy2ukfsgDFtU+qTkSgTtXE8tgy93shPtiRh26CAI4B/xHZHRA3yksTHzESDTtLTfc
 hkx/vJtVvARiEtMOVo9XeUNGfaajI8aiXVLIIqS4V2ypbaCq2WLx4syZDceR+bt5Twyc
 /X5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nrZeTwS6kx4cP2NO9b702JeAN19goFAEUjmpcoOvcKk=;
 b=rpBbhLuy2AWfSRhpcr1a7+PldIRhH430zQv2w3yvOHX5UvXax4VjVNNpP4EJ17KIUU
 T8e3AfptyiD9yaCskr/TgqY4hmk3DHH4voN8+VUTMp57rQYmauffJQuJncj7bt9n57oA
 2ztFNY0aTv3+lmn12PDk+E2H0OMBZR1J49+mwwTn0GqVtpDSj4Nyhic0bEMls55DeGhq
 kn7VJTYDCGWNf0lHhwFkoWFsraM7HmFh7hXd6CKJzJr6ke398pikQCuW6JsCLxTYV7uz
 usUteqcz12WP5G3MqEkOOOff99er4EziG8ESLUyyS6wwUgLJcIkVYWeV5vmVRSvNsrmd
 7/Sw==
X-Gm-Message-State: AOAM533VvA1aZI8vwOOxNFOjC5WFmDwRpBAEEthx6oA4IP5WXTgMt8Y1
 tDYxt/aKL0oA8cgVzLdEiMIOe9AXdOyK1J/1ZSo=
X-Google-Smtp-Source: ABdhPJzDHxQGDTI7g0UKcz6a13BZSa2gNpx/1RZxtE52bK5Z385aOEbeYr2yt8Py61Uu0oR1YTiUUgmIFug0Cm/uzJQ=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr21076616oti.333.1600403438139; 
 Thu, 17 Sep 2020 21:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200903183138.2161977-1-ppandit@redhat.com>
In-Reply-To: <20200903183138.2161977-1-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 18 Sep 2020 12:30:02 +0800
Message-ID: <CAKXe6SLv1HX5_ty2SP5F_MkVKYO-tz5fNOKhpqZr0mH_ePypSA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/ide: check null block before _cancel_dma_sync
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Ruhr-University <bugs-syssec@rub.de>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=884=E6=97=A5=E5=91=
=A8=E4=BA=94 =E4=B8=8A=E5=8D=882:34=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> When cancelling an i/o operation via ide_cancel_dma_sync(),
> a block pointer may be null. Add check to avoid null pointer
> dereference.
>
>  -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=3D%2Fide_nul=
lptr1
>  =3D=3D1803100=3D=3DHint: address points to the zero page.
>  #0 blk_bs ../block/block-backend.c:714
>  #1 blk_drain ../block/block-backend.c:1715
>  #2 ide_cancel_dma_sync ../hw/ide/core.c:723
>  #3 bmdma_cmd_writeb ../hw/ide/pci.c:298
>  #4 bmdma_write ../hw/ide/piix.c:75
>  #5 memory_region_write_accessor ../softmmu/memory.c:483
>  #6 access_with_adjusted_size ../softmmu/memory.c:544
>  #7 memory_region_dispatch_write ../softmmu/memory.c:1465
>  #8 flatview_write_continue ../exec.c:3176
>  ...
>
> Reported-by: Ruhr-University <bugs-syssec@rub.de>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/ide/core.c | 1 +
>  hw/ide/pci.c  | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> Update v2: use an assert() call
>  -> https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg08336.htm=
l
>
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index f76f7e5234..8105187f49 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -718,6 +718,7 @@ void ide_cancel_dma_sync(IDEState *s)
>       * whole DMA operation will be submitted to disk with a single
>       * aio operation with preadv/pwritev.
>       */
> +    assert(s->blk);
>      if (s->bus->dma->aiocb) {
>          trace_ide_cancel_dma_sync_remaining();
>          blk_drain(s->blk);
> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
> index b50091b615..b47e675456 100644
> --- a/hw/ide/pci.c
> +++ b/hw/ide/pci.c
> @@ -295,7 +295,10 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
>      /* Ignore writes to SSBM if it keeps the old value */
>      if ((val & BM_CMD_START) !=3D (bm->cmd & BM_CMD_START)) {
>          if (!(val & BM_CMD_START)) {
> -            ide_cancel_dma_sync(idebus_active_if(bm->bus));
> +            IDEState *s =3D idebus_active_if(bm->bus);
> +            if (s->blk) {
> +                ide_cancel_dma_sync(s);
> +            }
>              bm->status &=3D ~BM_STATUS_DMAING;
>          } else {
>              bm->cur_addr =3D bm->addr;
> --

Hello Prasad,
'bmdma_cmd_writeb' is in the bmdma layer, I think it is better to not
touch the IDE layer(check the 's->blk').

I think it is better to defer this check to 'ide_cancel_dma_sync'.
'ide_cancel_dma_sync' is also called by 'cmd_device_reset' and all of
the handlers of 'ide_cmd_table' will check
whether the 's->blk' is NULL in the beginning of 'ide_exec_cmd'.

So I think it is reasonable to check 's->blk' at the begining of
'ide_cancel_dma_sync'.

I'm not a blk expert, please correct me if I'm wrong.

Thanks,
Li Qiang

> 2.26.2
>
>

