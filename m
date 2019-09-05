Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5ADC3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 11:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1AA20870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 11:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0rPzfm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1AA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5qBG-0002Ys-Dn
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 07:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i5qAP-00025a-7z
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 07:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i5qAN-0005Zc-99
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 07:43:09 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i5qAN-0005ZP-43
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 07:43:07 -0400
Received: by mail-ot1-x344.google.com with SMTP id n7so1836083otk.6
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 04:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=cSdKaHFuB5dbLe4H5RKqkHFPXHCLLXUvf1glSkBSrCk=;
 b=X0rPzfm5WZAYhGB3dx2AHzh80IAHozHApFEkFc2v80FctVHnfVxzl8al9KjI3Nd8/D
 8alpkeGcuronYFfhayByLnz8bzfnKstEofWpkEMTjgl30df/DtTU0yY0a61fXkdrKf6V
 fwe6+TAWhQIwtSTRy0D+fmlQogFzMePFgSNSMPIgcMYfIqkMZzaOXERDToLX4SIOdlhw
 RaqhoAKkCJi/DCRxP5GCKVsKJ7BzXtxGYp+uc2Gn1FsXq6OR894qneO7DJVX0dhjlPWi
 cXrA//rgaulpxM2vAhcgjcz+zBHuhAoTDisMn2iSa4hyWR+biYUmKX2ndIh+JIa8XSH3
 /zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=cSdKaHFuB5dbLe4H5RKqkHFPXHCLLXUvf1glSkBSrCk=;
 b=nx5UGgfm1VuYzKrygH9n1HP773Z2KayCbAPTALK9/nh5+HDbwQoZ4wfnQL3Za4IkK+
 myr+YyyEW85ndgYj13yMqieioqnBzc6K0sgwyOUZspF563kbOqGkPvsW62VWxqheomsh
 EPRYMAq7j2bB74zeDtBgfVSiNA4WMAiJcjcfl0wEvGsqw31TE194Hxrl1iWxz60nKFcu
 xWNBlNIXLLeZcthurJ160oBLxwUaWrqsz9b1a96zdpsarWcVSYJKy7CTtsItm9S7Du5P
 rCKElTlpeWpJZ7pTMkchFBblUN1nWNp+aZy7flneuQkvEvtOrV29VrKCLyw+B5BYZp0Q
 5PbA==
X-Gm-Message-State: APjAAAVDeIQPiKdZcjP8gEJaw/umPjSkWeorLfjtsaoHesiI4afBMqkE
 r/Mh8KgsbAxDQS2GNzqsu19qHeP86xKCOWqmiuI=
X-Google-Smtp-Source: APXvYqz25qRDm8XgLvXhnsV6rUvFxUtWRnS3keYTdMm+KSanzyNdHuALictjplgUa/ewJnYT3a2I2iZXox4wurVreeI=
X-Received: by 2002:a9d:7989:: with SMTP id h9mr1570314otm.295.1567683786229; 
 Thu, 05 Sep 2019 04:43:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Thu, 5 Sep 2019 04:43:05 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Thu, 5 Sep 2019 04:43:05 -0700 (PDT)
In-Reply-To: <db28c297-290b-3641-d87a-67fde65312a8@ilande.co.uk>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <5746cc58-c132-ef29-6ff4-da07c6086dac@ilande.co.uk>
 <3fe632b7-e83c-9b26-9338-1d7a9c881e0d@linaro.org>
 <CABLmASFUnBnn2DZidKFAiaMb7gExYttgvEv12uce9EPi6NL9Qw@mail.gmail.com>
 <f1eeb1de-a6e7-bb83-3501-705382da4b14@ilande.co.uk>
 <CAL1e-=gtgzRHzZyX9r69_zB5-v-ThYeuxBameoF12TBs59M95w@mail.gmail.com>
 <db28c297-290b-3641-d87a-67fde65312a8@ilande.co.uk>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 5 Sep 2019 13:43:05 +0200
Message-ID: <CAL1e-=ibwvMWj3T8iPAyDqhsRTnxUZPxhos6BaVoOtbTWO9WPg@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v6 00/16] tcg/ppc: Add vector opcodes
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping for Richard

03.09.2019. 20.34, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 03/09/2019 18:37, Aleksandar Markovic wrote:
>
> > On Tue, Sep 3, 2019 at 7:05 PM Mark Cave-Ayland <
> > mark.cave-ayland@ilande.co.uk> wrote:
> >
> >> On 01/07/2019 19:34, Howard Spoelstra wrote:
> >>
> >>> On Mon, Jul 1, 2019 at 12:30 PM Richard Henderson <
> >>> richard.henderson@linaro.org> wrote:
> >>>
> >>>> On 6/30/19 7:58 PM, Mark Cave-Ayland wrote:
> >>>>> I don't have space for a full set of images on the G4, however I've
> >>>> tried boot tests
> >>>>> on installer CDs for MacOS 9, OS X 10.2, Linux and HelenOS and it
looks
> >>>> good here.
> >>>>>
> >>>>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> [PPC32]
> >>>>
> >>>> Thanks!
> >>>>
> >>>> Hi
> >>>
> >>> I just compiled the v6 set applied to current master on my G5, Ubuntu
16.
> >>> command line:
> >>> ./qemu-system-ppc -L pc-bios -boot c m 512 -M mac99,via=3Dpmu \
> >>> -netdev user,id=3Dnet1 -device sungem,netdev=3Dnet1 \
> >>> -drive file=3D10.3.img,format=3Draw,media=3Ddisk \
> >>>
> >>> With no specific cpu set, Mac OS 9.2 hard disk image and 9.2 iso do
not
> >> get
> >>> to the desktop, they just hang while still in the openbios window.
They
> >>> need -cpu G4 on the command line to get to the desktop.
> >>>
> >>> OSX 10.3 installed image boots to desktop.
> >>> OSX 10.3 iso boots to installer
> >>> OSX 10.4 installed image boots to desktop.
> >>> OSX 10.4 iso boot to installer
> >>> OSX 10.5 installed image boots to desktop.
> >>> OSX 10.5 iso boots to installer
> >>>
> >>> So there seems to be a difference between hosts: If ran on a G4 host
> >> there
> >>> is no need to add -cpu G4 to run Mac OS 9.x, while there is when ran
on a
> >>> G5 host.
> >>
> >> Are there any outstanding issues with this patchset now, or is it
ready to
> >> be merged?
> >> I'm really looking forward to seeing the improved performance when
testing
> >> QEMU on my
> >> Mac Mini :)
> >>
> >>
> > Howard pointed to some illogical quirks of command line:
> >
> >> If ran on a G4 host there is no need to add -cpu G4 to run Mac OS 9.x,
> >> while there is when ran on a G5 host.
> >
> > I am not sure if Howard says that this is a consequence of this series
> > though.
>
> No, that has been an existing issue for a long time :)
>
> > Overall, I think this is a very good series - however, I had a number o=
f
> > minor
> > objections to multiple patches, that don't affect (or affect in a
minimal
> > way)
> > provided functionality - those objections are not addressed, nor
properly
> > discussed - but I do think they should be addressed in order to get the
> > series
> > in a better shape before upstreaming.
>
> I've had a quick look at some of your review comments, and certainly I
can see how
> the earlier revisions have benefited from your feedback. There has been a
lot of
> positive discussion, and Richard has taken the time to respond and update
the
> patchset over several weeks to its latest revision.
>
> AFAICT the only remaining issue is that related to the ISA flags, but to
me this
> isn't something that should prevent the patchset being merged. I can
certainly see
> how the current flags implementation may not be considered technically
correct, but
> then from your comments I don't see that it would be something that would
be
> particularly difficult to change at a later date either.
>
> The things that are important to me are i) is the patchset functionally
correct and
> ii) is it understandable and maintainable. I would say that the first
point is
> clearly true (both myself and Howard have spent a lot of time testing
it), and given
> that I had to delve into these patches to fix the R2 register issue on
32-bit PPC
> then I can confirm that the contents of the patches were a reasonably
accurate
> representation of the changes described within. And that's from someone
like me who
> is mostly still a TCG beginner :)
>
> From a slightly more selfish position as the PPC Mac machine maintainer,
these
> patches make a significant difference to me in that they reduce the MacOS
boot times
> during everyday testing. Now for someone like myself who works on QEMU as
a hobby
> outside of family life and a full time job, those few minutes are really
important to
> me and soon add up really quickly during testing.
>
> I would really like these patches to be merged soon, since the worst
thing that can
> happen is that the patchset ends up bit-rotting and then all the time and
effort put
> into writing, testing and reviewing the patches by Richard, Howard,
David, myself and
> indeed your review time will all end up going to waste.
>
>
> ATB,
>
> Mark.
>
