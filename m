Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFABC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2987D2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="daBevHAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2987D2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39751 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMX41-0003tt-Cv
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 08:13:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMX3B-0003Z3-Fe
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMX3A-0006cI-IL
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:12:25 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMX3A-0006bn-CH
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:12:24 -0400
Received: by mail-oi1-x242.google.com with SMTP id t70so4231363oif.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=xY4c6NQjMMrKGjoUgDqOaSKuTDDWLkPb/all4IGS2jc=;
	b=daBevHABE5he1oZESthBSkjMDnCRJBbZo94xf+lOhRKR6NY0UGoc10nv1/LzuM+ThS
	Uv9iM3QxiTtacaUJD9n8cjEntG9uQX8gzAOEP/co3Xqw5p35p87ZHYuA4WrrwjU30Huk
	lqqM0T8hYeRSwTFZf7h8XTvehPXGC3EYLUhyHTj/6KvcXTPDJfVGAqKqCZ3xs2bDsd9N
	yunlEgG0yLTAdy3ox/5epC8yzPqRdu37jOzbJBpeR37dDS+k9rMGtL0cn0TuGn1CWbzN
	RNDl4FNEBT3PBXRm7agD5Z0op1Oc8Ra5XjOgZTT37yr1t7WQbxTMhkBzSpULFUZGch0D
	c91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=xY4c6NQjMMrKGjoUgDqOaSKuTDDWLkPb/all4IGS2jc=;
	b=Wsc6N/DhkHkX0BZzqM/Oz0vmP2hsBC3B4/BYVn8NdfTMhen/2l/536DM2KLNsAhVq/
	V7cEBxrh6ax4sLXwhMmMZaF05V+93208iQ53WonPiU6m9SIPccKDT1qSU16O1hAlO23P
	oAvyjvyNSuifs9RCKJQnSa3mYBjb0s44/01pnSN0rFCSWbU1M6MYK9KbMRLivMrSDqg5
	VP+WalbqxRSBtCHxbrK9uuwutchfP2cLqg/ec+ku2QTYqY5KC9ErwvQCsC5Z7Q5S2MDy
	rJTm34QiOWuGsw16r4B2kzA0Qa9imrysgnDPJJvdzars/E2OnG/YjEI0VVqIRRW4uPEY
	GL4g==
X-Gm-Message-State: APjAAAUdDiKlrl3RzT3+5V/f9OVJm4EiaOOBk3844CYQ0aw0gvbP9eJU
	He8qqw87iYnLaQNWMZxCDtr9Q1gicjF9RkIq+6HHjA==
X-Google-Smtp-Source: APXvYqznBDqv2ujVNsqrz4w/CrWOOXV5WBLhCQncNPWtsD8CQe6/ps/pNkqEtiLCs4xG0CXi6iG1l+zkseXdL4bwvLo=
X-Received: by 2002:aca:ab12:: with SMTP id u18mr5314971oie.48.1556885542950; 
	Fri, 03 May 2019 05:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190315143057.20165-1-peter.maydell@linaro.org>
	<87sgvkw4vp.fsf@zen.linaroharston>
	<CAFEAcA_n2MvRfCdydianR9EgDxdP093+Fi-Co2WRa0ncAF=Pgg@mail.gmail.com>
In-Reply-To: <CAFEAcA_n2MvRfCdydianR9EgDxdP093+Fi-Co2WRa0ncAF=Pgg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 13:12:11 +0100
Message-ID:
 <CAFEAcA88dHzePhpOBdKFXr4HpF3J40FqY6qdwFpNhyBgxbehkQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH for-4.0?] arm: Allow system registers for
 KVM guests to be changed by QEMU code
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
Cc: Dongjiu Geng <gengdongjiu@huawei.com>, Eric Auger <eric.auger@redhat.com>,
	qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
	"patches@linaro.org" <patches@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503121211.qu0y1Jh9hE8WY56sSlPWGi6fBLgafmqUS9gyQHZitdk@z>

On Mon, 25 Mar 2019 at 10:25, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Mon, 18 Mar 2019 at 15:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> >
> > Peter Maydell <peter.maydell@linaro.org> writes:
[...]
> > > Support this by making kvm_arch_put_registers() synchronize
> > > CPU state back into the list. We sync only those registers
> > > where the initial write succeeds, which should be sufficient.
> > >
> > > This commit is the same as commit 823e1b3818f9b10b824ddc which we
> > > had to revert in commit 942f99c825fc94c8b1a4, except that the bug
> > > which was preventing EDK2 guest firmware running has been fixed:
> > > kvm_arm_reset_vcpu() now calls write_list_to_cpustate().

> > > Should we try to put this in for rc1? Not sure... Testing
> > > definitely appreciated.
>
> > Hmm so running my testcase:
> >
> >  * gdbstub enabled with an active sw or hw breakpoint
> >  * run userspace program in guest:
> >    - sw breakpoint works fine
> >    - hw breakpoint never triggers because guest segs
>
> Further testing from Alex suggests this is some unrelated
> bug or regression (ie not caused by this patch), but:
> since the only in-tree use for this patch is to get nested
> debugging working and it would be broken for this other
> reason even with this patch, I'm going to postpone applying
> this patch until the start of the 4.1 cycle.

Since we're now in the 4.1 cycle I'm going to apply this
patch, as I suggested above -- I'm putting it into my
target-arm.next queue to go in in my next pullreq.

We should make sure we investigate the debugging-KVM
breakage Alex described at some point this cycle too.

thanks
-- PMM

