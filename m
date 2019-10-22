Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E74DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 04:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D784B2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 04:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D784B2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50263 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMmDe-0008UN-09
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 00:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iMmCt-0007vK-FM
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 00:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iMmCs-00019T-8n
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 00:55:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:41836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iMmCs-00019D-3R
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 00:55:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iMmCq-0002Ar-RC
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 04:55:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CC87D2E80C0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 04:55:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Oct 2019 04:45:46 -0000
From: Marshall Porter <1792523@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alex-l-williamson meoporter
X-Launchpad-Bug-Reporter: Marshall Porter (meoporter)
X-Launchpad-Bug-Modifier: Marshall Porter (meoporter)
References: <153690806645.16635.9456702675801152758.malonedeb@chaenomeles.canonical.com>
Message-Id: <157171954636.19010.1752292357601936845.malone@gac.canonical.com>
Subject: [Bug 1792523] Re: usb passthrough not resetting on host after vm
 shutdown if started with -daemonize
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="186023fa645d8be19d403a76064f0643f510db2f";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b54d9e48df7ba3d9e5188b11359efe25762dd313
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
Reply-To: Bug 1792523 <1792523@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I tested this again on the latest Qemu and Linux kernel and cannot
reproduce it anymore, so this can be closed now..

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1792523

Title:
  usb passthrough not resetting on host after vm shutdown if started
  with -daemonize

Status in QEMU:
  New

Bug description:
  Below is the full Qemu command used to launch the VM. Have been using
  this same setup since Qemu 2.12, plus a couple of cherry picked patch
  commits fixing ide-hd and e1000e in Windows guests. Both sets of
  patches have now been merged to 3.0, so decided to update to 3.0.

  The VM launches and runs fine, but after shutting down, the usb
  devices that are passed through from the host (keyboard, mouse) do not
  work until unplugged and plugged in again. Have narrowed this down to
  the -daemonize -pidfile arguments.. if those lines are removed, usb
  devices work in the host again right away after VM shutdown.

  CPU: Intel(R) Core(TM) i5-6600K CPU @ 3.50GHz
  OS: Linux dev 4.18.6-arch1-1-ARCH #1 SMP PREEMPT Wed Sep 5 11:54:09 UTC 2=
018 x86_64 GNU/Linux

  Thank you for looking into this!

  =

  #!/usr/bin/env bash

  echo vfio-pci > /sys/bus/pci/devices/0000:04:00.0/driver_override
  echo 0000:04:00.0 > /sys/bus/pci/devices/0000:04:00.0/driver/unbind
  echo 0000:04:00.0 > /sys/bus/pci/drivers/vfio-pci/bind
  echo > /sys/bus/pci/devices/0000:04:00.0/driver_override

  /usr/bin/qemu-system-x86_64 \
  -name winnt \
  -daemonize \
  -pidfile /run/vms/qemu/winnt.pid \
  -boot menu=3Don \
  -drive if=3Dpflash,format=3Draw,readonly,file=3D/opt/vms/qemu/machines/ov=
mf_code_patched.fd \
  -drive if=3Dpflash,format=3Draw,file=3D/opt/vms/qemu/machines/winnt/ovmf_=
vars_patched.fd \
  -machine pc-q35-3.0,accel=3Dkvm \
  -nodefaults \
  -cpu host,kvm=3Doff,hv_vendor_id=3DRedHat,hv_time,hv_relaxed,hv_vapic,hv_=
spinlocks=3D0x1fff \
  -accel kvm \
  -smp 4,sockets=3D1,cores=3D4,threads=3D1 \
  -m 16G \
  -nic bridge,br=3Dbr0,mac=3D52:54:00:12:34:77,model=3De1000e \
  -device vfio-pci,host=3D01:00.0,multifunction=3Don \
  -device vfio-pci,host=3D01:00.1 \
  -vga none \
  -display none \
  -monitor none \
  -blockdev raw,node-name=3Dide-hd.0,cache.direct=3Don,discard=3Dunmap,file=
.driver=3Dhost_device,file.aio=3Dnative,file.filename=3D/dev/disk/by-id/ata=
-WDC_WDS500G2B0A-00SM50_181265803048 \
  -device ide-hd,drive=3Dide-hd.0,bus=3Dide.0,rotation_rate=3D1 \
  -blockdev raw,node-name=3Dide-hd.1,cache.direct=3Don,file.driver=3Dhost_d=
evice,file.aio=3Dnative,file.filename=3D/dev/disk/by-id/ata-TOSHIBA_HDWE160=
_X746K8ZTF56D-part1 \
  -device ide-hd,drive=3Dide-hd.1,bus=3Dide.1 \
  -device vfio-pci,host=3D04:00.0 \
  -device qemu-xhci \
  -device usb-host,vendorid=3D0x04d9,productid=3D0x0171 \
  -device usb-host,vendorid=3D0x1532,productid=3D0x005c \
  -device usb-host,vendorid=3D0x1b1c,productid=3D0x0c09

  echo 0000:04:00.0 > /sys/bus/pci/devices/0000:04:00.0/driver/unbind
  echo 0000:04:00.0 > /sys/bus/pci/drivers_probe

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1792523/+subscriptions

