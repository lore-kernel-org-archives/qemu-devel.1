Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC32C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B831208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B831208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49868 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZIuP-0003hy-0g
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 13:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53709)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hZH0D-0003jt-GN
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hZGsk-00032B-Kd
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:34:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1hZGsj-0002vu-Gl; Fri, 07 Jun 2019 11:34:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FF84307D963;
 Fri,  7 Jun 2019 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-62.rdu2.redhat.com
 [10.10.122.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E38CC7E204;
 Fri,  7 Jun 2019 15:33:36 +0000 (UTC)
Date: Fri, 7 Jun 2019 11:33:34 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190607153334.GB9665@localhost.localdomain>
References: <20190117185628.21862-1-crosa@redhat.com>
 <20190117185628.21862-16-crosa@redhat.com>
 <b235e7a9-57ad-5547-b8ca-693159820a8f@redhat.com>
 <e63a4ea3-e9ff-4920-cdfa-14bf04b5b08c@redhat.com>
 <84aa43ba-df19-51f6-e14d-fb82a7f2dfcc@redhat.com>
 <a638e504-f7ad-fa3a-f198-c3878cfc560e@redhat.com>
 <20190607032648.GA22416@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190607032648.GA22416@habkost.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 07 Jun 2019 15:34:09 +0000 (UTC)
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

On Fri, Jun 07, 2019 at 12:26:48AM -0300, Eduardo Habkost wrote:
> On Fri, Feb 01, 2019 at 11:10:31AM -0500, Cleber Rosa wrote:
> >=20
> >=20
> > On 1/31/19 4:26 PM, Cleber Rosa wrote:
> > >=20
> > >=20
> > > On 1/31/19 3:21 PM, Cleber Rosa wrote:
> > >>
> > >>
> > >> On 1/31/19 3:02 PM, Wainer dos Santos Moschetta wrote:
> > >>>
> > >>> On 01/17/2019 04:56 PM, Cleber Rosa wrote:
> > >>>> Just like the previous tests, boots a Linux kernel on a aarch64 =
target
> > >>>> using the virt machine.
> > >>>>
> > >>>> One special option added is the CPU type, given that the kernel
> > >>>> selected fails to boot on the virt machine's default CPU (cortex=
-a15).
> > >>>>
> > >>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > >>>> ---
> > >>>> =A0 .travis.yml=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2 +-
> > >>>> =A0 tests/acceptance/boot_linux_console.py | 20 ++++++++++++++++=
++++
> > >>>> =A0 2 files changed, 21 insertions(+), 1 deletion(-)
> > >>>>
> > >>>> diff --git a/.travis.yml b/.travis.yml
> > >>>> index 54100eea5a..595e8c0b6c 100644
> > >>>> --- a/.travis.yml
> > >>>> +++ b/.travis.yml
> > >>>> @@ -187,7 +187,7 @@ matrix:
> > >>>> =A0 =A0=A0=A0=A0=A0 # Acceptance (Functional) tests
> > >>>> =A0=A0=A0=A0=A0 - env:
> > >>>> -=A0=A0=A0=A0=A0=A0=A0 - CONFIG=3D"--python=3D/usr/bin/python3
> > >>>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,ppc=
64-softmmu"
> > >>>> +=A0=A0=A0=A0=A0=A0=A0 - CONFIG=3D"--python=3D/usr/bin/python3
> > >>>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,ppc=
64-softmmu,aarch64-softmmu"
> > >>>>
> > >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 - TEST_CMD=3D"make check-acceptance"
> > >>>> =A0=A0=A0=A0=A0=A0=A0 addons:
> > >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 apt:
> > >>>> diff --git a/tests/acceptance/boot_linux_console.py
> > >>>> b/tests/acceptance/boot_linux_console.py
> > >>>> index f3ccd23a7a..107700b517 100644
> > >>>> --- a/tests/acceptance/boot_linux_console.py
> > >>>> +++ b/tests/acceptance/boot_linux_console.py
> > >>>> @@ -138,3 +138,23 @@ class BootLinuxConsole(Test):
> > >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.vm.launch()
> > >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 console_pattern =3D 'Kernel command =
line: %s' %
> > >>>> kernel_command_line
> > >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.wait_for_console_pattern(consol=
e_pattern)
> > >>>> +
> > >>>> +=A0=A0=A0 def test_aarch64_virt(self):
> > >>>
> > >>> That test case fails on my system (Fedora 29 x86_64). Avocado see=
ms
> > >>> unable to kill the VM so it=A0 reaches the timeout.
> > >>>
> > >>> I compiled QEMU with default configuration:
> > >>>
> > >>> $ configure --python=3D/usr/bin/python3 --target-list=3Dx86_64-so=
ftmmu
> > >>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,ppc6=
4-softmmu,aarch64-softmmu)
> > >>>
> > >>>
> > >>> Follows a snippet of the Avocado's job.log file:
> > >>> ----
> > >>> 2019-01-31 14:41:34,912 test=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
L0602 INFO | START
> > >>> 07-/root/src/qemu/tests/acceptance/boot_linux_console.py:BootLinu=
xConsole.test_aarch64_virt
> > >>>
> > >>> 2019-01-31 14:41:34,912 test=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
L0298 DEBUG| DATA
> > >>> (filename=3Doutput.expected) =3D> NOT FOUND (data sources: varian=
t, test, file)
> > >>> 2019-01-31 14:41:34,913 parameters=A0=A0=A0=A0=A0=A0 L0146 DEBUG|=
 PARAMS (key=3Darch,
> > >>> path=3D*, default=3Daarch64) =3D> 'aarch64'
> > >>> 2019-01-31 14:41:34,913 parameters=A0=A0=A0=A0=A0=A0 L0146 DEBUG|=
 PARAMS
> > >>> (key=3Dqemu_bin, path=3D*, default=3Daarch64-softmmu/qemu-system-=
aarch64) =3D>
> > >>> 'aarch64-softmmu/qemu-system-aarch64'
> > >>> 2019-01-31 14:41:34,915 download=A0=A0=A0=A0=A0=A0=A0=A0 L0070 IN=
FO | Fetching
> > >>> https://sjc.edge.kernel.org/fedora-buffet/fedora/linux/releases/2=
9/Server/aarch64/os/images/pxeboot/vmlinuz
> > >>> -> /var/lib/avocado/data/cache/by_name/vmlinuz.3upct2pr
> > >>> 2019-01-31 14:41:35,490 download=A0=A0=A0=A0=A0=A0=A0=A0 L0054 DE=
BUG| Retrieved URL
> > >>> "https://sjc.edge.kernel.org/fedora-buffet/fedora/linux/releases/=
29/Server/aarch64/os/images/pxeboot/vmlinuz":
> > >>> content-length 8623423, date: "Thu, 31 Jan 2019 19:41:35 GMT",
> > >>> last-modified: "Sun, 21 Oct 2018 00:43:09 GMT"
> > >>> 2019-01-31 14:41:41,765 qemu=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
L0317 DEBUG| VM launch command:
> > >>> 'aarch64-softmmu/qemu-system-aarch64 -chardev
> > >>> socket,id=3Dmon,path=3D/var/tmp/tmpizirkcud/qemu-32609-monitor.so=
ck -mon
> > >>> chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine vir=
t -chardev
> > >>> socket,id=3Dconsole,path=3D/var/tmp/tmpizirkcud/qemu-32609-consol=
e.sock,server,nowait
> > >>> -serial chardev:console -cpu cortex-a53 -kernel
> > >>> /var/lib/avocado/data/cache/by_name/vmlinuz -append console=3Dtty=
AMA0'
> > >>> 2019-01-31 14:41:41,779 qmp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 L0167 DEBUG| >>> {'execute':
> > >>> 'qmp_capabilities'}
> > >>> 2019-01-31 14:41:41,931 qmp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 L0175 DEBUG| <<< {'return': {}}
> > >>> 2019-01-31 14:41:42,830 boot_linux_conso L0041 DEBUG| [=A0=A0=A0 =
0.000000]
> > >>> Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> > >>>
> > >>> (...)
> > >>>
> > >>> 2019-01-31 14:41:42,833 boot_linux_conso L0041 DEBUG| [=A0=A0=A0 =
0.000000]
> > >>> Policy zone: DMA32
> > >>> 2019-01-31 14:41:42,833 boot_linux_conso L0041 DEBUG| [=A0=A0=A0 =
0.000000]
> > >>> Kernel command line: console=3DttyAMA0
> > >>> 2019-01-31 14:41:42,833 qmp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 L0167 DEBUG| >>> {'execute':
> > >>> 'quit'}
> > >>
> > >> Here, a QMP response like "<<< {'return': {}}" would be expected.
> > >>
> > >> Since I can not reproduce this on my system (or on Travis-CI jobs =
I've
> > >> sent), can you tell me on top of which commit you've applied these=
 patches?
> > >>
> > >=20
> > > I spoke too soon:
> > >=20
> > > https://travis-ci.org/clebergnu/qemu/jobs/487121425#L3033
> > >=20
> > > This looks like a recent regression, and I'm guessing it's not on t=
he
> > > test's side.  I'll try to bisect it and let you know.
> > >=20
> >=20
> > On a fresh environment, I am able to get this reproduced on every 2 o=
f
> > runs, more or less.  When I hit it, I attached GDB to it, and the
> > backtrace shows:
> >=20
> > Thread debugging using libthread_db enabled]
> > Using host libthread_db library "/lib64/libthread_db.so.1".
> > warning: Loadable section ".note.gnu.property" outside of ELF segment=
s
> > warning: Loadable section ".note.gnu.property" outside of ELF segment=
s
> > __lll_lock_wait () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.=
S:103
> > 103     2:      movl    %edx, %eax
> > (gdb) bt
> > #0  __lll_lock_wait () at
> > ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:103
> > #1  0x00007fc6ba1a2e09 in __GI___pthread_mutex_lock
> > (mutex=3Dmutex@entry=3D0x5615a233d020 <qemu_global_mutex>) at
> > ../nptl/pthread_mutex_lock.c:80
> > #2  0x00005615a1bb7593 in qemu_mutex_lock_impl (mutex=3D0x5615a233d02=
0
> > <qemu_global_mutex>, file=3D0x5615a1db2d4c "util/main-loop.c", line=3D=
236)
> > at util/qemu-thread-posix.c:66
> > #3  0x00005615a171125e in qemu_mutex_lock_iothread_impl
> > (file=3Dfile@entry=3D0x5615a1db2d4c "util/main-loop.c", line=3Dline@e=
ntry=3D236)
> > at /home/cleber/src/qemu/cpus.c:1849
> > #4  0x00005615a1bb415d in os_host_main_loop_wait (timeout=3D<optimize=
d
> > out>) at util/main-loop.c:236
> > #5  main_loop_wait (nonblocking=3D<optimized out>) at util/main-loop.=
c:497
> > #6  0x00005615a18fdd39 in main_loop () at vl.c:1928
> > #7  0x00005615a16c9ee9 in main (argc=3D<optimized out>, argv=3D<optim=
ized
> > out>, envp=3D<optimized out>) at vl.c:4665
>=20
> Tip: run "thread apply all bt" so you can get a backtrace of all
> threads.
>=20
>

Nice, thanks!

> >=20
> > Running it with `taskset -c 1` prevents this issue from happening, wh=
ich
> > AFAICT, contributes even further towards this being a QEMU race condi=
tion.
> >=20
> > I'm CC'ing Peter and Claudio (listed maintainers of aarch64), as this
> > seems to limited to that target.  Any tips on what to do here?
>=20
> I am hitting this on Travis, too, and I finally could reproduce
> it locally,
>=20
> The guest is still writing on the serial console, but nobody is
> reading the data on the other side.  A VCPU thread is stuck
> inside the EAGAIN/nanosleep loop at qemu_chr_write_buffer(),
> holding the QEMU global lock.
>

This is awesome, because it really looks like a perfect explanation
for the behavior/reproducer/workaround that I described here:

 https://bugs.launchpad.net/qemu/+bug/1829779

> Thread 4 (Thread 0x7f2e45fff700 (LWP 6461)):
> #0  0x00007f2e4ec03500 in nanosleep () at /lib64/libpthread.so.0
> #1  0x00007f2e4fb229d7 in g_usleep () at /lib64/libglib-2.0.so.0
> #2  0x0000559a4e7ca4c9 in qemu_chr_write_buffer (s=3Ds@entry=3D0x559a50=
2d0ac0, buf=3Dbuf@entry=3D0x7f2e45ffdd90 "7", len=3D1, offset=3Doffset@en=
try=3D0x7f2e45ffdd60, write_all=3Dtrue) at chardev/char.c:115
> #3  0x0000559a4e7ca78f in qemu_chr_write (s=3D0x559a502d0ac0, buf=3Dbuf=
@entry=3D0x7f2e45ffdd90 "7", len=3Dlen@entry=3D1, write_all=3Dwrite_all@e=
ntry=3Dtrue) at chardev/char.c:148
> #4  0x0000559a4e7cc7e2 in qemu_chr_fe_write_all (be=3Dbe@entry=3D0x559a=
504b4c50, buf=3Dbuf@entry=3D0x7f2e45ffdd90 "7", len=3Dlen@entry=3D1) at c=
hardev/char-fe.c:53
> #5  0x0000559a4e58f320 in pl011_write (opaque=3D0x559a504b47d0, offset=3D=
0, value=3D55, size=3D<optimized out>) at hw/char/pl011.c:183
> #6  0x0000559a4e325121 in memory_region_write_accessor (mr=3D0x559a504b=
4ae0, addr=3D0, value=3D<optimized out>, size=3D2, shift=3D<optimized out=
>, mask=3D<optimized out>, attrs=3D...) at /home/ehabkost/rh/proj/virt/qe=
mu/memory.c:503
> #7  0x0000559a4e322cd6 in access_with_adjusted_size (addr=3Daddr@entry=3D=
0, value=3Dvalue@entry=3D0x7f2e45ffded8, size=3Dsize@entry=3D2, access_si=
ze_min=3D<optimized out>, access_size_max=3D<optimized out>, access_fn=3D=
access_fn@entry=3D
>     0x559a4e3250a0 <memory_region_write_accessor>, mr=3D0x559a504b4ae0,=
 attrs=3D...) at /home/ehabkost/rh/proj/virt/qemu/memory.c:569
> #8  0x0000559a4e32763f in memory_region_dispatch_write (mr=3Dmr@entry=3D=
0x559a504b4ae0, addr=3Daddr@entry=3D0, data=3D<optimized out>, data@entry=
=3D55, size=3Dsize@entry=3D2, attrs=3D...) at /home/ehabkost/rh/proj/virt=
/qemu/memory.c:1497
> #9  0x0000559a4e338708 in io_writex (env=3Denv@entry=3D0x559a503d5620, =
mmu_idx=3Dmmu_idx@entry=3D1, val=3Dval@entry=3D55, addr=3Daddr@entry=3D18=
446462598867529728, retaddr=3D139836732143069, size=3D2, iotlbentry=3D<op=
timized out>, iotlbentry=3D<optimized out>)
>     at /home/ehabkost/rh/proj/virt/qemu/accel/tcg/cputlb.c:945
> #10 0x0000559a4e33d203 in store_helper (big_endian=3Dfalse, size=3D2, r=
etaddr=3D<optimized out>, oi=3D<optimized out>, val=3D55, addr=3D18446462=
598867529728, env=3D0x559a503d5620) at /home/ehabkost/rh/proj/virt/qemu/a=
ccel/tcg/cputlb.c:1544
> #11 0x0000559a4e33d203 in helper_le_stw_mmu (env=3D0x559a503d5620, addr=
=3D18446462598867529728, val=3D55, oi=3D<optimized out>, retaddr=3D139836=
732143069) at /home/ehabkost/rh/proj/virt/qemu/accel/tcg/cputlb.c:1636
> #12 0x00007f2e46bef5dd in code_gen_buffer ()
> #13 0x0000559a4e352381 in cpu_tb_exec (itb=3D<optimized out>, cpu=3D0x5=
59a503d5620) at /home/ehabkost/rh/proj/virt/qemu/accel/tcg/cpu-exec.c:171
> #14 0x0000559a4e352381 in cpu_loop_exec_tb (tb_exit=3D<synthetic pointe=
r>, last_tb=3D<synthetic pointer>, tb=3D<optimized out>, cpu=3D0x559a503d=
5620) at /home/ehabkost/rh/proj/virt/qemu/accel/tcg/cpu-exec.c:618
> #15 0x0000559a4e352381 in cpu_exec (cpu=3Dcpu@entry=3D0x559a503cd360) a=
t /home/ehabkost/rh/proj/virt/qemu/accel/tcg/cpu-exec.c:729
> #16 0x0000559a4e30ea0f in tcg_cpu_exec (cpu=3D0x559a503cd360) at /home/=
ehabkost/rh/proj/virt/qemu/cpus.c:1434
> #17 0x0000559a4e310b6b in qemu_tcg_cpu_thread_fn (arg=3Darg@entry=3D0x5=
59a503cd360) at /home/ehabkost/rh/proj/virt/qemu/cpus.c:1743
> #18 0x0000559a4e83669a in qemu_thread_start (args=3D<optimized out>) at=
 util/qemu-thread-posix.c:502
> #19 0x00007f2e4ebf958e in start_thread () at /lib64/libpthread.so.0
> #20 0x00007f2e4eb266f3 in clone () at /lib64/libc.so.6
>=20
>=20
> For reference, this is the QEMU command line:
>=20
> aarch64-softmmu/qemu-system-aarch64 -chardev socket,id=3Dmon,path=3D/va=
r/tmp/tmpxnkcjvf0/qemu-6453-monitor.sock -mon chardev=3Dmon,mode=3Dcontro=
l -display none -vga none -machine virt -chardev socket,id=3Dconsole,path=
=3D/var/tmp/tmpxnkcjvf0/qemu-6453-console.sock,server,nowait -serial char=
dev:console -cpu cortex-a53 -kernel /home/ehabkost/rh/proj/virt/qemu/test=
s/venv/data/cache/by_location/e959d0e1dd72e77653e218e666198db1f3d0c213/vm=
linuz -append printk.time=3D0 console=3DttyAMA0
>=20
>=20
>=20
> --=20
> Eduardo

Besides the command line, I hope it's also easy to use the following
reproducer:

 https://github.com/clebergnu/qemu/commit/c778e28c24030c4a36548b714293b31=
9f4bf18df

It should apply cleanly to QEMU master, and instructions on how to run
it are documented in the commit message.

Thanks,
- Cleber.

