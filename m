Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E93C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB2520658
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nzCTjk/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB2520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEx3T-0001CG-Fw
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 11:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEx2q-0000fI-9f
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEx2p-0000nd-0g
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:25:16 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEx2o-0000mX-QO
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:25:14 -0400
Received: by mail-oi1-x244.google.com with SMTP id p125so3041112oif.10
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jyRv3rP13OdLMBv8QRB7zdcpaPYtYEwSo56+MzJ+ZFs=;
 b=nzCTjk/WTGmmxNxA/H2Cm1aSINgVwKRL8P40cMXfECaWzeOSAETe1qT50eksA8E/7M
 d6GjSn2pnegk1NyifuP79dQ9dC84a8nmHM4syOqSu8g2d0cBsI9pyKnyp9aAHhpNWDgl
 SI5Sw4lRrTbSnV6BRVaNrD9l0O94eJvI9K0GDjWRZmWyg2PtbD4PFVnNrS+SC3zVHxiW
 ZZ9EZXoe4IZ+toL1KWsOxuyDqnbxAMygRUUttkQTKU0AyzcXRMRCFCeRdACmmtUKb8GO
 0kw84WtHRP2nsNgF9//Ikrxe0/kAALjzDPNwSPDsWSh+XO5iP74e7dP5Gs+/reJiePmq
 WfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jyRv3rP13OdLMBv8QRB7zdcpaPYtYEwSo56+MzJ+ZFs=;
 b=OJ6uZIRuQ/c1REanTQGSJwMBadUUX+gTG5VKS8EfheWINApBE3TUEh7ua0B8THj8wK
 kZ6JB37BwVz1npEf10Tm4qrGTEj2G2l0evYCwh+W3OpYAxbj1dpCe3/GA+RNhUD4pKcH
 1788bfuM5C+vW4sB6dB1ni9xB11mQumNnECEkMmm689u4aWN7a1Dk/VgHNjhB9oVwI1h
 8MndRdA09Vltn8sSI7OWSiZolIQnvMYgE4f+FVTu1tgaKknPLDcDULzkUj9cOUWU0kNr
 73Qogb2HkYm3yAo1mlCMdnT0yvzxrgsd6NNyzfWmICb2aFRrugXEKM6xgCIwHz9qEoLQ
 0a/w==
X-Gm-Message-State: ANhLgQ25mKrV7fLSoQiqTvla/wkB2FuaSvuoV9I5oIUW6nOX8++EwaXf
 31SCEdo7ljSt4b78tBrm3vt0fqLiEsMQcSXwIcDWFA==
X-Google-Smtp-Source: ADFU+vsgVj8VybU7JzyAy1YYrvaI4EJLEym/9TXDcM5ONy7z6Htgah/Qv4dB39epUio4ehFI0vqfFJqCDsnVlUdEerI=
X-Received: by 2002:aca:c695:: with SMTP id w143mr2824247oif.98.1584631513703; 
 Thu, 19 Mar 2020 08:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org>
 <CAFEAcA9mXE+gPnvM6HZ-w0+BhbpeuH=osFH-9NUzCLv=w-c7HQ@mail.gmail.com>
 <CACRpkdZtLNUwiZEMiJEoB0ojOBckyGcZeyFkR6MC69qv-ry9EA@mail.gmail.com>
In-Reply-To: <CACRpkdZtLNUwiZEMiJEoB0ojOBckyGcZeyFkR6MC69qv-ry9EA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2020 15:25:02 +0000
Message-ID: <CAFEAcA-gdwi=KSW6LqVdEJWSo9VEL5abYQs9LoHd4mKE_-h=Aw@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Thu, 19 Mar 2020 at 15:13, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Mar 17, 2020 at 12:58 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> > What in particular does this personality setting affect?
> > My copy of the personality(2) manpage just says:
> >
> >        PER_LINUX32 (since Linux 2.2)
> >               [To be documented.]
> >
> > which isn't very informative.
>
> It's not a POSIX thing (not part of the Single Unix Specification)
> so as with most Linux things it has some fuzzy semantics
> defined by the community...
>
> I usually just go to the source.

If we're going to decide that this is the way to say
"give me 32-bit semantics" we need to actually document
that and define in at least broad terms what we mean
by it, so that when new things are added that might or
might not check against the setting there is a reference
defining whether they should or not, and so that
userspace knows what it's opting into by setting the flag.
The kernel loves undocumented APIs but userspace
consumers of them are not so enamoured :-)

As a concrete example, should "give me 32-bit semantics
via PER_LINUX32" mean "mmap should always return addresses
within 4GB" ? That would seem like it would make sense --
but on the other hand it would make it absolutely unusable
for QEMU's purposes, because we want to be able to
do full 64-bit mmap() for our own internal allocations.
(This is a specific example of the general case that
I'm dubious about having this be a process-wide switch,
because QEMU is a single process which sometimes
makes syscalls on its own behalf and sometimes makes
syscalls on behalf of the guest program it is emulating.
We want 32-bit semantics for the latter but if we
also get them for the former then there might be
unintended side effects.)

> I would not be surprised if running say i586 on x86_64
> has the same problem, just that noone has reported
> it yet. But what do I know. If they have the same problem
> they can use the same solution. Hm QEMU supports
> emulating i586 or even i386 ... maybe you could test?

Native i586 code on x86-64 should be fine, because it
will be using the compat syscalls, which ext4 already
ensures get the 32-bit sized hash (see hash2pos() and
friends).

thanks
-- PMM

