Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609C8C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 22:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A89720663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 22:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBqh7pWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A89720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF3aV-0000iG-Ci
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 18:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1jF3Zt-0000J2-FI
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 18:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1jF3Zs-0001fL-1l
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 18:23:49 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:38581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1jF3Zr-0001ew-PI
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 18:23:48 -0400
Received: by mail-lj1-x243.google.com with SMTP id w1so4371423ljh.5
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 15:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WJ6MzhtWalH0hDBYxWzZFJvnUo/A0DOitGKj0UfdYo8=;
 b=XBqh7pWnTmUlqQohZOg/HeJr0gQHAIeXOwQCGzJ5OwLz0JntySiWzUQk/bbyBsqGm9
 AOagPLaBdiW1PMwWYNG62+YPygcjxUIjKZCSAWI7Y+gXGQmEpDRx5s4L6A86L4QjzPhm
 g1WliO6jBKgCaK0bZjyFPxJo1T1kZceLM4t/lRH12iiIppbgjzQ3iyFeIrW4qK58Nko5
 lbNS0FS7GU3iUIH68IUAikInyw3mSaCNwFQaUwVoTXF/SPEBXD79mERRqpVxClHgzlbO
 LuBZhWaZGVlUhSTRyD/NNbgZlWYzqDYTxbQym6CawlmhMV6GI3Nb15UmNwRMlI/s0Tib
 EF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WJ6MzhtWalH0hDBYxWzZFJvnUo/A0DOitGKj0UfdYo8=;
 b=NAlsmpo8eXiL356SMWzSis0CWAjDbPjot4tgqzfjNXrAZWVyU/amHTbW1yw1Sc7Lzm
 JWZZo1b0JhbliygL953HYACUJq28AoTWwKXBle6YmV8e316wVDbXBFTVov8e3KIeqobR
 2u9AQrVRYNOgbAPEmt7xsrWFeCsZO3puj97x4PmfTYyTGCa8lVtGmCYkcgnd5a31pKZq
 IqBlnupQ+LcT4KzrqOwRXF7JCoVqNtnYE9m8ot+Cy3/PG6UbsL8JSPYtkq8TUnRU9uF+
 gOeqWi/PHV2BqRSgez7dPBJ6jmp6lCkCsGx0GYlcyIlFWnV/cVWzkR0Dka1Ilx5U2MZj
 0OQg==
X-Gm-Message-State: ANhLgQ2DxIn67qJktb/58vZJHlTrdOjwqg7nSsIeWnHQABOYlnMghs7G
 t6drwvff0hPkJ6XVi98Dz7LeGtLqXZZk1HodNeP5sw==
X-Google-Smtp-Source: ADFU+vsNGI4DJxjB5f7C7tgGloRNRzSoDi/T/uXs4OR8cIg4QaTNXgqQeL/rC2Yz+GqKJZUSlth8pWewRRKx9U7JH3M=
X-Received: by 2002:a05:651c:1026:: with SMTP id
 w6mr3408670ljm.168.1584656625715; 
 Thu, 19 Mar 2020 15:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org>
 <CAFEAcA9mXE+gPnvM6HZ-w0+BhbpeuH=osFH-9NUzCLv=w-c7HQ@mail.gmail.com>
 <CACRpkdZtLNUwiZEMiJEoB0ojOBckyGcZeyFkR6MC69qv-ry9EA@mail.gmail.com>
 <CAFEAcA-gdwi=KSW6LqVdEJWSo9VEL5abYQs9LoHd4mKE_-h=Aw@mail.gmail.com>
In-Reply-To: <CAFEAcA-gdwi=KSW6LqVdEJWSo9VEL5abYQs9LoHd4mKE_-h=Aw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 19 Mar 2020 23:23:33 +0100
Message-ID: <CACRpkdYuZgZUznVxt1AHCSJa_GAXy8N0SduE5OrjDnE1s_L7Zg@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Theodore Ts'o <tytso@mit.edu>, "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
 Linux API <linux-api@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 stable <stable@vger.kernel.org>, Florian Weimer <fw@deneb.enyo.de>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 19, 2020 at 4:25 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> On Thu, 19 Mar 2020 at 15:13, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, Mar 17, 2020 at 12:58 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> > > What in particular does this personality setting affect?
> > > My copy of the personality(2) manpage just says:
> > >
> > >        PER_LINUX32 (since Linux 2.2)
> > >               [To be documented.]
> > >
> > > which isn't very informative.
> >
> > It's not a POSIX thing (not part of the Single Unix Specification)
> > so as with most Linux things it has some fuzzy semantics
> > defined by the community...
> >
> > I usually just go to the source.
>
> If we're going to decide that this is the way to say
> "give me 32-bit semantics" we need to actually document
> that and define in at least broad terms what we mean
> by it, so that when new things are added that might or
> might not check against the setting there is a reference
> defining whether they should or not, and so that
> userspace knows what it's opting into by setting the flag.
> The kernel loves undocumented APIs but userspace
> consumers of them are not so enamoured :-)

OK I guess we can at least take this opportunity to add
some kerneldoc to the include file.

> As a concrete example, should "give me 32-bit semantics
> via PER_LINUX32" mean "mmap should always return addresses
> within 4GB" ? That would seem like it would make sense --

Incidentally that thing in particular has its own personality
flag (personalities are additive, it's a bit schizophrenic)
so PER_LINUX_32BIT is defined as:
PER_LINUX_32BIT =       0x0000 | ADDR_LIMIT_32BIT,
and that is specifically for limiting the address space to
32bit.

There is also PER_LINUX32_3GB for a 3GB lowmem
limit.

Since the personality is kind of additive, if
we want a flag *specifically* for indicating that we want
32bit hashes from the file system, there are bits left so we
can provide that.

Is this what we want to do? I just think we shouldn't
decide on that lightly as we will be using up personality
bug bits, but sometimes you have to use them.

PER_LINUX32 as it stands means 32bit personality
but very specifically does not include memory range
limitations since that has its own flags.

Yours,
Linus Walleij

