Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9628FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B75520748
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B75520748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyqSf-0003ss-L0
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 01:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jyqS2-0003TH-Dd
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:40:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:47714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jyqS0-0001BF-0H
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:40:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jyqRw-00089v-Io
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 05:40:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6C5D02E80EE
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 05:40:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2020 05:34:27 -0000
From: Jason Wang <1888601@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h jasowang skaegi
X-Launchpad-Bug-Reporter: Simon Kaegi (skaegi)
X-Launchpad-Bug-Modifier: Jason Wang (jasowang)
References: <159547584008.11100.1316842366379773629.malonedeb@wampee.canonical.com>
Message-Id: <159556886792.22561.3496039160314436703.malone@soybean.canonical.com>
Subject: [Bug 1888601] Re: QEMU v5.1.0-rc0/rc1 hang with nested virtualization
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="f877c5162b568393e2d07ce948459ba0abc456fe";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 774760036b6310f126b5a7cbeae8833e5d447ca7
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:45:38
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

Hi:

It's not clear to me:

- Is the hang happen on the host or L1 guest?
- Is qemu 5.1-rc0 used on the host or L1 guest?
- When did you see the hung, just after launching the guest?
- Can you use gdb to get a calltrace of qemu when you see the hang?
- What's the version of kernel in L1 and L2 guest?

Thanks

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

  =C2=A0=C2=A0=C2=A0=C2=A0virtio-pci: implement queue_enabled method

  =C2=A0=C2=A0=C2=A0=C2=A0With version 1, we can detect whether a queue is =
enabled via
  =C2=A0=C2=A0=C2=A0=C2=A0queue_enabled.

  =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Jason Wang <jasowang@redhat.com>
  =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Cindy Lu <lulu@redhat.com>
  =C2=A0=C2=A0=C2=A0=C2=A0Message-Id: <20200701145538.22333-5-lulu@redhat.c=
om>
  =C2=A0=C2=A0=C2=A0=C2=A0Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
  =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
  =C2=A0=C2=A0=C2=A0=C2=A0Acked-by: Jason Wang <jasowang@redhat.com>

  =C2=A0hw/virtio/virtio-pci.c | 13 +++++++++++++
  =C2=A01 file changed, 13 insertions(+)

  ---

  Reverting this commit (on top of 5.1.0-rc1) seems to work and prevent
  the hanging.

  ---

  Here's how kata ends up launching qemu in our environment --
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

