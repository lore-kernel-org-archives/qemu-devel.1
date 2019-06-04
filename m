Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD073C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9116224CF2
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9116224CF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47752 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY4EO-0001Pr-SI
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 03:51:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hY4DN-0000ps-Ta
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hY4DM-0003CE-5w
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:50:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:35026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hY4DL-00034k-Vr
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:50:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hY4DK-0002W2-4H
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 07:50:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 024552E80C7
	for <qemu-devel@nongnu.org>; Tue,  4 Jun 2019 07:50:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Jun 2019 07:43:17 -0000
From: Dion Bosschieter <1831225@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h dionbosschieter
X-Launchpad-Bug-Reporter: Dion Bosschieter (dionbosschieter)
X-Launchpad-Bug-Modifier: Dion Bosschieter (dionbosschieter)
References: <155929929657.13088.9555373471112683391.malonedeb@soybean.canonical.com>
Message-Id: <155963419754.12528.9042189293362777881.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 8b77492d2881507524dd49d3cc88cfa5dc3fb6ea
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1831225] Re: guest migration 100% cpu freeze bug
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1831225 <1831225@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Is there a way that we can check that it indeed is the case that the clock =
jumped a bit, we can try to read some kernel variables.
We just got another hung guest's crash dump working, this vm also shows a w=
eird uptime
        DATE: Fri Dec 23 09:06:16 2603
        UPTIME: 106752 days, 00:10:35

Till now we have only see this happening on guests with linux kernel
3.*.

Again dmesg shows nothing.

The only way this has yet happened was when the target hypervisor kernel wa=
s 4.19.
So it seems that something changed over there, the only thing is it not qui=
te a small diff ;) between 4.14 and 4.19. And because it only happens once =
every couple of thousand migrations with unknown conditions makes it a hard=
 to bisect this.
Source hypervisor kernel could be 4.14 and 4.19.

If the clock did jump during the migration, is there something that we
could do about that on source/target hypervisor, with a libvirt xml
change, etc, to prevent it I mean.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1831225

Title:
  guest migration 100% cpu freeze bug

Status in QEMU:
  New

Bug description:
  # Investigate migration cpu hog(100%) bug

  I have some issues when migrating from kernel 4.14.63 running qemu 2.11.2=
 to kernel 4.19.43 running qemu 2.11.2.
  The hypervisors are running on debian jessie with libvirt v5.3.0.
  Linux, libvirt and qemu are all custom compiled.

  I migrated around 10.000 vms and every once in a while a vm is stuck
  at 100% cpu after what we can see right now is that the target
  hypervisor runs on linux 4.19.53. This happened with 4 vms so far. It
  is not that easy to debug, we found this out pretty quickly because we
  are running monitoring on frozen vms after migrations.

  Last year we were having the same "kind of" bug https://bugs.launchpad.ne=
t/qemu/+bug/1775555 when trying to upgrade qemu 2.6 to 2.11.
  This bug was fixed after applying the following patch: http://lists.nongn=
u.org/archive/html/qemu-devel/2018-04/msg00820.html

  This patch is still applied as you can see because of the available pre_l=
oad var on the kvmclock_vmsd struct:
  (gdb) ptype kvmclock_vmsd
  type =3D const struct VMStateDescription {
      const char *name;
      int unmigratable;
      int version_id;
      int minimum_version_id;
      int minimum_version_id_old;
      MigrationPriority priority;
      LoadStateHandler *load_state_old;
      int (*pre_load)(void *);                                             =
   =

      int (*post_load)(void *, int);
      int (*pre_save)(void *);
      _Bool (*needed)(void *);
      VMStateField *fields;
      const VMStateDescription **subsections;
  }

  I attached gdb to a vcpu thread of one stuck vm, and a bt showed the foll=
owing info:
  Thread 4 (Thread 0x7f3a431a4700 (LWP 37799)):
  #0  0x00007f3a576f5017 in ioctl () at ../sysdeps/unix/syscall-template.S:=
84
  #1  0x000055d84d15de57 in kvm_vcpu_ioctl (cpu=3Dcpu@entry=3D0x55d84fca78d=
0, type=3Dtype@entry=3D44672) at /home/dbosschieter/src/qemu-pkg/src/accel/=
kvm/kvm-all.c:2050
  #2  0x000055d84d15dfc6 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x55d84fca78d0)=
 at /home/dbosschieter/src/qemu-pkg/src/accel/kvm/kvm-all.c:1887
  #3  0x000055d84d13ab64 in qemu_kvm_cpu_thread_fn (arg=3D0x55d84fca78d0) a=
t /home/dbosschieter/src/qemu-pkg/src/cpus.c:1136
  #4  0x00007f3a579ba4a4 in start_thread (arg=3D0x7f3a431a4700) at pthread_=
create.c:456
  #5  0x00007f3a576fcd0f in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:97

  Thread 3 (Thread 0x7f3a439a5700 (LWP 37798)):
  #0  0x00007f3a576f5017 in ioctl () at ../sysdeps/unix/syscall-template.S:=
84
  #1  0x000055d84d15de57 in kvm_vcpu_ioctl (cpu=3Dcpu@entry=3D0x55d84fc5cbb=
0, type=3Dtype@entry=3D44672) at /home/dbosschieter/src/qemu-pkg/src/accel/=
kvm/kvm-all.c:2050
  #2  0x000055d84d15dfc6 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x55d84fc5cbb0)=
 at /home/dbosschieter/src/qemu-pkg/src/accel/kvm/kvm-all.c:1887
  #3  0x000055d84d13ab64 in qemu_kvm_cpu_thread_fn (arg=3D0x55d84fc5cbb0) a=
t /home/dbosschieter/src/qemu-pkg/src/cpus.c:1136
  #4  0x00007f3a579ba4a4 in start_thread (arg=3D0x7f3a439a5700) at pthread_=
create.c:456
  #5  0x00007f3a576fcd0f in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:97

  The ioctl call is a ioctl(18, KVM_RUN and it looks like it is looping
  inside the vm itself.

  I saved the state of the VM (with `virsh save`) after I found it was hang=
ing on its vcpu threads. Then I restored this vm on a test environment runn=
ing the same kernel, QEMU and libvirt version). After the restore the VM st=
ill was haning at 100% cpu usage on all the vcpus.
  I tried to use the perf kvm guest option to trace the guest vm with a cop=
y of the kernel, modules and kallsyms files from inside the guest vm and I =
got to the following perf stat:

   Event                                         Total %Total CurAvg/s
   kvm_entry                                   5198993   23.1   277007
   kvm_exit                                    5198976   23.1   277006
   kvm_apic                                    1732103    7.7    92289
   kvm_msr                                     1732101    7.7    92289
   kvm_inj_virq                                1731904    7.7    92278
   kvm_eoi                                     1731900    7.7    92278
   kvm_apic_accept_irq                         1731900    7.7    92278
   kvm_hv_timer_state                          1731780    7.7    92274
   kvm_pv_eoi                                  1731701    7.7    92267
   kvm_ple_window                                   36    0.0        2
   Total                                      22521394         1199967

  We tried to run the crash tool against a dump of guest vm memory and that=
 gave us the following backtrace:
  crash> bt
  PID: 0      TASK: ffffffff81610040  CPU: 0   COMMAND: "swapper/0"
      [exception RIP: native_read_tsc+2]
      RIP: ffffffff810146a9  RSP: ffff88003fc03df0  RFLAGS: 00000046
      RAX: 000000008762c0fa  RBX: ffff88003fc13680  RCX: 0000000000000001
      RDX: 0000000000fe4871  RSI: 0000000000000000  RDI: ffff88003fc13603
      RBP: 000000000003052c   R8: 0000000000000200   R9: ffffffff8169b180
      R10: 0000000000000020  R11: 0000000000000005  R12: 006a33290b40455c
      R13: 00000000df1fd292  R14: 000000002ca284ff  R15: 00fe485f3febe21a
      CS: 0010  SS: 0018
   #0 [ffff88003fc03df0] pvclock_clocksource_read at ffffffff8102cbb3
   #1 [ffff88003fc03e40] kvm_clock_read at ffffffff8102c2c9
   #2 [ffff88003fc03e50] timekeeping_get_ns at ffffffff810691b0
   #3 [ffff88003fc03e60] ktime_get at ffffffff810695c8
   #4 [ffff88003fc03e90] sched_rt_period_timer at ffffffff8103e4f5
   #5 [ffff88003fc03ee0] __run_hrtimer at ffffffff810652d3
   #6 [ffff88003fc03f20] hrtimer_interrupt at ffffffff81065abd
   #7 [ffff88003fc03f90] smp_apic_timer_interrupt at ffffffff81024ba8
   #8 [ffff88003fc03fb0] apic_timer_interrupt at ffffffff813587e2
  --- <IRQ stack> ---
   #9 [ffffffff81601e98] apic_timer_interrupt at ffffffff813587e2
      [exception RIP: native_safe_halt+2]
      RIP: ffffffff8102c360  RSP: ffffffff81601f40  RFLAGS: 00010246
      RAX: 0000000000000000  RBX: ffffffff81601fd8  RCX: 00000000ffffffff
      RDX: 00000000ffffffff  RSI: 0000000000000000  RDI: 0000000000000001
      RBP: 0000000000000000   R8: 0000000000000000   R9: 0000000000000000
      R10: 0000000000000020  R11: 0000000000000005  R12: ffffffff816f5d80
      R13: ffffffffffffffff  R14: 000000000008c800  R15: 0000000000000000
      ORIG_RAX: ffffffffffffff10  CS: 0010  SS: 0018
  #10 [ffffffff81601f40] default_idle at ffffffff81014c35
  #11 [ffffffff81601f50] cpu_idle at ffffffff8100d258

  So it seems like the vm is reading its clock constantly trying to
  catch up some time after the migration.

  Last time it was a bug that was only triggered on newer Gold cpu
  hardware, but this time we also see this coming back on older Intel E5
  cpus we tried to reproduce with a migrate loop of 3 days times between
  kernel 4.14.63 and 4.19.43 but this gave us no results.

  The vms were running ubuntu 14.04, centos 7, debian 7, debian 8 these
  vms are running linux kernel 3.*.

  The thing is that we are out of ideas for reproducing this, it seems
  like it the same kind of bug we are hitting, just like last time the
  vm is basically only trying to read the clock. Perhaps we can try to
  read the clock data and also try to read what the guest is actually
  waiting for, which value of the counter does it want to reach.

  I am not sure how to pinpoint the cause of this issue, I would like some =
help and possible some extra tips on debugging.
  We are able to read the guests kernel which makes it a bit easier to debu=
g, reproducing and finding the source of the problem is still something we =
are trying to figure out.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1831225/+subscriptions

