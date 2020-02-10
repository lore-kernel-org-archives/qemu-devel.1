Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5F0C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 18:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1F72080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 18:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GfBNA/Vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1F72080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Dhv-0002oP-3I
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 13:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j1Dh6-0001uc-4M
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 13:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j1Dh4-0004Zv-Nj
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 13:22:03 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:38457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j1Dh4-0004WL-96
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 13:22:02 -0500
Received: by mail-lj1-x242.google.com with SMTP id w1so8387152ljh.5
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 10:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=x/bKh94ywhm0lOW9QKrrnoTHnQ1/1M9I9J1a7IuOoug=;
 b=GfBNA/VfBVOz4c4Zku5MtEB1tunbEBzurVwnFJ6OCLJhaG9IvV/3K6PN635nZp9Wss
 smFBj0ajdC1cMTVgevUL0Wj4JET5FH0uFdpsLHqBsg2thws8GoBVJBZm8fcjM8vuWdY7
 Fqgf5DlWKORE+ybFQH1QG2tcjpEXcvIAht31sbWcej+mAQiczAVaWvfVMcYxsYwafHOR
 wkzApqhhAs6z4xDtn9YbXth+WoQ9DFjAxWWjj0T6KyGph8+VKjtDlme4nEWAgCCfosn8
 ttSlLULs2qo7AsqJ+JXtRykvXSY+skh9KjZN5rGvKsAwghNS3+h7K/khuD82DRz1L1So
 7hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=x/bKh94ywhm0lOW9QKrrnoTHnQ1/1M9I9J1a7IuOoug=;
 b=f0NVBLYhNVXNqvm662vArpSe/64eQsca1NiGRnwdSDTByn+IKcuRTFs0K+Fd06IYWr
 h+UMFWJq30/peJxAlxMH8eZ5lgga03EKyL8amJVJr+slZ9zdphUXcEahECM9wrsYCjIr
 9/XhHVgz/xNq8VkurTpPMi/Fq5llHcZcaZqVtfaD1T/SruqTRum7Er0vd1VZEg8fqlvT
 PWKu2eF5RQ7XG+cko/DO3lH7gY2WHjemNtqnoTZ5vyaafp1jEl1E6g8kXlDQ98brMPI2
 aFQj50YXsuk980FamP4QhMJQ5akxF4jgzlIKTkt6e8HrhK1OCI0EhhpOIAOS5Oj6MsQi
 yEiA==
X-Gm-Message-State: APjAAAU/21xI6RhTFHCthOObaVT+M3BGlEzIYgzJKmItF2UXYa6Wa55z
 ctdz6E1OkjJ/m+YN2eRCBMI661gJCE+fcSeb5HKe3Q==
X-Google-Smtp-Source: APXvYqyyDayYl3Pfq69BSVhTaWR9+grPLImLxsyuuqysaTst3cBouOUw0Bm7ZBzgfdi1sBwNtih7zFwHdiIXQMzsUHg=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr1736899ljg.166.1581358919320; 
 Mon, 10 Feb 2020 10:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20200205212920.467-1-robert.foley@linaro.org>
 <20200205212920.467-7-robert.foley@linaro.org>
 <874kw27248.fsf@linaro.org>
 <CAEyhzFs6+Lssj8a5QckmDaqi41E8_WemueSYuZrqtr=tVbYOjA@mail.gmail.com>
In-Reply-To: <CAEyhzFs6+Lssj8a5QckmDaqi41E8_WemueSYuZrqtr=tVbYOjA@mail.gmail.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 10 Feb 2020 13:21:23 -0500
Message-ID: <CAEyhzFv_W3cEFQYxpsrDDkbYawwGe2WFgi1SokLz9GO8xZ-w-A@mail.gmail.com>
Subject: Re: [PATCH v1 06/14] tests/vm: Add logging of console to file.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: fam@euphon.net, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 17:20, Robert Foley <robert.foley@linaro.org> wrote:
>
> On Fri, 7 Feb 2020 at 12:12, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> > > +
> > > +    def join(self, timeout=3DNone):
> > > +        """Time to destroy the thread.
> > > +           Clear the event to stop the thread, and wait for
> > > +           it to complete."""
> > > +        self.alive.clear()
> > > +        threading.Thread.join(self, timeout)
> > > +        self.log_file.close()
> >
> > I'm note sure about this - introducing threading into Python seems very
> > un-pythonic. I wonder if the python experts have any view on a better
> > way to achieve what we want which I think is:
> >
> >   - a buffer that properly drains output from QEMU
> >   - which can optionally be serialised onto disk for logging
> >
> > What else are we trying to achieve here?
>
> I think that covers what we are trying to achieve here.
> The logging to file is a nice to have, but
> the draining of the output from QEMU is the main objective here.
> We will do a bit more research here to seek out a cleaner way to achieve =
this,
> but certainly we would also be interested if any python experts have a
> view on a cleaner approach.
>
We have a few more ideas on how to make this a bit cleaner.

We could create a new class "ConsoleSocket", based on asyncore.dispatcher.
The asyncore python library allows for overriding certain functionality of
an underlying socket.
We could override the handle_read() method in order to get a callback
when data is available to be read from the console.  This is much cleaner
than us simply waiting with a read() on the socket in a thread.
Note that even asyncore requires a thread around asyncore.loop(), but we wo=
uld
only be responsible for start/stop of the thread and the thread body
is defined for us (literally just asyncore.loop()).
The thread starting/stopping would be completely transparent
to the users of this new ConsoleSocket.  The thread would be created on
initialization of ConsoleSocket, and destroyed upon close() of the socket.

As the console bytes get consumed we can dump them to an in memory stream,
rather than dumping them to a file right away.
We could perhaps use an io.StringIO text stream.  This stream will get
the bytes of the console and the test will consume the bytes directly
from this stream.
In addition, we could optionally dump the bytes to a file as well.

How does this sound?  Just looking for a bit of feedback before we
head in this direction.

Thanks & Regards,
-Rob

