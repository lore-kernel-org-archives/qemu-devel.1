Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9398AC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 18:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECA22084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 18:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="az1hU0QR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECA22084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47215 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDv4Z-00034j-00
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 14:02:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDv2r-0001qI-UY
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDv2q-0000sG-RT
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:00:29 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDv2q-0000qq-EC
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:00:28 -0400
Received: by mail-io1-xd41.google.com with SMTP id x3so15087304iol.10
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=Z8lLfZiLcg6LEoesR38urw7MTigj4hb6aHy9NAQKqOE=;
	b=az1hU0QREPcUBB5soJkUpnX+9r1SHXqJqhCpoKWtCA9uq/EN3IeeYLJtsQQUAX3HzI
	hFFP9bDV2g+Lr/PFuUkBWWswNIG28cGB5fRIfQbugNnvvP8lp3bDXLwkxCLIdv0yOTkO
	ThYQzg5rcpzTAWBVlrZs4vsrYEGxWP/+OnfufLP4jHhUaYba/aeeknfUtzaZ6OKwxoBT
	Ex86NgRevAIW2RFnIxkqh5rOlgOoPyhMRDdUL2+Ps00IpC/oaJT1+FMUf8h1hfiHalqY
	6bz5DG2CMSLaZPbZ2kyp87hyz8/Xvbr+3ZnVXuy15ZsgR0n6Yj0T8NUuNTTkxREac8p5
	BS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=Z8lLfZiLcg6LEoesR38urw7MTigj4hb6aHy9NAQKqOE=;
	b=shsaQV84isassmNjuI8+w8JkEnf94hvKyVqYlrnSE1TFplYvgs5CvHMvHFsvGa3FGI
	T9ZC3W5MKBFF1Thgvpr0GGvoyh+2fZGs64U2LoXoSQu2OpfrY0YRCiIpa4/BtB6L8R3z
	vgQzjPb6TitcfpsozndnJqY3Or6FXpCyoBUEXhDBYhtyk7b5jXy6EZSYLKouHg1ocgmO
	VOO9RIfaH46yL8vrRy+qIfFiE1iJP+9x4yKi8AY0WBRCMpG/Uk5sJN7zufbz5XKR60Y4
	3893dBW1Z1eTpfjgp0bbVlcHsruzSRAYxi+mI8PxY3u8aDrwk4UjW1xJw+DBD77Iywlq
	bp8g==
X-Gm-Message-State: APjAAAWSFw61+/w8IVdU1P6i3Kb6KULH7s8ZeGRoRXeazTlurW+kRp9S
	m/Vx2HF2npEUlOHr2EQZIc/7dw==
X-Google-Smtp-Source: APXvYqz1C6dDC7IJvkyUc0ARl8WmNNmr5T4zx75cyMssYJTdSnUFsXXS8deb4r5vC5pOVmhcSlFVjQ==
X-Received: by 2002:a5d:85d5:: with SMTP id e21mr2765311ios.27.1554832827663; 
	Tue, 09 Apr 2019 11:00:27 -0700 (PDT)
Received: from ip-70-93.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93]) by smtp.gmail.com with ESMTPSA id
	m81sm7246254itm.33.2019.04.09.11.00.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 11:00:26 -0700 (PDT)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <0437475a-10ff-b8e0-3914-536a78f99b6e@redhat.com>
Date: Tue, 9 Apr 2019 14:00:24 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <625D0D17-9BBA-444F-8204-A182B04238EC@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<6cf20899-f643-950b-37b9-dcc47df0d72e@redhat.com>
	<5C484463-F00B-4EC0-9272-DC23CEE8F376@oberlin.edu>
	<0437475a-10ff-b8e0-3914-536a78f99b6e@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Subject: Re: [Qemu-devel] [PATCH 00/10] block/pflash_cfi02: Implement
 missing AMD pflash functionality
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409180024.NKSLTUcrg1g4I8zmwhLUk9KhNtz6SIGU1OZEf89ut-E@z>



On Apr 9, 2019, at 12:15, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:

> Since you did changes in the CFI table, I think we should add a tests
> verifying the table is correctly generated for all you FlashConfig =
entries.

That's a good idea. Some of the values are essentially arbitrary (e.g., =
how long an erase typically takes) but the CFI values that indicate =
support for erase/suspend and erase regions at least should be tested. =
I'll take a closer look at what all I changed (it has been a few months =
since I wrote the code). Are there any in particular you think I should =
be sure to test? Do you want me to add those tests to the appropriate =
patches in the series or would you like an additional patch that adds =
those tests? (The later is easier to do as modifying the earlier patches =
in the series are likely to cause conflicts with later patches that I'd =
need to resolve, but I can do either.)

> I suppose you can not share the firmware binary. Can you share these
> unlock addresses? Maybe once I reviewed carefully your series I might
> ask you the (pflash) trace event output.

I probably cannot share the binary but the unlock addresses are 0x1554 =
and 0x2AA8. This is for two interleaved x8/x16 chips in x16 mode so =
shifting right by 2 (1 for the interleaving and 1 because it's an x16 =
chip) gives 0x555 and 0xAAA. The appropriate (word) unlock addresses for =
the chips are 0x555 and 0x2AA which is what you get if you restrict to =
11 bits.

My guess is that the firmware authors took the byte unlock addresses =
(0xAAA and 0x555), shifted left by 2, discovered that this didn't work, =
tried the unlock addresses in the opposite order, and found that that =
worked due to the chips only looking at 11 bits.

Looking at hw/arm/musicpal.c, I see that it is using unlock addresses =
0x5555 and 0x2AAA. My guess is this reflects a bug in some firmware and =
it should be using 0x555 and 0x2AA. I haven't seen any AMD pflash chips =
that used other unlock addresses, but I've only looked at about a dozen =
part sheets and I'm not sure what chips the musicpal is actually using.


--=20
Stephen Checkoway






