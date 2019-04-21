Return-Path: <SRS0=ydMe=SX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BBEC10F14
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 14:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6150720857
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 14:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYJqn7ny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6150720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53684 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIDKQ-0005G6-Fv
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 10:20:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hIDJf-0004xe-Jw
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 10:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hIDJe-00076h-IY
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 10:19:35 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hIDJe-00075B-Cc
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 10:19:34 -0400
Received: by mail-oi1-x244.google.com with SMTP id e5so6926720oii.0
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Hqf7Pw3T/mbvFWzC8VYfKQ21ZLGkwI3hZBLXJBad/oc=;
	b=QYJqn7ny3qPSWcvNYg18m3lYYKwKjT4MV4YkjCdX9M+Ay0tV6KRSanQECfCr31AHUa
	qT+v8dOd91im0xYXyisCRKRoQ8n84JSAl+UDQ2adDjCuUR3iE4AGe5loeGpfQHAZFWRt
	qM76+6MuS0Mdg5z/nMXELx3HH/6YOMa8bCKp4NWUO9cnNFWUFnxN8ktGJHBsZL5btSSd
	rQfonwSwFQr5qj7FYgOhaCWp5l/AXvNYLA9dzYpmvIR7Dm4zIayLGFhkA3H9pI1UUn5r
	SFpM2lK66t74QSXnBTzCJGjZ3J1brW0DEy/cQKO6ehoOTDMhOjTWZSP5tlECjbxiSBvL
	2hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Hqf7Pw3T/mbvFWzC8VYfKQ21ZLGkwI3hZBLXJBad/oc=;
	b=gP/vMN7SnwA9jHc98dKILQvw8noYoxQ6vGj6X3FLbb67qcEodEJi41iRe5tNHC8UKW
	ub/+Hpe6ui7IkfnmrtEy1LGyEGI8hUbVsH3eqpDr7ajzNSZX8ZBnCRHZYAG4cIRhbGKN
	6TVOXtWwIyrdFruKDo6qNaeAASVN9L2li/AohIZSMxTO3G4QxkO6cxxzYrIP5QsqmM0G
	4RIv21rQJETw4ECfh+SI0/AIn9xgy359UAq8ONhDgB5tY9+Ic+g8PBZ0F9jAiKSuCRyZ
	YYXP7RY6333nZjACfHoanUCvzmNTywVyDPnJpD7PwXeYaf3ZQP4ySF519EF7VD3FeOIU
	z0xg==
X-Gm-Message-State: APjAAAULh6C95jDIZr5LYk5R1a/HkGX6hif/x3fRiYjON1n5fC6iYDkP
	cufQCrpklhyRMNevj7+06wF855EA5BsVSlFV0IeqRA==
X-Google-Smtp-Source: APXvYqwmTZ/heygIBu8owxo+Dj4RPhYi2TqhXDHn+lD1pXJzotXNp3mBSmR8RkKMqFioi8jI4GG1L1QgGJA3O+815Yg=
X-Received: by 2002:aca:c7d3:: with SMTP id x202mr6980173oif.48.1555856372859; 
	Sun, 21 Apr 2019 07:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190419114502.20388-1-shahab.vahedi@gmail.com>
	<CAFEAcA_2aNt10Ti8HCTbCvHrgFYt7Uw2z=pNWBWyWMsbR6kjoQ@mail.gmail.com>
	<20190421080314.GA1817@gmail.com>
In-Reply-To: <20190421080314.GA1817@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 21 Apr 2019 15:19:21 +0100
Message-ID:
 <CAFEAcA-=HXpUR0f84c9nMvmktsLZ9ooE7NvryQGstiZ+BnhpXA@mail.gmail.com>
To: Shahab Vahedi <shahab.vahedi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH] cputlb: Fix io_readx() to respect the
 access_type
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	"open list:Overall" <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190421141921.edDL4G5gh2iztKa36-xxBVd6OWd5PvH96LjNQjdSiRA@z>

On Sun, 21 Apr 2019 at 09:03, Shahab Vahedi <shahab.vahedi@gmail.com> wrote:
>
> Hi Peter,
>
> On Sat, Apr 20, 2019 at 07:57:31PM +0100, Peter Maydell wrote:
> > On Fri, 19 Apr 2019 at 12:46, Shahab Vahedi <shahab.vahedi@gmail.com> wrote:
> > >
> > > This change adapts io_readx() to its input access_type. Currently
> > > io_readx() treats any memory access as a read, although it has an
> > > input argument "MMUAccessType access_type". This results in:
> > >
> > > 1) Calling the tlb_fill() only with MMU_DATA_LOAD
> > > 2) Considering only entry->addr_read as the tlb_addr
> > >
> > > Buglink: https://bugs.launchpad.net/qemu/+bug/1825359
> > >
> > > Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
> > > ---
> > > Changelog:
> > > - Extra space before closing parenthesis is removed
> > >
> > >  accel/tcg/cputlb.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > Hi; this patch mostly looks good; thanks for submitting it.
> >
> Please let me remind you that there is a newer [PATCH v3].

Oops, yes, I missed that (was going through a lot of
list emails after being away for a bit). Sorry.

> I have a question though: Richard (Henderson) has already
> _reviewed_ [PATCH v3]. Is it OK if I change the code further
> and submit yet a newer version?

If you think it's necessary, you can -- for instance if
you find a bug or other problem in it. If you change
the code much then you should drop the reviewed-by:
line as the code needs re-review. If the change is
entirely trivial (eg fixing a comment typo) then you
can let the reviewed-by tag stand (ie include it in
the version you send out).

But if you're thinking of doing it just to fiddle
with the ?: style issue I suggested above, don't
bother -- it doesn't matter that much (and not
trying to deal with all 3 cases means you don't
have the nested ?: anyway).

thanks
-- PMM

