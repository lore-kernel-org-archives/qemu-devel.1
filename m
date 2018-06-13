Received: from eggs.gnu.org ([2001:4830:134:3::10]:44435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fSxQW-0005oX-13
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fSxQR-0003V0-28
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:30:32 -0400
Received: from indium.canonical.com ([91.189.90.7]:55626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fSxQQ-0003UK-PH
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:30:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fSxQP-0001iP-Ne
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 04:30:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AF34E2E8031
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 04:30:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Jun 2018 04:17:34 -0000
From: Launchpad Bug Tracker <1446726@bugs.launchpad.net>
Reply-To: Bug 1446726 <1446726@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150421153539.13624.79753.malonedeb@chaenomeles.canonical.com>
Message-Id: <152886345507.16396.2906419067883120702.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1446726] Re: qemu stable 2.0 crashes during loadvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1446726

Title:
  qemu stable 2.0 crashes during loadvm

Status in QEMU:
  Expired

Bug description:
  Qemu output:

  2015-03-06 01:06:54.255+0000: starting up =

  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin=
:/bin QEMU_AUDIO_DRV=3Dnone /usr/bin/qemu-system-x86_64 -name instance-0000=
462a -S -machine pc-i440fx-trusty,accel=3Dkvm,usb=3Doff -cpu Westmere,+erms=
,+smep,+3dnowprefetch,+rdtscp,+rdrand,+tsc-deadline,+movbe,+pdcm,+xtpr,+tm2=
,+est,+vmx,+ds_cpl,+monitor,+dtes64,+pclmuldq,+pbe,+tm,+ht,+ss,+acpi,+ds,+v=
me -m 4096 -realtime mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -=
uuid 7c3f225c-df2a-4014-997b-3200fcfff43d -smbios type=3D1,manufacturer=3DO=
penStack Foundation,product=3DOpenStack Nova,version=3D2014.1.2,serial=3D47=
4aef35-d474-8001-e411-6108001017ac,uuid=3D7c3f225c-df2a-4014-997b-3200fcfff=
43d -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/va=
r/lib/libvirt/qemu/instance-0000462a.monitor,server,nowait -mon chardev=3Dc=
harmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -glo=
bal kvm-pit.lost_tick_policy=3Ddiscard -no-hpet -no-shutdown -boot strict=
=3Don -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive fil=
e=3D/var/lib/nova/instances/7c3f225c-df2a-4014-997b-3200fcfff43d/disk,if=3D=
none,id=3Ddrive-virtio-disk0,format=3Dqcow2,cache=3Dnone,iops_rd=3D100,iops=
_wr=3D100 -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x6,drive=3D=
drive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive file=3D/dev/mappe=
r/258c232d7056e0047,if=3Dnone,id=3Ddrive-virtio-disk1,format=3Draw,serial=
=3Ddedb9d8d-e727-4d09-bf89-52e870125303,cache=3Dnone -device virtio-blk-pci=
,scsi=3Doff,bus=3Dpci.0,addr=3D0x9,drive=3Ddrive-virtio-disk1,id=3Dvirtio-d=
isk1 -drive file=3D/var/lib/nova/instances/7c3f225c-df2a-4014-997b-3200fcff=
f43d/disk.config,if=3Dnone,id=3Ddrive-virtio-disk25,format=3Draw,cache=3Dno=
ne,iops_rd=3D100,iops_wr=3D100 -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.=
0,addr=3D0x7,drive=3Ddrive-virtio-disk25,id=3Dvirtio-disk25 -chardev file,i=
d=3Dcharserial0,path=3D/var/lib/nova/instances/7c3f225c-df2a-4014-997b-3200=
fcfff43d/console.log -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 =
-chardev pty,id=3Dcharserial1 -device isa-serial,chardev=3Dcharserial1,id=
=3Dserial1 -device usb-tablet,id=3Dinput0 -vnc 127.0.0.1:0 -k ja -device ci=
rrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -incoming fd:23 -device virtio-=
balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 =

  char device redirected to /dev/pts/3 (label charserial1) =

  qemu-system-x86_64: /build/buildd/qemu-2.0.0+dfsg/memory.c:1403: memory_r=
egion_del_eventfd: Assertion `i !=3D mr->ioeventfd_nb' failed. =

  2015-03-06 01:09:02.585+0000: shutting down

  =

  Libvirt log:
  2015-03-05 11:29:48.434+0000: 8392: error : qemuMonitorIO:656 : internal =
error: End of file from monitor
  2015-03-06 00:13:33.077+0000: 8397: warning : AppArmorSetFDLabel:919 : co=
uld not find path for descriptor /proc/self/fd/26, skipping
  2015-03-06 00:13:40.981+0000: 8397: warning : virFileWrapperFdClose:308 :=
 iohelper reports:
  2015-03-06 00:14:27.206+0000: 8396: warning : qemuDomainObjStart:6073 : U=
nable to restore from managed state /var/lib/libvirt/qemu/save/instance-000=
0462a.save. Maybe the file is corrupted?
  2015-03-06 00:14:40.160+0000: 8392: warning : qemuMonitorJSONHandleDevice=
Deleted:931 : missing device in device deleted event
  2015-03-06 00:20:45.414+0000: 8392: error : qemuMonitorIO:656 : internal =
error: End of file from monitor
  2015-03-06 00:26:21.849+0000: 8396: warning : AppArmorSetFDLabel:919 : co=
uld not find path for descriptor /proc/self/fd/25, skipping
  2015-03-06 00:26:24.764+0000: 8396: warning : virFileWrapperFdClose:308 :=
 iohelper reports:
  2015-03-06 00:28:09.425+0000: 8398: warning : qemuDomainObjStart:6073 : U=
nable to restore from managed state /var/lib/libvirt/qemu/save/instance-000=
0462a.save. Maybe the file is corrupted?
  2015-03-06 00:29:29.981+0000: 8392: error : qemuMonitorIO:656 : internal =
error: End of file from monitor
  2015-03-06 00:35:06.485+0000: 8398: warning : AppArmorSetFDLabel:919 : co=
uld not find path for descriptor /proc/self/fd/26, skipping
  2015-03-06 00:35:09.645+0000: 8398: warning : virFileWrapperFdClose:308 :=
 iohelper reports:
  2015-03-06 00:37:58.701+0000: 8397: warning : qemuDomainObjStart:6073 : U=
nable to restore from managed state /var/lib/libvirt/qemu/save/instance-000=
0462a.save. Maybe the file is corrupted?
  2015-03-06 00:59:12.925+0000: 8392: error : qemuMonitorIO:656 : internal =
error: End of file from monitor
  2015-03-06 01:04:57.990+0000: 8392: warning : qemuMonitorJSONHandleDevice=
Deleted:931 : missing device in device deleted event
  2015-03-06 01:05:18.031+0000: 8392: warning : qemuMonitorJSONHandleDevice=
Deleted:931 : missing device in device deleted event
  2015-03-06 01:05:37.954+0000: 8392: warning : qemuMonitorJSONHandleDevice=
Deleted:931 : missing device in device deleted event
  2015-03-06 01:06:13.213+0000: 8392: error : qemuMonitorIO:656 : internal =
error: End of file from monitor
  2015-03-06 01:06:29.870+0000: 8398: warning : AppArmorSetFDLabel:919 : co=
uld not find path for descriptor /proc/self/fd/26, skipping
  2015-03-06 01:06:31.024+0000: 8398: warning : virFileWrapperFdClose:308 :=
 iohelper reports:
  2015-03-06 01:06:57.274+0000: 8395: warning : qemuDomainObjStart:6073 : U=
nable to restore from managed state /var/lib/libvirt/qemu/save/instance-000=
0462a.save. Maybe the file is corrupted?
  2015-03-06 01:09:02.581+0000: 8392: error : qemuMonitorIORead:554 : Unabl=
e to read from monitor: Connection reset by peer

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1446726/+subscriptions
