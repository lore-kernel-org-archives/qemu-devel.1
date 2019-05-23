Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6303EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5EC217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at2qovJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5EC217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41211 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTrkd-0001yi-Ew
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 13:43:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTrjp-0001fW-VL
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTrjo-0008PT-E1
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:42:45 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hTrjo-0008Oz-7X
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:42:44 -0400
Received: by mail-oi1-x244.google.com with SMTP id q186so5045099oia.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 10:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=Ki7kHos6OA/IvqJPGevQKrqEjDiSZ+djnCfr6seCbpI=;
	b=at2qovJ7oH+SSYdyaqQhjTo5ZXxi2/QDKijbvbIBhtigxU50xEAYl0a8QZeoTn/AJl
	RtEPN3WJPIfAk7J11y86rYmrQRMwFjD4CBVVHKozKjwg4JvGzZC0i12yWJI5jm3ixtLO
	dAj4qRMstnYsKqIh36cxS0HaPbdIp4ZFAv/EhhIQKjZCwmV+IsMkijkoemXF8SALte3G
	rRlcXWJsNcQ6Q88QifrhEVZxo7AJlx7PXMNbC+R60ZUKhxgC1D/0tFl0R/7YvSGNXfXE
	dX+t4UwWQe1RSyMMl+qotgqAYPXbn/h6jDerB+U2sBSDmqosVvm/KyD98NnAmkFCa3PL
	XwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=Ki7kHos6OA/IvqJPGevQKrqEjDiSZ+djnCfr6seCbpI=;
	b=XfC8XT1vmdAAky3J1vqzAg7bM3FSCUr1l5xD+y0hZxGzpdfVAkuMvJLKv5RQEZ/NEk
	zEHOEl9z7LOO+o7N4n9oMb5Pl4nvhz2YIEBHhWebVGdtlCr4AZfj2e46mM7ss1GlsvmA
	0bc6VTZ4hR0ge8UPSrlrQCpgJ1i3FNyoRtRYuSJ3W8u7u5aeVTwN+OHnETZ11QuRRwoN
	GUF4+BU7fZyC7x/Qpqer/8QQ108rnFczfCmj85V4u3vL0qSM4wQmpexpwuCh3FeQrYlf
	nMuXthwYIk3rlxchbxY0LmW6Jn3wtfjL8nBfkJQTF10AKQrRdHPTH/KraCZ18PYTWHTX
	KERg==
X-Gm-Message-State: APjAAAUGAUGYtuGG8glfGYLwpYnWmwvAzXJBSGqlK2CHTUV/LEO+nqml
	xe+O30yi+HA3w35skQ5ImI9BXFPxLgsUEJd+xYA=
X-Google-Smtp-Source: APXvYqxTkpj50IOpEiEjSHhn0D4FIcy2UYG9WH0f/rsGN+7dAvu3ItFvo3FxhmZlXLtdtU83r2fH8BoZsxhmNJfNkOk=
X-Received: by 2002:aca:b50b:: with SMTP id e11mr3508783oif.53.1558633363289; 
	Thu, 23 May 2019 10:42:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Thu, 23 May 2019 10:42:42
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Thu, 23 May 2019 10:42:42
	-0700 (PDT)
In-Reply-To: <b4252e21-a82c-2e1b-7a3f-ed13cb3fba36@amsat.org>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190522211230.GA10764@habkost.net>
	<1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
	<CAL1e-=iW2honEgNfrsFoA0tU1wMq0mw5LuoRbWVmRDBMA22ELA@mail.gmail.com>
	<1094559891.24356881.1558619101528.JavaMail.zimbra@redhat.com>
	<CAL1e-=ikyNrfwBR_UW8wwCNHQjLWxhcfrTdde54OP4phkdvqHA@mail.gmail.com>
	<b4252e21-a82c-2e1b-7a3f-ed13cb3fba36@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 23 May 2019 19:42:42 +0200
Message-ID: <CAL1e-=hg4v=9B=xN44ttgK+cJ-siyL63Yv8M0zKMkuwrXmcBBg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 0/4] mips: Add more Avocado tests
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 23, 2019 7:27 PM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> wr=
ote:
>
> On 5/23/19 7:11 PM, Aleksandar Markovic wrote:
> > On May 23, 2019 3:45 PM, "Cleber Rosa" <crosa@redhat.com> wrote:
> >>> From: "Aleksandar Markovic" <aleksandar.m.mail@gmail.com>
> >>> On May 22, 2019 11:46 PM, "Cleber Rosa" <crosa@redhat.com> wrote:
> >>>>> From: "Eduardo Habkost" <ehabkost@redhat.com>
> >>>>>
> >>>>> Until we actually have a mechanism to exclude the test case on
> >>>>> travis-ci, I will remove patch 4/4 from the queue.  Aleksandar,
> >>>>> please don't merge patch 4/4 yet or it will break travis-ci.
> >>>>>
> >>>>> Cleber, Wainer, is it already possible to make "avocado run" skip
> >>>>> tests tagged with "slow"?
> >>>>>
> >>>>
> >>>> The mechanism exists, but we haven't tagged any test so far as slow.
> >>>>
> >>>
> >>> Cleber,
> >>>
> >>> For the test from patch 4/4, there is no dilemma - it should be in th=
e
> >>> =E2=80=9Cslow=E2=80=9D group, as Philippe envisioned and said, so tha=
t it is not
> > humpered
> >>> with stricter requirements for =E2=80=9Cfast=E2=80=9D (default) group=
. Could you
> > explain us
> >>> how to do it, so that we can hopefully finally proceed?
> >>>
> >>
> >> Hi Aleksandar,
> >>
> >> The point is that there's no "group" definition at this point.  This i=
s
> > the
> >> core of the discussion.
> >>
> >> I think we're close to converging to something simple and effective.
> > Please
> >> let us know what you think of the proposals given.
> >>
> >> Thanks!
> >> - Cleber.
> >>
> >
> > Cleber, hi.
> >
> > Thanks for responding.
> >
> > My views are very similar to Philippe's, but I will provide you with
more
> > details of our (mips) perspective.
> >
> > As far as black/whitelist issues that is a moot point for us - we only
want
> > to be able to have a way to tag a test within the test itself (so,
without
> > updating some common files, external lists,etc.)
> >
> > In general, we would like to have a test environment where we would be
able
> > to test what WE deem suitable for us, without feeling that we bother
you or
> > anybody else, or that we are bothered by others.
> >
> > Let me give you a little extreme example: Let's say we want a complex
test
> > that downloads components from let's say fifty internet location,
executes
> > zillion test cases, and last two days. I wouldn't like anybody to ask m=
e
> > =E2=80=9CWhy would you that?=E2=80=9D or tell me =E2=80=9CYou can't do =
this.=E2=80=9D or say =E2=80=9CNo, we did
> > not anticipate such tests, patch rejected.=E2=80=9D I (we, people from =
mips)
should
> > be able to define what I (we) need.
>
> Maybe we can use subdirectory like we do for the TCG tests (Aleksandar
> maintains tests/tcg/mips/). We should try to keep contribution upstream,
> so good idea/pattern can be reused by others.
>
> What I'd like to have with those tests is, at least:
>
> 1/ we don't need to run all the tests (but there is a set of 'quick'
> tests we can run on daily basis)
>
> 2/ maintainers can run their default tests easily (using a combination
> of Avocado tags)
>
> 3/ if a developer working on the PCI subsystem has to modify the MIPS
> subsystem (for example), he should be able to run the MIPS tests before
> sending his series.
>

Exactly! Excellent ideas and examples!

> > Having such test would be a big deal for me, not only that I could run
it
> > manually or automatically every weekend, but I could ask submitters of
> > critical changes: =E2=80=9CDid you run this test that we have in Avocad=
o dir?=E2=80=9D,
> > without specifying test details, procedures, etc. All this is a BIG dea=
l
> > for me.
> >
> > On the other hand, I agree that certain group of tests (envisioned for
> > daily or so Travis CI) should have some stricter limitations and
structure.
> > But right now I feel humpered by it, and this is counterproductive.
> >
> > So, we want freedom, responsibility and ownersheep of our tests. Please
> > give us the opportunity to get down on business and start writing tests
and
> > start testing.
> >
> > Yours,
> > Aleksandar
