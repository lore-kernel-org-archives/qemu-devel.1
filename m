Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D3EC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155332082F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJbGtTtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155332082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiMHn-0002ej-DA
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 13:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46551)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hiLS6-0002Pr-BR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hiLS3-0008Fk-GR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:16:18 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:33835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hiLS0-00087t-8x; Tue, 02 Jul 2019 12:16:14 -0400
Received: by mail-lj1-x242.google.com with SMTP id p17so17533517ljg.1;
 Tue, 02 Jul 2019 09:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZU0Kd/Xv5iJ3yRbbDVHYD4jeks6wD0BoPdNMIKus+J4=;
 b=NJbGtTtChlO7GHAppX76MKo/9sMK5K3I46wK+atNH+dHz42OisOs+d8aifhy9L/9Gf
 7HpYfEsIgAFcIW8hth4mo7BjQZ219fPk/eTNFcj5wmydcLSzNPhCNaP3tnBUgYBIQek7
 ULZ/jAeWqTTWzcL8HlY0W99NI95soTo/REY+4mNlPcHh6QozNqu+etO1HWwYD8vivnPy
 fL3RTAlq2rnjD+azB9+1lf+gVltAcZR+4KdC8gCudyqFA1nwY2LjleyrD/grAUaOLtss
 +g4RbA+ENB3eT0JwnoEqxApFllcltNxMGtnfZ4y1YKmzk+2VAU3AoyNVG6TKCXnf/N/y
 gtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZU0Kd/Xv5iJ3yRbbDVHYD4jeks6wD0BoPdNMIKus+J4=;
 b=AnfHDXy2auNt8MaG3pO/P93+kLxHqUz1tIEnO4kTv9vLpvWGkyWAuy6YS4jjonk2Tj
 aUUyOFRBWjgBS1fSJVqZIL1yLeMcu9z8M1NShiLTDB/+U7Le9+PdfEzKiUvLVT8bZPa4
 +HazFSAK1FhQKxtX6n73nxqF87O+hOJlCIQRAWayxUZgCVfT8Knphro0qbnkiik6ISDV
 9sZTduO5dn6EOqNqG0N1YDHkkoHvrlrzW/y4Vz0+8RwN0MDqvkRnMLfuVCYCfz0COtn4
 R7QHPPCO8iCbRFipM2CpG7UBLzGTWXnHJPvu1DQEdNa42/Pvi1I6m085Ef/PLR9Ab6YJ
 N23Q==
X-Gm-Message-State: APjAAAWrK935rgHBgP+L8czFPTN0PPcV98wm9U5YSYh0uyGm2jy/Hn88
 xcj4NOw139fcDq5rh4szkHJ/3ghxih6DyUuArPM=
X-Google-Smtp-Source: APXvYqy0bLL480Vi/3s18ciD+c9iZAIrKERSXLQdtsAc5ThV3H7A/0ztRVqBwvZVerXDB/o1dco7qQGKaK5YU8sI4rA=
X-Received: by 2002:a2e:9188:: with SMTP id f8mr12415938ljg.33.1562084165709; 
 Tue, 02 Jul 2019 09:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190702001301.4768-1-philmd@redhat.com>
 <20190702001301.4768-8-philmd@redhat.com>
In-Reply-To: <20190702001301.4768-8-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 2 Jul 2019 09:13:02 -0700
Message-ID: <CAKmqyKM3=yF_1ngt9dHXyYPOMoKs5gsZtVLWT6ovf--bSMk_ig@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v2 7/9] hw/block/pflash_cfi01: Improve
 command comments
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 1, 2019 at 5:15 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi01.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index c1b02219b2..f50d0a9d37 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -208,11 +208,11 @@ static uint32_t pflash_devid_query(PFlashCFI01 *pfl=
, hwaddr offset)
>       * Offsets 2/3 are block lock status, is not emulated.
>       */
>      switch (boff & 0xFF) {
> -    case 0:
> +    case 0: /* Manufacturer ID */
>          resp =3D pfl->ident0;
>          trace_pflash_manufacturer_id(resp);
>          break;
> -    case 1:
> +    case 1: /* Device ID */
>          resp =3D pfl->ident1;
>          trace_pflash_device_id(resp);
>          break;
> @@ -456,11 +456,11 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
>      case 0:
>          /* read mode */
>          switch (cmd) {
> -        case 0x10: /* Single Byte Program */
> -        case 0x40: /* Single Byte Program */
> +        case 0x10: /* Single Byte Program (setup) */
> +        case 0x40: /* Single Byte Program (setup) [Intel] */
>              DPRINTF("%s: Single Byte Program\n", __func__);
>              break;
> -        case 0x20: /* Block erase */
> +        case 0x20: /* Block erase (setup) */
>              p =3D pfl->storage;
>              offset &=3D ~(pfl->sector_len - 1);
>
> @@ -516,8 +516,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>          break;
>      case 1:
>          switch (pfl->cmd) {
> -        case 0x10: /* Single Byte Program */
> -        case 0x40: /* Single Byte Program */
> +        case 0x10: /* Single Byte Program (confirm) */
> +        case 0x40: /* Single Byte Program (confirm) [Intel] */
>              DPRINTF("%s: Single Byte Program\n", __func__);
>              if (!pfl->ro) {
>                  pflash_data_write(pfl, offset, value, width, be);
> @@ -528,7 +528,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>              pfl->status |=3D 0x80; /* Ready! */
>              pfl->wcycle =3D 0;
>          break;
> -        case 0x20: /* Block erase */
> +        case 0x20: /* Block erase (confirm) */
>          case 0x28:
>              if (cmd =3D=3D 0xd0) { /* confirm */
>                  pfl->wcycle =3D 0;
> --
> 2.20.1
>

