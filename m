Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB2CC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7677820643
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sL6/xvYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7677820643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWidG-0000TL-Iu
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 10:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWicX-00088D-6I
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWicW-0001xI-1k
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:07:17 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWicV-0001wr-Rj
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:07:15 -0500
Received: by mail-oi1-x243.google.com with SMTP id v138so15592332oif.6
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 07:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Gu1Iv+CCf5Exkt+e6vonr2FfIz9x71rXUkPRrXFHeuY=;
 b=sL6/xvYIcp2y1CIXEqJM1fxDHi9rw3vgWuCt+c9GN8zMxkVx2wfpOK/tz7ov0pCByS
 Db98AijiS0VeWFTOIk8hJJ1DteUFH09Tuli9smz5b8b4sP5z9EvqqyBT5ASAGLyMAbzB
 WYUNo94eUd2nE7Eg2bCL6lhhBTT9KItDJIk/Cs2aLJdfVPFS38UVpDc1VVEWTWLuh04T
 nDrzHt51hQbDzndOJhA0VI/WEYI6ob5Xph8K826N7b6/EZ+VNy5/M2Lq24pKhR8I1qHx
 ucrYDyfjjXPrpJlZ3fYF/bbzHooDliJZiRhFGKqihcWaCeHDjvHc1PyY05TVP6Tqul+n
 +now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Gu1Iv+CCf5Exkt+e6vonr2FfIz9x71rXUkPRrXFHeuY=;
 b=BBjrlHjpBm3GhjP+vTbEe44fVd4gtB6Lpvt4E2IQBTtxJfN0EALmoHDKVGCfmiUHY3
 6fgA4vkoiv/pK8x7uLLKX0QMpxY+WviqQgLuolWavsqf9i+ysJmNMSqzPChY6Qwq6Rqg
 bpmC7A5jAWchF6J2uEPWmc6VQSIgQXn5tJgncGBDorUdRHbhbi2dbSzvHpXUi33SALXi
 g9yHQaAyhlV4g4inA6CsmHxh3lHjSbjdeKKp7/7LiOEt8lwzUM9RsBG8hw8mp6fT5z5N
 SAjmKRYTwbnzcZU23I+Mumk2y37iqBtmHKh/2k/rpJEIfDk0Y4hFTi9tHIHMe7bw6n7v
 Hc/A==
X-Gm-Message-State: APjAAAWjEewqunDW2Fa5blfiq13pVx1tTABwQ59PIVQXqZbn9NLzOUP0
 FerHZVhJCXohOFTmKTXHyi/h1hiLJTArFoMSMngzLg==
X-Google-Smtp-Source: APXvYqxEjS7siq+yIgF3zh8VFZgeY0aE/sfvW4+xqUBzDHEk1qfC646UnSQviquz6lNUdFbcZice2Bwu+5UVKkj32lc=
X-Received: by 2002:a05:6808:b04:: with SMTP id
 s4mr20824695oij.163.1574089634917; 
 Mon, 18 Nov 2019 07:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-16-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-16-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 15:07:04 +0000
Message-ID: <CAFEAcA_e4byjW-zPWPWdwZX0qFwUesKo+FTFK6Y9_tMTejSsBQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/33] serial-mm: add endianness property
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Oct 2019 at 18:34, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Add a qdev property for endianness, so memory region setup can be done
> in realize.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/serial.c         | 2 ++
>  include/hw/char/serial.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index c28cfc94fd..2f7667c30c 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -1081,6 +1081,7 @@ SerialMM *serial_mm_init(MemoryRegion *address_spac=
e,
>      qdev_prop_set_uint32(DEVICE(s), "baudbase", baudbase);
>      qdev_prop_set_chr(DEVICE(s), "chardev", chr);
>      qdev_prop_set_int32(DEVICE(s), "instance-id", base);
> +    qdev_prop_set_uint8(DEVICE(s), "endianness", end);
>
>      qdev_init_nofail(DEVICE(s));
>      qdev_init_nofail(DEVICE(self));
> @@ -1102,6 +1103,7 @@ static void serial_mm_instance_init(Object *o)
>
>  static Property serial_mm_properties[] =3D {
>      DEFINE_PROP_UINT8("regshift", SerialMM, regshift, 0),
> +    DEFINE_PROP_UINT8("endianness", SerialMM, endianness, DEVICE_NATIVE_=
ENDIAN),
>      DEFINE_PROP_END_OF_LIST(),
>  };

...on reading patch 16, I just noticed that here in patch 15
you define the 'endianness' property on the SerialMM object, but
you're trying to set it on the SerialState object. This bug then
gets fixed in passing in patch 16, but we should just be
setting it on the right object to start with.

thanks
-- PMM

