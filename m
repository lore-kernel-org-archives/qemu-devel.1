Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACF3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75CEE206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuZ2bECv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CEE206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsU5T-0002If-QJ
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsU4q-0001U5-UO; Mon, 06 Jul 2020 12:34:44 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:44554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsU4p-0001dQ-AV; Mon, 06 Jul 2020 12:34:44 -0400
Received: by mail-il1-x143.google.com with SMTP id h16so10109363ilj.11;
 Mon, 06 Jul 2020 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9F4XfPVeQyIXBGJHPYC+xSPNy3jKuipkM2klDZi9MoE=;
 b=iuZ2bECvPfHW2qUpL5HnKUtKslVR1pEL2RVbubtIzumrK+hQ6hN2k+wf8baGFBYaWM
 GJ+iVCooJhG8AyQuSxWNHZnqKO12PRFhcXco0LlrCHTvXsd75cN4pC2asx9hDVw+Jxe+
 4lIN7izyFkFkIeLWjQH3H6Y7QSxhdLQ6FOH4dPn88YYO1NgQxsRcDVyFNFfi9lt/B2Ks
 sQO0vgPojMtqurkiHtTGevshCInUElTrVHj+HKUOX1ilPVTP46olxl7k9rdDQoSBD0s9
 y+dx+uxTPzgvX7U9pBi8pAgCp8WDIdyx5Y+eskU0fx+kgKfGmxDLxf3C7MQGc0eqaC5p
 7KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9F4XfPVeQyIXBGJHPYC+xSPNy3jKuipkM2klDZi9MoE=;
 b=M+T7HJEik5Iy0a/wYWFe+qHvUGiRV4jOKXfVhYWUm3jbplGvcLHzgAJ0fvHd7OJapG
 ACzs8QPZVCD4Vn1WJsTLFg97EMUqEjUmyo5RDzzbyJ6G3E5z+bj2QORD/2gEtn7/Svfk
 5RwcPobpDgdX1j/d/r5XGvKGvRKYSGRCOcbmUzoyf3vCSoMMF03hd5ZhYUTC6x3/615U
 f+IWIzHwCEwVqS4XGrNPWk6Rvb9RuiASdrWHlOU6o+rHiGxocjJ5NCsf4xeOwtO5C6TG
 6zscDg7DRwqvTIwcA9eWwXn87zyF6pD47eXL9yRqIkFkcOoQewM7JgYsOpANTEe4zomK
 N5wQ==
X-Gm-Message-State: AOAM5338HH+oaxPvFtEu4dkx/luMYM9bTcwn++cEVRNpR6zvLS4tJElq
 KO47M2YWKAr8x1dkM3x8HTtXt8c+JwNwRn46XeQ=
X-Google-Smtp-Source: ABdhPJxq9PBzpERlcAnPbmosIZmQNDi0fMUHtaGYD3388iCOVLvvHtyuATBgVsbXa/JRvApFr34DRMhpG643X983F2w=
X-Received: by 2002:a92:5f12:: with SMTP id t18mr31581266ilb.267.1594053262004; 
 Mon, 06 Jul 2020 09:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-3-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-3-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:24:33 -0700
Message-ID: <CAKmqyKNYpOoG7ReqAzBCkcXS-q1UAzbnXTZCatWKWwrCWeN-Mw@mail.gmail.com>
Subject: Re: [PATCH v7 02/17] hw/sd/sdcard: Update coding style to make
 checkpatch.pl happy
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 6:40 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> To make the next commit easier to review, clean this code first.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/sd/sd.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 97a9d32964..cac8d7d828 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1170,8 +1170,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,=
 SDRequest req)
>              sd->data_start =3D addr;
>              sd->data_offset =3D 0;
>
> -            if (sd->data_start + sd->blk_len > sd->size)
> +            if (sd->data_start + sd->blk_len > sd->size) {
>                  sd->card_status |=3D ADDRESS_ERROR;
> +            }
>              return sd_r1;
>
>          default:
> @@ -1186,8 +1187,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,=
 SDRequest req)
>              sd->data_start =3D addr;
>              sd->data_offset =3D 0;
>
> -            if (sd->data_start + sd->blk_len > sd->size)
> +            if (sd->data_start + sd->blk_len > sd->size) {
>                  sd->card_status |=3D ADDRESS_ERROR;
> +            }
>              return sd_r1;
>
>          default:
> @@ -1232,12 +1234,15 @@ static sd_rsp_type_t sd_normal_command(SDState *s=
d, SDRequest req)
>              sd->data_offset =3D 0;
>              sd->blk_written =3D 0;
>
> -            if (sd->data_start + sd->blk_len > sd->size)
> +            if (sd->data_start + sd->blk_len > sd->size) {
>                  sd->card_status |=3D ADDRESS_ERROR;
> -            if (sd_wp_addr(sd, sd->data_start))
> +            }
> +            if (sd_wp_addr(sd, sd->data_start)) {
>                  sd->card_status |=3D WP_VIOLATION;
> -            if (sd->csd[14] & 0x30)
> +            }
> +            if (sd->csd[14] & 0x30) {
>                  sd->card_status |=3D WP_VIOLATION;
> +            }
>              return sd_r1;
>
>          default:
> @@ -1256,12 +1261,15 @@ static sd_rsp_type_t sd_normal_command(SDState *s=
d, SDRequest req)
>              sd->data_offset =3D 0;
>              sd->blk_written =3D 0;
>
> -            if (sd->data_start + sd->blk_len > sd->size)
> +            if (sd->data_start + sd->blk_len > sd->size) {
>                  sd->card_status |=3D ADDRESS_ERROR;
> -            if (sd_wp_addr(sd, sd->data_start))
> +            }
> +            if (sd_wp_addr(sd, sd->data_start)) {
>                  sd->card_status |=3D WP_VIOLATION;
> -            if (sd->csd[14] & 0x30)
> +            }
> +            if (sd->csd[14] & 0x30) {
>                  sd->card_status |=3D WP_VIOLATION;
> +            }
>              return sd_r1;
>
>          default:
> --
> 2.21.3
>
>

