Return-Path: <SRS0=sDSq=3P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829EEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 16:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4F9206A2
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 16:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL15SHow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4F9206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivl80-0004JT-GK
	for qemu-devel@archiver.kernel.org; Sun, 26 Jan 2020 11:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivl7N-0003re-Rz
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 11:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivl7M-0006Z7-Cv
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 11:50:37 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ivl7M-0006YW-7k
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 11:50:36 -0500
Received: by mail-oi1-x243.google.com with SMTP id i1so4483572oie.8
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2020 08:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tIVFwxogzwnrFBuYVAn08RcmIO8VOZNo3EoNm0qw4SE=;
 b=PL15SHowEw5GlMDtU7TBD4PFCwThZ2CP3wdZ2+9tWYgU5yB6l9b4nuBjonnmFtyfxE
 OJQIqebj5iHoTYFEUA4lVAcWBkX5IZWcllqkNYb+WezKfNugAp2wY7F3UbGPjE3g+8D4
 dp0wUMURZLIKJZPHXux0mEYKIpUq5SEIDZjrx6wjdtJJyq/in/4piVzRYDon6JsFaHD6
 ByXeGtiYKzpmvZue62PorD/ZesnUCUaoUgx8netUXPuhXNLnra/SpPlsB5P6PpD0tkjL
 18DsRNZ9F8y8v0LcgIc8Dox177N86tgNQ0bkE/AO0QNAUv+FAU72VA6sFW4znMLukfzp
 aE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tIVFwxogzwnrFBuYVAn08RcmIO8VOZNo3EoNm0qw4SE=;
 b=Uk8uSKG/++ueAssoa5IopM5ifvK7lJCAyqfFpZV1UfzFo0K+djsxS+bw9pSgOO7amC
 gWCZjzNJF3hhvWjo8oeo7D3VWn8sbxe1vfPUmozwAoIOXWnB1QVOwFtBVR92Jp1YPdR6
 uZCFFHyGsxkafzivAcIuFuWB5g4sTsuqLBI7ALV7aQcHTBwxUtHyeoCCaZIpmxeEllZq
 kjwgfbfh6oysY5OGFvVTAdUm8cBsUP3O6DdhwqHgvBkrsfS3qfitFP1EEePdZT1Prr8J
 zew50pVYnOxwaMAUZATgHWWXFY1H/C8XeMAMhgwb54Z6hASWFs/0lAin9k9f59nmY2W1
 rYrA==
X-Gm-Message-State: APjAAAVlPc1jmTFnTHCFf9MPnxSjGNqjkHt+nwJwPkKhy/9+P2cP9RtU
 qwbVMmZHQgvpSPwQu+VYnKlsZUmDCsu824N87+c=
X-Google-Smtp-Source: APXvYqzu+7nowUD6WGs0Z+UjQMOZWwrZs50vLvLAfBOPc4VMXKnviIPb9uKCnIM4zd51IIYBdeL5zZNuMD38sizxqhU=
X-Received: by 2002:a05:6808:64e:: with SMTP id
 z14mr4980526oih.79.1580057435307; 
 Sun, 26 Jan 2020 08:50:35 -0800 (PST)
MIME-Version: 1.0
References: <324a-5e231180-7-6946d180@169257031>
 <20200120145024.GJ345995@stefanha-x1.localdomain>
 <CAL1e-=in3inmtH=4ZjM2bxnVPJz2GVW4pwTJ8PVkWoqiunPPfA@mail.gmail.com>
 <20200122112818.GA663955@stefanha-x1.localdomain>
In-Reply-To: <20200122112818.GA663955@stefanha-x1.localdomain>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 26 Jan 2020 17:50:24 +0100
Message-ID: <CAL1e-=hJ=vD6Ngy0_w-kGA2X4EP-yni+S0ZTkPKW36moqaBozg@mail.gmail.com>
Subject: Re: [GSoC/Outreachy QEMU project proposal] Measure and Analyze QEMU
 Performance
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 22, 2020 at 12:28 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Tue, Jan 21, 2020 at 03:07:53PM +0100, Aleksandar Markovic wrote:
> > On Mon, Jan 20, 2020 at 3:51 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > >
> > > On Sat, Jan 18, 2020 at 03:08:37PM +0100, Aleksandar Markovic wrote:
> > > > 3) The community will be given all devised performance measurement methods in the form of easily reproducible step-by-step setup and execution procedures.
> > >
> > > Tracking performance is a good idea and something that has not been done
> > > upstream yet.
> >
> > Thanks for the interest, Stefan!
> >
> > >  A few questions:
> > >
> > >  * Will benchmarks be run automatically (e.g. nightly or weekly) on
> > >    someone's hardware or does every TCG architecture maintainer need to
> > >    run them manually for themselves?
> >
> > If the community wants it, definitely yes. Once the methodology is
> > developed, it should be straightforward to setup nightly and/or weekly
> > benchmarks - that could definitely include sending mails with reports
> > to the entire list or just individuals or subgroups. The recipient
> > choice is just a matter or having decent criteria about
> > appropriateness of information within the message (e.g. not to flood
> > the list with the data most people are not really interested).
> >
> > For linux-user tests, they are typically very quick, and nightly tests
> > are quite feasible to run. On someone hardware, of course, and
> > consistently always on the same hardware, if possible. If it makes
> > sense, one could setup multiple test beds with a variety of hardware
> > setups.
> >
> > For system mode tests, I knoe they are much more difficult to
> > automate, and, on top of that, there could be greater risk of
> > hangs/crashes Also, considering the number of machines we support,
> > those tests could consume much more time - perhaps even one day would
> > not be sufficient, if we have many machines and boot/shutdown
> > variants. For these reason, perhaps weekly executions would be more
> > appropriate for them, and, in general, given greater complexity, the
> > expectation from system-mode performance tests should be better kept
> > quite low for now.
> >
> > >  * Where will the benchmark result history be stored?
> > >
> >
> > If emailing is set up, the results could be reconstructed from emails.
> > But, yes, it would be better if the result history is kept somewhere
> > on an internet-connected file server
>
> Thanks.  I don't want to overcomplicate this project.  The main thing is
> to identify the stakeholders (TCG target maintainers?) and make sure
> they are happy.
>

Yes, Stefan, TCG target maintainers would be the main stakeholders. To
some extent, various Machine maintainers would also be stakeholders,
but they will most likely come back to TCG target maintainers looking
for solution. In a literal sense, a number of maintainers were
initially going to be very unhappy seeing the results (for example,
seeing that the machine or entire target performs poorly compared to
similar machines/targets), but after a while they should and will
become happy realizing the problem was identified, and the culprit is
at least approximately determined.

I intentionally wanted to keep the project description simple in order
to be realistic and not develop high expectation among any of us. And
if the student proved to be capable, it will be very easy to add some
more useful tasks for him in this area, to be included in his/hers
GSoC/Outreachy activities.

He had just today one case of performance degradation identified manually:

https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06326.html

This project aims to do these kind of things easier, and possibly in
an automated way. Howard did this by manual measurements for one
particular setup, but this project will cover much much more.

Thanks, Stefan, again for your interest - and everything else!

Aleksandar



> Stefan

