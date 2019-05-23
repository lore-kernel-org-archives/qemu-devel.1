Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98034C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C9E20675
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNzAH7h3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C9E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40915 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTrGk-0007XV-3e
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 13:12:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTrFX-0006t9-Hq
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTrFV-0004Uj-7T
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:11:27 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:35089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hTrFS-0004QJ-Ni
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:11:24 -0400
Received: by mail-oi1-x22e.google.com with SMTP id a132so4964070oib.2
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 10:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=X6V2wQgbJAWIV2kwynuSyGWOweAkC/QJMgu++xqGQsw=;
	b=SNzAH7h302KxXXQparmmTtFm5vLXiIpbyLgwV7iqaSCocndVb08Qy4yk76+V4WmZXu
	2b1ZfET6co4NhlkCdwxcJFB55f8WhFYF6Yyq2GBZ7g5hW2mzLX+nE5X8Cpo2N0H40N4x
	T2Z5cJewiRGWxef9OTdXu2j78KBwqcFBKEwPvnA0YGQt5MTwMshExXU8kHBFcAMRGeiG
	Oo0LUNO1XspHFMOiGDN0OSJuBNytEjkGLOgqRoaZzDVuA5VTQrPIoSxscARWeRDyDpPu
	LyaAvOQEhf9vkHUP04haaVsfrO6ZHTLswqBAhq3XI//R64Dzb63bFhPx9YwUj+jDWl2V
	BSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=X6V2wQgbJAWIV2kwynuSyGWOweAkC/QJMgu++xqGQsw=;
	b=ffd1yUqI3GrRHvdU/3zJq7FDKFKpTMIt8fZAYFdY6oqwGAPZyaIJ520nos5igZv5Io
	8MCB8q/bFr4KhgylSQLIXpLGt+lDlorKlZYoMZqS8qk6wvneBEcj5DcfNXPTrO+/2nRk
	BWFn42ZmYYefydXUiZj3FoIBddJoEH4Sn1X2B/1n2kbQPkSd4hw5EZh2ZyeSFaRHKiAB
	EfeP0vIsSENTBYS1aekaGpN/ssZ5pVmQMOXOHoadbIFjKS5E4dcI2gKfyIBv+24vSyoG
	G6Gi5mFtU2LNwitWfJeDe2LAJu21zFay4r/7FXbNjVTPbgeA1YpWKoHa4n/Xq4/s7et1
	Efvg==
X-Gm-Message-State: APjAAAW87Nl7xVTDc36RdgUEpcb/WFBW/zlSMAyFROi2PHokOkQOv4Us
	uttoKIqBNyb6per1kog2IVLvv5EMBEF0XbO+RkI=
X-Google-Smtp-Source: APXvYqzNUHuHBPP16y848x+jOmQWIoZ1T7PxLtlorOGqBGvOS4RXbLoF4RC8RKy/u00ysyrW9KNZP+ly7V2yrlNQB3s=
X-Received: by 2002:aca:b50b:: with SMTP id e11mr3418114oif.53.1558631476706; 
	Thu, 23 May 2019 10:11:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Thu, 23 May 2019 10:11:15
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Thu, 23 May 2019 10:11:15
	-0700 (PDT)
In-Reply-To: <1094559891.24356881.1558619101528.JavaMail.zimbra@redhat.com>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190522211230.GA10764@habkost.net>
	<1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
	<CAL1e-=iW2honEgNfrsFoA0tU1wMq0mw5LuoRbWVmRDBMA22ELA@mail.gmail.com>
	<1094559891.24356881.1558619101528.JavaMail.zimbra@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 23 May 2019 19:11:15 +0200
Message-ID: <CAL1e-=ikyNrfwBR_UW8wwCNHQjLWxhcfrTdde54OP4phkdvqHA@mail.gmail.com>
To: Cleber Rosa <crosa@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 23, 2019 3:45 PM, "Cleber Rosa" <crosa@redhat.com> wrote:
>
>
>
> ----- Original Message -----
> > From: "Aleksandar Markovic" <aleksandar.m.mail@gmail.com>
> > To: "Cleber Rosa" <crosa@redhat.com>
> > Cc: "Wainer dos Santos Moschetta" <wainersm@redhat.com>, "Aleksandar
Markovic" <amarkovic@wavecomp.com>,
> > qemu-devel@nongnu.org, "Aleksandar Rikalo" <arikalo@wavecomp.com>,
"Eduardo Habkost" <ehabkost@redhat.com>,
> > "Aurelien Jarno" <aurelien@aurel32.net>, "Philippe Mathieu-Daud=C3=A9" =
<
f4bug@amsat.org>
> > Sent: Wednesday, May 22, 2019 6:43:54 PM
> > Subject: Re: [Qemu-devel] [PATCH 0/4] mips: Add more Avocado tests
> >
> > On May 22, 2019 11:46 PM, "Cleber Rosa" <crosa@redhat.com> wrote:
> > >
> > >
> > >
> > > ----- Original Message -----
> > > > From: "Eduardo Habkost" <ehabkost@redhat.com>
> > > > To: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> > > > Cc: qemu-devel@nongnu.org, "Aleksandar Rikalo" <arikalo@wavecomp.co=
m
>,
> > "Aleksandar Markovic"
> > > > <aleksandar.m.mail@gmail.com>, "Aleksandar Markovic" <
> > amarkovic@wavecomp.com>, "Cleber Rosa" <crosa@redhat.com>,
> > > > "Aurelien Jarno" <aurelien@aurel32.net>, "Wainer dos Santos
Moschetta" <
> > wainersm@redhat.com>
> > > > Sent: Wednesday, May 22, 2019 5:12:30 PM
> > > > Subject: Re: [Qemu-devel] [PATCH 0/4] mips: Add more Avocado tests
> > > >
> > > > On Tue, May 21, 2019 at 01:19:06AM +0200, Philippe Mathieu-Daud=C3=
=A9
wrote:
> > > > > Hi,
> > > > >
> > > > > It was a rainy week-end here, so I invested it to automatize some
> > > > > of my MIPS tests.
> > > > >
> > > > > The BootLinuxSshTest is not Global warming friendly, it is not
> > > > > meant to run on a CI system but rather on a workstation previous
> > > > > to post a pull request.
> > > > > It can surely be improved, but it is a good starting point.
> > > >
> > > > Until we actually have a mechanism to exclude the test case on
> > > > travis-ci, I will remove patch 4/4 from the queue.  Aleksandar,
> > > > please don't merge patch 4/4 yet or it will break travis-ci.
> > > >
> > > > Cleber, Wainer, is it already possible to make "avocado run" skip
> > > > tests tagged with "slow"?
> > > >
> > >
> > > The mechanism exists, but we haven't tagged any test so far as slow.
> > >
> >
> > Cleber,
> >
> > For the test from patch 4/4, there is no dilemma - it should be in the
> > =E2=80=9Cslow=E2=80=9D group, as Philippe envisioned and said, so that =
it is not
humpered
> > with stricter requirements for =E2=80=9Cfast=E2=80=9D (default) group. =
Could you
explain us
> > how to do it, so that we can hopefully finally proceed?
> >
>
> Hi Aleksandar,
>
> The point is that there's no "group" definition at this point.  This is
the
> core of the discussion.
>
> I think we're close to converging to something simple and effective.
Please
> let us know what you think of the proposals given.
>
> Thanks!
> - Cleber.
>

Cleber, hi.

Thanks for responding.

My views are very similar to Philippe's, but I will provide you with more
details of our (mips) perspective.

As far as black/whitelist issues that is a moot point for us - we only want
to be able to have a way to tag a test within the test itself (so, without
updating some common files, external lists,etc.)

In general, we would like to have a test environment where we would be able
to test what WE deem suitable for us, without feeling that we bother you or
anybody else, or that we are bothered by others.

Let me give you a little extreme example: Let's say we want a complex test
that downloads components from let's say fifty internet location, executes
zillion test cases, and last two days. I wouldn't like anybody to ask me
=E2=80=9CWhy would you that?=E2=80=9D or tell me =E2=80=9CYou can't do this=
.=E2=80=9D or say =E2=80=9CNo, we did
not anticipate such tests, patch rejected.=E2=80=9D I (we, people from mips=
) should
be able to define what I (we) need.

Having such test would be a big deal for me, not only that I could run it
manually or automatically every weekend, but I could ask submitters of
critical changes: =E2=80=9CDid you run this test that we have in Avocado di=
r?=E2=80=9D,
without specifying test details, procedures, etc. All this is a BIG deal
for me.

On the other hand, I agree that certain group of tests (envisioned for
daily or so Travis CI) should have some stricter limitations and structure.
But right now I feel humpered by it, and this is counterproductive.

So, we want freedom, responsibility and ownersheep of our tests. Please
give us the opportunity to get down on business and start writing tests and
start testing.

Yours,
Aleksandar

> > Gratefully,
> > Aleksandar
> >
> > > Should we define/document a criteria for a test to be slow?  Given
> > > that this is highly subjective, we have to think of:
> > >
> > >  * Will we consider the average or maximum run time (the timeout
> > >    definition)?
> > >
> > >  * For a single test, what is "slow"? Some rough numbers from Travis
> > >    CI[1] to help us with guidelines:
> > >    - boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:  PASS
(6.04 s)
> > >    - boot_linux_console.py:BootLinuxConsole.test_arm_virt:  PASS
(2.91 s)
> > >    -
> >
linux_initrd.py:LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_1=
6:
> > PASS (18.14 s)
> > >    - boot_linux.py:BootLinuxAarch64.test_virt:  PASS (396.88 s)
> > >
> > >  * Do we want to set a maximum job timeout?  This way we can skip
> > >    tests after a given amount of time has passed.  Currently we
interrupt
> > >    the test running when the job timeout is reached, but it's possibl=
e
> > >    to add a option so that no new tests will be started, but currentl=
y
> > >    running ones will be waited on.
> > >
> > > Regards,
> > > - Cleber.
> > >
> > > [1] - https://travis-ci.org/clebergnu/qemu/jobs/535967210#L3518
> > >
> > > > --
> > > > Eduardo
> > > >
> >
