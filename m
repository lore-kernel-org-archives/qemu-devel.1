Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A0AC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888562082F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1ZzXVIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888562082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiN2E-0008FI-0X
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 13:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43859)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hiLFH-0001OQ-Or
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hiLFG-00080F-Hd
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:03:03 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:33628)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hiLFG-0007zc-96; Tue, 02 Jul 2019 12:03:02 -0400
Received: by mail-lf1-x141.google.com with SMTP id y17so11811595lfe.0;
 Tue, 02 Jul 2019 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qsKibivX02EHntCrmbyiVJL0iGA9GE9EiTTaVocYZvE=;
 b=s1ZzXVIUoH8uhjXkzXoXrQ2knjwCkoSbisSECUSEUZ8oDhRFjEWMSKpzJTWwArKXZc
 xxaLIVsqyDrwgkYlIslpSuIGEkfV+sK1nt1rS9SMW6BHZExpd/1WGmjhHSnXBibZBCLn
 4/2TNa9pY5+toJ4dOpWCDmoXuOPX/nqUy8qhkiPm5V8miA+SpZ6695lJg1+n8SbsxINW
 1iKwwYtJKAJr9Mbe3j62JK/JiyPSSky205bZuKbY9fV7jjhiPboy40HYepe6HtWms5SN
 wr2tV9edY0ZOjPMC4wYTxZLLuc6tldy2PSlo1hOvQg6/XKrgn8urc1q0n28U1J8wNJyt
 Mj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qsKibivX02EHntCrmbyiVJL0iGA9GE9EiTTaVocYZvE=;
 b=YJozpXBCr5DCJWatJ/qun5VsnqgN65rMtyy1kl/5RqkBXH3Az8PH2MydLIURnEvrl7
 EGGjbZXBJBPfY4k4vvqw/QBG2Agmd4iwEgnbIhYFqdPp/c+9gIqfLd67cH29NElyE+Vi
 6lM2vkKq1e1CSrP61R+FjCqLDvtuNDwbbMc6CnkkjjjTpNzy/2Vgfnel2aP7M1PXlZZr
 ehfbtHElY0mGbeWwV98LTC3v5N+KQgrFmF/YWtMob3cFiVyE8mjJQluBizcoffdAMt/o
 faxDVXmNND2PMbqh/EmRiLa4N85BIZ88Mjpk39FLYgUZ8w5Blm9wf662En6GOPXBgn/y
 jv8w==
X-Gm-Message-State: APjAAAVw8QXlBpM/t5CcFeJI0yVizTeRwF4EZ4AR0b8xkozhPB6kpPZd
 xIb0CJdruql2SZRP3pXNZfPMv9w/U9UNjvkGt/Q=
X-Google-Smtp-Source: APXvYqz+wjJ9ZjPNWkduPaR1YRomsukF4BUx2G6gWf87O99xDcQ64v2Lw0knoL1qfI83Yy4pM9ORl8yWN1eL4nzE9Uo=
X-Received: by 2002:a05:6512:29a:: with SMTP id
 j26mr14692707lfp.44.1562083380780; 
 Tue, 02 Jul 2019 09:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190702001301.4768-1-philmd@redhat.com>
 <20190702001301.4768-3-philmd@redhat.com>
In-Reply-To: <20190702001301.4768-3-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 2 Jul 2019 08:59:56 -0700
Message-ID: <CAKmqyKPM-MKuB_nq-5KMBg0BR-QvYbDB7EtY_Wep2uoiMsbXxg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v2 2/9] hw/block/pflash_cfi01: Use the
 correct READ_ARRAY value
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

On Mon, Jul 1, 2019 at 5:14 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> In the "Read Array Flowchart" the command has a value of 0xFF.
>
> In the document [*] the "Read Array Flowchart", the READ_ARRAY
> command has a value of 0xff.
>
> Use the correct value in the pflash model.
>
> There is no change of behavior in the guest, because:
> - when the guest were sending 0xFF, the reset_flash label
>   was setting the command value as 0x00
> - 0x00 was used internally for READ_ARRAY
>
> [*] "Common Flash Interface (CFI) and Command Sets"
>     (Intel Application Note 646)
>     Appendix B "Basic Command Set"
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi01.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index dcc9885bf0..743b5d5794 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -280,10 +280,9 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr=
 offset,
>          /* This should never happen : reset state & treat it as a read *=
/
>          DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cmd);
>          pfl->wcycle =3D 0;
> -        pfl->cmd =3D 0;
> +        pfl->cmd =3D 0xff;
>          /* fall through to read code */
> -    case 0x00:
> -        /* Flash area read */
> +    case 0xff: /* Read Array */
>          ret =3D pflash_data_read(pfl, offset, width, be);
>          break;
>      case 0x10: /* Single byte program */
> @@ -449,8 +448,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>      case 0:
>          /* read mode */
>          switch (cmd) {
> -        case 0x00: /* ??? */
> -            goto reset_flash;
>          case 0x10: /* Single Byte Program */
>          case 0x40: /* Single Byte Program */
>              DPRINTF("%s: Single Byte Program\n", __func__);
> @@ -527,7 +524,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>              if (cmd =3D=3D 0xd0) { /* confirm */
>                  pfl->wcycle =3D 0;
>                  pfl->status |=3D 0x80;
> -            } else if (cmd =3D=3D 0xff) { /* read array mode */
> +            } else if (cmd =3D=3D 0xff) { /* Read Array */
>                  goto reset_flash;
>              } else
>                  goto error_flash;
> @@ -554,7 +551,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>              } else if (cmd =3D=3D 0x01) {
>                  pfl->wcycle =3D 0;
>                  pfl->status |=3D 0x80;
> -            } else if (cmd =3D=3D 0xff) {
> +            } else if (cmd =3D=3D 0xff) { /* read array mode */
>                  goto reset_flash;
>              } else {
>                  DPRINTF("%s: Unknown (un)locking command\n", __func__);
> @@ -646,7 +643,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>      trace_pflash_reset();
>      memory_region_rom_device_set_romd(&pfl->mem, true);
>      pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> +    pfl->cmd =3D 0xff;
>  }
>
>
> @@ -762,7 +759,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
>      }
>
>      pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> +    pfl->cmd =3D 0xff;
>      pfl->status =3D 0;
>      /* Hardcoded CFI table */
>      /* Standard "QRY" string */
> --
> 2.20.1
>

