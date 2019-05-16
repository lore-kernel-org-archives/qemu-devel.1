Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0000EC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 15:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE71220815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 15:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o4mAY6MY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE71220815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60268 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRImD-0000mF-1t
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 11:58:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRIkd-0008F8-Am
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRIkc-0002p5-13
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:56:59 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRIkb-0002nV-RA
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:56:57 -0400
Received: by mail-ot1-x341.google.com with SMTP id n14so3932147otk.2
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=wXHASg9Ms1/AhgMkkjvldTEjYbHigQD50JV9vemyh+E=;
	b=o4mAY6MYLGFWVsFOwUzjTcnJJ4BWk8RhE+af7ShbgnKIJB5vGFta4t9Jw4dfTMP9js
	DufBp+bybXLyQcW/JC32n3PigS9PSuecEpxZEDhxZomLnV4SDn+FBbpGmpjjiKcd8wpQ
	YpzAAz+66E15YxURgFA/GU1d7eBDSK02wZvPeD2i5HKdnE1EJA8fCxJrMx8irV6iOB79
	nD3U2gJJXqYoKxofM3HRJ2dI9vCn7aczwV6M+vwDEjXaSyUGewxERHuOXwn4uLKUG4d7
	pxsh5VmKzDfz9zC7nMEuqypTtd4fBv9nqlH0DziGISTUzbH3lNzClmG6xJp775kNTPU7
	prtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=wXHASg9Ms1/AhgMkkjvldTEjYbHigQD50JV9vemyh+E=;
	b=jv/RjthefKocebgfWRo2ttqdwLjuHRCq+dBLMmBqW7qJ2wxVehzwTNWlHVbkcctaQS
	iS1IGBPsVCW3St7d0t91AwjhxEvJz9XvYnjNIaGQxZ7djmdCL1fvaxLuleLQmAZvyAac
	XKyb0vdtVpH4tAntztBISZDJ9YWDbgtyrahZu1N99YoDG9SmqEhmrJKJW6CDXyyJUi2+
	tBmo02BmFOUyHKgaFxUcsbhCcInzGeI8B9ahN5f9Vt0Ub/Ket36sN1TVaGREXqjOoH9L
	6nIE9+Ckh11Su44L6veaczQ7zim4dxlBxw14/KexUdhFVLgLgWyZQmX3wgHewxchXU/v
	bACQ==
X-Gm-Message-State: APjAAAWQbRf4kUJTbqs1p8gQK55h8DAB+8+4S6RbWE0Nu31mz76M5nrR
	p5U2CZmiIwbbwM1uvMogxuKPIwenvsiXPfLdG/zAhw==
X-Google-Smtp-Source: APXvYqw0Dd423ETGA/vKgNdXOWBILRt1N4100RzMdDhHDvFGN+gjrvBSlASLN4VTAXbwKbEumxIADiGgZx7ELBk+70Q=
X-Received: by 2002:a05:6830:149a:: with SMTP id
	s26mr1630372otq.221.1558022216817; 
	Thu, 16 May 2019 08:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190510185438.29533-1-richard.henderson@linaro.org>
	<CAFEAcA-bGyRDeYNdiAkJfNNqSPkbOpGZCNyY94w3dJftzrYPJA@mail.gmail.com>
In-Reply-To: <CAFEAcA-bGyRDeYNdiAkJfNNqSPkbOpGZCNyY94w3dJftzrYPJA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 May 2019 16:56:45 +0100
Message-ID: <CAFEAcA9NzSwXgjevsNUtJqOLXqJPBZPSC-6YQh_QqzXcqVfj-Q@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL v2 00/27] tcg: Add CPUClass::tlb_fill
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 May 2019 at 13:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 10 May 2019 at 19:54, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Changes in v2:
> >
> >   * Fix --disable-tcg compilation for x86 and s390x.
> >     I adjusted every target/ that used any CONFIG_TCG in cpu.c.
> >     but then afterward I see that only x86 and s390x have had
> >     their Makefiles adjusted to make --disable-tcg actually work.
> >
> >   * Fix Werror for 64-bit on 32-bit.
> >
> > Only re-posting changed patches.
> >
> >
> > r~
> >
> >
> > The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
> >
> >   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/rth7680/qemu.git tags/pull-tcg-20190510
> >
> > for you to fetch changes up to 4811e9095c0491bc6f5450e5012c9c4796b9e59d:
> >
> >   tcg: Use tlb_fill probe from tlb_vaddr_to_host (2019-05-10 11:12:50 -0700)
> >
> > ----------------------------------------------------------------
> > Add CPUClass::tlb_fill.
> > Improve tlb_vaddr_to_host for use by ARM SVE no-fault loads.
> >
>
> I did a test merge of this and it passed my build tests; I haven't
> applied it though pending resolution of Aleksandar's comments.


Applied, thanks (conclusion of mailing list discussion was that it
was ok to apply as-is).

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

