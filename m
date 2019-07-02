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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BED3C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D6820989
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am2HpwDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D6820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiNHR-0005jG-6w
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 14:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44818)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hiLJA-0003wj-KG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hiLJ8-00028g-3T
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:07:04 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:33673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hiLJ3-000246-PZ; Tue, 02 Jul 2019 12:06:58 -0400
Received: by mail-lf1-x141.google.com with SMTP id y17so11821862lfe.0;
 Tue, 02 Jul 2019 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=191PEazMI6AZYxomtIRj4zRN76qVi7zp+FaJdnT1SJc=;
 b=Am2HpwDfCU2j4FqQhU35pMIcvHZiJA14RgnYPnaOWp+dBH3ua1vxFlPGaIyM7tlmCN
 5865o8vL1KQPVgv+vmCjNUQcia3MiLYt//LS3UZFnhiYFYkZOiXM2bJs5eWvK9bxtiqT
 F8tS3U4fhjx4g+4bZYlQjoaj6XwTTQH8fShnSBpEHQXJt/lted8iHqrtAwmaJf+r18+o
 VhIBESIA9C7HqUvP5S+pV1knvKV691P4uOqe+7o1CRIBrITVqefhReAu996rqCUjcB2t
 UZ0MK+AO9D8yaCII5zqoU5LlJ4qyfcjHBrp0ZHEy24b3Rd0r5jxmcHsbGXW4u59sQuOQ
 fVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=191PEazMI6AZYxomtIRj4zRN76qVi7zp+FaJdnT1SJc=;
 b=Bj1BK+gOgZRyWtS26XLyi6kwU5ngoGSS64LETnPmN5o0YEJmbuylxwrIsWy+zAVv+P
 2CiQqb4idSvnRe9d3yOWyhAzaXNCbAjCVq/0leh+NpfNIQlh96qdxKP1iMuLpywUAehB
 mX2zAyoKeuneewqpAF34dALLT0DCr6JZaRfdOEf11s7dS3IdmfVwnzkEiFzdcBCyoOE/
 xzsaTYI9vGMV25PUnjXlgBBIT61aAYF1v6eRvXrt4G/5gsv3+sZeS+xtMsTbOOlEMnhG
 idLp7xxLutDYoAudvWzszUvCpElUXO4AaxekLyliJb8FU6XycV2VarrihajJQvfgVdxk
 dGiA==
X-Gm-Message-State: APjAAAW5+DDzrtkfW5hdhwqupKK8pUl3ic9zIVMPj54lpSo5qXsb44dx
 Q+cFwWPs1tiBHOdKmzMY+jWbV4WTF8xRrlh/AGc=
X-Google-Smtp-Source: APXvYqyHbgXSZavlE/NdxL+IluKO6aiBhhzlUNZvLBXoABzxVIyUSgTn8WzBKuDJ3cVeZpWtkXfRFpzGcCvHXjuQqY8=
X-Received: by 2002:a19:4c05:: with SMTP id z5mr14851396lfa.5.1562083614266;
 Tue, 02 Jul 2019 09:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190702001301.4768-1-philmd@redhat.com>
 <20190702001301.4768-7-philmd@redhat.com>
In-Reply-To: <20190702001301.4768-7-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 2 Jul 2019 09:03:51 -0700
Message-ID: <CAKmqyKMgXKULX8JJSTmLyCbzRYJkeHZ=HqHBHA_cro-a21v=Zg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v2 6/9] hw/block/pflash_cfi01: Simplify
 CFI_QUERY processing
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
> The current code does:
>
> if (write_cycle =3D=3D 0)
>   if (command =3D=3D CFI_QUERY)
>     break
>   write_cycle +=3D 1
>   last_command =3D command
>
> if (write_cycle =3D=3D 1)
>   if (last_command =3D=3D CFI_QUERY)
>     if (command =3D=3D READ_ARRAY
>       write_cycle =3D 0
>       last_command =3D READ_ARRAY
>
> Simplify by not increasing the write_cycle on CFI_QUERY,
> the next command are processed as normal wcycle=3D0.
>
> This matches the hardware datasheet (we do not enter the WRITE
> state machine, thus no write cycle involved).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi01.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 8d632ea941..c1b02219b2 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -492,7 +492,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>              return;
>          case 0x98: /* CFI query */
>              DPRINTF("%s: CFI query\n", __func__);
> -            break;
> +            pfl->cmd =3D cmd;
> +            return;
>          case 0xe8: /* Write to buffer */
>              DPRINTF("%s: Write to buffer\n", __func__);
>              /* FIXME should save @offset, @width for case 1+ */
> @@ -566,13 +567,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr of=
fset,
>                  goto mode_read_array;
>              }
>              break;
> -        case 0x98:
> -            if (cmd =3D=3D 0xff) {
> -                goto mode_read_array;
> -            } else {
> -                DPRINTF("%s: leaving query mode\n", __func__);
> -            }
> -            break;
>          default:
>              goto error_flash;
>          }
> --
> 2.20.1
>

