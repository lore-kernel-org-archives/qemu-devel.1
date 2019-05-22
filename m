Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59052C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 21:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F394420868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 21:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F394420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51955 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZ5Z-00006L-KY
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 17:47:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hTZ4j-00085m-E1
	for qemu-devel@nongnu.org; Wed, 22 May 2019 17:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hTZ3v-0005Bp-GG
	for qemu-devel@nongnu.org; Wed, 22 May 2019 17:46:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hTZ3t-00059e-6R
	for qemu-devel@nongnu.org; Wed, 22 May 2019 17:46:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DA0E3079B65;
	Wed, 22 May 2019 21:46:09 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EC7E648D1;
	Wed, 22 May 2019 21:46:09 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5989C1806B14;
	Wed, 22 May 2019 21:46:09 +0000 (UTC)
Date: Wed, 22 May 2019 17:46:06 -0400 (EDT)
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <1711852617.24204010.1558561566547.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190522211230.GA10764@habkost.net>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190522211230.GA10764@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.36.116.137, 10.4.195.12]
Thread-Topic: mips: Add more Avocado tests
Thread-Index: OWdbio9uWGL8iBx0D64/+YLiFef+Og==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Wed, 22 May 2019 21:46:09 +0000 (UTC)
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
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Eduardo Habkost" <ehabkost@redhat.com>
> To: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org, "Aleksandar Rikalo" <arikalo@wavecomp.com>, "A=
leksandar Markovic"
> <aleksandar.m.mail@gmail.com>, "Aleksandar Markovic" <amarkovic@wavecomp.=
com>, "Cleber Rosa" <crosa@redhat.com>,
> "Aurelien Jarno" <aurelien@aurel32.net>, "Wainer dos Santos Moschetta" <w=
ainersm@redhat.com>
> Sent: Wednesday, May 22, 2019 5:12:30 PM
> Subject: Re: [Qemu-devel] [PATCH 0/4] mips: Add more Avocado tests
>=20
> On Tue, May 21, 2019 at 01:19:06AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi,
> >=20
> > It was a rainy week-end here, so I invested it to automatize some
> > of my MIPS tests.
> >=20
> > The BootLinuxSshTest is not Global warming friendly, it is not
> > meant to run on a CI system but rather on a workstation previous
> > to post a pull request.
> > It can surely be improved, but it is a good starting point.
>=20
> Until we actually have a mechanism to exclude the test case on
> travis-ci, I will remove patch 4/4 from the queue.  Aleksandar,
> please don't merge patch 4/4 yet or it will break travis-ci.
>=20
> Cleber, Wainer, is it already possible to make "avocado run" skip
> tests tagged with "slow"?
>=20

The mechanism exists, but we haven't tagged any test so far as slow.

Should we define/document a criteria for a test to be slow?  Given
that this is highly subjective, we have to think of:

 * Will we consider the average or maximum run time (the timeout
   definition)?
=20
 * For a single test, what is "slow"? Some rough numbers from Travis
   CI[1] to help us with guidelines:
   - boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:  PASS (6.04 s)
   - boot_linux_console.py:BootLinuxConsole.test_arm_virt:  PASS (2.91 s)
   - linux_initrd.py:LinuxInitrd.test_with_2gib_file_should_work_with_linux=
_v4_16:  PASS (18.14 s)
   - boot_linux.py:BootLinuxAarch64.test_virt:  PASS (396.88 s)

 * Do we want to set a maximum job timeout?  This way we can skip
   tests after a given amount of time has passed.  Currently we interrupt
   the test running when the job timeout is reached, but it's possible
   to add a option so that no new tests will be started, but currently
   running ones will be waited on.

Regards,
- Cleber.=20

[1] - https://travis-ci.org/clebergnu/qemu/jobs/535967210#L3518

> --
> Eduardo
>=20

