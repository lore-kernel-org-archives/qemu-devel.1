Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F53C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBF920708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kivjn/qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBF920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqdq-0007Dc-Ty
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsq7j-0003Wi-8U
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:07:11 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:33486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsq7U-0006ym-P2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:07:10 -0400
Received: by mail-il1-x142.google.com with SMTP id a11so28223169ilk.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bCLwJcDC3JFcYpaUeEXcQfkfm1O4lWUarYnDdR1KiN0=;
 b=Kivjn/qf546AYdWpBjcaaLHN4f8/Cux6doadMU9H1g+kKKzqIpVwTGVMem2LMVJQIP
 G4GC3bSKGIficFf56eAAE+z+csyR6FmJV94Fc81UhwMuVrdBHBMESh0sWHWV6oUp5obN
 HBSrr7zBfx0Qy+pFDeR04u/qWq6IZXnr5oTltoJ2yLCaR4SJTIXwMtqIH7mNitLF0aZg
 oviV5UtLSv7G+ih5psa6ksNE9V+r3Jok6ugTCOntXdkWg83xEl2PKr3gGx2S8RhP5wwQ
 Vtuq/7EDqxr9nyUo/p0Y6a5SQmATep36Ec9LS2ive/lJBBy6umPIuFgDjiH3FIL7RLL3
 Q5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bCLwJcDC3JFcYpaUeEXcQfkfm1O4lWUarYnDdR1KiN0=;
 b=a+8oIZW7ZjSoguLXU2lNXlGXJw/M9hb65tYg26AqlsqjBOM/dxgr9Rtyun2JuoC3qc
 kuEinqGidL7L1+/wYugLBNRDTUuFWd14K4mTwr4HVzdU6jqfBgAVQijzizyD6lovSGnZ
 CRlvk6N1BIpPqHKn+dvK0whaZXDSW/+CKY5J4BtFNwcopiiQm8LytscD6kMQA/j7ZddX
 qkWbpzlFRIReU0Z5JFEcui6s5Vqf973LvEsF81CHtdxbPxHEDcKQ7d9RHuT0mdbSsbdS
 mHdPjfme5k3XG6nEWSDG953YQuJwHP0JrzuTcwl9oyK2LpvVsQMVL5U+hJoalBgCx3Y2
 A6Fw==
X-Gm-Message-State: AOAM531KJF6Q7x6ZgR0vxlGrihXnhEEaX0kUBBO1sWFmpJ5Zu3+NEu6X
 TjW4pTpfLwgj5cIJAK+dFl1MgqzQJBnXlK6Srws=
X-Google-Smtp-Source: ABdhPJxzbDGdnED3KTFioF+zWDsAXymB1wcfKu/JghoaMbEPCLt5sP67MwuhLviDFo5UWFIWYZThozLEailIRFyWPzU=
X-Received: by 2002:a92:bb84:: with SMTP id x4mr37888075ilk.177.1594138015491; 
 Tue, 07 Jul 2020 09:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200705211016.15241-1-f4bug@amsat.org>
 <20200705211016.15241-3-f4bug@amsat.org>
 <CAKmqyKOcc=recN5dpsMUZRq9FkU2Kj0-AbmxGTOSpY=yxOEF-Q@mail.gmail.com>
 <68b27cb4-145b-47ed-bbed-428c7591f8c7@amsat.org>
 <CAKmqyKPGXzRYBTaV7JXuKOmXsez5oHWa23mJ7HDKiBuKvdLjRA@mail.gmail.com>
 <e4071f70-6e13-dcd1-cb90-c4fa7b46cfc5@amsat.org>
In-Reply-To: <e4071f70-6e13-dcd1-cb90-c4fa7b46cfc5@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Jul 2020 08:57:07 -0700
Message-ID: <CAKmqyKO76fFi8Tc0=rfKUS5YJPNC6Vak85yJbSiU68hMVgPLXA@mail.gmail.com>
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 6, 2020 at 7:06 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> On 7/6/20 8:32 PM, Alistair Francis wrote:
> > On Mon, Jul 6, 2020 at 11:04 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> >>
> >> On 7/6/20 6:19 PM, Alistair Francis wrote:
> >>> On Sun, Jul 5, 2020 at 2:10 PM Philippe Mathieu-Daud=C3=A9 <f4bug@ams=
at.org> wrote:
> >>>>
> >>>> The 'card is readonly' and 'card inserted' IRQs are not wired.
> >>>> Add a comment in case someone know where to wire them.
> >>>>
> >>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>>
> >>> I'm not convinced adding fixmes or todos in the code is the right
> >>> direction. It would be better to file bugs or use some other more
> >>> official tracking mechanism.
> >>
> >> This code is orphan :S
> >>
> >> I'll fill a launchpad bug ticket.
> >
> > I also mean in general (you have some other patches that add TODOs or F=
IXMEs).
>
> Not all developers look at launchpad, while all of them read the code ;)

Good point.

>
> $ git grep -E '(TODO|FIXME)' | wc -l
> 1899
>
> For orphan code, a comment in the code might be better to remember
> the technical debt to the next developers interested to rework this
> piece of code (I'd rather not trust they'll dig in the mailing list
> archive and launchpad tickets while staring at the code).

Agreed. I guess this is fine then. If possible/applicable a log
message would be more helpful.

Alistair

>
> >
> >>
> >> OTOH we could also log UNIMP for lost IRQs (triggered but
> >> no handler registered).
> >
> > That would also work.
> >
> > Alistair
> >
> >>
> >>>
> >>> Alistair
> >>>
> >>>> ---
> >>>>  hw/lm32/milkymist.c | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> >>>> index 469e3c4322..117973c967 100644
> >>>> --- a/hw/lm32/milkymist.c
> >>>> +++ b/hw/lm32/milkymist.c
> >>>> @@ -87,6 +87,7 @@ static DeviceState *milkymist_memcard_create(hwadd=
r base)
> >>>>      dev =3D qdev_new("milkymist-memcard");
> >>>>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> >>>>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> >>>> +    /* FIXME wire 'card is readonly' and 'card inserted' IRQs? */
> >>>>
> >>>>      return dev;
> >>>>  }
> >>>> --
> >>>> 2.21.3
> >>>>
> >>>>
> >>>
> >

