Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DA1C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FEA623AA0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcUN0Sg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEA623AA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yq1-0008Qv-KW
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k6yom-0007LG-2y; Sat, 15 Aug 2020 12:14:04 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k6yok-00035A-E5; Sat, 15 Aug 2020 12:14:03 -0400
Received: by mail-oi1-x243.google.com with SMTP id a24so10951019oia.6;
 Sat, 15 Aug 2020 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Rz1Bn0O+S+J/XTgmJoZptTZ3JFxX1OXOQheVdd25VFs=;
 b=pcUN0Sg6NBjaTaKCgFvA9WG5Z8FEGQX1O6t8VvlA/NL3tkse9IQ58KU8QtU2VkeRSP
 n5yzzoct7THb6hi95SJPdA0WTehr/my7TQRaa29Xg19rIcnWSKR8qDr0YGKBMSju5xgC
 QjIBACZJhzsgQGD7/j+8Mj1QGVORQUR83PW3BFbwcfgRy3FW6raDAvFm2/rsDnesq/Gd
 LoTVGAhk4b7p4nfkBp0TkMCPTGZaen1NNKaKCkOVX1QPIIJNlGFr8+FQ38vP40fa+0bj
 T5KKWwPyfilwoy6CvatB4AZ3y9hxP7iJq+YgLb3tWsvIXKIzc588JTGgka3e7yvuKSC5
 a6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Rz1Bn0O+S+J/XTgmJoZptTZ3JFxX1OXOQheVdd25VFs=;
 b=Ma/M8FoUN+EScc0xwnhk3Px7Ee/zrlH12uZSkre3kUghtfHVqLE+mn0lkDfQ29T1Y+
 RefCfiM8p4vjg/In/tNMi1Os+xANbRU3rm9qwmwhBEwQV2RbdusPY3Io2GRqxo+2VO+7
 koudrJk5/J5E+PJ20SQJg0oyjAeG8/8d2ElrRZNgwsNS1i9kO1bOiC3IGM3eJiwOiiE+
 UAvSLLCMSZjuw6hAp/yOq/GkBrPCJ5dbmbCGwRFFYVbxfICkSQgF41fee0JQ553jLq3Z
 V0cf5sja3Nw8E2cndo4NMd96wbmzlF2gORNbdaH2VnNMF3T6gwQtJWBJNGQRBnxo19VG
 8VhA==
X-Gm-Message-State: AOAM530Odpm/cYYJsnHFFzfrPFz9lyIVKyPX6R4a8EV1F7ScR4zIgvKK
 VQswLL5X94attQCeej6OzTCC8pOYMlMDQDt/QHyo6OrGajA=
X-Google-Smtp-Source: ABdhPJwmL9ilK3QZaYsWyYrWqFp5AGOB3zk4LrA+Cp4YB6D9betCEHIByOJ5fafzbCLSNdoYoVsJDClKk05FnrYXCIQ=
X-Received: by 2002:aca:fd46:: with SMTP id b67mr3333039oii.150.1597461623940; 
 Fri, 14 Aug 2020 20:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200814082841.27000-1-f4bug@amsat.org>
 <20200814082841.27000-4-f4bug@amsat.org>
In-Reply-To: <20200814082841.27000-4-f4bug@amsat.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 15 Aug 2020 11:19:48 +0800
Message-ID: <CAKXe6SJ-OvymYFD5d3R_Nq-tP5PQ0ScnU66UgVVfypgyNZx1uw@mail.gmail.com>
Subject: Re: [PATCH 3/7] hw/ide/core: Replace magic '512' value by
 BDRV_SECTOR_SIZE
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Qemu Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =E4=BA=8E2020=E5=B9=B48=E6=9C=
=8814=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:31=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Use self-explicit definitions instead of magic '512' value.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/ide/core.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index f76f7e5234..bcb2aa85fc 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -121,7 +121,7 @@ static void ide_identify(IDEState *s)
>      put_le16(p + 0, 0x0040);
>      put_le16(p + 1, s->cylinders);
>      put_le16(p + 3, s->heads);
> -    put_le16(p + 4, 512 * s->sectors); /* XXX: retired, remove ? */
> +    put_le16(p + 4, BDRV_SECTOR_SIZE * s->sectors); /* XXX: retired, rem=
ove ? */
>      put_le16(p + 5, 512); /* XXX: retired, remove ? */
>      put_le16(p + 6, s->sectors);
>      padstr((char *)(p + 10), s->drive_serial_str, 20); /* serial number =
*/
> @@ -864,7 +864,7 @@ static void ide_dma_cb(void *opaque, int ret)
>          }
>      }
>
> -    if (s->io_buffer_size > s->nsector * 512) {
> +    if (s->io_buffer_size > s->nsector * BDRV_SECTOR_SIZE) {
>          /*
>           * The PRDs were longer than needed for this request.
>           * The Active bit must remain set after the request completes.
> @@ -877,7 +877,7 @@ static void ide_dma_cb(void *opaque, int ret)
>
>      sector_num =3D ide_get_sector(s);
>      if (n > 0) {
> -        assert(n * 512 =3D=3D s->sg.size);
> +        assert(n * BDRV_SECTOR_SIZE =3D=3D s->sg.size);
>          dma_buf_commit(s, s->sg.size);
>          sector_num +=3D n;
>          ide_set_sector(s, sector_num);
> @@ -894,17 +894,17 @@ static void ide_dma_cb(void *opaque, int ret)
>      /* launch next transfer */
>      n =3D s->nsector;
>      s->io_buffer_index =3D 0;
> -    s->io_buffer_size =3D n * 512;
> +    s->io_buffer_size =3D n * BDRV_SECTOR_SIZE;
>      prep_size =3D s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffe=
r_size);
>      /* prepare_buf() must succeed and respect the limit */
> -    assert(prep_size >=3D 0 && prep_size <=3D n * 512);
> +    assert(prep_size >=3D 0 && prep_size <=3D n * BDRV_SECTOR_SIZE);
>
>      /*
>       * Now prep_size stores the number of bytes in the sglist, and
>       * s->io_buffer_size stores the number of bytes described by the PRD=
s.
>       */
>
> -    if (prep_size < n * 512) {
> +    if (prep_size < n * BDRV_SECTOR_SIZE) {
>          /*
>           * The PRDs are too short for this request. Error condition!
>           * Reset the Active bit and don't raise the interrupt.
> @@ -1412,7 +1412,8 @@ static bool cmd_identify(IDEState *s, uint8_t cmd)
>              ide_cfata_identify(s);
>          }
>          s->status =3D READY_STAT | SEEK_STAT;
> -        ide_transfer_start(s, s->io_buffer, 512, ide_transfer_stop);
> +        ide_transfer_start(s, s->io_buffer, BDRV_SECTOR_SIZE,
> +                           ide_transfer_stop);
>          ide_set_irq(s->bus);
>          return false;
>      } else {
> @@ -1482,7 +1483,7 @@ static bool cmd_write_multiple(IDEState *s, uint8_t=
 cmd)
>      n =3D MIN(s->nsector, s->req_nb_sectors);
>
>      s->status =3D SEEK_STAT | READY_STAT;
> -    ide_transfer_start(s, s->io_buffer, 512 * n, ide_sector_write);
> +    ide_transfer_start(s, s->io_buffer, BDRV_SECTOR_SIZE * n, ide_sector=
_write);
>
>      s->media_changed =3D 1;
>
> @@ -1524,7 +1525,7 @@ static bool cmd_write_pio(IDEState *s, uint8_t cmd)
>
>      s->req_nb_sectors =3D 1;
>      s->status =3D SEEK_STAT | READY_STAT;
> -    ide_transfer_start(s, s->io_buffer, 512, ide_sector_write);
> +    ide_transfer_start(s, s->io_buffer, BDRV_SECTOR_SIZE, ide_sector_wri=
te);
>
>      s->media_changed =3D 1;
>
> @@ -1678,7 +1679,7 @@ static bool cmd_identify_packet(IDEState *s, uint8_=
t cmd)
>  {
>      ide_atapi_identify(s);
>      s->status =3D READY_STAT | SEEK_STAT;
> -    ide_transfer_start(s, s->io_buffer, 512, ide_transfer_stop);
> +    ide_transfer_start(s, s->io_buffer, BDRV_SECTOR_SIZE, ide_transfer_s=
top);
>      ide_set_irq(s->bus);
>      return false;
>  }
> @@ -2559,7 +2560,7 @@ static void ide_init1(IDEBus *bus, int unit)
>      s->unit =3D unit;
>      s->drive_serial =3D drive_serial++;
>      /* we need at least 2k alignment for accessing CDROMs using O_DIRECT=
 */
> -    s->io_buffer_total_len =3D IDE_DMA_BUF_SECTORS*512 + 4;
> +    s->io_buffer_total_len =3D IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + =
4;
>      s->io_buffer =3D qemu_memalign(2048, s->io_buffer_total_len);
>      memset(s->io_buffer, 0, s->io_buffer_total_len);
>
> --
> 2.21.3
>
>

