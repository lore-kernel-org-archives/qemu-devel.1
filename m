Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB9BC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B8B20637
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2kvYCwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B8B20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPb0-0004rH-Km
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jGPXn-0007aY-IY
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jGPXk-0006fF-OL
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:03:15 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:37717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jGPXk-0006dA-KV; Mon, 23 Mar 2020 12:03:12 -0400
Received: by mail-ua1-x944.google.com with SMTP id l18so966748uak.4;
 Mon, 23 Mar 2020 09:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JnyeopB+Gr3i1azSR4z83W38j2lgLgHE6PDpwzZJBB8=;
 b=p2kvYCwkVukiiOQHNpOTZjXZ3qUhT2afJEgMCmV0WTjTzaqibkNcZdaUTtSLRN0J5C
 5blHrzibFGYcVx1aGlzOBkTIC/WY+Wyd1kBaVrr1VpE+tcR7+xRqwT6tQGDGSOF1aRZI
 t31rf2eFACLhd9OxEZ73GD8R3v2mhKs3mxwa1/fi4KOAQAfOqlG/vhCRoERQpVeTAq0N
 tViP7821FddrPWi0mOIl6Uh/QhXdlhecgVWvxjN6fR1oXV/g80k1wpdLjdx51o9PWPl5
 nkAX/MyVJvglANyR+WW1A+vKlruZKNhUfs5W9EuH7X6JlHVw53O7UXX8gmNGvInMDBw3
 rpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JnyeopB+Gr3i1azSR4z83W38j2lgLgHE6PDpwzZJBB8=;
 b=uYRsWxQbNq/smPf/MRNth0LHrKkwY8EsJu8EKUCDjnPHD/uIjAaNwBSKPHwcE5RmWm
 rzli1h/MFYMqUTVLhyCkZyivpR3OsfLbkvcOAwHXLcNUA6N5JbZahs9Yu1kchjiS3n50
 rYiMCCl/iz+/YuurIUoDNs5jRIa0yZgYg8WyRJ6wop5K560wjoxPLA0ZCz0VoEvnAL19
 rqJ27CdRgoRC+70eyziSdzaIk2MlcawSasPk3hBQ+JkZ++jZxlnOUxnKShmtxLw8qLI4
 n+LnQTOHGp2qxrDuCjYR7L33TBi1UnDKuFkBNJIF9UerU/Kelg2BgPvhcxFfexQQCGWP
 +aOQ==
X-Gm-Message-State: ANhLgQ0E2PPRa4uAOITIqOCHau6tnlaEG/9oNurb9DRvS8fvJFRs5lSP
 UWAFeZyeYV5fay8wq5tbz5TrYaHSC8nS0hKWgrg=
X-Google-Smtp-Source: ADFU+vultXvB6mUVHmmwMfWDB+Ux8l9wUoYuTCjGAJKPULuO0JSO86/77/q+fLk3kmIqdWHMgtuDtFn1LpShSqoLDYc=
X-Received: by 2002:a9f:2964:: with SMTP id t91mr7742050uat.21.1584979390662; 
 Mon, 23 Mar 2020 09:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200321144110.5010-1-philmd@redhat.com>
 <20200321144110.5010-11-philmd@redhat.com>
In-Reply-To: <20200321144110.5010-11-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 23 Mar 2020 08:55:08 -0700
Message-ID: <CAKmqyKOt9+O8fYsSOabSP6kOqi879-qE-GBJqhVvW=EtH_2rmg@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 v2 10/11] hw/timer/pxa2xx_timer: Add assertion to
 silent static analyzer warning
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::944
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 21, 2020 at 7:50 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> pxa2xx_timer_tick4() takes an opaque pointer, then calls
> pxa2xx_timer_update4(), so the static analyzer can not
> verify that the 'n < 8':
>
>   425 static void pxa2xx_timer_tick4(void *opaque)
>   426 {
>   427     PXA2xxTimer4 *t =3D (PXA2xxTimer4 *) opaque;
>   428     PXA2xxTimerInfo *i =3D (PXA2xxTimerInfo *) t->tm.info;
>   429
>   430     pxa2xx_timer_tick(&t->tm);
>   433     if (t->control & (1 << 6))
>   434         pxa2xx_timer_update4(i, qemu_clock_get_ns(QEMU_CLOCK_VIRTUA=
L), t->tm.num - 4);
>
>   135 static void pxa2xx_timer_update4(void *opaque, uint64_t now_qemu, i=
nt n)
>   136 {
>   137     PXA2xxTimerInfo *s =3D (PXA2xxTimerInfo *) opaque;
>   140     static const int counters[8] =3D { 0, 0, 0, 0, 4, 4, 6, 6 };
>   142
>   143     if (s->tm4[n].control & (1 << 7))
>   144         counter =3D n;
>   145     else
>   146         counter =3D counters[n];
>
> Add an assert() to give the static analyzer a hint, this fixes a
> warning reported by Clang static code analyzer:
>
>     CC      hw/timer/pxa2xx_timer.o
>   hw/timer/pxa2xx_timer.c:146:17: warning: Assigned value is garbage or u=
ndefined
>           counter =3D counters[n];
>                   ^ ~~~~~~~~~~~
>
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/timer/pxa2xx_timer.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
> index cd172cc1e9..944c165889 100644
> --- a/hw/timer/pxa2xx_timer.c
> +++ b/hw/timer/pxa2xx_timer.c
> @@ -140,6 +140,7 @@ static void pxa2xx_timer_update4(void *opaque, uint64=
_t now_qemu, int n)
>      static const int counters[8] =3D { 0, 0, 0, 0, 4, 4, 6, 6 };
>      int counter;
>
> +    assert(n < ARRAY_SIZE(counters));
>      if (s->tm4[n].control & (1 << 7))
>          counter =3D n;
>      else
> --
> 2.21.1
>
>

