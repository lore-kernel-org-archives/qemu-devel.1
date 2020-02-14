Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DD6C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 04:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5690020848
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 04:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5690020848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2SB8-0006tg-FT
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 23:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j2SAN-0006IL-F3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 23:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j2SAL-0002rc-UX
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 23:01:23 -0500
Received: from indium.canonical.com ([91.189.90.7]:57020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j2SAL-0002mZ-NW
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 23:01:21 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j2SAH-00020k-Cf
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 04:01:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EE97A2E80D9
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 04:01:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Feb 2020 03:46:17 -0000
From: xuan <1863200@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: mode packed ring server
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: xavier-ding
X-Launchpad-Bug-Reporter: xuan (xavier-ding)
X-Launchpad-Bug-Modifier: xuan (xavier-ding)
Message-Id: <158165197713.30147.2525334191220612578.malonedeb@wampee.canonical.com>
Subject: [Bug 1863200] [NEW] Reconnect failed with loopback virtio1.1 server
 mode test
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0128a9fb80d63a846b784ae6051590c313d5fa49
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
Reply-To: Bug 1863200 <1863200@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Issue discription=EF=BC=9A
Packed ring server mode is a new feature to enable the virtio-user or virti=
o-pmd(in VM) as the server, vhost as the client, then when the vhost-user i=
s killed then re-launched, the vhost-user can connect back to virtio-user/v=
irtio-pmd again. Test with dpdk 20.02 ,virtio-pmd loopback reconnect from v=
host-user failed.

Test Environment:
DPDK version: DPDK v20.02
Other software versions: virtio1.1
Qemu versions:4.2.0
OS: Linux 4.15.0-20-generic
Compiler: gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
Hardware platform: R2208WFTZSR.

The reproduce step is :
Test Case: vhost-user/virtio-pmd loopback reconnect from vhost-user
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Flow: Vhost-user --> Virtio --> Vhost-user

1. Launch vhost-user with client mode by below commands::

    ./testpmd -c 0x30 -n 4 --socket-mem 1024,1024 --legacy-mem --vdev 'eth_=
vhost0,iface=3D/tmp/vhost-net,client=3D1,queues=3D1' -- -i --nb-cores=3D1
    testpmd>set fwd mac

2. Start VM with 1 virtio device, and set the qemu as server mode::

    ./qemu-system-x86_64 -name vm2 -enable-kvm -cpu host -smp 100 -m 8G \
    -object memory-backend-file,id=3Dmem,size=3D8192M,mem-path=3D/mnt/huge,=
share=3Don \
    -numa node,memdev=3Dmem -mem-prealloc -drive file=3D/home/xuan/dpdk_pro=
ject/shell/u18.img  \
    -chardev socket,path=3D/tmp/vm2_qga0.sock,server,nowait,id=3Dvm2_qga0 -=
device virtio-serial \
    -device virtserialport,chardev=3Dvm2_qga0,name=3Dorg.qemu.guest_agent.2=
 -daemonize \
    -monitor unix:/tmp/vm2_monitor.sock,server,nowait -net nic,macaddr=3D00=
:00:00:08:e8:aa,addr=3D1f \
    -net user,hostfwd=3Dtcp:127.0.0.1:6002-:22 \
    -chardev socket,id=3Dchar0,path=3D/tmp/vhost-net,server \
    -netdev type=3Dvhost-user,id=3Dnetdev0,chardev=3Dchar0,vhostforce \
    -device virtio-net-pci,netdev=3Dnetdev0,mac=3D52:54:00:00:00:01,mrg_rxb=
uf=3Don,rx_queue_size=3D1024,tx_queue_size=3D1024,packed=3Don \
    -vnc :10

3. On VM, bind virtio net to igb_uio and run testpmd::

    ./testpmd -c 0x3 -n 4 -- -i --nb-cores=3D1 --txd=3D1024 --rxd=3D1024
    testpmd>set fwd mac
    testpmd>start

4. Send packets by vhost-user, check if packets can be RX/TX with
virtio-pmd::

    testpmd>start tx_first 32
    testpmd>show port stats all

5. On host, quit vhost-user, then re-launch the vhost-user with below
command::

    testpmd>quit
    ./testpmd -c 0x30 -n 4 --socket-mem 1024,1024 --legacy-mem --vdev 'eth_=
vhost0,iface=3D/tmp/vhost-net,client=3D1,queues=3D1' -- -i --nb-cores=3D1
    testpmd>set fwd mac
    testpmd>start tx_first 32

6. Check if the reconnection can work, still send packets by vhost-user,
check if packets can be RX/TX with virtio-pmd::

    testpmd>show port stats all

Expected result::

After the vhost-user is killed then re-launched, the VM can connect back
to vhost-user again with throughput.

Real result::

After the vhost-user is killed then re-launched, no throughput with PVP.

Analysis::

QEMU has its own way to handle reconnect function for virtio server
mode. However, for packed ring, when reconnecting to virtio, vhost
cannot get the status of descriptors via the descriptor ring. This bug
is caused since the reconnection for packed ring need additional reset
operation.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: mode packed ring server

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863200

Title:
  Reconnect failed with loopback virtio1.1 server mode test

Status in QEMU:
  New

Bug description:
  Issue discription=EF=BC=9A
  Packed ring server mode is a new feature to enable the virtio-user or vir=
tio-pmd(in VM) as the server, vhost as the client, then when the vhost-user=
 is killed then re-launched, the vhost-user can connect back to virtio-user=
/virtio-pmd again. Test with dpdk 20.02 ,virtio-pmd loopback reconnect from=
 vhost-user failed.

  Test Environment:
  DPDK version: DPDK v20.02
  Other software versions: virtio1.1
  Qemu versions:4.2.0
  OS: Linux 4.15.0-20-generic
  Compiler: gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  Hardware platform: R2208WFTZSR.

  The reproduce step is :
  Test Case: vhost-user/virtio-pmd loopback reconnect from vhost-user
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Flow: Vhost-user --> Virtio --> Vhost-user

  1. Launch vhost-user with client mode by below commands::

      ./testpmd -c 0x30 -n 4 --socket-mem 1024,1024 --legacy-mem --vdev 'et=
h_vhost0,iface=3D/tmp/vhost-net,client=3D1,queues=3D1' -- -i --nb-cores=3D1
      testpmd>set fwd mac

  2. Start VM with 1 virtio device, and set the qemu as server mode::

      ./qemu-system-x86_64 -name vm2 -enable-kvm -cpu host -smp 100 -m 8G \
      -object memory-backend-file,id=3Dmem,size=3D8192M,mem-path=3D/mnt/hug=
e,share=3Don \
      -numa node,memdev=3Dmem -mem-prealloc -drive file=3D/home/xuan/dpdk_p=
roject/shell/u18.img  \
      -chardev socket,path=3D/tmp/vm2_qga0.sock,server,nowait,id=3Dvm2_qga0=
 -device virtio-serial \
      -device virtserialport,chardev=3Dvm2_qga0,name=3Dorg.qemu.guest_agent=
.2 -daemonize \
      -monitor unix:/tmp/vm2_monitor.sock,server,nowait -net nic,macaddr=3D=
00:00:00:08:e8:aa,addr=3D1f \
      -net user,hostfwd=3Dtcp:127.0.0.1:6002-:22 \
      -chardev socket,id=3Dchar0,path=3D/tmp/vhost-net,server \
      -netdev type=3Dvhost-user,id=3Dnetdev0,chardev=3Dchar0,vhostforce \
      -device virtio-net-pci,netdev=3Dnetdev0,mac=3D52:54:00:00:00:01,mrg_r=
xbuf=3Don,rx_queue_size=3D1024,tx_queue_size=3D1024,packed=3Don \
      -vnc :10

  3. On VM, bind virtio net to igb_uio and run testpmd::

      ./testpmd -c 0x3 -n 4 -- -i --nb-cores=3D1 --txd=3D1024 --rxd=3D1024
      testpmd>set fwd mac
      testpmd>start

  4. Send packets by vhost-user, check if packets can be RX/TX with
  virtio-pmd::

      testpmd>start tx_first 32
      testpmd>show port stats all

  5. On host, quit vhost-user, then re-launch the vhost-user with below
  command::

      testpmd>quit
      ./testpmd -c 0x30 -n 4 --socket-mem 1024,1024 --legacy-mem --vdev 'et=
h_vhost0,iface=3D/tmp/vhost-net,client=3D1,queues=3D1' -- -i --nb-cores=3D1
      testpmd>set fwd mac
      testpmd>start tx_first 32

  6. Check if the reconnection can work, still send packets by vhost-
  user, check if packets can be RX/TX with virtio-pmd::

      testpmd>show port stats all

  Expected result::

  After the vhost-user is killed then re-launched, the VM can connect
  back to vhost-user again with throughput.

  Real result::

  After the vhost-user is killed then re-launched, no throughput with
  PVP.

  Analysis::

  QEMU has its own way to handle reconnect function for virtio server
  mode. However, for packed ring, when reconnecting to virtio, vhost
  cannot get the status of descriptors via the descriptor ring. This bug
  is caused since the reconnection for packed ring need additional reset
  operation.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863200/+subscriptions

