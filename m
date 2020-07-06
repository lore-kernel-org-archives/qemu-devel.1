Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9084C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D93207BB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3XU5Qx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D93207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsW5N-0003xb-UA
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 14:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsW4l-0003Vr-Rc
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:42:47 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:33853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsW4j-0007Ww-Ni
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:42:47 -0400
Received: by mail-il1-x142.google.com with SMTP id t4so20650558iln.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 11:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=perZ7FF8QeB/7vuvzv5TKDm2Pt3TqyNy1kGm1oDtV/0=;
 b=j3XU5Qx+kgeo3gd2Ut1eg+jqgJ3ba2Pw0aH1+B8KuXdhfCBs4DasDTwpzbKtf+aH8n
 jzIdIpW3IKumKXSINlqrwLw5jyHoR9JMHZxmw0pC41TggHrkEgZKG4n4mR7u06lwCMzz
 CNsegh1YD+MMQ7GUHXIvtZpj8DFXBMpfuONzNexVxzUIyFSUKRK2PhDTQrhYYnvrH31w
 zdtlGgwksom5iP0TtWU7o4960yc3lVVXpZ+UuesYcvpDSFB/NzRKwJAurn1xoK0Sa9G9
 l6Vr939onMlYFJSGQKvLFCs4tDfzfwusj2mqcVaWwH4+mPD1hSffhN/XzYCC6rW6ZFk0
 B8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=perZ7FF8QeB/7vuvzv5TKDm2Pt3TqyNy1kGm1oDtV/0=;
 b=KZSHoBRGAk7qfSNtV8PzrVIXBC/JUkv8pHr5GveYlGWXvgWxRpTc4i2PM57K3thNb2
 yZF1JNT1N92JKEsGvBVqpdWUN9xYM4GkG1QyaVGlHOCfTRY6VXYj0iAY/v2tu8KIZoba
 xlIISI4O3Rt/mUimM3DjuFSG/rzuoy2IPj4/jIuyRC+DjRINPiZ3I2JU/V6LmOGPHw+G
 WcQe+tRmfmUigj0JN2X9gXvv3vR6evSspqrURuBBw4pkdtWtkcWDxdtt11RPJcASN9Fd
 59/X06tBPhuChbT+/LWcGHxy41prBD/eHwNZapBDByt6qmOPY5W9VJUoj0Bf0+WSrgrH
 j0iQ==
X-Gm-Message-State: AOAM532MvqaX8r0Yo2++YM4NtAIeAiPr3HhDky+NiW1LCvj/IPxPNdCF
 lg/BuZT8tX/Tb9IkT+Ym2HbHNdQgPJhawfCWSUc=
X-Google-Smtp-Source: ABdhPJx+dWhh47KvzUcvNC5TIp7QBvv1lmRYbR2N/hb+CdhibkbwJo6a6w4adLmX1t7ZFDwQd+DPE6VgabB6/dVO0Oc=
X-Received: by 2002:a92:c213:: with SMTP id j19mr31999503ilo.40.1594060964578; 
 Mon, 06 Jul 2020 11:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200705211016.15241-1-f4bug@amsat.org>
 <20200705211016.15241-3-f4bug@amsat.org>
 <CAKmqyKOcc=recN5dpsMUZRq9FkU2Kj0-AbmxGTOSpY=yxOEF-Q@mail.gmail.com>
 <68b27cb4-145b-47ed-bbed-428c7591f8c7@amsat.org>
In-Reply-To: <68b27cb4-145b-47ed-bbed-428c7591f8c7@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 11:32:57 -0700
Message-ID: <CAKmqyKPGXzRYBTaV7JXuKOmXsez5oHWa23mJ7HDKiBuKvdLjRA@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/lm32/milkymist: Comment to remember some IRQs
 lines are left unwired
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 6, 2020 at 11:04 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 7/6/20 6:19 PM, Alistair Francis wrote:
> > On Sun, Jul 5, 2020 at 2:10 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org> wrote:
> >>
> >> The 'card is readonly' and 'card inserted' IRQs are not wired.
> >> Add a comment in case someone know where to wire them.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >
> > I'm not convinced adding fixmes or todos in the code is the right
> > direction. It would be better to file bugs or use some other more
> > official tracking mechanism.
>
> This code is orphan :S
>
> I'll fill a launchpad bug ticket.

I also mean in general (you have some other patches that add TODOs or FIXME=
s).

>
> OTOH we could also log UNIMP for lost IRQs (triggered but
> no handler registered).

That would also work.

Alistair

>
> >
> > Alistair
> >
> >> ---
> >>  hw/lm32/milkymist.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> >> index 469e3c4322..117973c967 100644
> >> --- a/hw/lm32/milkymist.c
> >> +++ b/hw/lm32/milkymist.c
> >> @@ -87,6 +87,7 @@ static DeviceState *milkymist_memcard_create(hwaddr =
base)
> >>      dev =3D qdev_new("milkymist-memcard");
> >>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> >>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> >> +    /* FIXME wire 'card is readonly' and 'card inserted' IRQs? */
> >>
> >>      return dev;
> >>  }
> >> --
> >> 2.21.3
> >>
> >>
> >

