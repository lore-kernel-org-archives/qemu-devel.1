Received: from eggs.gnu.org ([2001:4830:134:3::10]:46720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e84Uc-0004uf-G6
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e84UW-00028v-R4
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:16:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:45068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e84UW-00025x-HF
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:16:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e84UU-0005lm-N6
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 13:16:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8B1DD2E80C9
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 13:16:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Oct 2017 13:05:24 -0000
From: Bug Watch Updater <546458@bugs.launchpad.net>
Reply-To: Bug 546458 <546458@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100324221929.19590.58686.malonedeb@wampee.canonical.com>
Message-Id: <150910952739.23204.8449628901442712839.launchpad@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 546458] Re: kernel NULL pointer in -virtual
 (-server) kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Launchpad has imported 11 comments from the remote bug at
https://bugzilla.redhat.com/show_bug.cgi?id=3D560114.

If you reply to an imported comment from within Launchpad, your comment
will be sent to the remote bug automatically. Read more about
Launchpad's inter-bugtracker facilities at
https://help.launchpad.net/InterBugTracking.

------------------------------------------------------------------------
On 2010-01-29T21:39:02+00:00 James wrote:

Description of problem:

During an VNC installation on a virt guest, the installer appeared to
hang while installing the bootloader.  Closer inspection on the console
shows a kernel NULL pointer dereference.

Version-Release number of selected component (if applicable):

 * anaconda-13.23
 * kernel-2.6.33-0.23.rc5.git1.fc13.x86_64

How reproducible:
 * This is the first time out of 8 or more installs

Steps to Reproduce:
1. Perform an installation against http://alt.fedoraproject.org/pub/alt/sta=
ge/rawhide-testing/
  =

Actual results:

Running anaconda 13.23, the Fedora system installer - please wait.         =
    =

21:09:16 Starting VNC...
21:09:17 The VNC server is now running.
21:09:17 =


WARNING!!! VNC server running with NO PASSWORD!
You can use the vncpassword=3D<password> boot option
if you would like to secure the server.


21:09:17 Please manually connect your vnc client to test1200.test.redhat.co=
m:1 (10.10.10.200) to begin the install.
Press <enter> for a shell
21:09:18 Starting graphical installation.

sh-4.1# BUG: unable to handle kernel NULL pointer dereference at 0000000000=
000358
IP: [<ffffffffa010846b>] sym_int_sir+0x646/0x1549 [sym53c8xx]
PGD 2b2ef067 PUD 3eea2067 PMD 0 =

Oops: 0000 [#1] SMP =

last sysfs file: /sys/devices/pci0000:00/0000:00:04.0/host2/target2:0:0/2:0=
:0:0/block/sda/removable
CPU 0 =

Pid: 0, comm: swapper Not tainted 2.6.33-0.23.rc5.git1.fc13.x86_64 #1 /
RIP: 0010:[<ffffffffa010846b>]  [<ffffffffa010846b>] sym_int_sir+0x646/0x15=
49 [sym53c8xx]
RSP: 0018:ffff880003c039b0  EFLAGS: 00010087
RAX: 000000000000000a RBX: ffff88003e41c000 RCX: 0000000000000070
RDX: 0000000000000000 RSI: ffffffffa0103c22 RDI: ffffc90000a5a006
RBP: ffff880003c03a30 R08: ffffffff81a4b830 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88003e41c090 R14: ffff88003e6a800b R15: 0000000000000084
FS:  0000000000000000(0000) GS:ffff880003c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000358 CR3: 000000002b2ec000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process swapper (pid: 0, threadinfo ffffffff81a00000, task ffffffff81a4b020)
Stack:
 0000000000000000 0000000000000002 ffffffff81a4b020 0000000000000000
<0> 0000000000000000 0000000000000000 0000000000000000 0000000000000046
<0> 0000000000000000 0000000000000000 ffff880003c03a60 ffff88003e41c000
Call Trace:
 <IRQ> =

 [<ffffffffa010980c>] sym_interrupt+0x49e/0x6d2 [sym53c8xx]
 [<ffffffffa0103c2a>] sym53c8xx_intr+0x4d/0x7b [sym53c8xx]
 [<ffffffff810abec8>] handle_IRQ_event+0x53/0x119
 [<ffffffff810add95>] handle_fasteoi_irq+0x90/0xd0
 [<ffffffff8100c437>] handle_irq+0x88/0x91
 [<ffffffff8147ca74>] do_IRQ+0x5c/0xc3
 [<ffffffff81477b13>] ret_from_intr+0x0/0x16
 [<ffffffff814778d6>] ? _raw_spin_unlock_irqrestore+0x4c/0x56
 [<ffffffff812fb08f>] ? spin_unlock_irqrestore+0xe/0x10
 [<ffffffff812fbb16>] ? scsi_dispatch_cmd+0x1c1/0x234
 [<ffffffff81301b81>] ? scsi_request_fn+0x476/0x4a3
 [<ffffffff812152ed>] ? __blk_run_queue+0x45/0x74
 [<ffffffff812153d1>] ? blk_run_queue+0x26/0x3a
 [<ffffffff81300ff4>] ? scsi_run_queue+0x300/0x3ac
 [<ffffffff812e8964>] ? put_device+0x17/0x19
 [<ffffffff81301ddc>] ? scsi_next_command+0x3b/0x4b
 [<ffffffff813027cb>] ? scsi_io_completion+0x1f7/0x448
 [<ffffffff81300c43>] ? spin_unlock_irqrestore+0xe/0x10
 [<ffffffff812fb834>] ? scsi_finish_command+0xf5/0xfe
 [<ffffffff81302b42>] ? scsi_softirq_done+0x111/0x11a
 [<ffffffff8121a69a>] ? blk_done_softirq+0x82/0x92
 [<ffffffff810567e4>] ? __do_softirq+0xf8/0x1cd
 [<ffffffff8100ab9c>] ? call_softirq+0x1c/0x30
 [<ffffffff8100c357>] ? do_softirq+0x4b/0xa3
 [<ffffffff810563cf>] ? irq_exit+0x4a/0x8c
 [<ffffffff8147cac4>] ? do_IRQ+0xac/0xc3
 [<ffffffff81477b13>] ? ret_from_intr+0x0/0x16
 <EOI> =

 [<ffffffff81029289>] ? native_safe_halt+0xb/0xd
 [<ffffffff8107d04f>] ? trace_hardirqs_on+0xd/0xf
 [<ffffffff810115f5>] ? default_idle+0x3b/0x5d
 [<ffffffff81008bfc>] ? cpu_idle+0xaf/0xe9
 [<ffffffff8145ed6a>] ? rest_init+0x7e/0x80
 [<ffffffff81d82e2f>] ? start_kernel+0x440/0x44b
 [<ffffffff81d822bc>] ? x86_64_start_reservations+0xa7/0xab
 [<ffffffff81d823b8>] ? x86_64_start_kernel+0xf8/0x107
Code: b2 d5 10 a0 48 89 da eb 65 48 8b 9f b0 01 00 00 48 81 c7 a0 01 00 00 =
e8 68 02 1e e1 48 c7 c7 ec d5 10 a0 48 89 c6 48 89 da eb 6f <49> 8b 84 24 5=
8 03 00 00 48 8b 90 80 00 00 00 48 8b 38 4c 8b a2 =

RIP  [<ffffffffa010846b>] sym_int_sir+0x646/0x1549 [sym53c8xx]
 RSP <ffff880003c039b0>
CR2: 0000000000000358
---[ end trace f535af648735afc9 ]---
Kernel panic - not syncing: Fatal exception in interrupt
Pid: 0, comm: swapper Tainted: G      D    2.6.33-0.23.rc5.git1.fc13.x86_64=
 #1
Call Trace:
 <IRQ>  [<ffffffff81474628>] panic+0x7a/0x142
 [<ffffffff81478b03>] oops_end+0xb7/0xc7
 [<ffffffff8102f869>] no_context+0x1fc/0x20b
 [<ffffffff81029d1a>] ? pvclock_clocksource_read+0x47/0x83
 [<ffffffff8102fa0a>] __bad_area_nosemaphore+0x192/0x1b5
 [<ffffffff81029237>] ? kvm_clock_read+0x21/0x23
 [<ffffffff8102fa40>] bad_area_nosemaphore+0x13/0x15
 [<ffffffff8147a60b>] do_page_fault+0x16f/0x2df
 [<ffffffff81477e75>] page_fault+0x25/0x30
 [<ffffffffa0103c22>] ? sym53c8xx_intr+0x45/0x7b [sym53c8xx]
 [<ffffffffa010846b>] ? sym_int_sir+0x646/0x1549 [sym53c8xx]
 [<ffffffffa010980c>] sym_interrupt+0x49e/0x6d2 [sym53c8xx]
 [<ffffffffa0103c2a>] sym53c8xx_intr+0x4d/0x7b [sym53c8xx]
 [<ffffffff810abec8>] handle_IRQ_event+0x53/0x119
 [<ffffffff810add95>] handle_fasteoi_irq+0x90/0xd0
 [<ffffffff8100c437>] handle_irq+0x88/0x91
 [<ffffffff8147ca74>] do_IRQ+0x5c/0xc3
 [<ffffffff81477b13>] ret_from_intr+0x0/0x16
 [<ffffffff814778d6>] ? _raw_spin_unlock_irqrestore+0x4c/0x56
 [<ffffffff812fb08f>] ? spin_unlock_irqrestore+0xe/0x10
 [<ffffffff812fbb16>] ? scsi_dispatch_cmd+0x1c1/0x234
 [<ffffffff81301b81>] ? scsi_request_fn+0x476/0x4a3
 [<ffffffff812152ed>] ? __blk_run_queue+0x45/0x74
 [<ffffffff812153d1>] ? blk_run_queue+0x26/0x3a
 [<ffffffff81300ff4>] ? scsi_run_queue+0x300/0x3ac
 [<ffffffff812e8964>] ? put_device+0x17/0x19
 [<ffffffff81301ddc>] ? scsi_next_command+0x3b/0x4b
 [<ffffffff813027cb>] ? scsi_io_completion+0x1f7/0x448
 [<ffffffff81300c43>] ? spin_unlock_irqrestore+0xe/0x10
 [<ffffffff812fb834>] ? scsi_finish_command+0xf5/0xfe
 [<ffffffff81302b42>] ? scsi_softirq_done+0x111/0x11a
 [<ffffffff8121a69a>] ? blk_done_softirq+0x82/0x92
 [<ffffffff810567e4>] ? __do_softirq+0xf8/0x1cd
 [<ffffffff8100ab9c>] ? call_softirq+0x1c/0x30
 [<ffffffff8100c357>] ? do_softirq+0x4b/0xa3
 [<ffffffff810563cf>] ? irq_exit+0x4a/0x8c
 [<ffffffff8147cac4>] ? do_IRQ+0xac/0xc3
 [<ffffffff81477b13>] ? ret_from_intr+0x0/0x16
 <EOI>  [<ffffffff81029289>] ? native_safe_halt+0xb/0xd
 [<ffffffff8107d04f>] ? trace_hardirqs_on+0xd/0xf
 [<ffffffff810115f5>] ? default_idle+0x3b/0x5d
 [<ffffffff81008bfc>] ? cpu_idle+0xaf/0xe9
 [<ffffffff8145ed6a>] ? rest_init+0x7e/0x80
 [<ffffffff81d82e2f>] ? start_kernel+0x440/0x44b
 [<ffffffff81d822bc>] ? x86_64_start_reservations+0xa7/0xab
 [<ffffffff81d823b8>] ? x86_64_start_kernel+0xf8/0x107


Expected results:

No kernel oops

Reply at:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/546458/comments/0

------------------------------------------------------------------------
On 2010-02-03T12:00:42+00:00 Ariel wrote:

This seems to be the same kvm scsi emulation issue reported and discussed o=
n the LKML,
   http://www.mail-archive.com/kvm@vger.kernel.org/msg08927.html

and also Debian bug #511914
   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D511914

Rgds, Ariel

Reply at:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/546458/comments/1

------------------------------------------------------------------------
On 2010-02-05T04:27:31+00:00 Amit wrote:

Which qemu-kvm version are you using? Could you try the one from virt-
preview?

qemu's SCSI support isn't the one that gets most developer attention;
can you please try ide or virtio?

Reply at:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/546458/comments/2

------------------------------------------------------------------------
On 2010-02-05T14:08:12+00:00 James wrote:

(In reply to comment #2)
> Which qemu-kvm version are you using? Could you try the one from virt-pre=
view?

 * qemu-kvm-0.11.0-12.fc12.x86_64

I'm running into other issues when trying to use the F-12 virt-preview
repository.  I'll take those to virt@lists.fedoraproject.org for
feedback.

> qemu's SCSI support isn't the one that gets most developer attention; can=
 you
> please try ide or virtio?    =


I can work around this by using ide or virtio.  This is certainly
specific to SCSI KVM installs.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/546458/comments/3

------------------------------------------------------------------------
On 2010-02-18T13:10:18+00:00 James wrote:

(In reply to comment #3)
> (In reply to comment #2)
> > Which qemu-kvm version are you using? Could you try the one from virt-p=
review?
> =

>  * qemu-kvm-0.11.0-12.fc12.x86_64
> =

> I'm running into other issues when trying to use the F-12 virt-preview
> repository.  I'll take those to virt@lists.fedoraproject.org for feedback.

I'm still not able to start a guest using virt-preview repository.  I've
filed bug#566425 to address that issue.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/546458/comments/4

------------------------------------------------------------------------
On 2010-03-09T16:54:01+00:00 Fedora wrote:

This package has changed ownership in the Fedora Package Database.
Reassigning to the new owner of this component.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/546458/comments/5

------------------------------------------------------------------------
On 2010-03-09T17:19:51+00:00 Fedora wrote:

This package has changed ownership in the Fedora Package Database.
Reassigning to the new owner of this component.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/546458/comments/6

------------------------------------------------------------------------
On 2010-03-15T14:18:22+00:00 Bug wrote:


This bug appears to have been reported against 'rawhide' during the Fedora =
13 development cycle.
Changing version to '13'.

More information and reason for this action is here:
http://fedoraproject.org/wiki/BugZappers/HouseKeeping

Reply at:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/546458/comments/7

------------------------------------------------------------------------
On 2010-04-22T18:05:21+00:00 Justin wrote:

The issue which blocks use of virt-preview/F-13 qemu has been resolved.
Would it be possible to retest with qemu-0.12.x on the host?

Reply at:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/546458/comments/12

------------------------------------------------------------------------
On 2011-06-02T16:43:34+00:00 Bug wrote:


This message is a reminder that Fedora 13 is nearing its end of life.
Approximately 30 (thirty) days from now Fedora will stop maintaining
and issuing updates for Fedora 13.  It is Fedora's policy to close all
bug reports from releases that are no longer maintained.  At that time
this bug will be closed as WONTFIX if it remains open with a Fedora =

'version' of '13'.

Package Maintainer: If you wish for this bug to remain open because you
plan to fix it in a currently maintained version, simply change the 'versio=
n' =

to a later Fedora version prior to Fedora 13's end of life.

Bug Reporter: Thank you for reporting this issue and we are sorry that =

we may not be able to fix it before Fedora 13 is end of life.  If you =

would still like to see this bug fixed and are able to reproduce it =

against a later version of Fedora please change the 'version' of this =

bug to the applicable version.  If you are unable to change the version, =

please add a comment here and someone will do it for you.

Although we aim to fix as many bugs as possible during every release's =

lifetime, sometimes those efforts are overtaken by events.  Often a =

more recent Fedora release includes newer upstream software that fixes =

bugs or makes them obsolete.

The process we are following is described here: =

http://fedoraproject.org/wiki/BugZappers/HouseKeeping

Reply at:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/546458/comments/18

------------------------------------------------------------------------
On 2011-06-27T14:52:19+00:00 Bug wrote:


Fedora 13 changed to end-of-life (EOL) status on 2011-06-25. Fedora 13 is =

no longer maintained, which means that it will not receive any further =

security or bug fix updates. As a result we are closing this bug.

If you can reproduce this bug against a currently maintained version of =

Fedora please feel free to reopen this bug against that version.

Thank you for reporting this bug and we are sorry it could not be fixed.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/546458/comments/19


** Changed in: linux (Fedora)
       Status: Unknown =3D> Won't Fix

** Changed in: linux (Fedora)
   Importance: Unknown =3D> Medium

** Bug watch added: Debian Bug tracker #511914
   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D511914

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/546458

Title:
  kernel NULL pointer in -virtual (-server) kernel

Status in QEMU:
  Invalid
Status in linux package in Ubuntu:
  Triaged
Status in qemu-kvm package in Ubuntu:
  Invalid
Status in linux package in Fedora:
  Won't Fix

Bug description:
  When stress testing eucalyptus we have run into this oops inside VMs
  [   82.907577] BUG: unable to handle kernel NULL pointer dereference at 0=
000000000000358^M
  [   82.908842] IP: [<ffffffff813982e8>] sym_int_sir+0x2a8/0x750^M
  [   82.909773] PGD 0 ^M
  [   82.910110] Thread overran stack, or stack corrupted^M
  [   82.910870] Oops: 0000 [#1] SMP ^M
  [   82.911407] last sysfs file: /sys/devices/virtual/block/ram9/uevent^M

  We launched 18 instances, 2 of them failed this way.  The instances
  run with 192M of memory.  With 6 VM launches on a single node all at
  the same time the host is under heavy load.

  This occurred in 20100323 lucid x86_64 uec-image instance.

  ProblemType: Bug
  AlsaDevices: Error: command ['ls', '-l', '/dev/snd/'] failed with exit co=
de 2: ls: cannot access /dev/snd/: No such file or directory
  AplayDevices: Error: [Errno 2] No such file or directory
  Architecture: amd64
  ArecordDevices: Error: [Errno 2] No such file or directory
  CurrentDmesg:
   =

  Date: Wed Mar 24 22:06:32 2010
  DistroRelease: Ubuntu 10.04
  Frequency: Once a day.
  Lsusb: Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
  MachineType: Bochs Bochs
  Package: linux-image-2.6.32-16-virtual 2.6.32-16.25
  PciMultimedia:
   =

  ProcCmdLine: root=3D/dev/sda1 console=3DttyS0
  ProcEnviron:
   LANG=3Den_US.UTF-8
   SHELL=3D/bin/bash
  ProcVersionSignature: User Name 2.6.32-16.25-server
  Regression: No
  Reproducible: No
  SourcePackage: linux
  TestedUpstream: No
  Uname: Linux 2.6.32-16-server x86_64
  dmi.bios.date: 01/01/2007
  dmi.bios.vendor: Bochs
  dmi.bios.version: Bochs
  dmi.chassis.type: 1
  dmi.chassis.vendor: Bochs
  dmi.modalias: dmi:bvnBochs:bvrBochs:bd01/01/2007:svnBochs:pnBochs:pvr:cvn=
Bochs:ct1:cvr:
  dmi.product.name: Bochs
  dmi.sys.vendor: Bochs

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/546458/+subscriptions
