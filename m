Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D8BC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81E92080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="VxcXdKEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81E92080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBBFY-0003HD-K8
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 01:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iBAx7-00074Y-PY
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iBAjU-00053q-8X
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:41:25 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:44811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iBAjT-00053Z-6y; Fri, 20 Sep 2019 00:41:23 -0400
Received: by mail-qt1-x842.google.com with SMTP id u40so7163922qth.11;
 Thu, 19 Sep 2019 21:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=svyUs4NrWaVOqTlyzKtZko0aPQsadZqzKrC58rkDqdI=;
 b=VxcXdKEp/JtI7hx/YGOcU0mbewkt0foJOA9rGUg2zfJFZUNSanRxExBGTC69c8uQ4X
 2wIDRjjxXP5tjQaTTmuuU4KvOqXdRhHhmDS74c5rGMtGucozMawFrUxlWFS/3C32fK0v
 9mcpv+T4GAH9atlOwZ+L2gSZasv7QJ2eSulZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=svyUs4NrWaVOqTlyzKtZko0aPQsadZqzKrC58rkDqdI=;
 b=m3xDlZkpH23ymZ9q0GW8qof4HpOBYZ3VgEvHIHNVa1mLiAht5ze//mxiF3rnMS5Wgh
 zmkxzxAEs7faeYmRWc/T+lQoPi8Ccz51MTRxUKYjGbQt1vDJjMHq0Y9Mjwb3KDvH59J7
 hEAxnVwsA3qycoxvUetfHSPlUsZ3n7O2julh2R0m4tvpGP4EvgDNGjcYxfSQYNeWhAFq
 UzUSl6l+RRMbGvlImw/n2F7Pj/oFgEzRdSQYUb/Iy75EifA1qPmYNCHjv7W2m3S1h7t3
 iK5MDhemIEP1dXNViH+19Vt1g8VH+P9SzzJA9a7N0b1f+XN5mfDWXvYqpNTCruUstdOQ
 2UEw==
X-Gm-Message-State: APjAAAWl7GNTfIIU9+WMTHA8QFXPAIQ61Myk+JWBTDB8NOS8h9/5ad7e
 4OPp15P4lNV2eYX7UFO/VkmW7CChcjhUNrZv4yk=
X-Google-Smtp-Source: APXvYqxclTt1ZO/yNRw2CCCcouwtnsUrdw5U1b0ziTihmmuGQ/I0waTDBJeGfBKELmFVji7VhXnRqC2H88L56ASUgtM=
X-Received: by 2002:ac8:2d8b:: with SMTP id p11mr1240701qta.220.1568954482563; 
 Thu, 19 Sep 2019 21:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190919055002.6729-1-clg@kaod.org>
 <20190919055002.6729-2-clg@kaod.org>
In-Reply-To: <20190919055002.6729-2-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 20 Sep 2019 04:41:11 +0000
Message-ID: <CACPK8Xfyuz=nbkNj+UgzGYcz0OV0M0mXoQkkwSWfW-COj8K+4Q@mail.gmail.com>
Subject: Re: [PATCH 01/21] aspeed/wdt: Check correct register for clock source
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Amithash Prasad <amithash@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 at 05:50, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> From: Amithash Prasad <amithash@fb.com>
>
> When WDT_RESTART is written, the data is not the contents
> of the WDT_CTRL register. Hence ensure we are looking at
> WDT_CTRL to check if bit WDT_CTRL_1MHZ_CLK is set or not.
>
> Signed-off-by: Amithash Prasad <amithash@fb.com>
> [clg: improved Suject prefix ]
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

A patch from the Open Source Firmware Conference! Thanks Amithash.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/watchdog/wdt_aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
> index 9b932134172c..f710036535da 100644
> --- a/hw/watchdog/wdt_aspeed.c
> +++ b/hw/watchdog/wdt_aspeed.c
> @@ -140,7 +140,7 @@ static void aspeed_wdt_write(void *opaque, hwaddr off=
set, uint64_t data,
>      case WDT_RESTART:
>          if ((data & 0xFFFF) =3D=3D WDT_RESTART_MAGIC) {
>              s->regs[WDT_STATUS] =3D s->regs[WDT_RELOAD_VALUE];
> -            aspeed_wdt_reload(s, !(data & WDT_CTRL_1MHZ_CLK));
> +            aspeed_wdt_reload(s, !(s->regs[WDT_CTRL] & WDT_CTRL_1MHZ_CLK=
));
>          }
>          break;
>      case WDT_CTRL:
> --
> 2.21.0
>

