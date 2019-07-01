Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7130DC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 23:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2938021479
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 23:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDgsHCKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2938021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi5eG-0004X1-Af
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 19:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36626)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hi3gk-0006Jo-K0
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hi3ge-0003De-1h
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:18:10 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hi3gd-0003D0-Qs
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:18:07 -0400
Received: by mail-oi1-f194.google.com with SMTP id w7so11181350oic.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Kw48ScaWuU9s3mp6kMG3+Y6kpLvawE+2GHH9HizGFxI=;
 b=IDgsHCKRAxyM6JOBnj+AWY6fFpBDPDgrRhvgMdjPY9UgkUhMlatNOsEVI4z1byj+R8
 QQ35Ea0TNA80qAZ1E6103K3u2jK60rsngHlQaghuu/bG6ZHXsiazBL/pGbmQKQvLOXkh
 8kYcSlfIA9NTL/99W2frdFQjO7B1Y/+9p2iEHmgv4QEiPR6Y0j7mlHEbambuvsqP6W/e
 M7uLN+y7CT0YSo4cFYqFfjlMaqoc3aqyJOOzrk9nicCzFgFfAMsHRv6BYgh0G/32Ta5k
 zhPeBSAtAR2QLe9NC+Hui9n0bjEADX+T6ltuOEe/LX8+N/0igzUDVMwC54boJ7NvD85R
 BFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Kw48ScaWuU9s3mp6kMG3+Y6kpLvawE+2GHH9HizGFxI=;
 b=FOUvmMyUZmu+GQs8ZlPxDVB91SI1S5ZnqCjKjKQisFTxC2uZ2AwpvdRCgfiX5oM1Xb
 XGTqBxbCVnu44o32d00UwMR2VokJ+BMWQVb/T66FLR4pwimiOpJk7koDp7lRsMt0hL6V
 whGtsh3YyPtjih+iBCx6gxl35ZzhfRgAEjNK6+NCGu8hMU901XTIfGCKL0WXV+wdb0B8
 lDQX168PJLMiA+3788iUEDFBtyOOvMppHN5kuew+/mcNGgI+qSUjzYJPRscUf1gJTxY3
 KFJuX3Ravr2v6RBcc3Oy1gibNgtlIo0yerUbIjhy5LFPF1yZTNQQNd9o7cFAwIjw/e37
 aw0w==
X-Gm-Message-State: APjAAAWpwFsuT85oPH/qVjm6OkQ+Zh0S+hEON6grUiomWnUMjovsBeQo
 DnjQVIZC3Uo3TGQ9wovYaLTMQw8kyE2OWWmGIzD/Hw==
X-Google-Smtp-Source: APXvYqyYKPThMOFPvNDErLWmsRLquDx+ljTN/z8HDEdniU3bzB4Jptn/5ZcfDidxPRhy23L1gLh8Brk9+9aybTKEUIE=
X-Received: by 2002:aca:4083:: with SMTP id n125mr446582oia.106.1562006351521; 
 Mon, 01 Jul 2019 11:39:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 1 Jul 2019 11:39:10 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 1 Jul 2019 11:39:10 -0700 (PDT)
In-Reply-To: <8ad999d7-fec4-079f-dbed-454afe127899@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
 <CAL1e-=iLAKe+FunE2p9L3Ds8fPS2a8nf3hc=ga7CX6E2bjw0Uw@mail.gmail.com>
 <8ad999d7-fec4-079f-dbed-454afe127899@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jul 2019 20:39:10 +0200
Message-ID: <CAL1e-=h1=rNGC5quvmaOuNohXO60b=tiFEznMr11a3Asj9zgMg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.194
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 00/10] hw/pci-host: Clean the GT64120 north
 bridge
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 1, 2019 7:46 PM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> wro=
te:
>
> Hi Aleksandar,
>
> On 7/1/19 7:16 PM, Aleksandar Markovic wrote:
> >
> > On Jun 25, 2019 12:31 AM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.or=
g
> > <mailto:f4bug@amsat.org>> wrote:
> >>
> >> Hi,
> >>
> >> This series clean the gt64120 device.
> >> It is no more target-dependent, and tracing is improved.
> >>
> >
> > If nobody objects, I am going to select majority of the patches for mip=
s
> > queue scheduled tomorrow. Those that remain will be those that Philippe
> > still didn't make his mind.
>
> Which ones remain?
>
> For "pci-host/gt64120: Clean the decoded address space", I'd like a
> review from someone comfortable with MEMTXATTRS and address spaces.
> I'll ping on the patch.
>

Don't worry, the addres space one was left for later.

Sorry for confusion, but these patches are already in main tree (this is
from today):

Philippe Mathieu-Daud=C3=A9 (7):

hw/mips/gt64xxx_pci: Fix multiline comment syntax

hw/mips/gt64xxx_pci: Fix 'tabs' coding style issues

hw/mips/gt64xxx_pci: Fix 'braces' coding style issues

hw/mips/gt64xxx_pci: Fix 'spaces' coding style issues

hw/mips/gt64xxx_pci: Use qemu_log_mask() instead of debug printf()

hw/mips/gt64xxx_pci: Convert debug printf()s to trace events

hw/mips/gt64xxx_pci: Align the pci0-mem size

Let me know if you want more for tomorrow, otherwise I won't do anything.

Amicalement,
Aleksandar

> > Thanks thousand times, Philippe!
> >
> > Aleksandar
> >
> >> Regards,
> >>
> >> Phil.
> >>
> >> Based-on: 20190624220056.25861-1-f4bug@amsat.org
> > <mailto:20190624220056.25861-1-f4bug@amsat.org>
> >> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05304.html
> >>
> >> Philippe Mathieu-Daud=C3=A9 (10):
> >>   hw/mips/gt64xxx_pci: Fix multiline comment syntax
> >>   hw/mips/gt64xxx_pci: Fix 'tabs' coding style issues
> >>   hw/mips/gt64xxx_pci: Fix 'braces' coding style issues
> >>   hw/mips/gt64xxx_pci: Fix 'spaces' coding style issues
> >>   hw/mips/gt64xxx_pci: Use qemu_log_mask() instead of debug printf()
> >>   hw/mips/gt64xxx_pci: Convert debug printf()s to trace events
> >>   hw/mips/gt64xxx_pci: Align the pci0-mem size
> >>   hw/mips/gt64xxx_pci: Add a 'cpu_big_endian' qdev property
> >>   hw/mips/gt64xxx_pci: Move it to hw/pci-host/
> >>   hw/pci-host/gt64120: Clean the decoded address space
> >>
> >>  Makefile.objs                                 |   1 +
> >>  include/hw/mips/mips.h                        |   2 +-
> >>  hw/mips/mips_malta.c                          |   8 +-
> >>  hw/{mips/gt64xxx_pci.c =3D> pci-host/gt64120.c} | 542 ++++++++++-----=
---
> >>  MAINTAINERS                                   |   2 +-
> >>  hw/mips/Makefile.objs                         |   2 +-
> >>  hw/mips/trace-events                          |   0
> >>  hw/pci-host/Makefile.objs                     |   2 +-
> >>  hw/pci-host/trace-events                      |   5 +
> >>  9 files changed, 307 insertions(+), 257 deletions(-)
> >>  rename hw/{mips/gt64xxx_pci.c =3D> pci-host/gt64120.c} (68%)
> >>  create mode 100644 hw/mips/trace-events
> >>
> >> --
> >> 2.19.1
> >>
> >>
> >
