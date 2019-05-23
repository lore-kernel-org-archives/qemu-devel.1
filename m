Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60840C282CE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 02:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02AAA21019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 02:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AAA21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56186 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTd6v-00073e-V6
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 22:05:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hTd5e-0006Jm-F5
	for qemu-devel@nongnu.org; Wed, 22 May 2019 22:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hTctS-0001rc-G8
	for qemu-devel@nongnu.org; Wed, 22 May 2019 21:51:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hTctR-0001qW-OR
	for qemu-devel@nongnu.org; Wed, 22 May 2019 21:51:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D0E66698A;
	Thu, 23 May 2019 01:51:40 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B36E9544F8;
	Thu, 23 May 2019 01:51:36 +0000 (UTC)
Date: Wed, 22 May 2019 22:51:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190523015134.GC10764@habkost.net>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190522211230.GA10764@habkost.net>
	<1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
	<20190522230705.GB10764@habkost.net>
	<1603108978.24224480.1558573457497.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1603108978.24224480.1558573457497.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 23 May 2019 01:51:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 22, 2019 at 09:04:17PM -0400, Cleber Rosa wrote:
>=20
>=20
> ----- Original Message -----
> > From: "Eduardo Habkost" <ehabkost@redhat.com>
> > To: "Cleber Rosa" <crosa@redhat.com>
> > Cc: "Philippe Mathieu-Daud=E9" <f4bug@amsat.org>, qemu-devel@nongnu.o=
rg, "Aleksandar Rikalo" <arikalo@wavecomp.com>,
> > "Aleksandar Markovic" <aleksandar.m.mail@gmail.com>, "Aleksandar Mark=
ovic" <amarkovic@wavecomp.com>, "Aurelien
> > Jarno" <aurelien@aurel32.net>, "Wainer dos Santos Moschetta" <wainers=
m@redhat.com>
> > Sent: Wednesday, May 22, 2019 7:07:05 PM
> > Subject: Re: [Qemu-devel] [PATCH 0/4] mips: Add more Avocado tests
> >=20
> > On Wed, May 22, 2019 at 05:46:06PM -0400, Cleber Rosa wrote:
> > >=20
> > >=20
> > > ----- Original Message -----
> > > > From: "Eduardo Habkost" <ehabkost@redhat.com>
> > > > To: "Philippe Mathieu-Daud=E9" <f4bug@amsat.org>
> > > > Cc: qemu-devel@nongnu.org, "Aleksandar Rikalo" <arikalo@wavecomp.=
com>,
> > > > "Aleksandar Markovic"
> > > > <aleksandar.m.mail@gmail.com>, "Aleksandar Markovic"
> > > > <amarkovic@wavecomp.com>, "Cleber Rosa" <crosa@redhat.com>,
> > > > "Aurelien Jarno" <aurelien@aurel32.net>, "Wainer dos Santos Mosch=
etta"
> > > > <wainersm@redhat.com>
> > > > Sent: Wednesday, May 22, 2019 5:12:30 PM
> > > > Subject: Re: [Qemu-devel] [PATCH 0/4] mips: Add more Avocado test=
s
> > > >=20
> > > > On Tue, May 21, 2019 at 01:19:06AM +0200, Philippe Mathieu-Daud=E9=
 wrote:
> > > > > Hi,
> > > > >=20
> > > > > It was a rainy week-end here, so I invested it to automatize so=
me
> > > > > of my MIPS tests.
> > > > >=20
> > > > > The BootLinuxSshTest is not Global warming friendly, it is not
> > > > > meant to run on a CI system but rather on a workstation previou=
s
> > > > > to post a pull request.
> > > > > It can surely be improved, but it is a good starting point.
> > > >=20
> > > > Until we actually have a mechanism to exclude the test case on
> > > > travis-ci, I will remove patch 4/4 from the queue.  Aleksandar,
> > > > please don't merge patch 4/4 yet or it will break travis-ci.
> > > >=20
> > > > Cleber, Wainer, is it already possible to make "avocado run" skip
> > > > tests tagged with "slow"?
> > > >=20
> > >=20
> > > The mechanism exists, but we haven't tagged any test so far as slow=
.
> > >=20
> > > Should we define/document a criteria for a test to be slow?  Given
> > > that this is highly subjective, we have to think of:
> > >=20
> > >  * Will we consider the average or maximum run time (the timeout
> > >    definition)?
> > > =20
> > >  * For a single test, what is "slow"? Some rough numbers from Travi=
s
> > >    CI[1] to help us with guidelines:
> > >    - boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:  PASS (=
6.04 s)
> > >    - boot_linux_console.py:BootLinuxConsole.test_arm_virt:  PASS (2=
.91 s)
> > >    -
> > >    linux_initrd.py:LinuxInitrd.test_with_2gib_file_should_work_with=
_linux_v4_16:
> > >    PASS (18.14 s)
> > >    - boot_linux.py:BootLinuxAarch64.test_virt:  PASS (396.88 s)
> >=20
> > I don't think we need to overthink this.  Whatever objective
> > criteria we choose, I'm sure we'll have to adapt them later due
> > to real world problems.
> >=20
> > e.g.: is 396 seconds too slow?  I don't know, it depends: does it
> > break Travis and other CI systems often because of timeouts?  If
> > yes, then we should probably tag it as slow.
> >=20
>=20
> It's not only that.  We're close to a point where we'll need to
> determine whether "make check-acceptance" will work as a generic
> enough default for most user on their environments and most CI
> systems.
>=20
> As an example, this job ran 5 fairly slow tests (which I'm preparing
> to send):
>=20
>   https://travis-ci.org/clebergnu/qemu/jobs/535967210#L3518
>=20
> Those are justifiably slow, given the fact that they boot a full
> Fedora 30 system using TCG.  The job has a cumulative execution time
> of ~39 minutes.  That leaves only 11 minutes to spare on the Travis
> CI environment.  If they all exercised close to their 600s allowances
> (timeout), the Travis job would have failed.=20
>=20
> Having said that, if a CI failure is supposed to be a major breakage,
> which I believe it's the right mind set and a worthy goal, we should
> limit the amount of tests we run so that their *maximum* execution
> time does not exceed the maximum job time limit.
>=20
> > If having subjective criteria is really a problem (I don't think
> > it is), then we can call the tag "skip_travis", and stop worrying
> > about defining what exactly is "slow".
> >=20
> >=20
> > >=20
> > >  * Do we want to set a maximum job timeout?  This way we can skip
> > >    tests after a given amount of time has passed.  Currently we int=
errupt
> > >    the test running when the job timeout is reached, but it's possi=
ble
> > >    to add a option so that no new tests will be started, but curren=
tly
> > >    running ones will be waited on.
> >=20
> > I'm not sure I understand the suggestion to skip tests.  If we
> > skip tests after a timeout, how would we differentiate a test
> > being expectedly slow from a QEMU hang?
> >=20
> > --
> > Eduardo
> >=20
>=20
> Basically, what I meant is that we could attempt something like:
>=20
>  * Job "Brave"
>   - 50 tests, each with 60 seconds timeout =3D 50 min max
>   - 60 tests, each with 1 second timeout  =3D 1 min max
>=20
> If Job "Brave" is run on a system such as Travis, it *can* fail,
> because it can go over the maximum Travis CI job limit of 50 min.
> We could set an Avocado job timeout of say, 48 minutes, and tell
> Avocado to mark the tests it wasn't able to spawn as "SKIPPED",
> and do not report an overall error condition.

Oh, that would be a nice feature.  But while we don't have it,
the following proposal would work too.

>=20
> But, if we want to be more conservative (which I now realize is
> the best mindset for this situation), we should stick to something
> like:
>=20
>  * Job "Coward"
>   - 47 tests, each with 60 seconds timeout =3D 47 min max
>   - 60 tests, each with 1 second timeout  =3D 1 min max
>=20
> So my proposal is that we should:
>=20
>  * Give ample timeouts to test (at least 2x their average
>    run time on Travis CI)
>=20
>  * Define the standard job (make check-acceptance) as a set
>    of tests that can run under the Travis CI job (discounted
>    the average QEMU build time)

Agreed.

>=20
> This means that:
>=20
>  * We'd tag some tests as "not-default", filtering them out
>    of "make check-acceptance"
>=20
>  * Supposing a developer is using a machine as least as powerful
>    as the Travis CI environment, and assuming a build time of
>    10 minutes, his "make check-acceptance" maximum execution
>    time would be in the order of ~39 minutes.
>=20
> I can work on adding the missing Avocado features, such as
> the ability to list/count the maximum job time for the given test
> selection. This should help us to maintain sound CI jobs, and good
> user experience.

Sounds good to me.

>=20
> And finally, I'm sorry that I did overthink this... but I know
> that the time for hard choices are coming fast.

The above proposals are cool, I don't think they are
overthinking.

I only meant that we shouldn't be looking to a formal definition
of "slow", because "what exactly is a slow job?" isn't the
important question we should be asking.  "How to avoid timeouts
on CI jobs" is the important question, and your proposals above
help us address that.

--=20
Eduardo

