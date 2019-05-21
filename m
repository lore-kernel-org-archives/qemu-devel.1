Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EFCC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 13:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9845021479
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 13:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fxN4wUw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9845021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54238 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT5HP-0003rq-Oy
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 09:58:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT5DW-0000oZ-F6
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT5DV-00067q-Af
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:54:10 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT5DV-00066b-43
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:54:09 -0400
Received: by mail-ot1-x342.google.com with SMTP id l17so16413784otq.1
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=yawR0T7c+6hBTgTGqXSPrYi32xrOTuLdWUT26nn60b8=;
	b=fxN4wUw+rNYCW9RZT7SMquO/cZmj9sMotmZBRW0ZrFdDzAV26iP2VBzVhNsHpJmd5J
	+bjnzKsSQgZJKHASOOdHSG9Kd2vzmyUgbZrmrQJ4lVyQJmck0nLJUZBlJ7FMv2ulAtj9
	FMP+5VjRjiur7xr1z2XXMp2drhyJZGBTNZBqNNpgMSscRR8ulEsMeqkkIXS+psP4gpWH
	FAWDbLdedzGCvGtKOag3MrnwF43QGuzF6veG7/ss9iOs/v5IaPZh3FuQGe/R4eeZrX+P
	ntTB7zbwW4ALDVv10hpRFfZeX3f1AAROpZ9y7siXFPhrsjGlLYk1xNnK/S6blzIAuyha
	sQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=yawR0T7c+6hBTgTGqXSPrYi32xrOTuLdWUT26nn60b8=;
	b=PvkPQKs0rhAGojY3pgHjkdX+kn8g7TK/1Fj+UqGjU7aQfFyGZuUGHBYN1use4QdmH9
	+44wBNGiQBBC9iIi7/WjazBmMRwebF/HlWReWQ47ZxxLBzdPdJYPw7uHHzeoaaZRM1aJ
	CcMehUX/wnsflF0VSzPolvBwfHtwmu00xSbI7B+JAiJkh2P5YvFZhSv9IYlxt7w2s4y9
	G//H3K01dcLiCOy5A9Yedgr9Ow7+ZERZNAFZS7ae54FF3ZwS42Npz5jmIoOjpvuFhLRr
	2b79wFBOpXWIk0yryv1BAtIgc/muHkLYjKMXATuJpD22FPWVbNBWULsxO8uff9pgw1ht
	pTKQ==
X-Gm-Message-State: APjAAAVV8EBHGxvLGdTPvc/R2qrHZWVbdm3LGh9xt7FhFGS9emomVexu
	xU7Jp5ZWmwcol9lByWynoij1HjLKD13eijOj/Cdn6w==
X-Google-Smtp-Source: APXvYqw/dtX8uVnBbSLJ5cCab9RAt1gCqvP1/GzvVZNhHqnr7EOyN1YINV/LJdEHDhCue4nNN7EnUFiyUCUJg5sJIbw=
X-Received: by 2002:a05:6830:149a:: with SMTP id
	s26mr19838243otq.221.1558446848181; 
	Tue, 21 May 2019 06:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190521092048.28492-1-cohuck@redhat.com>
	<CAFEAcA_9QZRyx8_8qT208vsopquW5j-bkyZpmRCAhP-sqJ+0kg@mail.gmail.com>
	<20190521153104.403980b3.cohuck@redhat.com>
In-Reply-To: <20190521153104.403980b3.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 14:53:57 +0100
Message-ID: <CAFEAcA8QmPYzPeLt5LAg+7x5ySM0x3HUp_o54jo-iObG8ksy+A@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL v2 00/54] s390x update
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 14:31, Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Tue, 21 May 2019 14:24:07 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > ...it's copying the file into asm-arm/ rather than asm-arm64/.
> > (I did a by-hand move of the file into the right directory and
> > that was sufficient for the compile to succeed.)
>
> I'm obviously not at my best at the moment :(

No big deal, it's always awkward when you don't have access
to the test hardware.

> >
> > Also, can we keep the changes to scripts/ in a separate
> > commit, please? The idea of header-update commits is that they
> > should contain only the changes automatically generated
> > by the script, with no hand-written additions.
>
> This looks a bit like a chicken-and-egg problem, though... without the
> change, we cannot point the script at a current kernel tree. I'd prefer
> the two to stay together, but I can certainly point out the change to
> the script more prominently.

I would structure it as:

Commit 1: update the script
Commit 2: result of running the script

thanks
-- PMM

