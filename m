Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E49C10F0E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 04:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC36F20863
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 04:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC36F20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34237 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCzUL-0003Ke-8F
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 00:33:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hCzRE-0001DJ-BQ
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 00:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hCzRC-0007uB-Vl
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 00:29:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:47012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hCzRC-0007ts-Nm
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 00:29:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hCzRB-0007mr-A9
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 04:29:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 43F2E2E8076
	for <qemu-devel@nongnu.org>; Sun,  7 Apr 2019 04:29:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Apr 2019 04:17:22 -0000
From: Launchpad Bug Tracker <1547012@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public Security
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: yes
X-Launchpad-Bug-Commenters: janitor r-aviolat th-huth
X-Launchpad-Bug-Reporter: xens (r-aviolat)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20160218130432.32646.62868.malonedeb@gac.canonical.com>
Message-Id:
 <155461064269.28623.12411456476857682471.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 2a4794c4c02340c2307986268b4602318db97bb5
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1547012] Re: qemu instances crashes with certain
 spice clients
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
Reply-To: Bug 1547012 <1547012@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190407041722.gEFmGOXQ_QSvckyvECMrgLJG7OusEFSicOQ7u1Qbi6o@z>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1547012

Title:
  qemu instances crashes with certain spice clients

Status in QEMU:
  Expired

Bug description:
  It's possible to make qemu instances crash when using certain browsers
  connected as spice-clients.

  my environment:

  - OpenStack Kilo installed from ubuntu-cloud archive (qemu-system-x86 2.2=
+dfsg-5expubuntu9.6~cloud0)
  - Using spice for web-console access

  How to reproduce:

  1. Start a VM on openstack
  2. access the OpenStack dashboard using iceweasel 43.0.4 =

  3. Open the spice-console
  4. Leave the console open for few minutes
  5. The VM will crash on the hypervisor

  The content of qemu log-files for this particular VM:

  2016-02-18 07:25:23.655+0000: starting up
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin=
:/bin QEMU_AUDIO_DRV=3Dspice /usr/bin/qemu-system-x86_64 -name instance-000=
0188f -S -machine pc-i440fx-utopic,accel=3Dkvm,usb=3Doff -cpu SandyBridge,+=
erms,+smep,+fsgsbase,+pdpe1gb,+rdrand,+f16c,+osxsave,+dca,+pcid,+pdcm,+xtpr=
,+tm2,+est,+smx,+vmx,+ds_cpl,+monitor,+dtes64,+pbe,+tm,+ht,+ss,+acpi,+ds,+v=
me -m 4096 -realtime mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -=
uuid cb04ff25-056f-4f82-a2e8-1fbb762bc29e -smbios type=3D1,manufacturer=3DO=
penStack Foundation,product=3DOpenStack Nova,version=3D2015.1.2,serial=3D00=
000000-0000-0000-0000-0cc47a45f5e8,uuid=3Dcb04ff25-056f-4f82-a2e8-1fbb762bc=
29e -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/va=
r/lib/libvirt/qemu/instance-0000188f.monitor,server,nowait -mon chardev=3Dc=
harmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -glo=
bal kvm-pit.lost_tick_policy=3Ddiscard -no-hpet -no-shutdown -boot strict=
=3Don -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device vi=
rtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x4 -drive file=3Drb=
d:libvirt/cb04ff25-056f-4f82-a2e8-1fbb762bc29e_disk:id=3Dcinder:key=3DAQBYm=
dBUCDq7IBAA/7tLevRjdF3Bo7522xkFqA=3D=3D:auth_supported=3Dcephx\;none:mon_ho=
st=3Dxxx.xxx.xxx.xxx\:6789\;xxx.xxx.xxx.xxx\:6789\;xxx.xxx.xxx.xxx\:6789\;x=
xx.xxx.xxx.xxx\:6789\;xxx.xxx.xxx.xxx\:6789,if=3Dnone,id=3Ddrive-virtio-dis=
k0,format=3Draw,cache=3Dwriteback -device virtio-blk-pci,scsi=3Doff,bus=3Dp=
ci.0,addr=3D0x5,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 =
-netdev tap,fd=3D55,id=3Dhostnet0,vhost=3Don,vhostfd=3D58 -device virtio-ne=
t-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3Dfa:16:3e:a4:74:3b,bus=3Dpci.0,addr=
=3D0x3 -chardev file,id=3Dcharserial0,path=3D/var/lib/nova/instances/cb04ff=
25-056f-4f82-a2e8-1fbb762bc29e/console.log -device isa-serial,chardev=3Dcha=
rserial0,id=3Dserial0 -chardev pty,id=3Dcharserial1 -device isa-serial,char=
dev=3Dcharserial1,id=3Dserial1 -chardev pty,id=3Dcharchannel0 -device virts=
erialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel=
0,name=3Dcom.redhat.spice.0 -spice port=3D5929,addr=3D172.24.1.30,disable-t=
icketing,seamless-migration=3Don -k fr-ch -device qxl-vga,id=3Dvideo0,ram_s=
ize=3D67108864,vram_size=3D67108864,vgamem_mb=3D16,bus=3Dpci.0,addr=3D0x2 -=
device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x6 -msg timesta=
mp=3Don
  char device redirected to /dev/pts/64 (label charserial1)
  char device redirected to /dev/pts/65 (label charchannel0)
  main_channel_link: add main channel client
  main_channel_handle_parsed: net test: latency 44.136000 ms, bitrate 15753=
8461538 bps (150240.384615 Mbps)
  inputs_connect: inputs channel client create
  red_dispatcher_set_cursor_peer:
  ((null):18188): SpiceWorker-CRITICAL **: red_worker.c:1629:common_alloc_r=
ecv_buf: unexpected message size 214862 (max is 1024)
  2016-02-18 07:30:47.008+0000: shutting down

  It's funny because this error only occurs with certain browser
  versions, in my case with Iceweasel 43.0.4 and 44. 0 but it works well
  with Chrome 48.0.256482 and Firefox 44.0.2.

  Marking this a potential security issue as it could maybe lead to a
  denial-of-service if a user sends crafted packets.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1547012/+subscriptions

