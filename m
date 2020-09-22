Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9F8C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518A82396D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBjmYjJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518A82396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKftG-0001YP-5d
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kKflN-0002QC-Re; Tue, 22 Sep 2020 06:43:09 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:41006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kKflI-0007tC-2D; Tue, 22 Sep 2020 06:43:09 -0400
Received: by mail-oo1-xc42.google.com with SMTP id t3so4008310ook.8;
 Tue, 22 Sep 2020 03:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Xt9RtER3UGIOsPyO5Env9GZG+EATgENlBkUh8gxsJoI=;
 b=OBjmYjJK2Ag0TPKkM86FqoHgJUv6w06pr0EQx56ohYFOwqqQ4YrbPN6MJ4Ju5kFEJh
 8WLDdjUKGeKfiLWLydgb+qstVZidutw6lhTHKzs4Sw26G1ebGhGGCcID5ElE9SVv3oYG
 aoJ8dfiMoikYdCcY4DqBL+g1UNXzEyXtTsFfcyBPjLdZbLazfz1vYVW/NK3NNOGKsX54
 /u16Ew35awsatNZ3GufRuAwHjJZRmZ1ilvTycEQzHL7nuWT/3CR+BT/oZjxDvhBiLBVO
 kvmOK+MRJenszzwrkqNDKa31yUYCCYKQ5nC6HDyz/6m8U2FTpYjH+hw/sxNkfeflX4ep
 EFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Xt9RtER3UGIOsPyO5Env9GZG+EATgENlBkUh8gxsJoI=;
 b=qP/JgvjnGasUHIfwN+58+pHXAkA3nWG0wt5CpQDwHzt6cQq8+DpIt7/sxcWxthGrQ4
 ar3xYCaEnGMf+1XFUkqwfT6HqSWkx+yg/mwWqm+VHUnVJSNLlgnn2eOXXyEczPVYcBgD
 gwmYGMrw6I3mzKTJdDMJjD+RXGEVl/l0lggby115FpPl6imi99wEfXh3G1ZiM/e+xO5m
 Q7ONLA9HDV2uoeYynQfrwrwxpmOvKGveUWrodwsFzY+UALKvGX50jTm2fiyASQEmeVzh
 VIgnBnvhnQ11oRyEU6RI5Nj5pBv9VLEKNM7xxHC5EpKJ0+6HDG1KY9Te7iMiutxpcbPh
 Ao6w==
X-Gm-Message-State: AOAM532Su+dZyRmkRCrdI1U5UGPvtoPB5YP9RpvaAnTRBXIKMM8fjfj8
 g4Yj2peg+X8bEPKfd08jSsr+69zUq1ylPxmiUQk=
X-Google-Smtp-Source: ABdhPJxokUuTlLKA2xMUYugeYjeELOaXhfv1wyJ88UAFMM3l8LJ8hkXlUzvYwWuJi8eeAyg5CkP79PsouD2IaXVRzvk=
X-Received: by 2002:a4a:5d84:: with SMTP id w126mr2509562ooa.1.1600771378833; 
 Tue, 22 Sep 2020 03:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200922092722.344518-1-ppandit@redhat.com>
In-Reply-To: <20200922092722.344518-1-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 22 Sep 2020 18:42:22 +0800
Message-ID: <CAKXe6SLOgvwBtTthhB0zLv_cxB==jrT8eZcGioKTk1u=Rpio5w@mail.gmail.com>
Subject: Re: [PATCH v2] fdc: check null block pointer before r/w data transfer
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc42.google.com
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

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8822=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:29=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While transferring data via fdctrl_read/write_data() routines,
> check that current drive does not have a null block pointer.
> Avoid null pointer dereference.
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

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/block/fdc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Update v2: treat NULL blk pointer as an error
>   -> https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg06642.ht=
ml
>
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 224bac504f..bf968dc66f 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -1923,7 +1923,8 @@ static uint32_t fdctrl_read_data(FDCtrl *fdctrl)
>                                     fd_sector(cur_drv));
>                      return 0;
>                  }
> -            if (blk_pread(cur_drv->blk, fd_offset(cur_drv), fdctrl->fifo=
,
> +            if (!cur_drv->blk
> +                || blk_pread(cur_drv->blk, fd_offset(cur_drv), fdctrl->f=
ifo,
>                            BDRV_SECTOR_SIZE)
>                  < 0) {
>                  FLOPPY_DPRINTF("error getting sector %d\n",
> @@ -2427,7 +2428,8 @@ static void fdctrl_write_data(FDCtrl *fdctrl, uint3=
2_t value)
>          if (pos =3D=3D FD_SECTOR_LEN - 1 ||
>              fdctrl->data_pos =3D=3D fdctrl->data_len) {
>              cur_drv =3D get_cur_drv(fdctrl);
> -            if (blk_pwrite(cur_drv->blk, fd_offset(cur_drv), fdctrl->fif=
o,
> +            if (!cur_drv->blk
> +                || blk_pwrite(cur_drv->blk, fd_offset(cur_drv), fdctrl->=
fifo,
>                             BDRV_SECTOR_SIZE, 0) < 0) {
>                  FLOPPY_DPRINTF("error writing sector %d\n",
>                                 fd_sector(cur_drv));
> --
> 2.26.2
>

