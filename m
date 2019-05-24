Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B531C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 10:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F0720856
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 10:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8rH0BRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F0720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52425 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU7tW-0005s8-7m
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 06:57:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU7sP-0005PC-2C
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU7sO-00025u-03
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:56:41 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hU7sN-00024L-DR
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:56:39 -0400
Received: by mail-oi1-x244.google.com with SMTP id 203so6676433oid.13
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=WJGUWQzCyBfav+i0AdQnhQAz8aaBzTAkRWNXH5JSs7U=;
	b=B8rH0BRtgBuS9PXBjpzIp2B8gZI1ed6cZ0Jb3nk7QsriEb7UyrTh3dPwvhX38JAtai
	ybnhf1zpjd6rGd6EW4+Z6SG26Bjbj+DxHHvL7RJpzMfPbnkTr3EZTBm07PyFsvZE38Iq
	aA625CohmYtJHNwizdqVFdq8Y/uf3KhR8ZLQFPXANkuYtesYHh6tG7QOt+Pkz0TV/8GJ
	Anc+DYGLr4SMWjuhGfoofFQTgQy+SXK/VRafj2QwXjMLdTk+G4Ltx9N117k1RtFRnht4
	hCEzFuC3eoAa9F8OgS+GF1jUp1J8gfjxznjRX152WpuOiTlne1lG5SArHlBADKNcTeMY
	QEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=WJGUWQzCyBfav+i0AdQnhQAz8aaBzTAkRWNXH5JSs7U=;
	b=qMqEsZPVWyUgoYAVlQ8otd4CJo5bFvoyM8bMhWgnvIOhL03hTQcQWNw//3M0cIpB5P
	egz4rGrS6W6CvVK3vsSU9lWCtKC7zxUhPORgym7tCa2Ii3MTsI46wrxa5FmlwkpawRaU
	0NiX/8agHW3yadEg6hJ7GWxrHkT/fiK7Aahl2scY4Iq98sVUXIDjFhkSVy5d3yC8RAPZ
	OMJCMxgIc7S26Z81dLB91SC7voD2dNdwsqTje6Wf8M3yesoj7qDFzuefNx1BAr4qyTnP
	UAw4+RxY3YzfGC/Ax8cASXWCw46OXwEdIPVCtohZCH3yyJPp6Yr2F1Lk4gf/TcuErjIg
	ZwhQ==
X-Gm-Message-State: APjAAAVaBHXlvMBYhDlResfhBX4/r6X4gi/HW5JUh3zM2dr5DMTAgVaS
	p05lA9fvG+g/4inMX1Kctcjr95ojO6fdwGyxmFVC8A==
X-Google-Smtp-Source: APXvYqxVbmHOuT+SWWRgH8UNTYbywGrrZysLm2+EBf7oh9cRtpkun0F9oyS7Z0juIDMZ7B234QkhM0ahdUfN6uL/wLA=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr5911488oif.98.1558695398200; 
	Fri, 24 May 2019 03:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190523102532.10486-1-alex.bennee@linaro.org>
	<20190523102532.10486-4-alex.bennee@linaro.org>
	<CAFEAcA_+=7VfvZRc__q9L3vuHO6YgetrjTPAYJx4eo0mAdcPXg@mail.gmail.com>
	<877eag165o.fsf@zen.linaroharston>
In-Reply-To: <877eag165o.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 May 2019 11:56:26 +0100
Message-ID: <CAFEAcA_Fu3Ep10NooU5-XcAqQVjJQE5o1L2JTdYTatjcOptPUg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2 03/28] semihosting: implement a
 semihosting console
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 May 2019 at 11:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Thu, 23 May 2019 at 11:39, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> > I'm not sure about the "no callback" part of this API. The operation
> > here is genuinely asynchronous and providing no mechanism for the
> > caller to be able to say "ok, now wait til it completes" doesn't
> > seem like a good plan.
>
> Well the caller doesn't really get a choice. At least in system mode
> gdbstub does a vm_stop(RUN_STATE_DEBUG) and brings everything to a halt
> anyway. All we've removed is the ability to tack on a callback (which
> can get run in all sorts of contexts) when we restart.

gdb_do_syscall() is asynchronous -- it arranges for the syscall
to happen, but makes no guarantee about when it will finish.
At the moment the gdb_do_syscall() API allows the caller
to cope with this asynchronousness, because when the callback
is called the syscall has definitely finished. As it happens
the callers are buggy in that they don't actually do the
sync that they need to do, but we could fix that bug (ie post
a semaphore in the callback function, and wait on it after
the gdb_do_syscall() call). The API for this new function
doesn't allow us to do that.

> I could just drop the API here and allow the semihosting API to call
> gdb_do_syscallv directly?

I think we should either make the implementation of the function
properly synchronous (ie do the post-semaphore-in-callback,
wait-on-it-after-gdb_do_syscallv thing in the implementation,
or have an API that lets callers do it.

Perhaps we should just make gdb_do_syscall really be
synchronous (ie have it do the semaphore stuff)? We
only actually use it in semihosting, and I think all
those cases require that the operation completes before
we can resume execution of the guest CPU. So doing the
synchronization in one place in the gdb code would be
simpler than doing it separately in all the callers...

thanks
-- PMM

