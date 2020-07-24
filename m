Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAF1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F032063A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F032063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytyC-0008Qj-13
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 05:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jytxd-000806-TH
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:25:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:59576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jytxb-0006Fj-9g
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:25:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jytxZ-0002NA-Ir
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 09:25:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8D5292E80D2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 09:25:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2020 09:10:34 -0000
From: xuan <1888818@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: xavier-ding
X-Launchpad-Bug-Reporter: xuan (xavier-ding)
X-Launchpad-Bug-Modifier: xuan (xavier-ding)
Message-Id: <159558183424.11837.7512442025195132206.malonedeb@wampee.canonical.com>
Subject: [Bug 1888818] [NEW] Multi-queue vhost-user fails to reconnect with
 qemu version >=4.2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="f877c5162b568393e2d07ce948459ba0abc456fe";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a29f9a9e0f1c6f5aca7ebd22871209a0ab29a587
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 04:30:42
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
Reply-To: Bug 1888818 <1888818@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Test Environment:
DPDK version: DPDK v20.08
Other software versions: qemu4.2.0, qemu5.0.0.
OS: Linux 4.15.0-20-generic
Compiler: gcc (Ubuntu 7.3.0-16ubuntu3) 8.4.0
Hardware platform: Purley.
Test Setup
Steps to reproduce
List the steps to reproduce the issue.

Test flow
=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Launch vhost-user testpmd as port0 with 2 queues:

./x86_64-native-linuxapp-gcc/app/testpmd -l 2-4 -n 4 \
=C2=A0=C2=A0=C2=A0=C2=A0--file-prefix=3Dvhost --vdev 'net_vhost0,iface=3Dvh=
ost-net,queues=3D2,client=3D1' -- -i --txd=3D1024 --rxd=3D1024 --txq=3D2 --=
rxq=3D2
testpmd>start

3. Launch qemu with virtio-net:

=C2=A0taskset -c 13 \
=C2=A0=C2=A0=C2=A0=C2=A0qemu-system-x86_64 -name us-vhost-vm1 \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-cpu host -enable-kvm -m 2048 -ob=
ject memory-backend-file,id=3Dmem,size=3D2048M,mem-path=3D/mnt/huge,share=
=3Don \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-numa node,memdev=3Dmem \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-mem-prealloc -monitor unix:/tmp/=
vm2_monitor.sock,server,nowait -netdev user,id=3Dyinan,hostfwd=3Dtcp:127.0.=
0.1:6005-:22 -device e1000,netdev=3Dyinan \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-smp cores=3D1,sockets=3D1 -drive=
 file=3D/home/osimg/ubuntu16.img  \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-chardev socket,id=3Dchar0,path=
=3D./vhost-net,server \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-netdev type=3Dvhost-user,id=3Dmy=
net1,chardev=3Dchar0,vhostforce,queues=3D2 \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device virtio-net-pci,mac=3D52:5=
4:00:00:00:01,netdev=3Dmynet1,mrg_rxbuf=3Don,csum=3Don,gso=3Don,host_tso4=
=3Don,guest_tso4=3Don,mq=3Don,vectors=3D15 \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-vnc :10 -daemonize

6. Quit testpmd and restart vhost-user :

testpmd>quit
./x86_64-native-linuxapp-gcc/app/testpmd -l 2-4 -n 4 \
=C2=A0=C2=A0=C2=A0=C2=A0--file-prefix=3Dvhost --vdev 'net_vhost0,iface=3Dvh=
ost-net,queues=3D2,client=3D1' -- -i --txd=3D1024 --rxd=3D1024 --txq=3D2 --=
rxq=3D2

Expected Result:
After the vhost-user is killed then re-launched, the virtio-net can connect=
 back to vhost-user again.

Actual Result:
Vhost-user relaunch failed with continous log printed"VHOST_CONFIG: Process=
ing VHOST_USER_SET_FEATURES failed.

Analysis:
This is a regression bug, bad commit: c6beefd674f
When vhost-user quits, QEMU doesnot save acked features for each virtio-net=
 after vhost-user quits. When vhost-user reconnects to QEMU, QEMU sends two=
 different features(one is the true acked feature while the another is 0x40=
000000) to vhost-user successively which causing vhost-user exits abnormall=
y.

** Affects: qemu
     Importance: Undecided
         Status: New

** Summary changed:

- vhost-user/vitrio-net test fail to reconnect from vhost-user with qemu ve=
rsion >=3D4.2
+ vhost-user fail to reconnect from virtio-net with qemu version >=3D4.2

** Description changed:

  Test Environment:
  DPDK version: DPDK v20.08
- Other software versions: qemu4.2, qemu5.0.
+ Other software versions: qemu4.2.0, qemu5.0.0.
  OS: Linux 4.15.0-20-generic
  Compiler: gcc (Ubuntu 7.3.0-16ubuntu3) 8.4.0
  Hardware platform: Purley.
  Test Setup
  Steps to reproduce
  List the steps to reproduce the issue.
  =

  Test flow
  =3D=3D=3D=3D=3D=3D=3D=3D=3D
  1. Launch vhost-user testpmd as port0 with 2 queues:
  =

  ./x86_64-native-linuxapp-gcc/app/testpmd -l 2-4 -n 4 \
-     --file-prefix=3Dvhost --vdev 'net_vhost0,iface=3Dvhost-net,queues=3D2=
,client=3D1' -- -i --txd=3D1024 --rxd=3D1024 --txq=3D2 --rxq=3D2
+ =C2=A0=C2=A0=C2=A0=C2=A0--file-prefix=3Dvhost --vdev 'net_vhost0,iface=3D=
vhost-net,queues=3D2,client=3D1' -- -i --txd=3D1024 --rxd=3D1024 --txq=3D2 =
--rxq=3D2
  testpmd>start
  =

  3. Launch qemu with virtio-net:
  =

-  taskset -c 13 \
-     qemu-system-x86_64 -name us-vhost-vm1 \
-        -cpu host -enable-kvm -m 2048 -object memory-backend-file,id=3Dmem=
,size=3D2048M,mem-path=3D/mnt/huge,share=3Don \
-        -numa node,memdev=3Dmem \
-        -mem-prealloc -monitor unix:/tmp/vm2_monitor.sock,server,nowait -n=
etdev user,id=3Dyinan,hostfwd=3Dtcp:127.0.0.1:6005-:22 -device e1000,netdev=
=3Dyinan \
-        -smp cores=3D1,sockets=3D1 -drive file=3D/home/osimg/ubuntu16.img =
 \
-        -chardev socket,id=3Dchar0,path=3D./vhost-net,server \
-        -netdev type=3Dvhost-user,id=3Dmynet1,chardev=3Dchar0,vhostforce,q=
ueues=3D2 \
-        -device virtio-net-pci,mac=3D52:54:00:00:00:01,netdev=3Dmynet1,mrg=
_rxbuf=3Don,csum=3Don,gso=3Don,host_tso4=3Don,guest_tso4=3Don,mq=3Don,vecto=
rs=3D15 \
-        -vnc :10 -daemonize
+ =C2=A0taskset -c 13 \
+ =C2=A0=C2=A0=C2=A0=C2=A0qemu-system-x86_64 -name us-vhost-vm1 \
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-cpu host -enable-kvm -m 2048 -=
object memory-backend-file,id=3Dmem,size=3D2048M,mem-path=3D/mnt/huge,share=
=3Don \
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-numa node,memdev=3Dmem \
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-mem-prealloc -monitor unix:/tm=
p/vm2_monitor.sock,server,nowait -netdev user,id=3Dyinan,hostfwd=3Dtcp:127.=
0.0.1:6005-:22 -device e1000,netdev=3Dyinan \
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-smp cores=3D1,sockets=3D1 -dri=
ve file=3D/home/osimg/ubuntu16.img  \
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-chardev socket,id=3Dchar0,path=
=3D./vhost-net,server \
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-netdev type=3Dvhost-user,id=3D=
mynet1,chardev=3Dchar0,vhostforce,queues=3D2 \
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device virtio-net-pci,mac=3D52=
:54:00:00:00:01,netdev=3Dmynet1,mrg_rxbuf=3Don,csum=3Don,gso=3Don,host_tso4=
=3Don,guest_tso4=3Don,mq=3Don,vectors=3D15 \
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-vnc :10 -daemonize
  =

  6. Quit testpmd and restart vhost-user :
  =

  testpmd>quit
  ./x86_64-native-linuxapp-gcc/app/testpmd -l 2-4 -n 4 \
-     --file-prefix=3Dvhost --vdev 'net_vhost0,iface=3Dvhost-net,queues=3D2=
,client=3D1' -- -i --txd=3D1024 --rxd=3D1024 --txq=3D2 --rxq=3D2
- =

+ =C2=A0=C2=A0=C2=A0=C2=A0--file-prefix=3Dvhost --vdev 'net_vhost0,iface=3D=
vhost-net,queues=3D2,client=3D1' -- -i --txd=3D1024 --rxd=3D1024 --txq=3D2 =
--rxq=3D2
  =

  Expected Result:
  After the vhost-user is killed then re-launched, the virtio-net can conne=
ct back to vhost-user again.
  =

  Actual Result:
  Vhost-user relaunch failed with continous log printed"VHOST_CONFIG: Proce=
ssing VHOST_USER_SET_FEATURES failed.
  =

  Analysis:
  This is a regression bug, bad commit: c6beefd674f
  When vhost-user quits, QEMU doesnot save acked features for each virtio-n=
et after vhost-user quits. When vhost-user reconnects to QEMU, QEMU sends t=
wo different features(one is the true acked feature while the another is 0x=
40000000) to vhost-user successively which causing vhost-user exits abnorma=
lly.

** Summary changed:

- vhost-user fail to reconnect from virtio-net with qemu version >=3D4.2
+ Multi-queue vhost-user fails to reconnect with qemu version >=3D4.2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1888818

Title:
  Multi-queue vhost-user fails to reconnect with qemu version >=3D4.2

Status in QEMU:
  New

Bug description:
  Test Environment:
  DPDK version: DPDK v20.08
  Other software versions: qemu4.2.0, qemu5.0.0.
  OS: Linux 4.15.0-20-generic
  Compiler: gcc (Ubuntu 7.3.0-16ubuntu3) 8.4.0
  Hardware platform: Purley.
  Test Setup
  Steps to reproduce
  List the steps to reproduce the issue.

  Test flow
  =3D=3D=3D=3D=3D=3D=3D=3D=3D
  1. Launch vhost-user testpmd as port0 with 2 queues:

  ./x86_64-native-linuxapp-gcc/app/testpmd -l 2-4 -n 4 \
  =C2=A0=C2=A0=C2=A0=C2=A0--file-prefix=3Dvhost --vdev 'net_vhost0,iface=3D=
vhost-net,queues=3D2,client=3D1' -- -i --txd=3D1024 --rxd=3D1024 --txq=3D2 =
--rxq=3D2
  testpmd>start

  3. Launch qemu with virtio-net:

  =C2=A0taskset -c 13 \
  =C2=A0=C2=A0=C2=A0=C2=A0qemu-system-x86_64 -name us-vhost-vm1 \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-cpu host -enable-kvm -m 2048 -=
object memory-backend-file,id=3Dmem,size=3D2048M,mem-path=3D/mnt/huge,share=
=3Don \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-numa node,memdev=3Dmem \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-mem-prealloc -monitor unix:/tm=
p/vm2_monitor.sock,server,nowait -netdev user,id=3Dyinan,hostfwd=3Dtcp:127.=
0.0.1:6005-:22 -device e1000,netdev=3Dyinan \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-smp cores=3D1,sockets=3D1 -dri=
ve file=3D/home/osimg/ubuntu16.img  \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-chardev socket,id=3Dchar0,path=
=3D./vhost-net,server \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-netdev type=3Dvhost-user,id=3D=
mynet1,chardev=3Dchar0,vhostforce,queues=3D2 \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device virtio-net-pci,mac=3D52=
:54:00:00:00:01,netdev=3Dmynet1,mrg_rxbuf=3Don,csum=3Don,gso=3Don,host_tso4=
=3Don,guest_tso4=3Don,mq=3Don,vectors=3D15 \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-vnc :10 -daemonize

  6. Quit testpmd and restart vhost-user :

  testpmd>quit
  ./x86_64-native-linuxapp-gcc/app/testpmd -l 2-4 -n 4 \
  =C2=A0=C2=A0=C2=A0=C2=A0--file-prefix=3Dvhost --vdev 'net_vhost0,iface=3D=
vhost-net,queues=3D2,client=3D1' -- -i --txd=3D1024 --rxd=3D1024 --txq=3D2 =
--rxq=3D2

  Expected Result:
  After the vhost-user is killed then re-launched, the virtio-net can conne=
ct back to vhost-user again.

  Actual Result:
  Vhost-user relaunch failed with continous log printed"VHOST_CONFIG: Proce=
ssing VHOST_USER_SET_FEATURES failed.

  Analysis:
  This is a regression bug, bad commit: c6beefd674f
  When vhost-user quits, QEMU doesnot save acked features for each virtio-n=
et after vhost-user quits. When vhost-user reconnects to QEMU, QEMU sends t=
wo different features(one is the true acked feature while the another is 0x=
40000000) to vhost-user successively which causing vhost-user exits abnorma=
lly.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1888818/+subscriptions

