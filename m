Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B71AC48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 06:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DDD20656
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 06:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="c6uZPUud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DDD20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56872 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hffGQ-0003vt-4f
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 02:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54926)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hffFS-0003NC-NF
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 02:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1hffFR-0006YQ-N6
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 02:48:10 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:35126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1hffFO-0006WW-Ru; Tue, 25 Jun 2019 02:48:07 -0400
Received: by mail-qk1-x741.google.com with SMTP id l128so11734058qke.2;
 Mon, 24 Jun 2019 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Qgw/UEmTi+EnyEYVz+R14jW+cx7uhlztrfnIC1iFJkA=;
 b=c6uZPUudMoomhfjYM4Ec0lS2jtRu3EyRTYNcegeqdXSjsWI92qmE0cnZ4jUO71MXNh
 VAMBcJuk6VQLjzIcuQWbDMVlSkI7swjP8Oy3RC0+QKbzIp2RN6BTUxrf/0PvZkh+2SpZ
 MrPRUrE4ChWW+AhH0IYQtmOVVvUfp9aZYADzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Qgw/UEmTi+EnyEYVz+R14jW+cx7uhlztrfnIC1iFJkA=;
 b=eAYr9nyXZyXDqqDjg3dtGgOz4yIUfd6kczIU0hUozhVxxx24zWxwtYyS2tJoH2E0Sp
 gcvmmCepY9zvhnf5lTjJR7iK5k6LeaChP4ClIdM8B+aK6stsTO8qt2HrwNRMhF1bMLKj
 HNE+Y+gZ7Tg0aRgsxysUdIMuX4aR84iSNBiUZFQP6aUsS0G9hUxjonkI5/jqdNlimpHL
 F720iX0XksjbA28KiMxl9SeDdMeCZWhQRedFciGEAuXPYz/wS+udwXHreNu/rr/a7G/J
 Lc8BEMD+MJZIBqpbpZq7vvgm8hDltg9ICiK8BN9/rO8bwN3YfXondt6cST4i7HG5j08q
 z/Xw==
X-Gm-Message-State: APjAAAVeyl0lwkvuK1aka2QEk8bpmCgfOMu/vis41P8uDtxvsIf254ic
 Ps/NiGbg6Wo2impJyLj4SPAVV4DN5zxhuQQUrlg=
X-Google-Smtp-Source: APXvYqyT0nYksZC7XUh76ZUdtStKvijqz1suVQmwXHG2X0U4Mpi4PlDGR7/PPjQJtJ3LWwj9LN6QmAEbCbVl2TH4dsk=
X-Received: by 2002:a37:b0c6:: with SMTP id
 z189mr76395184qke.208.1561445284779; 
 Mon, 24 Jun 2019 23:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190621065242.32535-1-joel@jms.id.au>
 <6aec047c-81bd-e179-6fad-4bee896ea7a2@kaod.org>
 <21bd02d0-d051-e730-bfb9-bca2f57babe8@redhat.com>
In-Reply-To: <21bd02d0-d051-e730-bfb9-bca2f57babe8@redhat.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 25 Jun 2019 06:47:52 +0000
Message-ID: <CACPK8XcVZ68g+6BCvAszZubJOE1Y=Ac2EvZ84u_740Lo4Rqx1A@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: Re: [Qemu-devel] [PATCH v2] aspeed: Link SCU to the watchdog
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
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Jun 2019 at 09:06, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 6/21/19 10:25 AM, C=C3=A9dric Le Goater wrote:
> > On 21/06/2019 08:52, Joel Stanley wrote:
> >> The ast2500 uses the watchdog to reset the SDRAM controller. This
> >> operation is usually performed by u-boot's memory training procedure,
> >> and it is enabled by setting a bit in the SCU and then causing the
> >> watchdog to expire. Therefore, we need the watchdog to be able to
> >> access the SCU's register space.
> >>
> >> This causes the watchdog to not perform a system reset when the bit is
> >> set. In the future it could perform a reset of the SDMC model.
> >>
> >> Signed-off-by: Joel Stanley <joel@jms.id.au>
> >
> > I was keeping this patch in my tree (hence the Sob) hoping that
> > someone could find the time to study the reset question. But this
> > patch is useful as it is and I think we should merge it.
> >
> > Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >
> > Thanks,
> >
> > C.
> >
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

> >> --- a/hw/watchdog/wdt_aspeed.c
> >> +++ b/hw/watchdog/wdt_aspeed.c
> >> @@ -44,6 +44,9 @@
> >>
> >>  #define WDT_RESTART_MAGIC               0x4755
> >>
> >> +#define SCU_RESET_CONTROL1              (0x04 / 4)
> >> +#define    SCU_RESET_SDRAM              BIT(0)
> >> +
> >>  static bool aspeed_wdt_is_enabled(const AspeedWDTState *s)
> >>  {
> >>      return s->regs[WDT_CTRL] & WDT_CTRL_ENABLE;
> >> @@ -222,6 +225,13 @@ static void aspeed_wdt_timer_expired(void *dev)
> >>  {
> >>      AspeedWDTState *s =3D ASPEED_WDT(dev);
> >>
> >> +    /* Do not reset on SDRAM controller reset */
> >> +    if (s->scu->regs[SCU_RESET_CONTROL1] & SCU_RESET_SDRAM) {
>
> This would be cleaner as an static inlined function in
> "hw/misc/aspeed_scu.h" IMO, maybe 'bool scu_sdram_is_reset()'.

I will take this suggestion on board in the future when I model the
watchdog reset behavior in more detail.

>
> Anyway the patch looks sane:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks.

Joel

