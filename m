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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335C9C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76BCB21973
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhUBZd+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BCB21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJE1g-0003Xu-Ct
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 06:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kJE0f-0002ok-Ch; Fri, 18 Sep 2020 06:52:57 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kJE0d-0007p6-AN; Fri, 18 Sep 2020 06:52:57 -0400
Received: by mail-ot1-x344.google.com with SMTP id o6so4988524ota.2;
 Fri, 18 Sep 2020 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oocQ5mlAt6HnjaWdLqPOvslz8XKIQac7kdibgx2EP+w=;
 b=RhUBZd+f6FwQfe73c2PvweYO01M6U5rNvWwEfcIErVi5QLopbsqDz0wO2R7UbMCZwH
 7/Lkjch9GDLq3kHrJDsI4NsWXXFSNUQwMYZITRS9y8p0TfQk96c69oRAqhsOgUS4FP/B
 womZ5gPI1GbOCousp8OqAUHvjcPQc6DvLiS9kPV87Wpm7e85mz4n7G0PdDOiV2D98rrP
 Xuzki1FOoRQ6FsxX99xiMKjfNPum1XycU4tsDX9De3CvavPxYMfESw0ajwy3hkK316g/
 Tw9T6uD1R9kabQKQjkL+4gI8+6Lav07Ok0cKyamxGF6o2FS+t39tmC5JLQuNXRF0htNp
 h/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oocQ5mlAt6HnjaWdLqPOvslz8XKIQac7kdibgx2EP+w=;
 b=ABgdYEwRh4nLKvJGzXoVDrDc+Y/Bxwj86xFZifLEv3hnN47XWX33Su/DV9JKKxY3s7
 6rjhFJn+oohV8ZVtV6kdxh8ldgaVDbc83ts2dbMAEO3hcTbbv78530zVZmEMANKuatEo
 s4WPbUOO4s4RWI3gUBLN2Ti6R/8fSopmXvAHy9rAbQ7a3W6uGt5yYBNsAMj5dQjMZGvl
 9/ylIbzn9zheEJP4tyx9oaxW43ILrSFnjZrPdRUO1g3nMXxxMCCIxExSS9xn/ijR5UHn
 l+hzkV0qd5btv/FS2bFaxlbTNuqVX0hKFpp4eXSODAZHugYRtnijukSFynNin9+Cvmuf
 znHA==
X-Gm-Message-State: AOAM533leOqWhTQKX5J2icYSeisnah0ipC1a3jHFaUPgI0M3Sl/L8kNR
 vjd5CzxIR2d123McswZcMVxpNgOwoU5wXXboeus=
X-Google-Smtp-Source: ABdhPJw3eKrth2ebMddwmuAVqo5WeGSyWs/wDImnr7sPSkCR9wZmIRUwEufznJLpBkPjx0Y7rsgtIcV3ayykJSP8Wfs=
X-Received: by 2002:a05:6830:2302:: with SMTP id
 u2mr21376323ote.181.1600426373807; 
 Fri, 18 Sep 2020 03:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200827113806.1850687-1-ppandit@redhat.com>
In-Reply-To: <20200827113806.1850687-1-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 18 Sep 2020 18:52:18 +0800
Message-ID: <CAKXe6SK2MQS-ntCpo2-TkAh57PcuGRaCBRMur91sxiB1Z-k62g@mail.gmail.com>
Subject: Re: [PATCH] fdc: check null block pointer before blk_pwrite
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x344.google.com
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
Cc: Ruhr-University <bugs-syssec@rub.de>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8827=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:41=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While transferring data via fdctrl_write_data(), check that
> current drive does not have a null block pointer. Avoid
> null pointer dereference.
>
>  -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=3D%2Ffdc_nul=
lptr1
>     =3D=3D1658854=3D=3DHint: address points to the zero page.
>     #0 blk_inc_in_flight block/block-backend.c:1327
>     #1 blk_prw block/block-backend.c:1299
>     #2 blk_pwrite block/block-backend.c:1464
>     #3 fdctrl_write_data hw/block/fdc.c:2418
>     #4 fdctrl_write hw/block/fdc.c:962
>     #5 portio_write ioport.c:205
>     #6 memory_region_write_accessor memory.c:483
>     #7 access_with_adjusted_size memory.c:544
>     #8 memory_region_dispatch_write memory.c:1476
>
> Reported-by: Ruhr-University <bugs-syssec@rub.de>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/block/fdc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index e9ed3eef45..dedadac68a 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -2419,7 +2419,8 @@ static void fdctrl_write_data(FDCtrl *fdctrl, uint3=
2_t value)
>          if (pos =3D=3D FD_SECTOR_LEN - 1 ||
>              fdctrl->data_pos =3D=3D fdctrl->data_len) {
>              cur_drv =3D get_cur_drv(fdctrl);
> -            if (blk_pwrite(cur_drv->blk, fd_offset(cur_drv), fdctrl->fif=
o,
> +            if (cur_drv->blk
> +                && blk_pwrite(cur_drv->blk, fd_offset(cur_drv), fdctrl->=
fifo,
>                             BDRV_SECTOR_SIZE, 0) < 0) {
>                  FLOPPY_DPRINTF("error writing sector %d\n",
>                                 fd_sector(cur_drv));
> --

Hello Prasad,

There are several pattern to address this NULL check in fdc.c.
I think it is better to consider this as an error. Just like the check
in 'fdctrl_format_sector':

if (cur_drv->blk =3D=3D NULL ||
    blk_pwrite(cur_drv->blk, fd_offset(cur_drv), fdctrl->fifo,
    BDRV_SECTOR_SIZE, 0) < 0) {
    FLOPPY_DPRINTF("error formatting sector %d\n", fd_sector(cur_drv));
    fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM | FD_SR0_SEEK, 0x00, 0x00);
} else {

Also there seems exists the same issue in  'fdctrl_read_data'

Thanks,
Li Qiang

> 2.26.2
>
>

