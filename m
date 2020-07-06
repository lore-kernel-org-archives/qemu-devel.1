Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D882C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B7B206DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skxynAhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B7B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsU7B-0004if-DQ
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsU6V-0003o8-Lh; Mon, 06 Jul 2020 12:36:27 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:39150)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsU6T-00024x-LX; Mon, 06 Jul 2020 12:36:27 -0400
Received: by mail-io1-xd43.google.com with SMTP id f23so40047396iof.6;
 Mon, 06 Jul 2020 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yyuj29I1KssESzbm0ObS4zW8l8xx+VlZ9cn9lqaJVb0=;
 b=skxynAhdQaaSfgvGHlb6Byr95jv8pSZZxvKdiScKqsr/x5ySgA+ZUZx58YZ3eYUf4b
 UKpln/6VhhuTO1jEPumRLkm6skZbpQcJtvGqTX5rkRda/6iRrKk48cZMbPKVYJK2grlP
 qKHjiBpaK8FqvxaV/rzalU4NUbK6vBYja3mRB4bkxDKz7fYmJpQuzZ1IDP+0le+w356w
 oqqpHAeOruSknshIQRCKjsxTuAMzJo1L3200mrSunti09uSUgFuc92ytV3FSXokxwTnt
 4Gi3T6zTDY6bVjvbSgHy4OBiYVoEmnSmgv86+U+8QkPeUL+f+rAerrlAJ8gK5OyLvx9w
 E0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yyuj29I1KssESzbm0ObS4zW8l8xx+VlZ9cn9lqaJVb0=;
 b=HbCSQbp1xfZWoqAPaO2gGclPFSHf4lLdXiIGAeF/KARfsa9VkJVYPZRCoKbPF2goJN
 9U7yI8XzYtpVe0LpC3h8A6jkhlz4MQ2vY4VGiweTWTzVZTrC+EkiscYcN+SLjZenp7iX
 gYHMPdg5RxJAZqP3N4u3E8X593PXFrcHvRH3nyYC0+CnySvOPanEf3CvZy5ovk/Kxth2
 9Y47AzR40zFFSfFkcznSVyfvG6GzB/i5ikjHfuHJGHDJ0PdF1n9BLAeYogwZDg/s0HA9
 kV4PSomKd5sdGhqW5uNlOIUevMcHcOXvvgPiBnZDJwfgA31Hbw0mjEYvnlNES00mXlL5
 7SKw==
X-Gm-Message-State: AOAM531RfLsevtbdGduoG1O6NIYfY3lKY7vdJQiqe8EeGEdz8yl1Sv60
 o1E1Ljyy6wgn9eym2Dxghr5QeraEs/ccvW5+qrU=
X-Google-Smtp-Source: ABdhPJy0fywygdzTcF8C8ewblkSwbfVR57x6YFaSI8QsOG5dlr5LLGjroQ2qrYB0N1AhGWOIZ+iT11TCDXCMMPhxMWA=
X-Received: by 2002:a5d:97d9:: with SMTP id k25mr26377713ios.42.1594053384330; 
 Mon, 06 Jul 2020 09:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-6-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-6-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:26:35 -0700
Message-ID: <CAKmqyKPbTfCWcPiBbDeSfnmdYJq6DpdNrnrzvtxfAPLTdYKZDw@mail.gmail.com>
Subject: Re: [PATCH v7 05/17] hw/sd/sdcard: Do not switch to ReceivingData if
 address is invalid
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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
 Prasad J Pandit <pjp@fedoraproject.org>, Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 6:42 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Only move the state machine to ReceivingData if there is no
> pending error. This avoids later OOB access while processing
> commands queued.
>
>   "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"
>
>   4.3.3 Data Read
>
>   Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>   occurred and no data transfer is performed.
>
>   4.3.4 Data Write
>
>   Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>   occurred and no data transfer is performed.
>
> WP_VIOLATION errors are not modified: the error bit is set, we
> stay in receive-data state, wait for a stop command. All further
> data transfer is ignored. See the check on sd->card_status at the
> beginning of sd_read_data() and sd_write_data().
>
> Fixes: CVE-2020-13253
> Cc: Prasad J Pandit <pjp@fedoraproject.org>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1880822
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v4: Only modify ADDRESS_ERROR, not WP_VIOLATION (pm215)
> ---
>  hw/sd/sd.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 04451fdad2..7e0d684aca 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1167,13 +1167,15 @@ static sd_rsp_type_t sd_normal_command(SDState *s=
d, SDRequest req)
>      case 17:   /* CMD17:  READ_SINGLE_BLOCK */
>          switch (sd->state) {
>          case sd_transfer_state:
> -            sd->state =3D sd_sendingdata_state;
> -            sd->data_start =3D addr;
> -            sd->data_offset =3D 0;
>
>              if (sd->data_start + sd->blk_len > sd->size) {
>                  sd->card_status |=3D ADDRESS_ERROR;
> +                return sd_r1;
>              }
> +
> +            sd->state =3D sd_sendingdata_state;
> +            sd->data_start =3D addr;
> +            sd->data_offset =3D 0;
>              return sd_r1;
>
>          default:
> @@ -1184,13 +1186,15 @@ static sd_rsp_type_t sd_normal_command(SDState *s=
d, SDRequest req)
>      case 18:   /* CMD18:  READ_MULTIPLE_BLOCK */
>          switch (sd->state) {
>          case sd_transfer_state:
> -            sd->state =3D sd_sendingdata_state;
> -            sd->data_start =3D addr;
> -            sd->data_offset =3D 0;
>
>              if (sd->data_start + sd->blk_len > sd->size) {
>                  sd->card_status |=3D ADDRESS_ERROR;
> +                return sd_r1;
>              }
> +
> +            sd->state =3D sd_sendingdata_state;
> +            sd->data_start =3D addr;
> +            sd->data_offset =3D 0;
>              return sd_r1;
>
>          default:
> @@ -1230,14 +1234,17 @@ static sd_rsp_type_t sd_normal_command(SDState *s=
d, SDRequest req)
>              /* Writing in SPI mode not implemented.  */
>              if (sd->spi)
>                  break;
> +
> +            if (sd->data_start + sd->blk_len > sd->size) {
> +                sd->card_status |=3D ADDRESS_ERROR;
> +                return sd_r1;
> +            }
> +
>              sd->state =3D sd_receivingdata_state;
>              sd->data_start =3D addr;
>              sd->data_offset =3D 0;
>              sd->blk_written =3D 0;
>
> -            if (sd->data_start + sd->blk_len > sd->size) {
> -                sd->card_status |=3D ADDRESS_ERROR;
> -            }
>              if (sd_wp_addr(sd, sd->data_start)) {
>                  sd->card_status |=3D WP_VIOLATION;
>              }
> @@ -1257,14 +1264,17 @@ static sd_rsp_type_t sd_normal_command(SDState *s=
d, SDRequest req)
>              /* Writing in SPI mode not implemented.  */
>              if (sd->spi)
>                  break;
> +
> +            if (sd->data_start + sd->blk_len > sd->size) {
> +                sd->card_status |=3D ADDRESS_ERROR;
> +                return sd_r1;
> +            }
> +
>              sd->state =3D sd_receivingdata_state;
>              sd->data_start =3D addr;
>              sd->data_offset =3D 0;
>              sd->blk_written =3D 0;
>
> -            if (sd->data_start + sd->blk_len > sd->size) {
> -                sd->card_status |=3D ADDRESS_ERROR;
> -            }
>              if (sd_wp_addr(sd, sd->data_start)) {
>                  sd->card_status |=3D WP_VIOLATION;
>              }
> --
> 2.21.3
>
>

