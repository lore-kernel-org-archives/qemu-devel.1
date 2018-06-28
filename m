Received: from eggs.gnu.org ([2001:4830:134:3::10]:37604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fYXdI-0006Oe-SS
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fYXdD-0001xx-SO
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:10:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:59906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fYXdD-0001wP-Lp
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:10:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fYXdC-0008Qf-Li
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 14:10:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9B4FB2E8023
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 14:10:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Jun 2018 14:00:42 -0000
From: =?utf-8?b?6LSe6LS15p2O?= <1779120@bugs.launchpad.net>
Reply-To: Bug 1779120 <1779120@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153018930547.7042.8204279860342554943.malonedeb@soybean.canonical.com>
	<153019087311.6638.5931161413177474259.malone@soybean.canonical.com>
Message-Id: <e0ccb74d-9aca-20a7-1ba8-5615f13a73e0@huawei.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1779120] Re: disk missing in the guest
 contingently when hotplug several virtio scsi disks consecutively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, Stefan.
(host)# rpm -qa | grep qemu-kvm
qemu-kvm-2.8.1-25.142.x86_64
(guest)# uname -r
3.10.0-514.el7.x86_64

I also tried the newest version of qemu-kvm, but it also met this issue.
The steps to reproduce this issue are below:

1)attach four virtio-scsi controller with dataplane to vm.
 =C2=A0=C2=A0=C2=A0 <controller type=3D'scsi' index=3D'0' model=3D'virtio-s=
csi'>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <driver iothread=3D'1'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <alias name=3D'scsi0'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=
=3D'0x00' slot=3D'0x07' =

function=3D'0x0'/>
 =C2=A0=C2=A0=C2=A0 </controller>
 =C2=A0=C2=A0=C2=A0 <controller type=3D'scsi' index=3D'1' model=3D'virtio-s=
csi'>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <driver iothread=3D'2'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <alias name=3D'scsi1'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=
=3D'0x00' slot=3D'0x0a' =

function=3D'0x0'/>
 =C2=A0=C2=A0=C2=A0 </controller>
 =C2=A0=C2=A0=C2=A0 <controller type=3D'scsi' index=3D'2' model=3D'virtio-s=
csi'>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <driver iothread=3D'3'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <alias name=3D'scsi2'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=
=3D'0x00' slot=3D'0x0b' =

function=3D'0x0'/>
 =C2=A0=C2=A0=C2=A0 </controller>
 =C2=A0=C2=A0=C2=A0 <controller type=3D'scsi' index=3D'3' model=3D'virtio-s=
csi'>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <driver iothread=3D'4'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <alias name=3D'scsi3'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=
=3D'0x00' slot=3D'0x0c' =

function=3D'0x0'/>
 =C2=A0=C2=A0=C2=A0 </controller>

2)attach 35 virtio-scsi disks(sda - sdai) to vm consecutively. One =

controller has 15 scsi disks.
A example of disk xml is below:
 =C2=A0=C2=A0=C2=A0 <disk type=3D'block' device=3D'lun' rawio=3D'yes'>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <driver name=3D'qemu' type=3D'raw' cache=3D=
'none' io=3D'native'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <source dev=3D'/dev/mapper/360022a11000c1e0=
a0787bb2500000139'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <backingStore/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <target dev=3D'sda' bus=3D'scsi'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <shareable/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <alias name=3D'scsi0-0-0-0'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <address type=3D'drive' controller=3D'0' bu=
s=3D'0' target=3D'0' unit=3D'0'/>
 =C2=A0=C2=A0=C2=A0 </disk>

 =C2=A0=C2=A0 You can write a shell script like this:
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 for((i=3D1;i++;i<=3D35))
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 do
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 virsh attach-devi=
ce centos7.3_64_server scsi_disk_$i.xml =

--config --live
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 done

This issue is a probabilistic event. If it does not appear, repeat the =

above steps several more times.
Thank you!

On 2018/6/28 21:01, Stefan Hajnoczi wrote:
> Please post the following information:
> (host)# rpm -qa | grep qemu-kvm
> (guest)# uname -r
>
> What are the exact steps to reproduce this issue (virsh command-lines
> and XML)?
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1779120

Title:
  disk missing in the guest contingently when hotplug several virtio
  scsi disks consecutively

Status in QEMU:
  New

Bug description:
  Hi, I found a bug that disk missing (not all disks missing ) in the
  guest contingently when hotplug several virtio scsi disks
  consecutively.  After rebooting the guest,the missing disks appear
  again.

  The guest is centos7.3 running on a centos7.3 host and the scsi
  controllers are configed with iothread.  The scsi controller xml is
  below:

  =C2=A0=C2=A0=C2=A0=C2=A0<controller type=3D'scsi' index=3D'0' model=3D'vi=
rtio-scsi'>
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<driver iothread=3D'26'/>
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<alias name=3D'scsi0'/>
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<address type=3D'pci' domain=3D'0x000=
0' bus=3D'0x00' slot=3D'0x07' function=3D'0x0'/>
  =C2=A0=C2=A0=C2=A0=C2=A0</controller>

  If the scsi controllers are configed without iothread,  disks are all
  can be seen in the guest when hotplug several virtio scsi disks
  consecutively.

  I think the biggest difference between them is that scsi controllers
  with iothread call virtio_notify_irqfd to notify guest and scsi
  controllers without iothread call virtio_notify instead.  What make it
  difference? Will interrupts are lost when call virtio_notify_irqfd
  due to  race condition for some unknow reasons? Maybe guys more
  familiar with scsi dataplane can help. Thanks for your reply!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1779120/+subscriptions
