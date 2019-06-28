Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E935C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 23:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA0D208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 23:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GopEczGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA0D208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hh08r-0005JF-C4
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 19:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50525)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hh05a-0003fr-VI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 19:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hh05Z-0001se-RG
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 19:15:30 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hh05Z-0001qF-1d; Fri, 28 Jun 2019 19:15:29 -0400
Received: by mail-lj1-x244.google.com with SMTP id h10so7535096ljg.0;
 Fri, 28 Jun 2019 16:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CvJ9SM/XPQnJs9PsEukEPdEpIalBIj+pe8+Z80hYcTo=;
 b=GopEczGOPHU8PNLXw63uiLaNi+MWMf9MIUFbHxC7EfVVTXltkno8QYSvsYSjd3vbPA
 0zecR9YpyVRnkNwxWn81c86J3TfugbrVZk5GTV99AvDJraz0NQUW+fU95W1UqStT4lHn
 s8sDuX/5bdKs0a04qj5aL4x+YJCF4YufmwBDnXEF8sIAJpZF8GLewXwNiEP6wS2hZMKj
 C3IYblTDr7QppnsU2Hwd7Mf255bjFSp8whuIHNSp3DEnsIT4xNWRrqRNw+voNOTGY4Gv
 0ODQPhTqtbeMPGQ3lzta8q91+Uvz7ksC1a5XnEoAuT0KBwwfOkCzTFhF5yVVEhqxrU98
 JGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CvJ9SM/XPQnJs9PsEukEPdEpIalBIj+pe8+Z80hYcTo=;
 b=gbbnr4805K0QrCDA59IPDV1DqoM+rOebxkwQuYd4GN4zEZ5b/ZETXIF2Hkv0LBl0t9
 8nWzQzUNbajB9ECCHL73i2paZw2WaHsZuO7kPCRiXlaSWWrD16dSh0LTrlZZe0Se4Q02
 pa/Er/69y22q0Kh6bywrYjIzrW7f58ip+gFq5+m23Rf5GzDbEsOFQ+BDVXJ3uttE3ZI6
 jGuTIpbJBRS3ijcPM9QBymsA+grBcbnx/Tp/WquzUjKncqa7Vo1txcHo3jr1mXRTxOli
 3/izlgHwNnsYClYtrBdflXGkWsBRP5FekPJSU+r0ze1iLaAbUZjErMR1HuArp2bJ/06Y
 gSAw==
X-Gm-Message-State: APjAAAVwWCIQURfCDtKbLg8liqNssHiAFowe3BFK76sUL1rlZ92Egxy+
 4K1lNjk40e6UFT+gIbzDn8c0mluBwN7JuvPPJDI=
X-Google-Smtp-Source: APXvYqyQgpqNpnRwHb1B/5G1f/qO71wvgeECAZ1KpLmZ2sbR0sA0kTP/m02C59BaeJ90N9hS1MdXS6KWRubAqqR6rxA=
X-Received: by 2002:a2e:9188:: with SMTP id f8mr2061084ljg.33.1561763727703;
 Fri, 28 Jun 2019 16:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-26-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-26-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 16:12:27 -0700
Message-ID: <CAKmqyKMTa09ajWuxtDC9kh1Fi=EFw=CZWJk+8P+fATK89otUzg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v5 25/28] hw/block/pflash_cfi02: Use chip
 erase time specified in the CFI table
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
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 2:12 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
>
> When erasing the chip, use the typical time specified in the CFI table
> rather than arbitrarily selecting 5 seconds.
>
> Since the currently unconfigurable value set in the table is 12, this
> means a chip erase takes 4096 ms so this isn't a big change in behavior.
>
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Message-Id: <20190426162624.55977-11-stephen.checkoway@oberlin.edu>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> TODO check not zero
> ---
>  hw/block/pflash_cfi02.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index a3665da3b8..b2d37c33bb 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -617,9 +617,9 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
>                  pflash_update(pfl, 0, pfl->chip_len);
>              }
>              set_dq7(pfl, 0x00);
> -            /* Let's wait 5 seconds before chip erase is done */
> +            /* Wait the time specified at CFI address 0x22. */
>              timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
 +
> -                      (NANOSECONDS_PER_SECOND * 5));
> +                      (1ULL << pfl->cfi_table[0x22]) * SCALE_MS);
>              break;
>          case 0x30:
>              /* Sector erase */
> --
> 2.20.1
>
>

