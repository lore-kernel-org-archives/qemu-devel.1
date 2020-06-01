Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4619DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1190C2065C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umQ0Gth9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1190C2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfhmy-00079Q-6w
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfhm2-0006P8-3P
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:34:30 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:42620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfhm0-0002jq-Sn
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:34:29 -0400
Received: by mail-ed1-x544.google.com with SMTP id k19so6857773edv.9
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 03:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pCGKY/SwoJT+MifvgGwmbbj/9vdEevUHTXQXGY6VPEU=;
 b=umQ0Gth9jqs2tafLv0MaOsvTtBPvXcFh9GlxII2rB7Hb0ZpylSy20deqNm8Pe6HSTa
 S4K7LN1MBw5wSEc10UHurRU4G28Kh17fG9HvcVA89UGkqGZa4G5aD1WEWVFq8zZJVyZo
 EqDqbrZ9Ocem3UV7AI+hR+a4O5NkcuwgrBUsftNTLPHmE6k6BsO4lOrjxLXzlL9EkNQd
 Qi20q6cG9dEnSZx+DPFlp2NK/nvEC94I04gkyY7KPGO8EsnFH3uFbAw4ZTjU1lNNH8+V
 IKl1eMDcVX6GIkPp6puZPsCuOuspeH86uCQ4AEhgRVhKhzu1c5cUAgkCxnjI8xT69ejz
 VUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pCGKY/SwoJT+MifvgGwmbbj/9vdEevUHTXQXGY6VPEU=;
 b=p4f87laNcSRZksG8E4qDdyC8r/x7VNR8s86srUo2XAVwWWKXrfhDtuTVykWnYufHpf
 loS4V4mwfe/u7EFgnFd+c512uHjwOQHD5LTtAV/OiI5z9q2LkGNGJhKYcIufUnZDaRTx
 0k6yeKCVxXvQOumufV0VOW1neAoc3vd/Pu7m3vPT7N7CE67CKknYFBDjiJAtawaiinW2
 jtnTzkT0bPimjtsyPmjiYLtNANjOYnPwRy2uxpJX4SLdU9Z0HvWt01M2v2og7Xlflhsi
 c5iZkv4rBc56k+smZeT0wLxYOtrHnBd2Sd0xhJDm6JRz8eOh7ccgBv5ZIc2jN0lMfQ45
 JaAA==
X-Gm-Message-State: AOAM5305wdydZbs5Os8Y7HF1ILrKDYlVJ05RnaK2KMFI4+bcYZIsqsqm
 T/S9zcmaRdXAYFThH7yH0c8Y0IwmWPMXkcX+cT4=
X-Google-Smtp-Source: ABdhPJxwl+2nZSEHK4ggin07itXMOzFMYpv3reBGwmdP5oEaObkhv7HytbD2aBTUtrNMMzN+osXkLA7hK8rV27M9H4M=
X-Received: by 2002:a50:fb14:: with SMTP id d20mr13721991edq.209.1591007667289; 
 Mon, 01 Jun 2020 03:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200601092057.10555-1-f4bug@amsat.org>
 <CAL1e-=ju88pJcXiK_KN1w5qbFR5MBNJqbGCo-ZtYnDmVo7O+ZQ@mail.gmail.com>
 <ee1b80b2-3d8c-4b73-1164-7beb4fa866d7@amsat.org>
In-Reply-To: <ee1b80b2-3d8c-4b73-1164-7beb4fa866d7@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jun 2020 12:34:16 +0200
Message-ID: <CAL1e-=jqQ_GciNN3jjqV_u6MZMYRMWjwT_V6bUWYfaK6pGegkw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Volunteer for maintaining the Renesas
 hardware
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 1, 2020 at 12:23 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> +Peter +Markus as neutral and experienced contributors.
>
> On 6/1/20 11:56 AM, Aleksandar Markovic wrote:
> > On Mon, Jun 1, 2020 at 11:21 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> >>
> >> I don't have much clue about the Renesas hardware, but at least
> >> I know now the source files a little bit, so I volunteer to pick
> >> up patches and send pull-requests for them during my scarce
> >> hobbyist time, until someone else with more knowledge steps up
> >> to do this job instead.
> >>
> >> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >
> > There is alive and well Renesas target maintainer that obviously has
> > the access to Renesas hardware, and I have no idea why you should
> > be the maintainer for something that you say do not have much clue,
> > while at the same time omitting the original Renesas contributor.
>
> The last time Magnus was active was more than 10years ago...
>
> commit fc8e320ef5831dc0b0d744e369537893a4379753
> Author: Magnus Damm <damm@opensource.se>
> Date:   Fri Nov 13 18:51:05 2009 +0900
>
>     fix make clean targets
>
>     This patch fixes clean in case of missing directories and
>     also adds code to distclean that removes the following files:
>      qemu-monitor.texi roms/seabios/config.mak roms/vgabios/config.mak
>
>     Signed-off-by: Magnus Damm <damm@opensource.se>
>     Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>
> There are SH4 patches on the list:
> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08519.html
>
> Who is going to pick them?
>
> >
> > Scandalous.
>
> I don't understand your attitude, I'm simply trying to help everyone by
> giving time to the project, relieving overloaded maintainers. You only
> keep tracking my activity and yelling about all my contributions. What
> do you expect with all your critics? They are not very constructive and
> don't improve much the project in general.
>

You add the utter confusion to a clear thing.

"Renesas" is not the same as "sh4". We had "sh4" as a target since
forever, and now you suddenly want to change "sh4 hardware" to
"Renesas hardware"??

Today, "Renesas", as a company, is more oriented towards architectures
that are similar to "sh4", but not the same - RX architectures. I find it
surprising and interesting you don't know that, since you participated
in introduction of "RX" target. BTW, you also dictate there Yoshimoto
that to do and what not to do. Why?

Aleksandar

> Regards,
>
> Phil.
>
> >
> > Regards,
> > Aleksandar
> >
> >>  MAINTAINERS | 15 +++++++++++++--
> >>  1 file changed, 13 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 0944d9c731..cbba3ac757 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -298,9 +298,7 @@ SH4 TCG CPUs
> >>  M: Aurelien Jarno <aurelien@aurel32.net>
> >>  S: Odd Fixes
> >>  F: target/sh4/
> >> -F: hw/sh4/
> >>  F: disas/sh4.c
> >> -F: include/hw/sh4/
> >>
> >>  SPARC TCG CPUs
> >>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> @@ -1238,6 +1236,18 @@ F: pc-bios/canyonlands.dt[sb]
> >>  F: pc-bios/u-boot-sam460ex-20100605.bin
> >>  F: roms/u-boot-sam460ex
> >>
> >> +Renesas Hardware
> >> +----------------
> >> +SH4 Hardware
> >> +M: Aurelien Jarno <aurelien@aurel32.net>
> >> +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> +S: Odd Fixes
> >> +F: hw/sh4/
> >> +F: hw/char/sh_serial.c
> >> +F: hw/intc/sh_intc.c
> >> +F: hw/timer/sh_timer.c
> >> +F: include/hw/sh4/
> >> +
> >>  SH4 Machines
> >>  ------------
> >>  R2D
> >> @@ -1246,6 +1256,7 @@ S: Maintained
> >>  F: hw/sh4/r2d.c
> >>  F: hw/intc/sh_intc.c
> >>  F: hw/timer/sh_timer.c
> >> +F: include/hw/sh4/sh_intc.h
> >>
> >>  Shix
> >>  M: Magnus Damm <magnus.damm@gmail.com>
> >> --
> >> 2.21.3
> >>
> >>
> >

