Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1CEC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 15:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF17207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 15:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF17207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir1vT-0001R2-LS
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 10:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ir1uO-0000YJ-EV
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ir1uM-0000qz-Su
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:45:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:56866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ir1uM-0000pO-Mi
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:45:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ir1uL-0000zf-Iz
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 15:45:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 86AE52E80C0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 15:45:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jan 2020 15:35:23 -0000
From: Yonggang Luo <1622582@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=jsnow@redhat.com; 
X-Launchpad-Bug-Tags: q35 sata windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 4o-ubrgtu-59 jnsnow luoyonggang
X-Launchpad-Bug-Reporter: Dennis (4o-ubrgtu-59)
X-Launchpad-Bug-Modifier: Yonggang Luo (luoyonggang)
References: <20160912115104.2358.5193.malonedeb@wampee.canonical.com>
Message-Id: <157892972315.27324.12009981949838206410.malone@chaenomeles.canonical.com>
Subject: [Bug 1622582] Re: Can't install Windows 7 with q35 (SATA)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e9bf8ea9a7b2ab29c3d8cee95daa32545e552394
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1622582 <1622582@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I also face this problem, any idea to resolve.
I am using qemeu 4.2 + whpx support but failed to install

./qemu-system-x86_64 -m 4096 \
-vga vmware \
-machine q35 \
-accel whpx \
-usb -device usb-kbd \
-device usb-mouse -device usb-audio -boot c \
-netdev tap,id=3Dmynet0,ifname=3Dtap0,script=3Dno,downscript=3Dno \
-device e1000,netdev=3Dmynet0,mac=3D52:55:00:d1:55:01 \
 -smp 4  \
-cdrom /e/Software/OS/WIN7/en_windows_7_ultimate_with_sp1_x64_dvd_u_677332.=
iso


But when using -accel tcg, it's insalled fine.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1622582

Title:
  Can't install Windows 7 with q35 (SATA)

Status in QEMU:
  Confirmed

Bug description:
  I'm trying to install Windows 7 on a q35 machine on a "SATA disk". If
  I use q35 the installation is extremely slow. With extremely slow I
  mean, that the first few minutes (10-15 minutes) on the second
  installation step (copying files to disk) nothing happens. Than there
  is some progress, maybe until 9% and than there is "silence" for
  another 10 minutes or so. Therefore I used iotop (with --only option)
  in order to see, if there are any disk operations. But as I mentioned,
  only a few times qemu writes something to disk (with about < 1M/s).
  But most of the time there is nothing from qemu. Therefore the
  installation lasts over an hour. But even worse, after installation I
  can't boot Windows. Windows-Start-Manager tells me, that windows
  couldn't be loaded because the kernel is missing or corrupt (Status
  0xc0000221, File: \Windows\system32\ntoskrnl.exe). If I use IDE on q35
  or pc-i440fx-2.6 everything works fine. There is a continuous
  installation progress and iotop shows continuous disk writes with max
  30M/s (but also 5M/s and other values...).

  I've tried qemu 2.6.0, 2.6.1 and 2.7.0 (all versions from git).

  My host machine: =

  Ubuntu 14.04.5 LTS
  3.13.0-95-generic #142-Ubuntu SMP Fri Aug 12 17:00:09 UTC 2016 x86_64 x86=
_64 x86_64 GNU/Linux
  Intel(R) Core(TM) i5-3470 CPU
  16 GB RAM

  =

  I used the following commands:

  "Standard" command
  qemu-system-x86_64 -m 2048 -machine q35,accel=3Dkvm -cpu host,kvm=3Doff -=
smp 1,sockets=3D1,cores=3D1,threads=3D1 -enable-kvm -hda win7_qemu_standard=
_q35.qcow2 -cdrom win7proX64.iso -boot order=3Dd

  I think by using -hda sata will be used?!?

  With explicit ahci:
  qemu-system-x86_64 -m 2048 -machine q35,accel=3Dkvm -cpu host,kvm=3Doff -=
smp 1,sockets=3D1,cores=3D1,threads=3D1 -enable-kvm -drive file=3Dwin7_qemu=
_standard_q35.qcow2,media=3Ddisk,if=3Dnone,id=3Dsata-disk -device ich9-ahci=
,id=3Dahci -device ide-drive,drive=3Dsata-disk,bus=3Dahci.0 -drive file=3Dw=
in7proX64.iso,media=3Dcdrom,if=3Dnone,id=3Dsata-cdrom -device ide-cd,drive=
=3Dsata-cdrom,bus=3Dahci.1 -boot order=3Dd

  I don't know if this is totally correct, because it's a little bit
  weird that I have to use ide-drive on a ich9 bus.

  Without kvm there is a continious disk write with 100 K/s - 5 M/s (works =
only with qemu 2.7.0, otherwise I get a 0x000000D1 bluescreen on the setup =
start screen):
  qemu-system-x86_64 -m 2048 -machine q35 -cpu IvyBridge -hda win7_qemu_sta=
ndard_q35.qcow2 -cdrom win7proX64.iso -boot order=3Dd

  But with all three commands the installed Windows is not working,
  because always the same error occurs: windows couldn't be loaded
  because kernel is missing or corrupt

  Interestingly both commands ("standard" command and with explicit
  ahci) works very well with a Windows 10 installation.

  In my opinion it's a "SATA problem", because if I use e.g. piix4-ide inst=
ead of ich9-ahci it works:
  qemu-system-x86_64 -m 2048 -machine q35,accel=3Dkvm -cpu host,kvm=3Doff -=
smp 1,sockets=3D1,cores=3D1,threads=3D1 -enable-kvm -drive file=3Dwin7_qemu=
_standard_q35.qcow2,media=3Ddisk,if=3Dnone,id=3Dide-disk -device piix4-ide,=
id=3Dide -device ide-drive,drive=3Dide-disk,bus=3Dide.0 -drive file=3Dwin7p=
roX64.iso,media=3Dcdrom,if=3Dnone,id=3Dide-cdrom -device ide-cd,drive=3Dide=
-cdrom,bus=3Dide.1 -boot order=3Dd

  With this command there is a continuous disk write and the
  installation is bootable.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1622582/+subscriptions

