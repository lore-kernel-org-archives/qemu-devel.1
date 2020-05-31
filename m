Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1643CC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D912074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D912074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfTC9-00045O-4h
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 15:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jfTBI-0003X7-7R
 for qemu-devel@nongnu.org; Sun, 31 May 2020 14:59:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:56316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jfTBF-0005Mq-NC
 for qemu-devel@nongnu.org; Sun, 31 May 2020 14:59:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jfTBC-0002TV-8y
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 18:59:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3839F2E8109
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 18:59:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2020 18:50:13 -0000
From: 123p <1377095@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: hotplug pass-through printer usb
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 123p th-huth
X-Launchpad-Bug-Reporter: 123p (123p)
X-Launchpad-Bug-Modifier: 123p (123p)
References: <20141003105035.5331.35277.malonedeb@wampee.canonical.com>
Message-Id: <159095101318.29529.4718433364226189154.malone@chaenomeles.canonical.com>
Subject: [Bug 1377095] Re: KVM guest VM does not reattach a throughpassed USB
 printer from Host after switching printer off and on
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="275d46a24253e557e4403d52832837e4bfa425b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ae2f3ac36300557e21f35aa9d11d946d9acabfa5
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 14:59:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1377095 <1377095@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks Thomas for Your suggestion. Unfortunately I cannot achieve the
reconnection:

KVM runs with following parameters:

-usb -device usb-host,vendorid=3D0x04e8,productid=3D0x3242,id=3Ddrucker
-monitor unix:qemu-monitor-socket,server,nowait

With the Unix socket, I can now pipe commands to the qemu monitor. This
info command works:

echo 'info status' | socat - unix-connect:/qemu-monitor-socket
QEMU 4.2.0 monitor - type 'help' for more information
(qemu) info status
VM status: running

What I have is this:
- disconnect USB printer (Product Samsung ML-1510_700)
- stop KVM
- connect USB printer
- start KVM

echo 'info usb' | socat - unix-connect:/qemu-monitor-socket
QEMU 4.2.0 monitor - type 'help' for more information
(qemu) info usb
  Device 0.1, Port 1, Speed 12 Mb/s, Product QEMU USB Tablet
  Device 0.2, Port 2, Speed 12 Mb/s, Product QEMU USB Hub
  Device 0.3, Port 2.1, Speed 12 Mb/s, Product Samsung ML-1510_700, ID: dru=
cker

Printer works.
- disconnect printer

echo 'info usb' | socat - unix-connect:/qemu-monitor-socket
QEMU 4.2.0 monitor - type 'help' for more information
(qemu) info usb
  Device 0.2, Port 1, Speed 12 Mb/s, Product QEMU USB Tablet
  Device 0.3, Port 2, Speed 12 Mb/s, Product QEMU USB Hub
  Device 0.4, Port 2.1, Speed 12 Mb/s, Product Samsung ML-1510_700, ID: dru=
cker

USB Info still shows the printer, allthough it is disconnected.

Remove device from KVM:

echo 'device_del drucker' | socat - unix-connect:/qemu-monitor-socket

Printer is removed from the device list:

info usbdrucker' | socat - unix-connect:/qemu-monitor-socket
QEMU 4.2.0 monitor - type 'help' for more information
(qemu) info usb
  Device 0.2, Port 1, Speed 12 Mb/s, Product QEMU USB Tablet
  Device 0.3, Port 2, Speed 12 Mb/s, Product QEMU USB Hub

-connect printer

printer is not shown:

echo 'info usb' | socat - unix-connect:/qemu-monitor-socket
QEMU 4.2.0 monitor - type 'help' for more information
(qemu) info usb
  Device 0.2, Port 1, Speed 12 Mb/s, Product QEMU USB Tablet
  Device 0.3, Port 2, Speed 12 Mb/s, Product QEMU USB Hub

Add printer device:

echo 'device_add usb-host,vendorid=3D0x04e8,productid=3D0x3242,id=3Ddrucker=
 ' | socat - unix-connect:/qemu-monitor-socket
QEMU 4.2.0 monitor - type 'help' for more information
(qemu) device_add usb-host,vendorid=3D0x04e8,productid=3D0x3242,id=3Ddrucker

echo 'info usb' | socat - unix-connect:/qemu-monitor-socket
QEMU 4.2.0 monitor - type 'help' for more information
(qemu) info usb
  Device 0.2, Port 1, Speed 12 Mb/s, Product QEMU USB Tablet
  Device 0.3, Port 2, Speed 12 Mb/s, Product QEMU USB Hub
  Device 0.0, Port 2.2, Speed 1.5 Mb/s, Product USB Host Device, ID: drucker

Device is shown, but not like when KVM is started with connected
printer: Speed only 1.5 Mb/s, no vendor and product info.

Printer does _not_ work.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1377095

Title:
  KVM guest VM does not reattach a throughpassed USB printer from Host
  after switching printer off and on

Status in QEMU:
  New

Bug description:
  =

  Host OS: Gentoo, all packages built 2014-10-01

  qemu version 2.1.0-r1

  Linux kernel 3.14.14   x86_64 Intel(R) Core(TM) i3-3220T CPU @ 2.80GHz
  GenuineIntel GNU/Linux

  =

  Guest VM: Debian 7 (Wheezy) Linux 3.2.0 686

  =

  Start command:
  /usr/bin/qemu-system-i386 -enable-kvm -name wheezy -k de -serial null -pa=
rallel null -hda /var/kvm/wheezy.kvm-img -daemonize -net nic,macaddr=3D02:0=
0:00:00:01:31 -net tap,ifname=3Dtap3,script=3Dno,downscript=3Dno -m 512 -pi=
dfile /var/run/kvm/wheezy.pid -usb -usbdevice tablet -runas myuser -vnc 127=
.0.0.1:3 -usbdevice host:04e8:3242

  Problem:
  USB printer pass-through from KVM host to guest vm only works if I start =
the qemu kvm when the USB printer (vendor/product ID 04e8:3242) is switched=
 on and therefore shown in lsusb on the host. Then it is available in the s=
tarted VM.

  But when I switch the usb printer attached to the host off, it
  disappears in lsusb both on the host and the VM (as expected) but when
  I switch the USB printer on again, it is shown on the host and also on
  the QEMU Monitor (Crtl Alt Shift 2 -> info usbhost), but in the VM
  lsusb does not show it again- so USB pass-through / hot plugging does
  not work. It worked with a previous Version of qemu (1.0 or
  something).

  That is very annoying, because every time I want to print something, I ne=
ed to shutdown the VM, start the printer, and then start the VM (which runs=
 cups as printer server).
  But after printing, I do not want the printer to keep running, so I switc=
h it off.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1377095/+subscriptions

