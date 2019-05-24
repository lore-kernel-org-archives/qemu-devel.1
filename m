Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2CCC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 20:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B3920868
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 20:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbPThJk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B3920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUGtA-00022e-Ti
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 16:34:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hUGrp-0001Ih-Cr
	for qemu-devel@nongnu.org; Fri, 24 May 2019 16:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hUGrn-00050R-HC
	for qemu-devel@nongnu.org; Fri, 24 May 2019 16:32:41 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hUGrn-0004zP-6T
	for qemu-devel@nongnu.org; Fri, 24 May 2019 16:32:39 -0400
Received: by mail-ot1-x343.google.com with SMTP id s19so9851414otq.5
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 13:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=M2De66r36ffarReiDsq9zsHIwTVFhFn8Uv/cUuOYmc0=;
	b=ZbPThJk+tSu+hrR4Enra+IdNk4txwg5qyvGNS3j0KriuqwZXoMDOGPA4ZAJSA/Z3dT
	ESzC3qmpOK0Mil9Blf0Qu7+RAIJytwZqKC4SAb+yFWIl6zLFgpRMUxpQ1BOZqf3Ps0y+
	hiMMd+mZ+X85Yw3+S0Jjv47uJHKq9kIYmr35FFjfa/n7of3zBDA64AhYKQDId3LjDCAX
	ofgN9RVqfKnsgAXG60GwSvPre88gdR4bKObBcW9PdXWil4qWD7uWmJlyjEkac2WmbO68
	z+wndXWPgLgNDQxq/31jd6AnakAQ6sqJTxJvirdwF4P9Xopn3YZ26Cr17sFqkxqANTA0
	Swig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=M2De66r36ffarReiDsq9zsHIwTVFhFn8Uv/cUuOYmc0=;
	b=fA9SvfglZ9VlxFVpYU5XxqFKkbXUJsp/Orwp6JYqSzuJ/565VimFD9WU+w9dc93oKL
	21DzH4ZWrigw3FEBuGjjr52d2cAXxcmz3K+W5UfwAkW9oVr/N6zyI+4S6n6vTGUQQuus
	LrvT0Dp9LbxP6roUY6CWArQWL52LyDP6hYFRk9XAAmcFhH3e/h6WOouUbQ7ODDczyrMa
	06psBLTWlnYW8XhIewXSkRb8x2nDN+EaQU4oB0SKWmlQaiB1OR0KnJ4lwLf6/JUWsaNC
	x7AOcYL4Mq7S1vfWRR7yjF7FvrgGsTZtaPT0sPDxpy/VhbSgYE97bpki7WontTZjASnR
	N9oA==
X-Gm-Message-State: APjAAAXEfko/FcBDWMab6CxJSC7z7wu4ZILAW5Dd6+XxTsLxZ/8Nnbsd
	rDOC8mm2TwRkspJgaLaDWogxFe2SU1nRArf2/lk=
X-Google-Smtp-Source: APXvYqzjNWjWUkBr9wVpGTICCJgypoS8qtCIqu4ZqlCVhZCvC25RWicyqjJXp5Y7BCfG2xZrjOv59EL1JT8RMY+jh1s=
X-Received: by 2002:a9d:7858:: with SMTP id c24mr230106otm.64.1558729957497;
	Fri, 24 May 2019 13:32:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Fri, 24 May 2019 13:32:36
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Fri, 24 May 2019 13:32:36
	-0700 (PDT)
In-Reply-To: <20190524193955.GN10764@habkost.net>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190522211230.GA10764@habkost.net>
	<1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
	<CAL1e-=iW2honEgNfrsFoA0tU1wMq0mw5LuoRbWVmRDBMA22ELA@mail.gmail.com>
	<1094559891.24356881.1558619101528.JavaMail.zimbra@redhat.com>
	<CAL1e-=ikyNrfwBR_UW8wwCNHQjLWxhcfrTdde54OP4phkdvqHA@mail.gmail.com>
	<b4252e21-a82c-2e1b-7a3f-ed13cb3fba36@amsat.org>
	<20190524193955.GN10764@habkost.net>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 24 May 2019 22:32:36 +0200
Message-ID: <CAL1e-=h-4RNGYtBPL9PEHux6qYUXAmi_2BqpgPM+j4MiWfn3iA@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 24, 2019 9:40 PM, "Eduardo Habkost" <ehabkost@redhat.com> wrote:
>
> On Thu, May 23, 2019 at 07:27:35PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 5/23/19 7:11 PM, Aleksandar Markovic wrote:
> > > On May 23, 2019 3:45 PM, "Cleber Rosa" <crosa@redhat.com> wrote:
> > >>> From: "Aleksandar Markovic" <aleksandar.m.mail@gmail.com>
> > >>> On May 22, 2019 11:46 PM, "Cleber Rosa" <crosa@redhat.com> wrote:
> > >>>>> From: "Eduardo Habkost" <ehabkost@redhat.com>
> > >>>>>
> > >>>>> Until we actually have a mechanism to exclude the test case on
> > >>>>> travis-ci, I will remove patch 4/4 from the queue.  Aleksandar,
> > >>>>> please don't merge patch 4/4 yet or it will break travis-ci.
> > >>>>>
> > >>>>> Cleber, Wainer, is it already possible to make "avocado run" skip
> > >>>>> tests tagged with "slow"?
> > >>>>>
> > >>>>
> > >>>> The mechanism exists, but we haven't tagged any test so far as
slow.
> > >>>>
> > >>>
> > >>> Cleber,
> > >>>
> > >>> For the test from patch 4/4, there is no dilemma - it should be in
the
> > >>> =E2=80=9Cslow=E2=80=9D group, as Philippe envisioned and said, so t=
hat it is not
> > > humpered
> > >>> with stricter requirements for =E2=80=9Cfast=E2=80=9D (default) gro=
up. Could you
> > > explain us
> > >>> how to do it, so that we can hopefully finally proceed?
> > >>>
> > >>
> > >> Hi Aleksandar,
> > >>
> > >> The point is that there's no "group" definition at this point.  This
is
> > > the
> > >> core of the discussion.
> > >>
> > >> I think we're close to converging to something simple and effective.
> > > Please
> > >> let us know what you think of the proposals given.
> > >>
> > >> Thanks!
> > >> - Cleber.
> > >>
> > >
> > > Cleber, hi.
> > >
> > > Thanks for responding.
> > >
> > > My views are very similar to Philippe's, but I will provide you with
more
> > > details of our (mips) perspective.
> > >
> > > As far as black/whitelist issues that is a moot point for us - we
only want
> > > to be able to have a way to tag a test within the test itself (so,
without
> > > updating some common files, external lists,etc.)
> > >
> > > In general, we would like to have a test environment where we would
be able
> > > to test what WE deem suitable for us, without feeling that we bother
you or
> > > anybody else, or that we are bothered by others.
> > >
> > > Let me give you a little extreme example: Let's say we want a complex
test
> > > that downloads components from let's say fifty internet location,
executes
> > > zillion test cases, and last two days. I wouldn't like anybody to ask
me
> > > =E2=80=9CWhy would you that?=E2=80=9D or tell me =E2=80=9CYou can't d=
o this.=E2=80=9D or say =E2=80=9CNo, we
did
> > > not anticipate such tests, patch rejected.=E2=80=9D I (we, people fro=
m mips)
should
> > > be able to define what I (we) need.
> >
> > Maybe we can use subdirectory like we do for the TCG tests (Aleksandar
> > maintains tests/tcg/mips/). We should try to keep contribution upstream=
,
> > so good idea/pattern can be reused by others.
> >
> > What I'd like to have with those tests is, at least:
> >
> > 1/ we don't need to run all the tests (but there is a set of 'quick'
> > tests we can run on daily basis)
> >
> > 2/ maintainers can run their default tests easily (using a combination
> > of Avocado tags)
> >
> > 3/ if a developer working on the PCI subsystem has to modify the MIPS
> > subsystem (for example), he should be able to run the MIPS tests before
> > sending his series.
>
> Keeping the test cases organized in subdirectories are a good
> idea, but don't think this is going to help us when we need to
> quickly enable/disable specific test cases on some CI systems.
>

Well, Eduardo, nobody said that directory locations should be used for
enabling/disabling or tagging/untagging tests in the first place. I think
it was clear for everybody from the outset that these features should have
their own mechanisms, which Cleber says already exist, but can't be used
because the test group still can't figure out (in some hamletesque way)
whether to blacklist or to whitelist, or how to name the tag for travis,
and tag for not travis, and if such tags should even exist, etc. - that is
my layman impression from recent discussions. And now when Philippe
suggested (in my opinion logical and reasonable) subdirectory, an endless
discussion begins: =E2=80=9CTo subdirectory or not to subdirectory? That is=
 the
question.=E2=80=9D Meanwhile, 4.1 is inexorably getting closer and closer, =
and with
each day, the value of any potential tests is decreasing.

Directory structure should be used in its usual and basic way: for
clustering files of similar nature, purpose, or origin, and I do certainly
support any reasonable subdirectory organization for your directory - and
you should think about it, and probably while doing that consult a little
bit other people from all walks of QEMU. We are ready to comply with your
final decision.

The good thing is that nothing is set in stone, everything can be changed
and improved, moving files is easy in git.

All that said, many thanks for reviewing patch 4/4.

Aleksandar



> Disabling a test case (or an entire category of test cases) known
> to be failing on some CI systems should require a one line patch,
> not moving files to a separate directory.
>
> >
> > > Having such test would be a big deal for me, not only that I could
run it
> > > manually or automatically every weekend, but I could ask submitters o=
f
> > > critical changes: =E2=80=9CDid you run this test that we have in Avoc=
ado
dir?=E2=80=9D,
> > > without specifying test details, procedures, etc. All this is a BIG
deal
> > > for me.
> > >
> > > On the other hand, I agree that certain group of tests (envisioned fo=
r
> > > daily or so Travis CI) should have some stricter limitations and
structure.
> > > But right now I feel humpered by it, and this is counterproductive.
> > >
> > > So, we want freedom, responsibility and ownersheep of our tests.
Please
> > > give us the opportunity to get down on business and start writing
tests and
> > > start testing.
> > >
> > > Yours,
> > > Aleksandar
>
> --
> Eduardo
