Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AD0C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAEB20881
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAEB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36482 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnvg-00071q-L7
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:38:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hTnlY-0006xw-Mk
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hTnlX-0000EF-Bc
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:28:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hTnlX-0000D2-3l
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:28:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41B15300194A;
	Thu, 23 May 2019 13:28:09 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 09C5B67607;
	Thu, 23 May 2019 13:28:04 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 8DE4B5B423;
	Thu, 23 May 2019 13:28:03 +0000 (UTC)
Date: Thu, 23 May 2019 09:28:00 -0400 (EDT)
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <1319868675.24353089.1558618080629.JavaMail.zimbra@redhat.com>
In-Reply-To: <7a046f76-c892-a796-e7d0-b0eda92075d9@redhat.com>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190522211230.GA10764@habkost.net>
	<1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
	<20190522230705.GB10764@habkost.net>
	<7a046f76-c892-a796-e7d0-b0eda92075d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.36.116.137, 10.4.195.24]
Thread-Topic: mips: Add more Avocado tests
Thread-Index: mkxBB8IsPIcjcTrJ60vGqLCcYiO5ng==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 23 May 2019 13:28:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> To: "Eduardo Habkost" <ehabkost@redhat.com>, "Cleber Rosa" <crosa@redhat.=
com>
> Cc: "Aleksandar Rikalo" <arikalo@wavecomp.com>, "Philippe Mathieu-Daud=C3=
=A9" <f4bug@amsat.org>, "Wainer dos Santos
> Moschetta" <wainersm@redhat.com>, qemu-devel@nongnu.org, "Aleksandar Mark=
ovic" <aleksandar.m.mail@gmail.com>,
> "Aleksandar Markovic" <amarkovic@wavecomp.com>, "Aurelien Jarno" <aurelie=
n@aurel32.net>
> Sent: Thursday, May 23, 2019 5:38:34 AM
> Subject: Re: [Qemu-devel] [PATCH 0/4] mips: Add more Avocado tests
>=20
> On 5/23/19 1:07 AM, Eduardo Habkost wrote:
> > On Wed, May 22, 2019 at 05:46:06PM -0400, Cleber Rosa wrote:
> >> ----- Original Message -----
> >>> From: "Eduardo Habkost" <ehabkost@redhat.com>
> >>> On Tue, May 21, 2019 at 01:19:06AM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
> >>>> Hi,
> >>>>
> >>>> It was a rainy week-end here, so I invested it to automatize some
> >>>> of my MIPS tests.
> >>>>
> >>>> The BootLinuxSshTest is not Global warming friendly, it is not
> >>>> meant to run on a CI system but rather on a workstation previous
> >>>> to post a pull request.
> >>>> It can surely be improved, but it is a good starting point.
> >>>
> >>> Until we actually have a mechanism to exclude the test case on
> >>> travis-ci, I will remove patch 4/4 from the queue.  Aleksandar,
> >>> please don't merge patch 4/4 yet or it will break travis-ci.
> >>>
> >>> Cleber, Wainer, is it already possible to make "avocado run" skip
> >>> tests tagged with "slow"?
> >>>
> >>
> >> The mechanism exists, but we haven't tagged any test so far as slow.
> >>
> >> Should we define/document a criteria for a test to be slow?  Given
> >> that this is highly subjective, we have to think of:
> >>
> >>  * Will we consider the average or maximum run time (the timeout
> >>    definition)?
> >> =20
> >>  * For a single test, what is "slow"? Some rough numbers from Travis
> >>    CI[1] to help us with guidelines:
> >>    - boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:  PASS (6.0=
4 s)
> >>    - boot_linux_console.py:BootLinuxConsole.test_arm_virt:  PASS (2.91=
 s)
> >>    -
> >>    linux_initrd.py:LinuxInitrd.test_with_2gib_file_should_work_with_li=
nux_v4_16:
> >>    PASS (18.14 s)
> >>    - boot_linux.py:BootLinuxAarch64.test_virt:  PASS (396.88 s)
> >=20
> > I don't think we need to overthink this.  Whatever objective
> > criteria we choose, I'm sure we'll have to adapt them later due
> > to real world problems.
> >=20
> > e.g.: is 396 seconds too slow?  I don't know, it depends: does it
> > break Travis and other CI systems often because of timeouts?  If
> > yes, then we should probably tag it as slow.
> >=20
> > If having subjective criteria is really a problem (I don't think
> > it is), then we can call the tag "skip_travis", and stop worrying
> > about defining what exactly is "slow".
>=20
> I'd go with a simpler "tags:travis-ci" whitelisting any job expecting to
> run smoothly there.
>=20

My concern is what becomes of "make check-acceptance".  Should we introduce
another target, say, "make check-acceptance-ci" or just change its meaning
and reuse it?

> Then we can add "slow" tests without having to worry about blacklisting
> for Travis CI.
> Also, Other CI can set different timeouts.
>=20
> I'd like maintainers to add as many tests as they want to upstream, so
> these tests can eventually run by anyone, then each maintainer is free
> to select which particular set he wants to run as default.
>=20

OK, so this matches the idea of carefully curating a set of tests for
CI.  WRT white or blacklisting, I favor the approach that requires the
least effort from the developer to have its test enabled, so I'd go
with blacklisting.  I fear that simple tests will just sit on the repo
without being properly exercised if we need to whitelist them.

But, I'll certainly and gladly accept the majority's opinion here. =20

Regards,
- Cleber.

> >>  * Do we want to set a maximum job timeout?  This way we can skip
> >>    tests after a given amount of time has passed.  Currently we interr=
upt
> >>    the test running when the job timeout is reached, but it's possible
> >>    to add a option so that no new tests will be started, but currently
> >>    running ones will be waited on.
> >=20
> > I'm not sure I understand the suggestion to skip tests.  If we
> > skip tests after a timeout, how would we differentiate a test
> > being expectedly slow from a QEMU hang?
> >=20
>=20


