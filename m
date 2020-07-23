Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05550C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF36206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF36206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jySGQ-0008Vq-55
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jySFo-00084h-Pq
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:50:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:57908)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jySFm-0003e6-HH
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:50:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jySFh-0007qp-TW
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:50:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BD6232E80E7
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:50:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2020 03:43:59 -0000
From: Simon Kaegi <1888601@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: skaegi
X-Launchpad-Bug-Reporter: Simon Kaegi (skaegi)
X-Launchpad-Bug-Modifier: Simon Kaegi (skaegi)
Message-Id: <159547584008.11100.1316842366379773629.malonedeb@wampee.canonical.com>
Subject: [Bug 1888601] [NEW] QEMU v5.1.0-rc0/rc1 hang with nested
 virtualization
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="f877c5162b568393e2d07ce948459ba0abc456fe";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 2e544754d59d2ecef43be41b067215b9d5fe3140
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 23:50:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1888601 <1888601@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

We're running Kata Containers using QEMU and with v5.1.0rc0 and rc1 have
noticed a problem at startup where QEMu appears to hang. We are not
seeing this problem on our bare metal nodes and only on a VSI that
supports nested virtualization.

We unfortunately see nothing at all in the QEMU logs to help understand
the problem and a hung process is just a guess at this point.

Using git bisect we first see the problem with...

---

f19bcdfedd53ee93412d535a842a89fa27cae7f2 is the first bad commit
commit f19bcdfedd53ee93412d535a842a89fa27cae7f2
Author: Jason Wang <jasowang@redhat.com>
Date:   Wed Jul 1 22:55:28 2020 +0800

    virtio-pci: implement queue_enabled method
    =

    With version 1, we can detect whether a queue is enabled via
    queue_enabled.
    =

    Signed-off-by: Jason Wang <jasowang@redhat.com>
    Signed-off-by: Cindy Lu <lulu@redhat.com>
    Message-Id: <20200701145538.22333-5-lulu@redhat.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
    Acked-by: Jason Wang <jasowang@redhat.com>

 hw/virtio/virtio-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

---

Reverting this commit seems to work and prevent the hanging.

---

Here's how kata ends up launching qemu in our environment -- =

/opt/kata/bin/qemu-system-x86_64 -name sandbox-849df14c6065931adedb9d18bc92=
60a6d896f1814a8c5cfa239865772f1b7a5f -uuid 6bec458e-1da7-4847-a5d7-5ab31d4d=
2465 -machine pc,accel=3Dkvm,kernel_irqchip -cpu host,pmu=3Doff -qmp unix:/=
run/vc/vm/849df14c6065931adedb9d18bc9260a6d896f1814a8c5cfa239865772f1b7a5f/=
qmp.sock,server,nowait -m 4096M,slots=3D10,maxmem=3D30978M -device pci-brid=
ge,bus=3Dpci.0,id=3Dpci-bridge-0,chassis_nr=3D1,shpc=3Don,addr=3D2,romfile=
=3D -device virtio-serial-pci,disable-modern=3Dtrue,id=3Dserial0,romfile=3D=
 -device virtconsole,chardev=3Dcharconsole0,id=3Dconsole0 -chardev socket,i=
d=3Dcharconsole0,path=3D/run/vc/vm/849df14c6065931adedb9d18bc9260a6d896f181=
4a8c5cfa239865772f1b7a5f/console.sock,server,nowait -device virtio-scsi-pci=
,id=3Dscsi0,disable-modern=3Dtrue,romfile=3D -object rng-random,id=3Drng0,f=
ilename=3D/dev/urandom -device virtio-rng-pci,rng=3Drng0,romfile=3D -device=
 virtserialport,chardev=3Dcharch0,id=3Dchannel0,name=3Dagent.channel.0 -cha=
rdev socket,id=3Dcharch0,path=3D/run/vc/vm/849df14c6065931adedb9d18bc9260a6=
d896f1814a8c5cfa239865772f1b7a5f/kata.sock,server,nowait -chardev socket,id=
=3Dchar-396c5c3e19e29353,path=3D/run/vc/vm/849df14c6065931adedb9d18bc9260a6=
d896f1814a8c5cfa239865772f1b7a5f/vhost-fs.sock -device vhost-user-fs-pci,ch=
ardev=3Dchar-396c5c3e19e29353,tag=3DkataShared,romfile=3D -netdev tap,id=3D=
network-0,vhost=3Don,vhostfds=3D3:4,fds=3D5:6 -device driver=3Dvirtio-net-p=
ci,netdev=3Dnetwork-0,mac=3D52:ac:2d:02:1f:6f,disable-modern=3Dtrue,mq=3Don=
,vectors=3D6,romfile=3D -global kvm-pit.lost_tick_policy=3Ddiscard -vga non=
e -no-user-config -nodefaults -nographic -daemonize -object memory-backend-=
file,id=3Ddimm1,size=3D4096M,mem-path=3D/dev/shm,share=3Don -numa node,memd=
ev=3Ddimm1 -kernel /opt/kata/share/kata-containers/vmlinuz-5.7.9-74 -initrd=
 /opt/kata/share/kata-containers/kata-containers-initrd_alpine_1.11.2-6_age=
nt.initrd -append tsc=3Dreliable no_timer_check rcupdate.rcu_expedited=3D1 =
i8042.direct=3D1 i8042.dumbkbd=3D1 i8042.nopnp=3D1 i8042.noaux=3D1 noreplac=
e-smp reboot=3Dk console=3Dhvc0 console=3Dhvc1 iommu=3Doff cryptomgr.notest=
s net.ifnames=3D0 pci=3Dlastbus=3D0 debug panic=3D1 nr_cpus=3D4 agent.use_v=
sock=3Dfalse scsi_mod.scan=3Dnone init=3D/usr/bin/kata-agent -pidfile /run/=
vc/vm/849df14c6065931adedb9d18bc9260a6d896f1814a8c5cfa239865772f1b7a5f/pid =
-D /run/vc/vm/849df14c6065931adedb9d18bc9260a6d896f1814a8c5cfa239865772f1b7=
a5f/qemu.log -smp 2,cores=3D1,threads=3D1,sockets=3D4,maxcpus=3D4

---

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1888601

Title:
  QEMU v5.1.0-rc0/rc1 hang with nested virtualization

Status in QEMU:
  New

Bug description:
  We're running Kata Containers using QEMU and with v5.1.0rc0 and rc1
  have noticed a problem at startup where QEMu appears to hang. We are
  not seeing this problem on our bare metal nodes and only on a VSI that
  supports nested virtualization.

  We unfortunately see nothing at all in the QEMU logs to help
  understand the problem and a hung process is just a guess at this
  point.

  Using git bisect we first see the problem with...

  ---

  f19bcdfedd53ee93412d535a842a89fa27cae7f2 is the first bad commit
  commit f19bcdfedd53ee93412d535a842a89fa27cae7f2
  Author: Jason Wang <jasowang@redhat.com>
  Date:   Wed Jul 1 22:55:28 2020 +0800

      virtio-pci: implement queue_enabled method
      =

      With version 1, we can detect whether a queue is enabled via
      queue_enabled.
      =

      Signed-off-by: Jason Wang <jasowang@redhat.com>
      Signed-off-by: Cindy Lu <lulu@redhat.com>
      Message-Id: <20200701145538.22333-5-lulu@redhat.com>
      Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
      Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
      Acked-by: Jason Wang <jasowang@redhat.com>

   hw/virtio/virtio-pci.c | 13 +++++++++++++
   1 file changed, 13 insertions(+)

  ---

  Reverting this commit seems to work and prevent the hanging.

  ---

  Here's how kata ends up launching qemu in our environment -- =

  /opt/kata/bin/qemu-system-x86_64 -name sandbox-849df14c6065931adedb9d18bc=
9260a6d896f1814a8c5cfa239865772f1b7a5f -uuid 6bec458e-1da7-4847-a5d7-5ab31d=
4d2465 -machine pc,accel=3Dkvm,kernel_irqchip -cpu host,pmu=3Doff -qmp unix=
:/run/vc/vm/849df14c6065931adedb9d18bc9260a6d896f1814a8c5cfa239865772f1b7a5=
f/qmp.sock,server,nowait -m 4096M,slots=3D10,maxmem=3D30978M -device pci-br=
idge,bus=3Dpci.0,id=3Dpci-bridge-0,chassis_nr=3D1,shpc=3Don,addr=3D2,romfil=
e=3D -device virtio-serial-pci,disable-modern=3Dtrue,id=3Dserial0,romfile=
=3D -device virtconsole,chardev=3Dcharconsole0,id=3Dconsole0 -chardev socke=
t,id=3Dcharconsole0,path=3D/run/vc/vm/849df14c6065931adedb9d18bc9260a6d896f=
1814a8c5cfa239865772f1b7a5f/console.sock,server,nowait -device virtio-scsi-=
pci,id=3Dscsi0,disable-modern=3Dtrue,romfile=3D -object rng-random,id=3Drng=
0,filename=3D/dev/urandom -device virtio-rng-pci,rng=3Drng0,romfile=3D -dev=
ice virtserialport,chardev=3Dcharch0,id=3Dchannel0,name=3Dagent.channel.0 -=
chardev socket,id=3Dcharch0,path=3D/run/vc/vm/849df14c6065931adedb9d18bc926=
0a6d896f1814a8c5cfa239865772f1b7a5f/kata.sock,server,nowait -chardev socket=
,id=3Dchar-396c5c3e19e29353,path=3D/run/vc/vm/849df14c6065931adedb9d18bc926=
0a6d896f1814a8c5cfa239865772f1b7a5f/vhost-fs.sock -device vhost-user-fs-pci=
,chardev=3Dchar-396c5c3e19e29353,tag=3DkataShared,romfile=3D -netdev tap,id=
=3Dnetwork-0,vhost=3Don,vhostfds=3D3:4,fds=3D5:6 -device driver=3Dvirtio-ne=
t-pci,netdev=3Dnetwork-0,mac=3D52:ac:2d:02:1f:6f,disable-modern=3Dtrue,mq=
=3Don,vectors=3D6,romfile=3D -global kvm-pit.lost_tick_policy=3Ddiscard -vg=
a none -no-user-config -nodefaults -nographic -daemonize -object memory-bac=
kend-file,id=3Ddimm1,size=3D4096M,mem-path=3D/dev/shm,share=3Don -numa node=
,memdev=3Ddimm1 -kernel /opt/kata/share/kata-containers/vmlinuz-5.7.9-74 -i=
nitrd /opt/kata/share/kata-containers/kata-containers-initrd_alpine_1.11.2-=
6_agent.initrd -append tsc=3Dreliable no_timer_check rcupdate.rcu_expedited=
=3D1 i8042.direct=3D1 i8042.dumbkbd=3D1 i8042.nopnp=3D1 i8042.noaux=3D1 nor=
eplace-smp reboot=3Dk console=3Dhvc0 console=3Dhvc1 iommu=3Doff cryptomgr.n=
otests net.ifnames=3D0 pci=3Dlastbus=3D0 debug panic=3D1 nr_cpus=3D4 agent.=
use_vsock=3Dfalse scsi_mod.scan=3Dnone init=3D/usr/bin/kata-agent -pidfile =
/run/vc/vm/849df14c6065931adedb9d18bc9260a6d896f1814a8c5cfa239865772f1b7a5f=
/pid -D /run/vc/vm/849df14c6065931adedb9d18bc9260a6d896f1814a8c5cfa23986577=
2f1b7a5f/qemu.log -smp 2,cores=3D1,threads=3D1,sockets=3D4,maxcpus=3D4

  ---

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1888601/+subscriptions

