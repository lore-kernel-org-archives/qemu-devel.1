Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB88C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43EF0206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EF0206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdH6G-0006Zx-7Q
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33044)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hdGCp-00053T-CV
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hdGCm-0000ER-3P
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:39:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hdGCi-0007GE-Qd
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:39:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 72EF43092676;
 Tue, 18 Jun 2019 15:38:36 +0000 (UTC)
Received: from unused (unknown [10.16.197.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E861F7D65A;
 Tue, 18 Jun 2019 15:38:29 +0000 (UTC)
Date: Tue, 18 Jun 2019 11:38:28 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190618153828.GA13454@unused>
References: <20190611171456.23444-1-ehabkost@redhat.com>
 <CAFEAcA8MO=g2_ce9JGuUafYJRxpsTjQetYXRannYGbhTv_dYHw@mail.gmail.com>
 <20190618140153.GA26629@unused>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190618140153.GA26629@unused>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 18 Jun 2019 15:38:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/6] Python queue, 2019-06-11
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 18, 2019 at 10:01:53AM -0400, Cleber Rosa wrote:
> On Tue, Jun 18, 2019 at 02:27:29PM +0100, Peter Maydell wrote:
> > On Tue, 11 Jun 2019 at 18:15, Eduardo Habkost <ehabkost@redhat.com> w=
rote:
> > >
> > > Changes from 2019-06-07: Python 2 deprecation and Python 3 check
> > > for 3.5+ were removed.
> > >
> > > The following changes since commit 219dca61ebf41625831d4f96a720852b=
af44b762:
> > >
> > >   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull=
-request' into staging (2019-06-11 16:02:07 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
> > >
> > > for you to fetch changes up to 6d7a134da4afebe8551a69329478415cfb4c=
be91:
> > >
> > >   travis: Make check-acceptance job more verbose (2019-06-11 14:13:=
09 -0300)
> > >
> > > ----------------------------------------------------------------
> > > Python queue, 2019-06-11
> > >
> > > * New boot_linux_console test cases (Philippe Mathieu-Daud=E9)
> > > * Make check-acceptance Travis job more verbose (Eduardo Habkost)
> > >
> > > ----------------------------------------------------------------
> > >
> > > Eduardo Habkost (1):
> > >   travis: Make check-acceptance job more verbose
> > >
> > > Philippe Mathieu-Daud=E9 (5):
> > >   tests/boot_linux_console: Let extract_from_deb handle various
> > >     compressions
> > >   BootLinuxConsoleTest: Do not log empty lines
> > >   BootLinuxConsoleTest: Test the SmartFusion2 board
> > >   BootLinuxConsoleTest: Test nanoMIPS kernels on the I7200 CPU
> > >   BootLinuxConsoleTest: Run kerneltests BusyBox on Malta
> >=20
> > Hi -- it looks like the Travis check-acceptance run started
> > failing when this pull was merged. Could somebody have a look
> > at it, please?
> >=20
> > https://travis-ci.org/qemu/qemu/jobs/544724911
> >
> > thanks
> > -- PMM
>=20
> Hi Peter,
>=20
> I'm looking at it.  Strangely enough, I don't see any error or
> failures, but only a couple of skips (besides passes):
>=20
>  PASS 01-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_conso=
le.py:BootLinuxConsole.test_x86_64_pc
>  PASS 02-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_conso=
le.py:BootLinuxConsole.test_mips_malta
>  PASS 03-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_conso=
le.py:BootLinuxConsole.test_mips64el_malta
>  PASS 04-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_conso=
le.py:BootLinuxConsole.test_mips_malta_cpio
>  PASS 05-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_conso=
le.py:BootLinuxConsole.test_aarch64_virt
>  PASS 06-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_conso=
le.py:BootLinuxConsole.test_arm_virt
>  PASS 07-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_conso=
le.py:BootLinuxConsole.test_arm_emcraft_sf2
>  PASS 08-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_conso=
le.py:BootLinuxConsole.test_s390x_s390_ccw_virtio
>  PASS 09-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_conso=
le.py:BootLinuxConsole.test_alpha_clipper
>  PASS 10-/home/travis/build/qemu/qemu/tests/acceptance/cpu_queries.py:Q=
ueryCPUModelExpansion.test
>  PASS 11-/home/travis/build/qemu/qemu/tests/acceptance/empty_cpu_model.=
py:EmptyCPUModel.test
>  PASS 12-/home/travis/build/qemu/qemu/tests/acceptance/linux_initrd.py:=
LinuxInitrd.test_with_2gib_file_should_exit_error_msg_with_linux_v3_6
>  PASS 13-/home/travis/build/qemu/qemu/tests/acceptance/linux_initrd.py:=
LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16
>  SKIP 14-/home/travis/build/qemu/qemu/tests/acceptance/linux_ssh_mips_m=
alta.py:LinuxSSH.test_mips_malta32eb_kernel3_2_0 -> TestSkipError: Runnin=
g on Travis-CI
>  SKIP 15-/home/travis/build/qemu/qemu/tests/acceptance/linux_ssh_mips_m=
alta.py:LinuxSSH.test_mips_malta64el_kernel3_2_0 -> TestSkipError: Runnin=
g on Travis-CI
>  PASS 16-/home/travis/build/qemu/qemu/tests/acceptance/migration.py:Mig=
ration.test_migration_with_tcp_localhost
>  PASS 17-/home/travis/build/qemu/qemu/tests/acceptance/version.py:Versi=
on.test_qmp_human_info_version
>  PASS 18-/home/travis/build/qemu/qemu/tests/acceptance/virtio_version.p=
y:VirtioVersionCheck.test_conventional_devs
>  PASS 19-/home/travis/build/qemu/qemu/tests/acceptance/virtio_version.p=
y:VirtioVersionCheck.test_modern_only_devs
>  PASS 20-/home/travis/build/qemu/qemu/tests/acceptance/vnc.py:Vnc.test_=
no_vnc
>  PASS 21-/home/travis/build/qemu/qemu/tests/acceptance/vnc.py:Vnc.test_=
no_vnc_change_password
>  PASS 22-/home/travis/build/qemu/qemu/tests/acceptance/vnc.py:Vnc.test_=
vnc_change_password_requires_a_password
>  PASS 23-/home/travis/build/qemu/qemu/tests/acceptance/vnc.py:Vnc.test_=
vnc_change_password
>=20
> And Avocado *should* return 0 for those results (I tried it on my
> system and this is indeed what I get).  I'm investigating other
> possibilities and will let you know.
>
> Regards,
> - Cleber.

I take that back. The simple "egrep" I didn't show the interruption
during test tearDown() that ocurred here for aarch64:

 - https://travis-ci.org/qemu/qemu/jobs/544724911#L3909

And here for arm:

 - https://travis-ci.org/qemu/qemu/jobs/544724911#L3959

With the revert that Eduardo just proposed, it should be eaiser to see
that those tests actually finished with status INTERRUPTED.

Now, the core issue Which is this related to this:

 - https://bugs.launchpad.net/qemu/+bug/1829779

Some people contributed to discussions around this, and the general
outcome is that we need to workaround the current sitation in the
test code.  So, I'm working on a patch and will send ASAP.

- Cleber.

