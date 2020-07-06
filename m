Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C08206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTbd0Jx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C08206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUhi-0004TA-8T
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUDa-0006Md-W6; Mon, 06 Jul 2020 12:43:47 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:38499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUDV-0003Lg-6v; Mon, 06 Jul 2020 12:43:46 -0400
Received: by mail-il1-x142.google.com with SMTP id s21so18312710ilk.5;
 Mon, 06 Jul 2020 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1A5by5Dcf2Xm/q/no0sQcQ3omwc15fY2C9Fn84uKp9E=;
 b=dTbd0Jx+i+9HT9+VvDmbm9bmtV3m7c5T8zKQwelONnx1wUEtsaZTEU3Wa06HIJHyXm
 jQivEXgQEFhH+4VnvL9Fr73nYrudQzPEDXDVBfRYbkgwyVAVyojeqgoDIcdscnRAIP8x
 mmnZyGl1gtG+79/DcIfSjQmWXVFHLKPIo/YKqvfJ6XXVLpLUbJErqHf/LFwXV+nFArP6
 xc26kTqGQ0hFGdk55TDBB5cMTesMmA/QUg9zJjKShvkqi8zimFGwh/asy+DjF7RcqmlH
 FG6bRrFsD1+P8OzhNk528v9wya0nvgblLBS/ZhkDHFaYlRExIsKvYB0Bavk6Ksjnr7b8
 at0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1A5by5Dcf2Xm/q/no0sQcQ3omwc15fY2C9Fn84uKp9E=;
 b=DjLziQKg4oxdY4vQ6GMFgJVqjITb88nMqWt7P3re3XGcGSe4deT5OwLwx6Tbq9IEPw
 /VVAz3U17yFqNYdQT9bOCxr3Tv8q2WezKIeUAC6S7DIRQ6Tvxs6AX2Rta4dxhbKLnI0m
 8WgEc55+q8oHm1f+wGE0aq+a7NAgnI96znJU3KdQEPpNo+4YoEgiPZqOVgB8xv6/b2UR
 rgc0vUrPWnkaeJYnMIMAr6prgsbHTOg/CaX3TwbkINofY7q/47PVjfiwE/1KE4LdrWW+
 lD1FrYh4zCJIk5A3SkXLkRb8B406UPfSziN/ZIch4FF9n2xG1x20R2ZCjUNoRe98nZ6f
 K2fQ==
X-Gm-Message-State: AOAM533M/tWWD2/3djZz75rQVId4813Kvedr2ujjAEUg+8+ew3fl1xNu
 6yfgSkmHE6cMiUeiNY05ufHGE4XY2Cam2G4Sj3fB9Nlt
X-Google-Smtp-Source: ABdhPJw8xoSBRsrB5K1H2/IXuAUo+Geue32tfbFj3EYhqWRdgtgBIWiIeHZsgixLW5V/WnWYbxeBh9FXp5UIUY8My58=
X-Received: by 2002:a05:6e02:d51:: with SMTP id
 h17mr31675654ilj.131.1594053819685; 
 Mon, 06 Jul 2020 09:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-17-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-17-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:33:53 -0700
Message-ID: <CAKmqyKOjrXB_87eQgmuD1pvDNgKMvbQDU7LZD57+O1F19QG0bA@mail.gmail.com>
Subject: Re: [PATCH v7 16/17] hw/sd/sdcard: Display offset in
 read/write_data() trace events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
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

On Tue, Jun 30, 2020 at 6:44 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Having 'base address' and 'relative offset' displayed
> separately is more helpful than the absolute address.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/sd/sd.c         | 8 ++++----
>  hw/sd/trace-events | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index eb549a52e1..304fa4143a 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1855,8 +1855,8 @@ void sd_write_data(SDState *sd, uint8_t value)
>          return;
>
>      trace_sdcard_write_data(sd->proto_name,
> -                            sd_current_cmd_name(sd),
> -                            sd->current_cmd, value);
> +                            sd_current_cmd_name(sd), sd->current_cmd,
> +                            sd->data_start, sd->data_offset, value);
>      switch (sd->current_cmd) {
>      case 24:   /* CMD24:  WRITE_SINGLE_BLOCK */
>          sd->data[sd->data_offset ++] =3D value;
> @@ -2009,8 +2009,8 @@ uint8_t sd_read_data(SDState *sd)
>      io_len =3D (sd->ocr & (1 << 30)) ? HWBLOCK_SIZE : sd->blk_len;
>
>      trace_sdcard_read_data(sd->proto_name,
> -                           sd_current_cmd_name(sd),
> -                           sd->current_cmd, io_len);
> +                           sd_current_cmd_name(sd), sd->current_cmd,
> +                           sd->data_start, sd->data_offset, io_len);
>      switch (sd->current_cmd) {
>      case 6:    /* CMD6:   SWITCH_FUNCTION */
>          ret =3D sd->data[sd->data_offset ++];
> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> index d0cd7c6ec4..946923223b 100644
> --- a/hw/sd/trace-events
> +++ b/hw/sd/trace-events
> @@ -51,8 +51,8 @@ sdcard_lock(void) ""
>  sdcard_unlock(void) ""
>  sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size =
0x%x"
>  sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size=
 0x%x"
> -sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, =
uint8_t value) "%s %20s/ CMD%02d value 0x%02x"
> -sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, u=
int32_t length) "%s %20s/ CMD%02d len %" PRIu32
> +sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, =
uint64_t address, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d addr 0x=
%" PRIx64 " ofs 0x%" PRIx32 " val 0x%02x"
> +sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, u=
int64_t address, uint32_t offset, uint32_t length) "%s %20s/ CMD%02d addr 0=
x%" PRIx64 " ofs 0x%" PRIx32 " len %" PRIu32
>  sdcard_set_voltage(uint16_t millivolts) "%u mV"
>
>  # milkymist-memcard.c
> --
> 2.21.3
>
>

