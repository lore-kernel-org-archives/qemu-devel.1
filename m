Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F4EC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F22C2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dz/cFVwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F22C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGqwc-0007f1-A6
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 17:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGqvk-0006zg-3W
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGqvi-0005Zc-Hi
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:17:47 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:35086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGqvi-0005ZD-4g
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:17:46 -0400
Received: by mail-oi1-x236.google.com with SMTP id t25so94044oij.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 14:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RfCKCLspr2ShfRlz+oSY1fLyKBreJRQdOGFDVP/2h/w=;
 b=Dz/cFVwFvnjE4MAjltm8IudNhCukdyb2e/C1roeUXZMpR4Y7VSSfTGGHNxJ0pBD8km
 +yV6tZUB3mpz28CS88IU9+axNrWGVWlXoDerOdlMOq5BTTG5FBbtQjR9/aNJN33izv6d
 bbYVjqfS2ArNSy7y25Qom7lXmK+rrrTbMIKKCzw47Dwhr7NDOsyOISo7+Id/hstKKHJ9
 vhdOWZiLPtJtyoQHMv3sC61fSmOBwT+46Fg8V+aUszDSzYESAuYc1b34VWHSptt8OXvN
 RddRkwoWd3pGCjSlxRBcqHmSrZtJZByy5bbkmQe0tNXnRkfMQF+t0Y9KMP9tQtRIyavy
 UH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RfCKCLspr2ShfRlz+oSY1fLyKBreJRQdOGFDVP/2h/w=;
 b=D0IRPoB9DH49gjy6/lV5EVUnCP6TUamI3NnxhzKkbEk5emxP2TR81OIkyzU3retI2I
 ogX5HMR2l/rhlyeDlWonE/Pk2bWor8J8yphE/hBQxC3otQ9arANlgsp9AR9b1s314Yr7
 +UDOiYQnVoYVcaQ2exi53r/lomRzXMLz/bDBly97+Yq2S9y4WzIzzwDxT19eAtXETHdx
 s0PmXUG+w/VfwxZVa8lgf63/Sy+wg/efjlzJXilhOJjtQ0w/iK7InAIycBWyE+fA6t0Y
 Lg8fGqsqGGj2kfX7z1vP+Ppu/6QZahGVI1AQ/sVjbLTLBHCUgWjxRGyqOXc+I7dGnM0+
 mWlg==
X-Gm-Message-State: ANhLgQ0O+677pul3tn5YMxO/hk2TELbVkInAg/Kl99BKqna64buLIE41
 7E5QzXEaRQEitjS4VD//2iLRRBlzMteGUNKvoJLoSw==
X-Google-Smtp-Source: ADFU+vvTutxy/79S5r4bgobej1skKSKOTAJUXHmqs7ryaTqUlJReJ300xSCYlRuDvDLn0B9M1rZRYzWB49OUnp3qSn8=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr190376oih.146.1585084664905; 
 Tue, 24 Mar 2020 14:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAGT9xrDKJQW6HV6OWDDck=H0bGzk=7ZTVn6tTfNnv=tH0sr1nA@mail.gmail.com>
 <CAFEAcA-sY_H5s6j4ZEZ+SMvQgyENF+w+v5ajiJOhHDrn_zfjrA@mail.gmail.com>
 <CAGT9xrBS_Hp5VHjZeSP4q5CMEbzu33B3Jza+nxGybK-n4QLQGA@mail.gmail.com>
In-Reply-To: <CAGT9xrBS_Hp5VHjZeSP4q5CMEbzu33B3Jza+nxGybK-n4QLQGA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2020 21:17:33 +0000
Message-ID: <CAFEAcA_nwwOyaadO7AuQ1dax0gQTfVEvwtCQS2OSmn+OcMUAWQ@mail.gmail.com>
Subject: Re: Potential missing checks
To: Mansour Ahmadi <mansourweb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
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

On Tue, 24 Mar 2020 at 20:39, Mansour Ahmadi <mansourweb@gmail.com> wrote:
>
> Thank you for looking into this, Peter. I agree that static analysis has =
false positives; that's why I called them potential. Basically, they are fo=
und based on code similarity so I might be wrong and I need a second opinio=
n from QEMU developers. I appreciate your effort.

The thing is, you're making us do all the work here. That's
not very useful to us. It's doubly unuseful when there's
a strong chance that when we do do the work of looking
at the code it turns out that there's no problem.

"I did some static analysis, and I looked at the
results, and I dug through the QEMU code, and it
does seem to me that this could well be a bug" is
definitely useful. "I did some static analysis using
only analysis techniques that have an pretty
low false positive rate, and here is a selection of
the results" is also useful. But "I just ran the
code through an analyser that produces lots of
false positives and then I didn't do any further
human examination of the results" is of much less
utility to the project, I'm afraid.

> For the first case, I noticed a check on offset (if (offset)) before nega=
ting it and passing to stream function here.
> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df7=
6/disas/arm.c#L1748
>
> Similar scenario happened here WITHOUT the check:
> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df7=
6/disas/arm.c#L2731-L2733

So, this is in the disassembler. The difference is
just whether we print out a register+offset memory
reference where the offset happens to be zero
as "[reg, #0]" or just "[reg]", and the no-special-case-0
is for encodings which are always pc-relative.
So even if it was a missing check the results are
entirely harmless, since anybody reading the disassembly
will understand the #0 fine.

Secondly, this code is imported from binutils,
so we usually don't worry too much about fixing
up minor bugs in it.

Finally, I went and checked the Arm specs, and for
the kinds of PC-relative load/store that the second
example is handling the specified disassembly format
does mandate the "pc, #0" (whereas the other example
is correctly skipping it for 0-immediates because
in those insns the offset is optional in disassembly).

So the code is correct as it stands.

thanks
-- PMM

