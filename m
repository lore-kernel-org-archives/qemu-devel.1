Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE6AC31E43
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3EA7206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EA7206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48394 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haNXJ-0002wz-MD
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 12:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45229)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1haNWX-00024S-BR
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1haNWT-0001FF-I1
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:51:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9437)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1haNWT-0000sf-98; Mon, 10 Jun 2019 12:51:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D371307D84F;
 Mon, 10 Jun 2019 16:50:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-202.rdu2.redhat.com
 [10.10.123.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A8C95C22E;
 Mon, 10 Jun 2019 16:50:42 +0000 (UTC)
Date: Mon, 10 Jun 2019 12:50:39 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190610165039.GA7033@localhost.localdomain>
References: <20190117185628.21862-16-crosa@redhat.com>
 <b235e7a9-57ad-5547-b8ca-693159820a8f@redhat.com>
 <e63a4ea3-e9ff-4920-cdfa-14bf04b5b08c@redhat.com>
 <84aa43ba-df19-51f6-e14d-fb82a7f2dfcc@redhat.com>
 <a638e504-f7ad-fa3a-f198-c3878cfc560e@redhat.com>
 <20190607032648.GA22416@habkost.net>
 <20190607034214.GB22416@habkost.net>
 <20190607154432.GA10275@localhost.localdomain>
 <20190607185857.GD22416@habkost.net>
 <20190610085303.GA7809@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190610085303.GA7809@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 10 Jun 2019 16:51:17 +0000 (UTC)
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Claudio Fontana <claudio.fontana@huawei.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-s390x@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Caio Carrara <ccarrara@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 10, 2019 at 09:53:03AM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, Jun 07, 2019 at 03:58:57PM -0300, Eduardo Habkost wrote:
> > CCing Daniel, who wrote commit 6ab3fc32ea64.
> >=20
> > On Fri, Jun 07, 2019 at 11:44:32AM -0400, Cleber Rosa wrote:
> > > On Fri, Jun 07, 2019 at 12:42:14AM -0300, Eduardo Habkost wrote:
> > > > On Fri, Jun 07, 2019 at 12:26:48AM -0300, Eduardo Habkost wrote:
> > > > > On Fri, Feb 01, 2019 at 11:10:31AM -0500, Cleber Rosa wrote:
> > > > > >=20
> > > > > >=20
> > > > > > On 1/31/19 4:26 PM, Cleber Rosa wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > On 1/31/19 3:21 PM, Cleber Rosa wrote:
> > > > > > >>
> > > > > > >>
> > > > > > >> On 1/31/19 3:02 PM, Wainer dos Santos Moschetta wrote:
> > > > > > >>>
> > > > > > >>> On 01/17/2019 04:56 PM, Cleber Rosa wrote:
> > > > > > >>>> Just like the previous tests, boots a Linux kernel on a =
aarch64 target
> > > > > > >>>> using the virt machine.
> > > > > > >>>>
> > > > > > >>>> One special option added is the CPU type, given that the=
 kernel
> > > > > > >>>> selected fails to boot on the virt machine's default CPU=
 (cortex-a15).
> > > > > > >>>>
> > > > > > >>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > > > > > >>>> ---
> > > > > > >>>> =A0 .travis.yml=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2 +-
> > > > > > >>>> =A0 tests/acceptance/boot_linux_console.py | 20 ++++++++=
++++++++++++
> > > > > > >>>> =A0 2 files changed, 21 insertions(+), 1 deletion(-)
> > > > > > >>>>
> > > > > > >>>> diff --git a/.travis.yml b/.travis.yml
> > > > > > >>>> index 54100eea5a..595e8c0b6c 100644
> > > > > > >>>> --- a/.travis.yml
> > > > > > >>>> +++ b/.travis.yml
> > > > > > >>>> @@ -187,7 +187,7 @@ matrix:
> > > > > > >>>> =A0 =A0=A0=A0=A0=A0 # Acceptance (Functional) tests
> > > > > > >>>> =A0=A0=A0=A0=A0 - env:
> > > > > > >>>> -=A0=A0=A0=A0=A0=A0=A0 - CONFIG=3D"--python=3D/usr/bin/p=
ython3
> > > > > > >>>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-sof=
tmmu,ppc64-softmmu"
> > > > > > >>>> +=A0=A0=A0=A0=A0=A0=A0 - CONFIG=3D"--python=3D/usr/bin/p=
ython3
> > > > > > >>>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-sof=
tmmu,ppc64-softmmu,aarch64-softmmu"
> > > > > > >>>>
> > > > > > >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 - TEST_CMD=3D"make check-acc=
eptance"
> > > > > > >>>> =A0=A0=A0=A0=A0=A0=A0 addons:
> > > > > > >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 apt:
> > > > > > >>>> diff --git a/tests/acceptance/boot_linux_console.py
> > > > > > >>>> b/tests/acceptance/boot_linux_console.py
> > > > > > >>>> index f3ccd23a7a..107700b517 100644
> > > > > > >>>> --- a/tests/acceptance/boot_linux_console.py
> > > > > > >>>> +++ b/tests/acceptance/boot_linux_console.py
> > > > > > >>>> @@ -138,3 +138,23 @@ class BootLinuxConsole(Test):
> > > > > > >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.vm.launch()
> > > > > > >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 console_pattern =3D 'Kernel =
command line: %s' %
> > > > > > >>>> kernel_command_line
> > > > > > >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.wait_for_console_patter=
n(console_pattern)
> > > > > > >>>> +
> > > > > > >>>> +=A0=A0=A0 def test_aarch64_virt(self):
> > > > > > >>>
> > > > > > >>> That test case fails on my system (Fedora 29 x86_64). Avo=
cado seems
> > > > > > >>> unable to kill the VM so it=A0 reaches the timeout.
> > > > > > >>>
> > > > > > >>> I compiled QEMU with default configuration:
> > > > > > >>>
> > > > > > >>> $ configure --python=3D/usr/bin/python3 --target-list=3Dx=
86_64-softmmu
> > > > > > >>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-soft=
mmu,ppc64-softmmu,aarch64-softmmu)
> > > > > > >>>
> > > > > > >>>
> > > > > > >>> Follows a snippet of the Avocado's job.log file:
> > > > > > >>> ----
> > > > > > >>> 2019-01-31 14:41:34,912 test=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 L0602 INFO | START
> > > > > > >>> 07-/root/src/qemu/tests/acceptance/boot_linux_console.py:=
BootLinuxConsole.test_aarch64_virt
> > > > > > >>>
> > > > > > >>> 2019-01-31 14:41:34,912 test=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 L0298 DEBUG| DATA
> > > > > > >>> (filename=3Doutput.expected) =3D> NOT FOUND (data sources=
: variant, test, file)
> > > > > > >>> 2019-01-31 14:41:34,913 parameters=A0=A0=A0=A0=A0=A0 L014=
6 DEBUG| PARAMS (key=3Darch,
> > > > > > >>> path=3D*, default=3Daarch64) =3D> 'aarch64'
> > > > > > >>> 2019-01-31 14:41:34,913 parameters=A0=A0=A0=A0=A0=A0 L014=
6 DEBUG| PARAMS
> > > > > > >>> (key=3Dqemu_bin, path=3D*, default=3Daarch64-softmmu/qemu=
-system-aarch64) =3D>
> > > > > > >>> 'aarch64-softmmu/qemu-system-aarch64'
> > > > > > >>> 2019-01-31 14:41:34,915 download=A0=A0=A0=A0=A0=A0=A0=A0 =
L0070 INFO | Fetching
> > > > > > >>> https://sjc.edge.kernel.org/fedora-buffet/fedora/linux/re=
leases/29/Server/aarch64/os/images/pxeboot/vmlinuz
> > > > > > >>> -> /var/lib/avocado/data/cache/by_name/vmlinuz.3upct2pr
> > > > > > >>> 2019-01-31 14:41:35,490 download=A0=A0=A0=A0=A0=A0=A0=A0 =
L0054 DEBUG| Retrieved URL
> > > > > > >>> "https://sjc.edge.kernel.org/fedora-buffet/fedora/linux/r=
eleases/29/Server/aarch64/os/images/pxeboot/vmlinuz":
> > > > > > >>> content-length 8623423, date: "Thu, 31 Jan 2019 19:41:35 =
GMT",
> > > > > > >>> last-modified: "Sun, 21 Oct 2018 00:43:09 GMT"
> > > > > > >>> 2019-01-31 14:41:41,765 qemu=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 L0317 DEBUG| VM launch command:
> > > > > > >>> 'aarch64-softmmu/qemu-system-aarch64 -chardev
> > > > > > >>> socket,id=3Dmon,path=3D/var/tmp/tmpizirkcud/qemu-32609-mo=
nitor.sock -mon
> > > > > > >>> chardev=3Dmon,mode=3Dcontrol -display none -vga none -mac=
hine virt -chardev
> > > > > > >>> socket,id=3Dconsole,path=3D/var/tmp/tmpizirkcud/qemu-3260=
9-console.sock,server,nowait
> > > > > > >>> -serial chardev:console -cpu cortex-a53 -kernel
> > > > > > >>> /var/lib/avocado/data/cache/by_name/vmlinuz -append conso=
le=3DttyAMA0'
> > > > > > >>> 2019-01-31 14:41:41,779 qmp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 L0167 DEBUG| >>> {'execute':
> > > > > > >>> 'qmp_capabilities'}
> > > > > > >>> 2019-01-31 14:41:41,931 qmp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 L0175 DEBUG| <<< {'return': {}}
> > > > > > >>> 2019-01-31 14:41:42,830 boot_linux_conso L0041 DEBUG| [=A0=
=A0=A0 0.000000]
> > > > > > >>> Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> > > > > > >>>
> > > > > > >>> (...)
> > > > > > >>>
> > > > > > >>> 2019-01-31 14:41:42,833 boot_linux_conso L0041 DEBUG| [=A0=
=A0=A0 0.000000]
> > > > > > >>> Policy zone: DMA32
> > > > > > >>> 2019-01-31 14:41:42,833 boot_linux_conso L0041 DEBUG| [=A0=
=A0=A0 0.000000]
> > > > > > >>> Kernel command line: console=3DttyAMA0
> > > > > > >>> 2019-01-31 14:41:42,833 qmp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 L0167 DEBUG| >>> {'execute':
> > > > > > >>> 'quit'}
> > > > > > >>
> > > > > > >> Here, a QMP response like "<<< {'return': {}}" would be ex=
pected.
> > > > > > >>
> > > > > > >> Since I can not reproduce this on my system (or on Travis-=
CI jobs I've
> > > > > > >> sent), can you tell me on top of which commit you've appli=
ed these patches?
> > > > > > >>
> > > > > > >=20
> > > > > > > I spoke too soon:
> > > > > > >=20
> > > > > > > https://travis-ci.org/clebergnu/qemu/jobs/487121425#L3033
> > > > > > >=20
> > > > > > > This looks like a recent regression, and I'm guessing it's =
not on the
> > > > > > > test's side.  I'll try to bisect it and let you know.
> > > > > > >=20
> > > > > >=20
> > > > > > On a fresh environment, I am able to get this reproduced on e=
very 2 of
> > > > > > runs, more or less.  When I hit it, I attached GDB to it, and=
 the
> > > > > > backtrace shows:
> > > > > >=20
> > > > > > Thread debugging using libthread_db enabled]
> > > > > > Using host libthread_db library "/lib64/libthread_db.so.1".
> > > > > > warning: Loadable section ".note.gnu.property" outside of ELF=
 segments
> > > > > > warning: Loadable section ".note.gnu.property" outside of ELF=
 segments
> > > > > > __lll_lock_wait () at ../sysdeps/unix/sysv/linux/x86_64/lowle=
vellock.S:103
> > > > > > 103     2:      movl    %edx, %eax
> > > > > > (gdb) bt
> > > > > > #0  __lll_lock_wait () at
> > > > > > ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:103
> > > > > > #1  0x00007fc6ba1a2e09 in __GI___pthread_mutex_lock
> > > > > > (mutex=3Dmutex@entry=3D0x5615a233d020 <qemu_global_mutex>) at
> > > > > > ../nptl/pthread_mutex_lock.c:80
> > > > > > #2  0x00005615a1bb7593 in qemu_mutex_lock_impl (mutex=3D0x561=
5a233d020
> > > > > > <qemu_global_mutex>, file=3D0x5615a1db2d4c "util/main-loop.c"=
, line=3D236)
> > > > > > at util/qemu-thread-posix.c:66
> > > > > > #3  0x00005615a171125e in qemu_mutex_lock_iothread_impl
> > > > > > (file=3Dfile@entry=3D0x5615a1db2d4c "util/main-loop.c", line=3D=
line@entry=3D236)
> > > > > > at /home/cleber/src/qemu/cpus.c:1849
> > > > > > #4  0x00005615a1bb415d in os_host_main_loop_wait (timeout=3D<=
optimized
> > > > > > out>) at util/main-loop.c:236
> > > > > > #5  main_loop_wait (nonblocking=3D<optimized out>) at util/ma=
in-loop.c:497
> > > > > > #6  0x00005615a18fdd39 in main_loop () at vl.c:1928
> > > > > > #7  0x00005615a16c9ee9 in main (argc=3D<optimized out>, argv=3D=
<optimized
> > > > > > out>, envp=3D<optimized out>) at vl.c:4665
> > > > >=20
> > > > > Tip: run "thread apply all bt" so you can get a backtrace of al=
l
> > > > > threads.
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > > Running it with `taskset -c 1` prevents this issue from happe=
ning, which
> > > > > > AFAICT, contributes even further towards this being a QEMU ra=
ce condition.
> > > > > >=20
> > > > > > I'm CC'ing Peter and Claudio (listed maintainers of aarch64),=
 as this
> > > > > > seems to limited to that target.  Any tips on what to do here=
?
> > > > >=20
> > > > > I am hitting this on Travis, too, and I finally could reproduce
> > > > > it locally,
> > > > >=20
> > > > > The guest is still writing on the serial console, but nobody is
> > > > > reading the data on the other side.  A VCPU thread is stuck
> > > > > inside the EAGAIN/nanosleep loop at qemu_chr_write_buffer(),
> > > > > holding the QEMU global lock.
> > > >=20
> > > > Experimental fix below.
> > > >=20
> > > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > ---
> > > >  python/qemu/__init__.py | 12 ++++++++----
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
> > > > index 81d9657ec0..4a691f34da 100644
> > > > --- a/python/qemu/__init__.py
> > > > +++ b/python/qemu/__init__.py
> > > > @@ -274,10 +274,6 @@ class QEMUMachine(object):
> > > > =20
> > > >          self._qemu_log_path =3D None
> > > > =20
> > > > -        if self._console_socket is not None:
> > > > -            self._console_socket.close()
> > > > -            self._console_socket =3D None
> > > > -
> > > >          if self._temp_dir is not None:
> > > >              shutil.rmtree(self._temp_dir)
> > > >              self._temp_dir =3D None
> > > > @@ -336,6 +332,14 @@ class QEMUMachine(object):
> > > >          """
> > > >          Terminate the VM and clean up
> > > >          """
> > > > +
> > > > +        # If we keep the console socket open, we may deadlock wa=
iting
> > > > +        # for QEMU to exit, while QEMU is waiting for the socket=
 to
> > > > +        # become writeable.
> > > > +        if self._console_socket is not None:
> > > > +            self._console_socket.close()
> > > > +            self._console_socket =3D None
> > > > +
> > >=20
> > > Right, this is somewhat equivalent to the following "workaround":
> > >=20
> > >    https://github.com/clebergnu/qemu/commit/e1713f3b91972ad57c089f2=
76c54db3f3fa63423
> > >=20
> > > I could not tell at the moment, though, if closing (or shutting dow=
n)
> > > the console socket was the appropriate fix.
> > >=20
> > > What I see is that Rick's commit pointed to by Lazlo is dated from
> > > 2016, and it says that a virtio-console fix is necessary.  I'd imag=
ine
> > > that, if a fix was ever proposed, it'd have been incorporated in th=
e
> > > F29 kernel used in this test... and that this workaround/fix would
> > > not be the best solution.
> >=20
> > If I understood this correctly, fixing the guest driver wouldn't
> > help here.  The commit mentioned by Laszlo (6ab3fc32ea64 "hw:
> > replace most use of qemu_chr_fe_write with qemu_chr_fe_write_all")
> > fixes data loss bugs but introduces the potential for deadlocks
> > like the one we are seeing.
> >=20
> > Unless we replace the existing ~30 qemu_chr_fe_write_all() calls
> > in device code, we need to make sure we are constantly reading
> > data from the console socket.
>=20
> Yes, you must *always* have something reading from the chardev backend.
> This really sucks, but it is preferrable to letting data end up in
> /dev/null.
>=20
> If this is being a problem for tests then consider it motivation to
> fix the root cause problem and make the devices properly do async
> I/O for chardevs.  Only a handful of them properly do this right
> now.
>
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|

Daniel,

Thanks for the explanation.  I don't feel completely capable of tackling
the root cause, but I'll give it a go anyway.

Eduardo,

Looks like we'll need this type of workaround now anyways.  As seen in
the reproducer I wrote, a test can cause this deadlock before it gets
to the test tearDown(), and either implicitly or explicitly gets to
QEMUMachine::shutdown().

I would also like to avoid exposing the user (test writer) to that
kind of situation though, which seems like what you tried to do.  But,
maybe the most honest approach right now is to make a explicit call to
read from and close the socket, paired with documentation/comment about
why that is being done?  This would be similar to the "XXX" comments on
6ab3fc32ea64.

Regards!
- Cleber.


