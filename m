Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB7BC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086632133D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="uDPhRueM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086632133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45442 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtFg-0006w9-4s
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:05:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDt5v-00086y-BF
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDt5t-0004i2-MT
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:31 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:39007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDt5t-0004fw-2n
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:29 -0400
Received: by mail-it1-x144.google.com with SMTP id 139so5733265ita.4
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=0gqBrNUBN17mN32Poegd2PM0Plcs43VygO+lKXAYAhM=;
	b=uDPhRueMIbQytScEK4U1AaxIwH/ms+6MnG0Ymr5d6l0pXKV7SucMSMLZpKd6V6KEIQ
	AhImCnscpfv5FYelmKhMqprlhSDnDGj8m8Bkp2l8uBoIKoL92WuRc0t7jac05+tUbUZC
	yYWzke15Mg4/anhfDkk8qilnbQVbZ05JepkpZvwwra/GN968yrU3kVyMh+TL6/KuuSWu
	FVJicvo3JKdVtfh6bDnbFPSg1IytRX/Jr9ZGFwnDjoCGxbGwQunDachLwo/AnYGdG/ME
	0zUzc1TD9P4fhxAssCZb/Cm25mKryd1wkzRqLpZrUk0/RGlGiMgY2rZjndhgk+nIO/Un
	oBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=0gqBrNUBN17mN32Poegd2PM0Plcs43VygO+lKXAYAhM=;
	b=RRjvxhFvzQOI8hDvYfcZEMHeWOxI/D3mjTChoX+6OcTV7qMA+ceEWfBddpSUd1yVnm
	tpLE5z/iWuaR0VFh43kEq2BfRQmiiHRS1Lj+LiiK5vE0Bo4sftSjBTsWEL2yWl6gjDH3
	lVvCrzoNvMJbJhdzCwD0Qby9mgafgpLSdA6uJj4bmMloiIpGAtuWPv5llGmVdBxxlk+9
	uZNbsi0r3Behqe+f50woCXFLlXJiUb9+aLeKO+t5H5EEWOAEjl445S1KsobEN+FgYaQp
	c4iR13z21+aQlsXbsVBm+yA/NlcGeuFzosAVwTeaakv3Qmt3sraV8lEcvIewPWQXNXV3
	HzTg==
X-Gm-Message-State: APjAAAWQZqDSpCmgfqEgZHYEbIXtSZt8i7Zxef09pOXoAnlzt4PeecFz
	YCiob+Aj8dAkxi0nwHVZlt643w==
X-Google-Smtp-Source: APXvYqwz2mbVMd8B8tnWgybVOc5/2SWBYuIM01zTWI/+Tfg6Kz6npZ8+dH4lMSxOUNNCymgn1GmOaA==
X-Received: by 2002:a24:254c:: with SMTP id g73mr25203396itg.77.1554825327554; 
	Tue, 09 Apr 2019 08:55:27 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	u26sm12798396iob.78.2019.04.09.08.55.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 08:55:27 -0700 (PDT)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <6cf20899-f643-950b-37b9-dcc47df0d72e@redhat.com>
Date: Tue, 9 Apr 2019 11:55:25 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C484463-F00B-4EC0-9272-DC23CEE8F376@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<6cf20899-f643-950b-37b9-dcc47df0d72e@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409155525._nz6pWhsSPEko0p0JzOiuUx_Fg7CzRS24kRKnEzlHtQ@z>

Hi Phil,

> On Apr 9, 2019, at 06:34, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> Hi Stephen,
>=20
> [Cc'ing Markus and Laszlo, we have similar interest in pflash01 =
testing]
>=20
> On 4/8/19 10:55 PM, Stephen Checkoway wrote:
>> The goal of this patch series implement the following AMD command-set =
parallel
>> flash functionality:
>> - flash interleaving;
>> - nonuniform sector sizes;
>> - erase suspend/resume commands; and
>> - multi-sector erase.
>=20
> I am very glad you addressed these long overdue issues and very =
pleased
> by your patches :)
> I'll thoroughly review it during next week (this won't get merge for =
the
> current 4.0 cycle anyway).

Great!

> I started a similar cleanup (mostly pflash01 focused) and converted
> DPRINTF to trace events, added few constants. I'll see if I can rebase
> your work on top of mine. So far only your patch 2 (refactor) would be
> modified, simplified as the "pull out all of the code to modify the
> status into simple helper functions" part (which else I'd ask you to
> move in a separate patch).
>=20
> We should think of more intereleaved tests, I'll prepare a table of
> current QEMU models using this device and how is their intereleave
> mapping. Hopefully it would be enough to simply add the existing
> machines to your current musicpal qtest.
>=20
> Also I'd like to see some Top/Bottom block configuration qtests, your
> patch #5 doesn't seem tested.

I included four tests =
<https://patchew.org/QEMU/cover.1554774454.git.stephen.checkoway@oberlin.e=
du/bbe417c354dfa908d5e1bc8f8ad7121ec9451682.1554774454.git.stephen.checkow=
ay@oberlin.edu/>.

Patchew makes it hard to link to particular lines. Here's the same patch =
on Github =
<https://github.com/qemu/qemu/commit/a851d21347121a91ba9a39c133a8fbee6e84e=
557#diff-d2ed797ca8898de80768bdfb390781dfR498>.

Are those sufficient or would you like more tests?

>=20
>> During refactoring and implementation, I discovered several bugs that =
are
>> fixed here as well:
>> - flash commands use only 11-bits of the address in most cases, but =
the
>>  current code uses all of them [1];
>> - entering CFI mode from autoselect mode and then exiting CFI mode =
should
>>  return the chip to autoselect mode, but the current code returns to =
read
>>  array mode; and
>> - reset command should be ignored during sector/chip erase, but the =
current
>>  code performs the reset.
>>=20
>> The first patch in the series adds a test for the existing behavior. =
Tests for
>> additional behavior/bug fixes are added in the relevant patch.
>>=20
>> 1. I found firmware in the wild that relies on the 11-bit address =
behavior,
>>   probably due to a bug in the firmware itself.
>=20
> Is it a musicpal firmware? Are you able to compare with real hardware?

No, it's not musicpal. I'm not even sure what musicpal is, it was just =
the most convenient choice for testing.  The real hardware is an =
embedded system using an old AMD processor (Am486) with three different =
AMD command set flash chips. The unlock addresses the firmware uses =
don't actually match the part sheets (in most cases). It took quite a =
while to realize that the flash hardware only uses 11 bits of address. =
(It's clearly spelled out in the various part sheets, but I guess I =
missed it on the first 15 or so readings.)

> I vaguely remember some issue regarding address bus width when trying =
to
> implement the TopBlock small sectors, but I wasn't using the musicpal.
> I'll see if I can find my old notes and test with your series.

The one boot chip I'm using is the AM29F080B-90SI with top boot blocks. =
It has an 8-bit address bus.

--=20
Stephen Checkoway






