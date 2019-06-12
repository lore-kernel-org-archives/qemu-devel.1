Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2B1C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFE720896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFE720896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35848 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbCHb-0007ni-ES
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 19:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56447)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hbCAI-0001xe-SX
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hbC1x-0004j4-JK
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:47:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hbC1v-0004gd-JD
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:47:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BC2BB300414E;
 Wed, 12 Jun 2019 22:47:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-184.rdu2.redhat.com
 [10.10.120.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32DFF5ED2B;
 Wed, 12 Jun 2019 22:47:37 +0000 (UTC)
Date: Wed, 12 Jun 2019 18:47:36 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190612224736.GA9536@localhost.localdomain>
References: <20190611171456.23444-1-ehabkost@redhat.com>
 <20190611171456.23444-7-ehabkost@redhat.com>
 <d107483c-eba8-f6fc-8e3a-ad0a86472d07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d107483c-eba8-f6fc-8e3a-ad0a86472d07@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 12 Jun 2019 22:47:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 6/6] travis: Make check-acceptance job more
 verbose
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 12, 2019 at 10:49:18PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 6/11/19 7:14 PM, Eduardo Habkost wrote:
> > It will help us debug issues when tests fail.
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  .travis.yml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/.travis.yml b/.travis.yml
> > index b053a836a3..a08a7b7278 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -225,7 +225,7 @@ matrix:
> >      # Acceptance (Functional) tests
> >      - env:
> >          - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_=
64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390=
x-softmmu,alpha-softmmu"
> > -        - TEST_CMD=3D"make check-acceptance"
> > +        - TEST_CMD=3D"make AVOCADO_SHOW=3Dtest check-acceptance"
> >        addons:
> >          apt:
> >            packages:
> >=20
>=20
> Cleber, can you help figuring what's wrong here?
>=20
> https://travis-ci.org/qemu/qemu/jobs/544805900
>=20
> The tests seems successfull, is it possible the verbose logging returns
> error to the shell even if the test succeed?
>

There's some confusion here... To the best of my knowledge this failure i=
s
not associated with Eduardo's change of the of the AVOCADO_SHOW variable.
This seems to be we hitting this:

  https://bugs.launchpad.net/qemu/+bug/1829779

Which was also discussed in other threads, such as:

  https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg01254.html

We have identified two ways to work around this, and about two days
ago Eduardo and myself settled on one of them.  I'll send a patch in
a few.

> INIT
> 05-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_console.py:=
BootLinuxConsole.test_aarch64_virt
> PARAMS (key=3Dtimeout, path=3D*, default=3D90) =3D> 90
> Test metadata:
>   filename:
> /home/travis/build/qemu/qemu/tests/acceptance/boot_linux_console.py
>   teststmpdir: /tmp/avocado_6tk1s4nz
>   workdir:
> /tmp/avocado_ifg2df04/avocado_job_zqdrt4ht/05-_home_travis_build_qemu_q=
emu_tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_aarch64_=
virt
> START
> 05-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_console.py:=
BootLinuxConsole.test_aarch64_virt
> DATA (filename=3Doutput.expected) =3D> NOT FOUND (data sources: variant=
,
> test, file)
> PARAMS (key=3Darch, path=3D*, default=3Daarch64) =3D> 'aarch64'
> PARAMS (key=3Dqemu_bin, path=3D*,
> default=3Daarch64-softmmu/qemu-system-aarch64) =3D>
> 'aarch64-softmmu/qemu-system-aarch64'
> Fetching
> https://download.fedoraproject.org/pub/fedora/linux/releases/29/Everyth=
ing/aarch64/os/images/pxeboot/vmlinuz
> ->
> /home/travis/avocado/data/cache/by_location/e959d0e1dd72e77653e218e6661=
98db1f3d0c213/vmlinuz.g3ehffso
> Retrieved URL
> "https://download.fedoraproject.org/pub/fedora/linux/releases/29/Everyt=
hing/aarch64/os/images/pxeboot/vmlinuz":
> content-length 8623423, date: "Wed, 12 Jun 2019 18:54:21 GMT",
> last-modified: "Sun, 21 Oct 2018 00:43:09 GMT"
> VM launch command: 'aarch64-softmmu/qemu-system-aarch64 -chardev
> socket,id=3Dmon,path=3D/var/tmp/tmptpv0noew/qemu-6334-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine virt -cha=
rdev
> socket,id=3Dconsole,path=3D/var/tmp/tmptpv0noew/qemu-6334-console.sock,=
server,nowait
> -serial chardev:console -cpu cortex-a53 -kernel
> /home/travis/avocado/data/cache/by_location/e959d0e1dd72e77653e218e6661=
98db1f3d0c213/vmlinuz
> -append printk.time=3D0 console=3DttyAMA0'
> >>> {'execute': 'qmp_capabilities'}
> <<< {'return': {}}
> Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> Linux version 4.18.16-300.fc29.aarch64
> (mockbuild@buildvm-aarch64-02.arm.fedoraproject.org) (gcc version 8.2.1
> 20180801 (Red Hat 8.2.1-2) (GCC)) #1 SMP Sat Oct 20 23:12:22 UTC 2018
> Machine model: linux,dummy-virt
> efi: Getting EFI parameters from FDT:
> efi: UEFI not found.
> cma: Failed to reserve 64 MiB
> NUMA: No NUMA configuration found
> NUMA: Faking a node at [mem 0x0000000000000000-0x0000000047ffffff]
> NUMA: NODE_DATA [mem 0x47f9c780-0x47fa9fff]
> Zone ranges:
> DMA32    [mem 0x0000000040000000-0x0000000047ffffff]
> Normal   empty
> Movable zone start for each node
> Early memory node ranges
> node   0: [mem 0x0000000040000000-0x0000000047ffffff]
> Initmem setup node 0 [mem 0x0000000040000000-0x0000000047ffffff]
> psci: probing for conduit method from DT.
> psci: PSCIv0.2 detected in firmware.
> psci: Using standard PSCI v0.2 function IDs
> psci: Trusted OS migration not required
> percpu: Embedded 23 pages/cpu @(____ptrval____) s53528 r8192 d32488 u94=
208
> Detected VIPT I-cache on CPU0
> CPU features: enabling workaround for ARM erratum 843419
> CPU features: detected: Kernel page table isolation (KPTI)
> Built 1 zonelists, mobility grouping on.  Total pages: 32256
> Policy zone: DMA32
> Kernel command line: printk.time=3D0 console=3DttyAMA0
> >>> {'execute': 'quit'}

Notice how QEMU gets stuck here.

- Cleber.

> qemu received signal 9: aarch64-softmmu/qemu-system-aarch64 -chardev
> socket,id=3Dmon,path=3D/var/tmp/tmptpv0noew/qemu-6334-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine virt -cha=
rdev
> socket,id=3Dconsole,path=3D/var/tmp/tmptpv0noew/qemu-6334-console.sock,=
server,nowait
> -serial chardev:console -cpu cortex-a53 -kernel
> /home/travis/avocado/data/cache/by_location/e959d0e1dd72e77653e218e6661=
98db1f3d0c213/vmlinuz
> -append printk.time=3D0 console=3DttyAMA0
> DATA (filename=3Doutput.expected) =3D> NOT FOUND (data sources: variant=
,
> test, file)
> DATA (filename=3Dstdout.expected) =3D> NOT FOUND (data sources: variant=
,
> test, file)
> DATA (filename=3Dstderr.expected) =3D> NOT FOUND (data sources: variant=
,
> test, file)
> Not logging /var/log/syslog (lack of permissions)
> PASS
> 05-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_console.py:=
BootLinuxConsole.test_aarch64_virt
> Runner error occurred: Timeout reached
> Original status: PASS
> {'fail_class': None, 'name':
> '05-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_console.py=
:BootLinuxConsole.test_aarch64_virt',
> 'timeout': 90, 'time_elapsed': 90.49569606781006, 'params': [],
> 'time_end': 1560365750.8509598, 'logdir':
> '/home/travis/build/qemu/qemu/tests/results/job-2019-06-12T18.51-677936=
8/test-results/05-_home_travis_build_qemu_qemu_tests_acceptance_boot_linu=
x_console.py_BootLinuxConsole.test_aarch64_virt',
> 'status': 'PASS', 'whiteboard': '', 'fail_reason': None, 'traceback':
> None, 'job_unique_id': '6779368b0faa619be34d024bad5ee46367c44df0',
> 'class_name': 'BootLinuxConsole', 'paused': False, 'time_start':
> 1560365660.3552637, 'job_logdir':
> '/home/travis/build/qemu/qemu/tests/results/job-2019-06-12T18.51-677936=
8',
> 'running': False, 'logfile':
> '/home/travis/build/qemu/qemu/tests/results/job-2019-06-12T18.51-677936=
8/test-results/05-_home_travis_build_qemu_qemu_tests_acceptance_boot_linu=
x_console.py_BootLinuxConsole.test_aarch64_virt/debug.log'}
> File /etc/avocado/sysinfo/commands does not exist.
> File /etc/avocado/sysinfo/files does not exist.
> File /etc/avocado/sysinfo/profilers does not exist.
> Journalctl collection failed: Command 'journalctl --quiet --lines 1
> --output json' failed.
> stdout: b''
> stderr: b'No journal files were opened due to insufficient permissions.=
\n'
> additional_info: None
>=20
> Thanks,
>=20
> Phil.
>=20

