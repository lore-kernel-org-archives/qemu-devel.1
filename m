Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54702C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA5C205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7qLZWd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA5C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi4dZ-0008Jl-6B
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 18:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58566)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hsp.cat7@gmail.com>) id 1hi3ZR-0001pr-9H
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1hi3ZE-0007k0-6c
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:10:32 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33169)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1hi3ZD-0006tM-RR
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:10:28 -0400
Received: by mail-oi1-f195.google.com with SMTP id u15so11046499oiv.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SDn2hXn3wvxwD7zacLCJjcs8TDhqjr3MNBApJ17qUvk=;
 b=G7qLZWd2Rumc/JDRnXIM2OCG7+HvBldqXI9P/7p+2wesFnibwVIKyfIt4QQcH1URSL
 eDLcT8uwD8JodQoaLHLilx/Io9OMN1fqYnf2228W4XYtc6OBW06miaiForCkNsGD5sJM
 yVDhLsBZb838k3ygmwvLAL2uApgjSSND1eGK6eN79l5Yx4ftBOkFnBtBLi43nlehsPvv
 0kVk52sVdJmPTSa1BbBHtwTbjaC/guGpvjCdO511yT2jcHtiyygBQqLuir05z+HHbWpY
 lilg+m0sAX/+P0FXNnm1qI0ORLPD5Y57mxH9ZjMTCeQFyx29Pb8qE4qs03W5tUPdZ0Iu
 /0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SDn2hXn3wvxwD7zacLCJjcs8TDhqjr3MNBApJ17qUvk=;
 b=QwzSh2TFnnWLAVLllvLpi4blRDVUx3ZrWUjXT3o5teDmk/eaDjAncxUev6kKtzQwcB
 BRrj4lqYU+H2xjFfD/YOOEw/JHLNqddKQzfb2FgE5tUEd8pKG/GlZEDCLWAHJx7J1hBD
 f9gWix6lTmwGG/usFyiBrIkED2N7PdPkStCpYAvoUfK/L/YVjK23u+RVNoGwXKTKLSWP
 PMWYwyz39/UNtacT7SXzvNACL+NfyxjkoXDLleTLtH+mVF5elT5EzPk78xp3L/65sjJy
 OlQSuUSBXteqxHb1XS3+AOprs8F9b7r00PeGdkVphFIW3Du5ChRqAnTPq5YNWd/8lWSC
 akOA==
X-Gm-Message-State: APjAAAWxj69b4+GWCknFDRtXywBGaHhwBNpNsmCeMaCZeK3+32o+n57l
 VD2+5JTscqTbrk6Iy6cJUClRCAgfUQWeMeuDGOCVrFqi
X-Google-Smtp-Source: APXvYqxNlHpM1XDRNiYYfbFION72gwagngDoz6HvkkLTrL9jDPha0HpevEUlsplG2U6mNEV8CZAQxmmq+Ueovp+7YRw=
X-Received: by 2002:aca:b104:: with SMTP id a4mr466163oif.14.1562006088017;
 Mon, 01 Jul 2019 11:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <5746cc58-c132-ef29-6ff4-da07c6086dac@ilande.co.uk>
 <3fe632b7-e83c-9b26-9338-1d7a9c881e0d@linaro.org>
In-Reply-To: <3fe632b7-e83c-9b26-9338-1d7a9c881e0d@linaro.org>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Mon, 1 Jul 2019 20:34:36 +0200
Message-ID: <CABLmASFUnBnn2DZidKFAiaMb7gExYttgvEv12uce9EPi6NL9Qw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.195
Content-Type: text/plain; charset="UTF-8"
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 1, 2019 at 12:30 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/30/19 7:58 PM, Mark Cave-Ayland wrote:
> > I don't have space for a full set of images on the G4, however I've
> tried boot tests
> > on installer CDs for MacOS 9, OS X 10.2, Linux and HelenOS and it looks
> good here.
> >
> > Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> [PPC32]
>
> Thanks!
>
> Hi

I just compiled the v6 set applied to current master on my G5, Ubuntu 16.
command line:
./qemu-system-ppc -L pc-bios -boot c m 512 -M mac99,via=pmu \
-netdev user,id=net1 -device sungem,netdev=net1 \
-drive file=10.3.img,format=raw,media=disk \

With no specific cpu set, Mac OS 9.2 hard disk image and 9.2 iso do not get
to the desktop, they just hang while still in the openbios window. They
need -cpu G4 on the command line to get to the desktop.

OSX 10.3 installed image boots to desktop.
OSX 10.3 iso boots to installer
OSX 10.4 installed image boots to desktop.
OSX 10.4 iso boot to installer
OSX 10.5 installed image boots to desktop.
OSX 10.5 iso boots to installer

So there seems to be a difference between hosts: If ran on a G4 host there
is no need to add -cpu G4 to run Mac OS 9.x, while there is when ran on a
G5 host.

Best,
Howard
