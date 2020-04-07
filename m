Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374B0C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 13:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08526206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 13:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08526206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLoL9-00056e-8v
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 09:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jLoKF-0004JT-0E
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jLoKD-0002uw-80
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:31:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:43118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jLoKD-0002uJ-1Q
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:31:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jLoKB-0003tO-A2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 13:31:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4AB6F2E810A
 for <qemu-devel@nongnu.org>; Tue,  7 Apr 2020 13:31:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Apr 2020 13:17:18 -0000
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: hugepage kvm powerpc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mopsfelder sathnaga
X-Launchpad-Bug-Reporter: Satheesh Rajendran (sathnaga)
X-Launchpad-Bug-Modifier: Satheesh Rajendran (sathnaga)
References: <158391580227.26961.2494190856052631580.malonedeb@gac.canonical.com>
Message-Id: <158626543829.12584.7437498497947709466.malone@chaenomeles.canonical.com>
Subject: [Bug 1866962] Re: [Regression]Powerpc kvm guest unable to start with
 hugepage backed memory
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 631128512c63ab794d36716c4bc60f0284dfaa7f
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1866962 <1866962@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks! Murilo, am able to boot with current master, tested with(commit
53ef8a92eb04ee19640f5aad3bff36cd4a36c250).

Regards,
-Satheesh

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1866962

Title:
  [Regression]Powerpc kvm guest unable to start with hugepage backed
  memory

Status in QEMU:
  Fix Released

Bug description:
  Current upstream qemu master does not boot a powerpc kvm guest backed
  by hugepage.

  HW: Power9 (DD2.3)
  Host Kernel: 5.6.0-rc5
  Guest Kernel: 5.6.0-rc5
  Qemu: ba29883206d92a29ad5a466e679ccfc2ee6132ef

  Steps to reproduce:
  1. Allocate enough hugepage to boot a KVM guest
  # cat /proc/meminfo |grep ^HugePages
  HugePages_Total:    5000
  HugePages_Free:     5000
  HugePages_Rsvd:        0
  HugePages_Surp:        0

  2. Define and boot a guest
  /usr/bin/virt-install --connect=3Dqemu:///system --hvm --accelerate --nam=
e 'vm1' --machine pseries --memory=3D8192,hugepages=3Dyes --vcpu=3D8,maxvcp=
us=3D8,sockets=3D1,cores=3D8,threads=3D1 --import --nographics --serial pty=
 --memballoon model=3Dvirtio --controller type=3Dscsi,model=3Dvirtio-scsi -=
-disk path=3D/home/kvmci/tests/data/avocado-vt/images/f31-ppc64le.qcow2,bus=
=3Dscsi,size=3D10,format=3Dqcow2 --network=3Dbridge=3Dvirbr0,model=3Dvirtio=
,mac=3D52:54:00:5f:82:83 --mac=3D52:54:00:5f:82:83 --boot emulator=3D/home/=
sath/qemu/ppc64-softmmu/qemu-system-ppc64,kernel=3D/home/kvmci/linux/vmlinu=
x,kernel_args=3D"root=3D/dev/sda5 rw console=3Dtty0 console=3DttyS0,115200 =
init=3D/sbin/init initcall_debug selinux=3D0" --noautoconsole

  Starting install...
  ERROR    internal error: qemu unexpectedly closed the monitor: qemu-syste=
m-ppc64: util/qemu-thread-posix.c:76: qemu_mutex_lock_impl: Assertion `mute=
x->initialized' failed.
  qemu-system-ppc64: util/qemu-thread-posix.c:76: qemu_mutex_lock_impl: Ass=
ertion `mutex->initialized' failed.

   -----------NOK

  =

  Bisected the issue to below commit.

  037fb5eb3941c80a2b7c36a843e47207ddb004d4 is the first bad commit
  commit 037fb5eb3941c80a2b7c36a843e47207ddb004d4
  Author: bauerchen <bauerchen@tencent.com>
  Date:   Tue Feb 11 17:10:35 2020 +0800

      mem-prealloc: optimize large guest startup
      =

      [desc]:
          Large memory VM starts slowly when using -mem-prealloc, and
          there are some areas to optimize in current method;
      =

          1=E3=80=81mmap will be used to alloc threads stack during create =
page
          clearing threads, and it will attempt mm->mmap_sem for write
          lock, but clearing threads have hold read lock, this competition
          will cause threads createion very slow;
      =

          2=E3=80=81methods of calcuating pages for per threads is not well=
;if we use
          64 threads to split 160 hugepage,63 threads clear 2page,1 thread
          clear 34 page,so the entire speed is very slow;
      =

          to solve the first problem,we add a mutex in thread function,and
          start all threads when all threads finished createion;
          and the second problem, we spread remainder to other threads,in
          situation that 160 hugepage and 64 threads, there are 32 threads
          clear 3 pages,and 32 threads clear 2 pages.
      =

      [test]:
          320G 84c VM start time can be reduced to 10s
          680G 84c VM start time can be reduced to 18s
      =

      Signed-off-by: bauerchen <bauerchen@tencent.com>
      Reviewed-by: Pan Rui <ruippan@tencent.com>
      Reviewed-by: Ivan Ren <ivanren@tencent.com>
      [Simplify computation of the number of pages per thread. - Paolo]
      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

   util/oslib-posix.c | 32 ++++++++++++++++++++++++--------
   1 file changed, 24 insertions(+), 8 deletions(-)


  bisect log:

  # git bisect log
  git bisect start
  # good: [52901abf94477b400cf88c1f70bb305e690ba2de] Update version for v4.=
2.0-rc5 release
  git bisect good 52901abf94477b400cf88c1f70bb305e690ba2de
  # bad: [ba29883206d92a29ad5a466e679ccfc2ee6132ef] Merge remote-tracking b=
ranch 'remotes/borntraeger/tags/s390x-20200310' into staging
  git bisect bad ba29883206d92a29ad5a466e679ccfc2ee6132ef
  # good: [d1ebbc9d16297b54b153ee33abe05eb4f1df0c66] target/arm/kvm: trivia=
l: Clean up header documentation
  git bisect good d1ebbc9d16297b54b153ee33abe05eb4f1df0c66
  # good: [87b74e8b6edd287ea2160caa0ebea725fa8f1ca1] target/arm: Vectorize =
USHL and SSHL
  git bisect good 87b74e8b6edd287ea2160caa0ebea725fa8f1ca1
  # bad: [e0175b71638cf4398903c0d25f93fe62e0606389] Merge remote-tracking b=
ranch 'remotes/pmaydell/tags/pull-target-arm-20200228' into staging
  git bisect bad e0175b71638cf4398903c0d25f93fe62e0606389
  # bad: [ca6155c0f2bd39b4b4162533be401c98bd960820] Merge tag 'patchew/2020=
0219160953.13771-1-imammedo@redhat.com' of https://github.com/patchew-proje=
ct/qemu into HEAD
  git bisect bad ca6155c0f2bd39b4b4162533be401c98bd960820
  # good: [ab74e543112957696f7c79b0c33ecebd18b52af5] ppc/spapr: use memdev =
for RAM
  git bisect good ab74e543112957696f7c79b0c33ecebd18b52af5
  # good: [cb06fdad05f3e546a4e20f1f3c0127f9ae53de1a] fuzz: support for fork=
-based fuzzing.
  git bisect good cb06fdad05f3e546a4e20f1f3c0127f9ae53de1a
  # bad: [037fb5eb3941c80a2b7c36a843e47207ddb004d4] mem-prealloc: optimize =
large guest startup
  git bisect bad 037fb5eb3941c80a2b7c36a843e47207ddb004d4
  # good: [88e2b97aa3e369a454c9d8360afddc348070c708] Merge remote-tracking =
branch 'remotes/dgilbert-gitlab/tags/pull-virtiofs-20200221' into staging
  git bisect good 88e2b97aa3e369a454c9d8360afddc348070c708
  # good: [b1db8c63169f2139af9f26c884e5e2abd27dd290] fuzz: add virtio-net f=
uzz target
  git bisect good b1db8c63169f2139af9f26c884e5e2abd27dd290
  # good: [e5c59355ae9f724777c61c859292ec9db2c8c2ab] fuzz: add documentatio=
n to docs/devel/
  git bisect good e5c59355ae9f724777c61c859292ec9db2c8c2ab
  # good: [920d557e5ae58671d335acbcfba3f9a97a02911c] memory: batch allocate=
 ioeventfds[] in address_space_update_ioeventfds()
  git bisect good 920d557e5ae58671d335acbcfba3f9a97a02911c
  # first bad commit: [037fb5eb3941c80a2b7c36a843e47207ddb004d4] mem-preall=
oc: optimize large guest startup


  =

  Qemu cmdline:
  ```
  /home/sath/qemu/ppc64-softmmu/qemu-system-ppc64 \
  -name guest=3Dvm1,debug-threads=3Don \
  -S \
  -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/=
domain-9-vm1/master-key.aes \
  -machine pseries-5.0,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff \
  -m 8192 \
  -mem-prealloc \
  -mem-path /dev/hugepages/libvirt/qemu/9-vm1 \
  -overcommit mem-lock=3Doff \
  -smp 8,sockets=3D1,cores=3D8,threads=3D1 \
  -uuid e5875dd8-0d1c-422f-ae46-9a0b88919902 \
  -display none \
  -no-user-config \
  -nodefaults \
  -chardev socket,id=3Dcharmonitor,fd=3D36,server,nowait \
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
  -rtc base=3Dutc \
  -no-shutdown \
  -boot strict=3Don \
  -kernel /home/kvmci/linux/vmlinux \
  -append 'root=3D/dev/sda5 rw console=3Dtty0 console=3DttyS0,115200 init=
=3D/sbin/init initcall_debug selinux=3D0' \
  -device qemu-xhci,p2=3D15,p3=3D15,id=3Dusb,bus=3Dpci.0,addr=3D0x3 \
  -device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.0,addr=3D0x2 \
  -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x4 \
  -drive file=3D/home/kvmci/tests/data/avocado-vt/images/f31-ppc64le.qcow2,=
format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0 \
  -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,device_id=
=3Ddrive-scsi0-0-0-0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=
=3D1 \
  -netdev tap,fd=3D38,id=3Dhostnet0,vhost=3Don,vhostfd=3D39 \
  -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:5f:82:8=
3,bus=3Dpci.0,addr=3D0x1 \
  -chardev pty,id=3Dcharserial0 \
  -device spapr-vty,chardev=3Dcharserial0,id=3Dserial0,reg=3D0x30000000 \
  -chardev socket,id=3Dcharchannel0,fd=3D40,server,nowait \
  -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchanne=
l0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 \
  -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 \
  -msg timestamp=3Don
  2020-03-11 08:11:46.639+0000: 494632: info : libvirt version: 5.6.0, pack=
age: 5.fc31 (Fedora Project, 2019-11-11-20:24:40, )
  2020-03-11 08:11:46.639+0000: 494632: info : hostname: ltcmihawk50.aus.st=
glabs.ibm.com
  2020-03-11 08:11:46.639+0000: 494632: info : virObjectUnref:349 : OBJECT_=
UNREF: obj=3D0x7fff3c0f6fb0
  char device redirected to /dev/pts/2 (label charserial0)
  qemu-system-ppc64: util/qemu-thread-posix.c:76: qemu_mutex_lock_impl: Ass=
ertion `mutex->initialized' failed.
  qemu-system-ppc64: util/qemu-thread-posix.c:76: qemu_mutex_lock_impl: Ass=
ertion `mutex->initialized' failed.
  2020-03-11 08:11:47.195+0000: shutting down, reason=3Dfailed
  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1866962/+subscriptions

