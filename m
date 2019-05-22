Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE3AC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 23:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9620E206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 23:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9620E206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53719 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTaL5-0005ov-Dw
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 19:08:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hTaKJ-0005YK-1K
	for qemu-devel@nongnu.org; Wed, 22 May 2019 19:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hTaKH-0005Hc-Un
	for qemu-devel@nongnu.org; Wed, 22 May 2019 19:07:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hTaKH-0005HF-Mp
	for qemu-devel@nongnu.org; Wed, 22 May 2019 19:07:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70F4C8666E;
	Wed, 22 May 2019 23:07:12 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8AA1D17CC0;
	Wed, 22 May 2019 23:07:07 +0000 (UTC)
Date: Wed, 22 May 2019 20:07:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190522230705.GB10764@habkost.net>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190522211230.GA10764@habkost.net>
	<1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 22 May 2019 23:07:12 +0000 (UTC)
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

On Wed, May 22, 2019 at 05:46:06PM -0400, Cleber Rosa wrote:
>=20
>=20
> ----- Original Message -----
> > From: "Eduardo Habkost" <ehabkost@redhat.com>
> > To: "Philippe Mathieu-Daud=E9" <f4bug@amsat.org>
> > Cc: qemu-devel@nongnu.org, "Aleksandar Rikalo" <arikalo@wavecomp.com>=
, "Aleksandar Markovic"
> > <aleksandar.m.mail@gmail.com>, "Aleksandar Markovic" <amarkovic@wavec=
omp.com>, "Cleber Rosa" <crosa@redhat.com>,
> > "Aurelien Jarno" <aurelien@aurel32.net>, "Wainer dos Santos Moschetta=
" <wainersm@redhat.com>
> > Sent: Wednesday, May 22, 2019 5:12:30 PM
> > Subject: Re: [Qemu-devel] [PATCH 0/4] mips: Add more Avocado tests
> >=20
> > On Tue, May 21, 2019 at 01:19:06AM +0200, Philippe Mathieu-Daud=E9 wr=
ote:
> > > Hi,
> > >=20
> > > It was a rainy week-end here, so I invested it to automatize some
> > > of my MIPS tests.
> > >=20
> > > The BootLinuxSshTest is not Global warming friendly, it is not
> > > meant to run on a CI system but rather on a workstation previous
> > > to post a pull request.
> > > It can surely be improved, but it is a good starting point.
> >=20
> > Until we actually have a mechanism to exclude the test case on
> > travis-ci, I will remove patch 4/4 from the queue.  Aleksandar,
> > please don't merge patch 4/4 yet or it will break travis-ci.
> >=20
> > Cleber, Wainer, is it already possible to make "avocado run" skip
> > tests tagged with "slow"?
> >=20
>=20
> The mechanism exists, but we haven't tagged any test so far as slow.
>=20
> Should we define/document a criteria for a test to be slow?  Given
> that this is highly subjective, we have to think of:
>=20
>  * Will we consider the average or maximum run time (the timeout
>    definition)?
> =20
>  * For a single test, what is "slow"? Some rough numbers from Travis
>    CI[1] to help us with guidelines:
>    - boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:  PASS (6.04=
 s)
>    - boot_linux_console.py:BootLinuxConsole.test_arm_virt:  PASS (2.91 =
s)
>    - linux_initrd.py:LinuxInitrd.test_with_2gib_file_should_work_with_l=
inux_v4_16:  PASS (18.14 s)
>    - boot_linux.py:BootLinuxAarch64.test_virt:  PASS (396.88 s)

I don't think we need to overthink this.  Whatever objective
criteria we choose, I'm sure we'll have to adapt them later due
to real world problems.

e.g.: is 396 seconds too slow?  I don't know, it depends: does it
break Travis and other CI systems often because of timeouts?  If
yes, then we should probably tag it as slow.

If having subjective criteria is really a problem (I don't think
it is), then we can call the tag "skip_travis", and stop worrying
about defining what exactly is "slow".


>=20
>  * Do we want to set a maximum job timeout?  This way we can skip
>    tests after a given amount of time has passed.  Currently we interru=
pt
>    the test running when the job timeout is reached, but it's possible
>    to add a option so that no new tests will be started, but currently
>    running ones will be waited on.

I'm not sure I understand the suggestion to skip tests.  If we
skip tests after a timeout, how would we differentiate a test
being expectedly slow from a QEMU hang?

--=20
Eduardo

