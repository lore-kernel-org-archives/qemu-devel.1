Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55980C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 241D8208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241D8208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50338 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJbg-0002Ey-5F
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 14:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56564)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hZH3V-0006Yr-QN
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hZH3R-0004Mr-T2
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:45:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1hZH3R-0003ZX-B9; Fri, 07 Jun 2019 11:45:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2101D20276;
 Fri,  7 Jun 2019 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-62.rdu2.redhat.com
 [10.10.122.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CE3260DDF;
 Fri,  7 Jun 2019 15:44:34 +0000 (UTC)
Date: Fri, 7 Jun 2019 11:44:32 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190607154432.GA10275@localhost.localdomain>
References: <20190117185628.21862-1-crosa@redhat.com>
 <20190117185628.21862-16-crosa@redhat.com>
 <b235e7a9-57ad-5547-b8ca-693159820a8f@redhat.com>
 <e63a4ea3-e9ff-4920-cdfa-14bf04b5b08c@redhat.com>
 <84aa43ba-df19-51f6-e14d-fb82a7f2dfcc@redhat.com>
 <a638e504-f7ad-fa3a-f198-c3878cfc560e@redhat.com>
 <20190607032648.GA22416@habkost.net>
 <20190607034214.GB22416@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190607034214.GB22416@habkost.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 07 Jun 2019 15:45:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 15/18] Boot Linux Console Test: add a test
 for aarch64 + virt
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
 Stefan Markovic <smarkovic@wavecomp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Claudio Fontana <claudio.fontana@huawei.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-s390x@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Caio Carrara <ccarrara@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 07, 2019 at 12:42:14AM -0300, Eduardo Habkost wrote:
> On Fri, Jun 07, 2019 at 12:26:48AM -0300, Eduardo Habkost wrote:
> > On Fri, Feb 01, 2019 at 11:10:31AM -0500, Cleber Rosa wrote:
> > >=20
> > >=20
> > > On 1/31/19 4:26 PM, Cleber Rosa wrote:
> > > >=20
> > > >=20
> > > > On 1/31/19 3:21 PM, Cleber Rosa wrote:
> > > >>
> > > >>
> > > >> On 1/31/19 3:02 PM, Wainer dos Santos Moschetta wrote:
> > > >>>
> > > >>> On 01/17/2019 04:56 PM, Cleber Rosa wrote:
> > > >>>> Just like the previous tests, boots a Linux kernel on a aarch6=
4 target
> > > >>>> using the virt machine.
> > > >>>>
> > > >>>> One special option added is the CPU type, given that the kerne=
l
> > > >>>> selected fails to boot on the virt machine's default CPU (cort=
ex-a15).
> > > >>>>
> > > >>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > > >>>> ---
> > > >>>> =A0 .travis.yml=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2 +-
> > > >>>> =A0 tests/acceptance/boot_linux_console.py | 20 ++++++++++++++=
++++++
> > > >>>> =A0 2 files changed, 21 insertions(+), 1 deletion(-)
> > > >>>>
> > > >>>> diff --git a/.travis.yml b/.travis.yml
> > > >>>> index 54100eea5a..595e8c0b6c 100644
> > > >>>> --- a/.travis.yml
> > > >>>> +++ b/.travis.yml
> > > >>>> @@ -187,7 +187,7 @@ matrix:
> > > >>>> =A0 =A0=A0=A0=A0=A0 # Acceptance (Functional) tests
> > > >>>> =A0=A0=A0=A0=A0 - env:
> > > >>>> -=A0=A0=A0=A0=A0=A0=A0 - CONFIG=3D"--python=3D/usr/bin/python3
> > > >>>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,p=
pc64-softmmu"
> > > >>>> +=A0=A0=A0=A0=A0=A0=A0 - CONFIG=3D"--python=3D/usr/bin/python3
> > > >>>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,p=
pc64-softmmu,aarch64-softmmu"
> > > >>>>
> > > >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 - TEST_CMD=3D"make check-acceptanc=
e"
> > > >>>> =A0=A0=A0=A0=A0=A0=A0 addons:
> > > >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 apt:
> > > >>>> diff --git a/tests/acceptance/boot_linux_console.py
> > > >>>> b/tests/acceptance/boot_linux_console.py
> > > >>>> index f3ccd23a7a..107700b517 100644
> > > >>>> --- a/tests/acceptance/boot_linux_console.py
> > > >>>> +++ b/tests/acceptance/boot_linux_console.py
> > > >>>> @@ -138,3 +138,23 @@ class BootLinuxConsole(Test):
> > > >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.vm.launch()
> > > >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 console_pattern =3D 'Kernel comman=
d line: %s' %
> > > >>>> kernel_command_line
> > > >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.wait_for_console_pattern(cons=
ole_pattern)
> > > >>>> +
> > > >>>> +=A0=A0=A0 def test_aarch64_virt(self):
> > > >>>
> > > >>> That test case fails on my system (Fedora 29 x86_64). Avocado s=
eems
> > > >>> unable to kill the VM so it=A0 reaches the timeout.
> > > >>>
> > > >>> I compiled QEMU with default configuration:
> > > >>>
> > > >>> $ configure --python=3D/usr/bin/python3 --target-list=3Dx86_64-=
softmmu
> > > >>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,pp=
c64-softmmu,aarch64-softmmu)
> > > >>>
> > > >>>
> > > >>> Follows a snippet of the Avocado's job.log file:
> > > >>> ----
> > > >>> 2019-01-31 14:41:34,912 test=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 L0602 INFO | START
> > > >>> 07-/root/src/qemu/tests/acceptance/boot_linux_console.py:BootLi=
nuxConsole.test_aarch64_virt
> > > >>>
> > > >>> 2019-01-31 14:41:34,912 test=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 L0298 DEBUG| DATA
> > > >>> (filename=3Doutput.expected) =3D> NOT FOUND (data sources: vari=
ant, test, file)
> > > >>> 2019-01-31 14:41:34,913 parameters=A0=A0=A0=A0=A0=A0 L0146 DEBU=
G| PARAMS (key=3Darch,
> > > >>> path=3D*, default=3Daarch64) =3D> 'aarch64'
> > > >>> 2019-01-31 14:41:34,913 parameters=A0=A0=A0=A0=A0=A0 L0146 DEBU=
G| PARAMS
> > > >>> (key=3Dqemu_bin, path=3D*, default=3Daarch64-softmmu/qemu-syste=
m-aarch64) =3D>
> > > >>> 'aarch64-softmmu/qemu-system-aarch64'
> > > >>> 2019-01-31 14:41:34,915 download=A0=A0=A0=A0=A0=A0=A0=A0 L0070 =
INFO | Fetching
> > > >>> https://sjc.edge.kernel.org/fedora-buffet/fedora/linux/releases=
/29/Server/aarch64/os/images/pxeboot/vmlinuz
> > > >>> -> /var/lib/avocado/data/cache/by_name/vmlinuz.3upct2pr
> > > >>> 2019-01-31 14:41:35,490 download=A0=A0=A0=A0=A0=A0=A0=A0 L0054 =
DEBUG| Retrieved URL
> > > >>> "https://sjc.edge.kernel.org/fedora-buffet/fedora/linux/release=
s/29/Server/aarch64/os/images/pxeboot/vmlinuz":
> > > >>> content-length 8623423, date: "Thu, 31 Jan 2019 19:41:35 GMT",
> > > >>> last-modified: "Sun, 21 Oct 2018 00:43:09 GMT"
> > > >>> 2019-01-31 14:41:41,765 qemu=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 L0317 DEBUG| VM launch command:
> > > >>> 'aarch64-softmmu/qemu-system-aarch64 -chardev
> > > >>> socket,id=3Dmon,path=3D/var/tmp/tmpizirkcud/qemu-32609-monitor.=
sock -mon
> > > >>> chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine v=
irt -chardev
> > > >>> socket,id=3Dconsole,path=3D/var/tmp/tmpizirkcud/qemu-32609-cons=
ole.sock,server,nowait
> > > >>> -serial chardev:console -cpu cortex-a53 -kernel
> > > >>> /var/lib/avocado/data/cache/by_name/vmlinuz -append console=3Dt=
tyAMA0'
> > > >>> 2019-01-31 14:41:41,779 qmp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 L0167 DEBUG| >>> {'execute':
> > > >>> 'qmp_capabilities'}
> > > >>> 2019-01-31 14:41:41,931 qmp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 L0175 DEBUG| <<< {'return': {}}
> > > >>> 2019-01-31 14:41:42,830 boot_linux_conso L0041 DEBUG| [=A0=A0=A0=
 0.000000]
> > > >>> Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> > > >>>
> > > >>> (...)
> > > >>>
> > > >>> 2019-01-31 14:41:42,833 boot_linux_conso L0041 DEBUG| [=A0=A0=A0=
 0.000000]
> > > >>> Policy zone: DMA32
> > > >>> 2019-01-31 14:41:42,833 boot_linux_conso L0041 DEBUG| [=A0=A0=A0=
 0.000000]
> > > >>> Kernel command line: console=3DttyAMA0
> > > >>> 2019-01-31 14:41:42,833 qmp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 L0167 DEBUG| >>> {'execute':
> > > >>> 'quit'}
> > > >>
> > > >> Here, a QMP response like "<<< {'return': {}}" would be expected=
.
> > > >>
> > > >> Since I can not reproduce this on my system (or on Travis-CI job=
s I've
> > > >> sent), can you tell me on top of which commit you've applied the=
se patches?
> > > >>
> > > >=20
> > > > I spoke too soon:
> > > >=20
> > > > https://travis-ci.org/clebergnu/qemu/jobs/487121425#L3033
> > > >=20
> > > > This looks like a recent regression, and I'm guessing it's not on=
 the
> > > > test's side.  I'll try to bisect it and let you know.
> > > >=20
> > >=20
> > > On a fresh environment, I am able to get this reproduced on every 2=
 of
> > > runs, more or less.  When I hit it, I attached GDB to it, and the
> > > backtrace shows:
> > >=20
> > > Thread debugging using libthread_db enabled]
> > > Using host libthread_db library "/lib64/libthread_db.so.1".
> > > warning: Loadable section ".note.gnu.property" outside of ELF segme=
nts
> > > warning: Loadable section ".note.gnu.property" outside of ELF segme=
nts
> > > __lll_lock_wait () at ../sysdeps/unix/sysv/linux/x86_64/lowlevelloc=
k.S:103
> > > 103     2:      movl    %edx, %eax
> > > (gdb) bt
> > > #0  __lll_lock_wait () at
> > > ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:103
> > > #1  0x00007fc6ba1a2e09 in __GI___pthread_mutex_lock
> > > (mutex=3Dmutex@entry=3D0x5615a233d020 <qemu_global_mutex>) at
> > > ../nptl/pthread_mutex_lock.c:80
> > > #2  0x00005615a1bb7593 in qemu_mutex_lock_impl (mutex=3D0x5615a233d=
020
> > > <qemu_global_mutex>, file=3D0x5615a1db2d4c "util/main-loop.c", line=
=3D236)
> > > at util/qemu-thread-posix.c:66
> > > #3  0x00005615a171125e in qemu_mutex_lock_iothread_impl
> > > (file=3Dfile@entry=3D0x5615a1db2d4c "util/main-loop.c", line=3Dline=
@entry=3D236)
> > > at /home/cleber/src/qemu/cpus.c:1849
> > > #4  0x00005615a1bb415d in os_host_main_loop_wait (timeout=3D<optimi=
zed
> > > out>) at util/main-loop.c:236
> > > #5  main_loop_wait (nonblocking=3D<optimized out>) at util/main-loo=
p.c:497
> > > #6  0x00005615a18fdd39 in main_loop () at vl.c:1928
> > > #7  0x00005615a16c9ee9 in main (argc=3D<optimized out>, argv=3D<opt=
imized
> > > out>, envp=3D<optimized out>) at vl.c:4665
> >=20
> > Tip: run "thread apply all bt" so you can get a backtrace of all
> > threads.
> >=20
> >=20
> > >=20
> > > Running it with `taskset -c 1` prevents this issue from happening, =
which
> > > AFAICT, contributes even further towards this being a QEMU race con=
dition.
> > >=20
> > > I'm CC'ing Peter and Claudio (listed maintainers of aarch64), as th=
is
> > > seems to limited to that target.  Any tips on what to do here?
> >=20
> > I am hitting this on Travis, too, and I finally could reproduce
> > it locally,
> >=20
> > The guest is still writing on the serial console, but nobody is
> > reading the data on the other side.  A VCPU thread is stuck
> > inside the EAGAIN/nanosleep loop at qemu_chr_write_buffer(),
> > holding the QEMU global lock.
>=20
> Experimental fix below.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  python/qemu/__init__.py | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
> index 81d9657ec0..4a691f34da 100644
> --- a/python/qemu/__init__.py
> +++ b/python/qemu/__init__.py
> @@ -274,10 +274,6 @@ class QEMUMachine(object):
> =20
>          self._qemu_log_path =3D None
> =20
> -        if self._console_socket is not None:
> -            self._console_socket.close()
> -            self._console_socket =3D None
> -
>          if self._temp_dir is not None:
>              shutil.rmtree(self._temp_dir)
>              self._temp_dir =3D None
> @@ -336,6 +332,14 @@ class QEMUMachine(object):
>          """
>          Terminate the VM and clean up
>          """
> +
> +        # If we keep the console socket open, we may deadlock waiting
> +        # for QEMU to exit, while QEMU is waiting for the socket to
> +        # become writeable.
> +        if self._console_socket is not None:
> +            self._console_socket.close()
> +            self._console_socket =3D None
> +

Right, this is somewhat equivalent to the following "workaround":

   https://github.com/clebergnu/qemu/commit/e1713f3b91972ad57c089f276c54d=
b3f3fa63423

I could not tell at the moment, though, if closing (or shutting down)
the console socket was the appropriate fix.

What I see is that Rick's commit pointed to by Lazlo is dated from
2016, and it says that a virtio-console fix is necessary.  I'd imagine
that, if a fix was ever proposed, it'd have been incorporated in the
F29 kernel used in this test... and that this workaround/fix would
not be the best solution.

But, I'm mostly attempting to navigate this using my senses , few hard
data and even less background :).

Regards,
- Cleber.

>          if self.is_running():
>              try:
>                  self._qmp.cmd('quit')
> --=20
> 2.18.0.rc1.1.g3f1ff2140
>=20
> --=20
> Eduardo

