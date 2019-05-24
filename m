Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553FAC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093B020675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk1of27p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093B020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54981 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUAXt-0001Dy-VE
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 09:47:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hUAWn-0000qr-Uc
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hUAWh-00022K-9N
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:46:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hUAWb-0001m4-0k
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:46:22 -0400
Received: by mail-ot1-x344.google.com with SMTP id r7so8725845otn.6
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 06:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=45rQurOypCXf9RH1E3grlOKnKdSm4XQNCb+U8kPZyx4=;
	b=Qk1of27p+7IG//8o+J4MCQJ2l04o3CCkLWVh0tQHiY3682KmhNYRK8WFGhcSOcbCah
	ArwoEw55qXvBakJ6HWUsMtKVqm1i9pDwzDE9VUm1bPCW6us/A0gHD6Ezhv5HAlxe1y8V
	+jJzzOGeAPrPnHVhXC3qcyRS6BykYr8104jmyj/8On+qshL5wd3ILbjVRw7dPDyDqs8E
	lmAcQXbVB9iHG7h4t2BpuHbVSo5YPrar8anFjsJgsBFQEXrHrmEQqe87JuB4W9aO4DVa
	5FAJ8wmcLKIzQDd/5HK0qDZnlmprC2YQ1VqsRiItDuXs3Y2BzfB7wrWM3Z7CQogZZGW8
	1tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=45rQurOypCXf9RH1E3grlOKnKdSm4XQNCb+U8kPZyx4=;
	b=Qf75rMQN1OxVAGbZtJFdVGnWtJ8XxJi/T632vPDdX3f6Kl+zDiYZOkcfix35SIj98S
	JnCnODDymOIeN4I67ZjhrPn0R+XO/sfWW67MKvM+789B++7PYWf1Q5LbmiPB8sdlR6lP
	MdqGzIIZPuJ5qFa3nBaMIRtzRE5o5UQ/2+2mKeD5JZRNpI1zRNlnCDiG5FnTtDQFimw2
	vwp7shThHKG5/7aGnZ1WTzbBh5Q0yQX0RhGxzJssMLRNQt2CkP3DMLUST8cgGFp3vPMF
	ZB7cqa4IHJFpjsFFEdCSBMohh/mBkhBZegz0jwGan/E1eYjPV5sfdTnN52zOOw3Jd/f9
	v8Qg==
X-Gm-Message-State: APjAAAVuuHKkBaCKefBkZrNvlZxPYQj4LqLhNKlxQAhDx9/mT+aJS881
	AM/NVGtwO9thW3KDTbJUxfis6d3YMkBq8j0IyDg=
X-Google-Smtp-Source: APXvYqxM4AYO/+Z3+fk+vxZ75vQ1zVUxShb3mD+T2JDBuKFhBIuGaVnwMMGBKMHKv0tWKseVRVI3E/5rmQrj4Ii8MQ8=
X-Received: by 2002:a05:6830:160a:: with SMTP id
	g10mr143047otr.121.1558705557579; 
	Fri, 24 May 2019 06:45:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Fri, 24 May 2019 06:45:56
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Fri, 24 May 2019 06:45:56
	-0700 (PDT)
In-Reply-To: <20190523213031.GE10764@habkost.net>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190522211230.GA10764@habkost.net>
	<1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
	<20190522230705.GB10764@habkost.net>
	<7a046f76-c892-a796-e7d0-b0eda92075d9@redhat.com>
	<1319868675.24353089.1558618080629.JavaMail.zimbra@redhat.com>
	<20190523213031.GE10764@habkost.net>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 24 May 2019 15:45:56 +0200
Message-ID: <CAL1e-=jqVWxtOCoBayiYhA6D1yxZDA3a3+JrqV3wTDaGbS-eHQ@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
	Cleber Rosa <crosa@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 23, 2019 11:31 PM, "Eduardo Habkost" <ehabkost@redhat.com> wrote:
>
> On Thu, May 23, 2019 at 09:28:00AM -0400, Cleber Rosa wrote:
> >
> >
> > ----- Original Message -----
> > > From: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> > > To: "Eduardo Habkost" <ehabkost@redhat.com>, "Cleber Rosa" <
crosa@redhat.com>
> > > Cc: "Aleksandar Rikalo" <arikalo@wavecomp.com>, "Philippe
Mathieu-Daud=C3=A9" <f4bug@amsat.org>, "Wainer dos Santos
> > > Moschetta" <wainersm@redhat.com>, qemu-devel@nongnu.org, "Aleksandar
Markovic" <aleksandar.m.mail@gmail.com>,
> > > "Aleksandar Markovic" <amarkovic@wavecomp.com>, "Aurelien Jarno" <
aurelien@aurel32.net>
> > > Sent: Thursday, May 23, 2019 5:38:34 AM
> > > Subject: Re: [Qemu-devel] [PATCH 0/4] mips: Add more Avocado tests
> > >
> > > On 5/23/19 1:07 AM, Eduardo Habkost wrote:
> > > > On Wed, May 22, 2019 at 05:46:06PM -0400, Cleber Rosa wrote:
> > > >> ----- Original Message -----
> > > >>> From: "Eduardo Habkost" <ehabkost@redhat.com>
> > > >>> On Tue, May 21, 2019 at 01:19:06AM +0200, Philippe Mathieu-Daud=
=C3=A9
wrote:
> > > >>>> Hi,
> > > >>>>
> > > >>>> It was a rainy week-end here, so I invested it to automatize som=
e
> > > >>>> of my MIPS tests.
> > > >>>>
> > > >>>> The BootLinuxSshTest is not Global warming friendly, it is not
> > > >>>> meant to run on a CI system but rather on a workstation previous
> > > >>>> to post a pull request.
> > > >>>> It can surely be improved, but it is a good starting point.
> > > >>>
> > > >>> Until we actually have a mechanism to exclude the test case on
> > > >>> travis-ci, I will remove patch 4/4 from the queue.  Aleksandar,
> > > >>> please don't merge patch 4/4 yet or it will break travis-ci.
> > > >>>
> > > >>> Cleber, Wainer, is it already possible to make "avocado run" skip
> > > >>> tests tagged with "slow"?
> > > >>>
> > > >>
> > > >> The mechanism exists, but we haven't tagged any test so far as
slow.
> > > >>
> > > >> Should we define/document a criteria for a test to be slow?  Given
> > > >> that this is highly subjective, we have to think of:
> > > >>
> > > >>  * Will we consider the average or maximum run time (the timeout
> > > >>    definition)?
> > > >>
> > > >>  * For a single test, what is "slow"? Some rough numbers from
Travis
> > > >>    CI[1] to help us with guidelines:
> > > >>    - boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:  PASS
(6.04 s)
> > > >>    - boot_linux_console.py:BootLinuxConsole.test_arm_virt:  PASS
(2.91 s)
> > > >>    -
> > > >>
linux_initrd.py:LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_1=
6:
> > > >>    PASS (18.14 s)
> > > >>    - boot_linux.py:BootLinuxAarch64.test_virt:  PASS (396.88 s)
> > > >
> > > > I don't think we need to overthink this.  Whatever objective
> > > > criteria we choose, I'm sure we'll have to adapt them later due
> > > > to real world problems.
> > > >
> > > > e.g.: is 396 seconds too slow?  I don't know, it depends: does it
> > > > break Travis and other CI systems often because of timeouts?  If
> > > > yes, then we should probably tag it as slow.
> > > >
> > > > If having subjective criteria is really a problem (I don't think
> > > > it is), then we can call the tag "skip_travis", and stop worrying
> > > > about defining what exactly is "slow".
> > >
> > > I'd go with a simpler "tags:travis-ci" whitelisting any job expecting
to
> > > run smoothly there.
> > >
> >
> > My concern is what becomes of "make check-acceptance".  Should we
introduce
> > another target, say, "make check-acceptance-ci" or just change its
meaning
> > and reuse it?
>
> What about "make check-acceptance TAG=3Dtravis-ci"?
>
> >
> > > Then we can add "slow" tests without having to worry about
blacklisting
> > > for Travis CI.
> > > Also, Other CI can set different timeouts.
> > >
> > > I'd like maintainers to add as many tests as they want to upstream, s=
o
> > > these tests can eventually run by anyone, then each maintainer is fre=
e
> > > to select which particular set he wants to run as default.
> > >
> >
> > OK, so this matches the idea of carefully curating a set of tests for
> > CI.  WRT white or blacklisting, I favor the approach that requires the
> > least effort from the developer to have its test enabled, so I'd go
> > with blacklisting.  I fear that simple tests will just sit on the repo
> > without being properly exercised if we need to whitelist them.
> >
>
> I agree.  I'd prefer the default case to be simple and not
> require extra tags.  (i.e. tests without any tags would be run in
> Travis by default).
>

Eduardo,

You are confusing me here.

You first suggest:

> What about "make check-acceptance TAG=3Dtravis-ci"?

... and then say:

> ...tests without any tags would be run in Travis by default.

For casual observers like me it is contradictory, I must be missing
something here, no?

Regards,
Aleksandar

> --
> Eduardo
