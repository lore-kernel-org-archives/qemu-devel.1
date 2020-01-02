Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB61C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 13:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567592072C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 13:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FZkd9scg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567592072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in0kF-0004f3-Hz
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 08:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Jason@zx2c4.com>) id 1in0jX-00049w-L5
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 08:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Jason@zx2c4.com>) id 1in0jW-0002Zb-8l
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 08:41:51 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:58305)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Jason@zx2c4.com>) id 1in0jW-0002ZF-1u
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 08:41:50 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 3d035529
 for <qemu-devel@nongnu.org>; Thu, 2 Jan 2020 12:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
 :references:in-reply-to:from:date:message-id:subject:to:cc
 :content-type:content-transfer-encoding; s=mail; bh=tU2OvsITZVwt
 laXAdpCvi5ZghAM=; b=FZkd9scgohjTFIwaVAd6NItW5feZHmmvGJ7ELXPxJO1y
 5RwPHUjLRYP+xY+RiDmqJmONz6tMvfpUS49MEHWzjdIt+ilezAKXKJ8FvDaFVG/W
 UqLHPFIoXLYofWDq8bwWO1F4z20Qk5Bmz5cEAX772smQsR1TiCV4RhMIIjlJiVfk
 pvafiR7WaOHsO8veWKoaxoVTiFauKymAUbjinlp3s/kKDccHkIGQ1Vh960B/Fdm5
 Bcbs6Y3mLp+Lw8abIgR3oUOaKwvfS1GJAlefEkv6GHhwLRkF21lANa7kyYUQLm07
 W/4LuU0eWxYSlGapWstFYhrAWjlhUPLhMkoehw2caA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 442330ca
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
 for <qemu-devel@nongnu.org>; Thu, 2 Jan 2020 12:43:18 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id p8so20688386oth.10
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 05:41:48 -0800 (PST)
X-Gm-Message-State: APjAAAVVLLw9KM11Ac8bHdHhT1OhD0017yHkNryJl5FTRItY/l5h4ZG5
 v4ka0mJNuOWBMjNiNt38E3FMPOx8bM3/YNlDCPg=
X-Google-Smtp-Source: APXvYqzOu/OEiiAq5193Yd23HoRn6Gqn9Qwy9Ur+eMdEgpYHjS3VHoMapHWOygXrCPcg7kqQCg9yC3puh/FTdK9QeRE=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr77912434otm.52.1577972507900; 
 Thu, 02 Jan 2020 05:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20200102103644.233370-1-Jason@zx2c4.com>
 <60efe91c-af82-f6d7-36c5-c603971c2f33@vivier.eu>
 <d3eb847b-a6b9-4ac7-3c06-576686cca608@vivier.eu>
In-Reply-To: <d3eb847b-a6b9-4ac7-3c06-576686cca608@vivier.eu>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 2 Jan 2020 14:41:37 +0100
X-Gmail-Original-Message-ID: <CAHmME9qiPypd6U46Of+1YrU6ORerqEBPZ_T+ieqBv6C6StyHvw@mail.gmail.com>
Message-ID: <CAHmME9qiPypd6U46Of+1YrU6ORerqEBPZ_T+ieqBv6C6StyHvw@mail.gmail.com>
Subject: Re: [PATCH] q800: implement mac rom reset function for BIOS-less mode
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 192.95.5.64
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 2, 2020 at 12:41 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 02/01/2020 =C3=A0 12:10, Laurent Vivier a =C3=A9crit :
> > Le 02/01/2020 =C3=A0 11:36, Jason A. Donenfeld a =C3=A9crit :
> >> On Linux, calling `reboot(RB_AUTOBOOT);` will result in
> >> arch/m68k/mac/misc.c's mac_reset function being called. That in turn
> >> looks at the rombase (or uses 0x40800000 is there's no rombase), adds
> >> 0xa, and jumps to that address. At the moment, there's nothing there, =
so
> >> the kernel just crashes when trying to reboot. So, this commit adds a
> >> very simple implementation at that location, which just writes to via2
> >> to power down.
> >>
> >> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >> ---
> >
> > There are two cleaners solution to do that:
> > 1- catch the jump to the ROM address in QEMU and shutdown the machine, =
see
> >
> > https://github.com/vivier/qemu-m68k/commit/51cd57d1128059819038b9800455=
fbf794430c15
> >
> > 2- or as you do, write a fake ROM but use the VIA2 port B bit 3 to
> > shutdown the machine see hw/misc/mac_via.c mos6522_q800_via2_portB_writ=
e().
>
> OK, 2 is what you do, so I think we can take this.
>
> The assembly code is correct but not easy to read, could you use defined
> values (VIA_BASE) and add some comments?
>
> I think we don't need the BI_MAC_ROMBASE: in fact MACROM_ADDR is wrong,
> you can change its definition to 0x40800000.
>
> Thanks,
> Laurent

I've addressed your comments and submitted v2.

