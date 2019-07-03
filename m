Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67D9C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6C1218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXPOGxja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6C1218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hinCw-0002UA-Et
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 17:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38780)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marlies.ruck@gmail.com>) id 1himX8-0007kN-AA
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marlies.ruck@gmail.com>) id 1himX6-0008Ll-PK
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:11:18 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:44662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marlies.ruck@gmail.com>)
 id 1himX5-0008Ic-ST
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:11:16 -0400
Received: by mail-io1-xd42.google.com with SMTP id s7so8236874iob.11
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 14:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FIBgkNMuS9WBSFnNTVA2oFYZ9kIFylQR6qM1JudMkmc=;
 b=CXPOGxjaDKwFRxtHvQOTouHZsKSqB+Oy7zbHqCOQe2tM23fFE60YxpgBPH1q+zr4tu
 PUa+BMZO6ILAh3kDlNU6DLaaH7zSJK/9jSFN9SGK9olEEYbcZsSpccPNMwJo5J12s6+k
 Pw/ybR+4IpCW45YX3+yHileGOuxE5UeW0aPB0Eb0wQ+kmc8M5JWgB9oWOBgA3OE9nv+B
 XzpJ1Kuf5BtgPzfXsUC/+DZB8QEXp+uKivmS4DuWs7zxcHtxUjqy/nQw+wrbTpGuvPwt
 tEl8X/AioUM0woXp9SFrNE0BjEmCQu4/jLLGwHy9dGD39ZhYdlxeEjZiz1G0NTpNiMby
 IlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FIBgkNMuS9WBSFnNTVA2oFYZ9kIFylQR6qM1JudMkmc=;
 b=VxXP67uznRBidIllWBvATkzIzq3I5tbvGj78O4/5KEf5xOp0VpCBjLlqWZYPkqFd96
 lc2WnxmKjwsO77XYCWxtp+SNgjOXDLNvNu3o5mzMdbzEsvXFZkpCV/THy3KrTo0/A2NF
 ly/IBW69oLz/oUBcefZyqFNUzMMepdAAogEmRw7HkYq0Im90ZF3UEdJFwfq8wuhkYsyc
 vrLHGOErxlvs2zrEcq/k8xZ06kYMe7cbzK6hIzSllaAXu++ihXZRKOSp1te+ouL+AAki
 5HiosGSlnglKhK9A6Q7ONPQ4mljuh13bn9WY8ucCBGlGeB2nZnTd/phxqe+z3auMmPH0
 loMA==
X-Gm-Message-State: APjAAAXYwILc28D+1QeLwd0+ENOYiGAxwZfypFNCoeIipGB5Jtit6dqc
 erYwPgWCQ9CwWQD4g6LxMmjv170qqvKcwnWqk3U=
X-Google-Smtp-Source: APXvYqywkHuA5aNgyE36c9MmR2igQKDZyeSlqN4iwH+ZEryTDXvteMbIUeFvXTt+Y3U8iQ7+ctWF6O0WBQcPpCUcce4=
X-Received: by 2002:a5d:860e:: with SMTP id f14mr7739514iol.242.1562188272508; 
 Wed, 03 Jul 2019 14:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <CALw29ZZZ08Lt13oZsbZCwV+uP0roLuT6t+8m16y+8YT-KH4t7A@mail.gmail.com>
 <CALw29ZbiqpGFOGHOP_7K2DvAfap_xE+PWAfXvvr35eK7aKn-dA@mail.gmail.com>
 <e3282346-166b-ef37-b874-2c2625cf31c1@redhat.com>
 <CAFEAcA-ZVGq1bD4+fu2+7GOVq_nBXBy8h31AY-0=i2ixnvvRnQ@mail.gmail.com>
 <CALw29Za+za-Pncr5esvnaNU8C3dx6Jws+jSbJAPJ0fSc50NotA@mail.gmail.com>
In-Reply-To: <CALw29Za+za-Pncr5esvnaNU8C3dx6Jws+jSbJAPJ0fSc50NotA@mail.gmail.com>
From: Marlies Ruck <marlies.ruck@gmail.com>
Date: Wed, 3 Jul 2019 14:11:01 -0700
Message-ID: <CALw29ZZS+CzCDNCR4DLZb4j=3KX4dzxKk3JdUZGUXUeJn0hW0w@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and SIGRTMAX - 1
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Just wanted to follow up to see what your thoughts are.  Is it preferable
if I submit a PR to the Go runtime first?  That would mitigate concerns
about Go breaking on QEMU with this patch.

Thanks,
Marli

On Mon, Jul 1, 2019 at 3:04 PM Marlies Ruck <marlies.ruck@gmail.com> wrote:

> Hi All,
>
> You are correct, this would break Go binaries.  I was planning on
> submitting a PR to the Go runtime if my patch was accepted to QEMU.  The =
Go
> PR would ignore the failure to register a handler for SIGRTMAX - 1, just =
as
> it currently ignores the failure on SIGRTMAX (
> https://github.com/golang/go/blob/master/src/runtime/os_linux.go#L443).
> Does this seem reasonable to you?  My local set up has these patches to
> QEMU and Go and it allows me to run both Go guest programs, and guest
> programs that use SIGRTMIN + 1.
>
> Also, thank you Peter and Phil for your patience as this is my first time
> contributing to QEMU.  If you decide to use this patch, I'm happy to rese=
nd
> the patch via `git send email`.
>
> Thanks!
> Marli
>
>
>
> On Mon, Jul 1, 2019 at 2:08 AM Peter Maydell <peter.maydell@linaro.org>
> wrote:
>
>> On Sat, 29 Jun 2019 at 11:53, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
>> wrote:
>> >
>> > Hi Marlies,
>> >
>> > On 6/29/19 1:26 AM, Marlies Ruck wrote:
>> > > Hi,
>> > >
>> > > I just wanted to follow up since I sent this patch a week ago to mak=
e
>> sure
>> > > it was a received.  An ack would be appreciated.
>> >
>> > You did not Cc'ed the maintainer, so he likely missed it.
>> > See:
>> >
>> https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer
>> >
>> > $ ./scripts/get_maintainer.pl -f linux-user/signal.c
>> > Riku Voipio <riku.voipio@iki.fi> (maintainer:Linux user)
>> > Laurent Vivier <laurent@vivier.eu> (reviewer:Linux user)
>> >
>> > BTW you should also look at the next paragraph in this wiki page:
>> >
>> https://wiki.qemu.org/Contribute/SubmitAPatch#Do_not_send_as_an_attachme=
nt
>> >
>> > Since you credit Peter Maydell, it would be kind to Cc him too.
>>
>> I have a strong suspicion that if we applied this patch it would
>> break running a pile of Go binaries that currently work, which means
>> it's something we need to be cautious about. (The Go runtime special
>> cases the fact that when it tries to register some signals they don't
>> work, but will abort on startup I think if it can't register a handler
>> for SIGRTMAX-1, which will be the case after this patch.)
>>
>> thanks
>> -- PMM
>>
>
