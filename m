Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D485CC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 14:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A223A2053B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 14:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3RYK5aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A223A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41330 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMZ07-0005rP-Uy
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 10:17:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYzH-0005U7-8h
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYzF-0003dB-LP
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:16:31 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYzF-0003ch-FY
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:16:29 -0400
Received: by mail-ot1-x342.google.com with SMTP id o39so5408308ota.6
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=FBRpsNs6FN7GW71xeqe4DvqE0M/fmdiVzZ+9DUld9dE=;
	b=g3RYK5aj1JlLG5voilGcPaQnGfCfvqmkuSduXAAUSgErt0MDgLaraNuBvUIxQ235pT
	XC84lmgMxmuIKn9sSFZMUjMluWYrrWR9p3p7Swp8V+EtpWqzpW7QBg+XWp/rSUUAn6yx
	LO5YRrGiirL3x2qSYXWJNgNbq9ptRn2T1Dlb33tR/mct5RPR8CYO4DcDxPcqHHEwOt3p
	9mXqmyS6A0eZLiYf5yMSBI10ZXIlgMqdjGiHRQAUpIgfI5GxkSS11EZD8pwUULxzcJ+l
	zt/TM2JPFsPYHZv8ojgIHfjd3S23bObljM/8z15J+LYnZvJCEX3lNCO1V64X6IQZgCfk
	/Fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=FBRpsNs6FN7GW71xeqe4DvqE0M/fmdiVzZ+9DUld9dE=;
	b=ts5GhvIxTyjkf9ZWnBNLBaBSHl8MjY7vgqHtwbjQRaSx+n96vPZ/9NqYBIfee2Fa2N
	TuWb1uMJ9bsVcB68wKBU78DZ2wxxAkiC+xNYDjysDyNjS/vmtGjXEnGlHgL70g0Nf7Uc
	p6J/cLHlhsB5shfYiQhO1HgD2RUueS/WXsrsSmlFCVLkOs0x4I35xubqjzbs1D2q13Kd
	GgeDl5/LPMIC6l8NW5/nUTu+shYtVq4WXerrd6GksiyfsDe90NTMXNo4hMgx3hpq5Rme
	SwJqO7FxlOZ8msE34DobcYJgXzzw8MR7N6cP/6xWScCd2IS28L65rRjKAOSQ/vOlB3Bd
	WXeQ==
X-Gm-Message-State: APjAAAUvgIvZmQ6oaIbTVUWpIvY7krUVBJ1Ks1FWfEvoZLYHybckqcGI
	1szNgSJxzKkvthuxNUC12HR35Kzqs2Nox6ECe0agyQ==
X-Google-Smtp-Source: APXvYqxGjlJbLNVbo3CvGg+HcWXPjnaY5b3HHDES1e/Ha0zO7lJsQnBvZfstj+oQH2vrx5//7iXDxlb7nEgZXzQCE7g=
X-Received: by 2002:a9d:404:: with SMTP id 4mr6574114otc.352.1556892988088;
	Fri, 03 May 2019 07:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181210165636.28366-1-peter.maydell@linaro.org>
	<3afc2ab8-c6b6-7157-e744-e742b384b0da@vivier.eu>
In-Reply-To: <3afc2ab8-c6b6-7157-e744-e742b384b0da@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 15:16:16 +0100
Message-ID:
 <CAFEAcA_RCS0=1057PDeSfDtsiPK6V4HYKmZYDo0jJ_nokWDo_A@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [RFC 0/3] target/m68k: convert to
 transaction_failed hook
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"patches@linaro.org" <patches@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503141616.P3IrpzNmm9iSq6jijz-YBi9uveqzDaGN2v1xjMIkLtc@z>

On Wed, 12 Dec 2018 at 20:43, Laurent Vivier <laurent@vivier.eu> wrote:
>
> On 10/12/2018 17:56, Peter Maydell wrote:
> > This patchset converts the m68k target from the deprecated
> > unassigned_access hook to the new transaction_failed hook.
> > It's RFC for a couple of reasons:
> >  * it's untested, since I don't have an m68k test image
> >  * the second patch just makes "bus error while trying to
> >    read page tables" be treated as a page fault, when it
> >    should probably cause a fault reporting it as a bus error
> >    of some kind
> >  * I don't understand why the old unassigned_access hook
> >    set the ATC bit in the MMU SSW, since the docs I have say
> >    this should be set if the fault happened during a table
> >    search, but cleared if it's just an ordinary bus-errored
> >    data or insn access. Probably this is a pre-existing bug?
> >
> > Anyway, I send it out as a skeleton for comments, because
> > it would be nice to get rid of the old unassigned_access
> > hook, which is fundamentally broken (it's still used by m68k,
> > microblaze, mips and sparc).
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (3):
> >   target/m68k: In dump_address_map() check for memory access failures
> >   target/m68k: In get_physical_address() check for memory access
> >     failures
> >   target/m68k: Switch to transaction_failed hook
> >
> >  target/m68k/cpu.h       |  7 ++--
> >  target/m68k/cpu.c       |  2 +-
> >  target/m68k/helper.c    | 84 ++++++++++++++++++++++++++++++++---------
> >  target/m68k/op_helper.c | 20 ++++------
> >  4 files changed, 80 insertions(+), 33 deletions(-)
> >
>
> Tested-by: Laurent Vivier <laurent@vivier.eu>
>
> I'll try to review this later...

Ping! Are we at "later" yet ? :-)

I checked with the mbox of the series from
https://patchew.org/QEMU/20181210165636.28366-1-peter.maydell@linaro.org/
and it still applies cleanly to master.

thanks
-- PMM

