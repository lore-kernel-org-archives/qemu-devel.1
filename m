Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5B0C04AAC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 04:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EAC020868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 04:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAC020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57458 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTfOr-0007MJ-CU
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 00:32:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hTfMf-0006K6-59
	for qemu-devel@nongnu.org; Thu, 23 May 2019 00:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hTfMd-0005tD-TA
	for qemu-devel@nongnu.org; Thu, 23 May 2019 00:30:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:34672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hTfMd-0005sF-Ny
	for qemu-devel@nongnu.org; Thu, 23 May 2019 00:29:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hTfMc-0003AD-0P
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 04:29:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CF4D12E80E0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 04:29:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 May 2019 04:17:25 -0000
From: Launchpad Bug Tracker <1562653@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
	status=Expired; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: changlimin janitor serge-hallyn th-huth
X-Launchpad-Bug-Reporter: changlimin (changlimin)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20160328013239.3708.98267.malonedeb@wampee.canonical.com>
Message-Id: <155858504571.3863.6712716764004592394.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: dd12e7ac5d7d1fd23313a3fc168c53e3de5e5721
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1562653] Re: Ubuntu 15.10: QEMU VM hang if memory
 >= 1T
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
Reply-To: Bug 1562653 <1562653@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for qemu (Ubuntu) because there has been no activity for 60
days.]

** Changed in: qemu (Ubuntu)
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1562653

Title:
  Ubuntu 15.10: QEMU VM hang if memory >=3D 1T

Status in QEMU:
  Expired
Status in qemu package in Ubuntu:
  Expired

Bug description:
  1. Ubuntu 15.10 x86_64 installed on HP SuperDome X with 8CPUs and 4T
  memory.

  2. Create a VM, install Ubuntu 15.10, if memory >=3D 1T , VM hang when st=
art. If memory < 1T, it is good.
  <domain type=3D'kvm'>
    <name>u1510-1</name>
    <uuid>39eefe1e-4829-4843-b892-026d143f3ec7</uuid>
    <memory unit=3D'KiB'>1073741824</memory>
    <currentMemory unit=3D'KiB'>1073741824</currentMemory>
    <vcpu placement=3D'static'>16</vcpu>
    <os>
      <type arch=3D'x86_64' machine=3D'pc-i440fx-2.3'>hvm</type>
      <boot dev=3D'hd'/>
      <boot dev=3D'cdrom'/>
    </os>
    <features>
      <acpi/>
      <apic/>
      <pae/>
    </features>
    <clock offset=3D'utc'/>
    <on_poweroff>destroy</on_poweroff>
    <on_reboot>restart</on_reboot>
    <on_crash>restart</on_crash>
    <devices>
      <emulator>/usr/bin/kvm</emulator>
      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'qcow2' cache=3D'directsync'/>
        <source file=3D'/vms/images/u1510-1.img'/>
        <target dev=3D'vda' bus=3D'virtio'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x08' =
function=3D'0x0'/>
      </disk>
      <disk type=3D'file' device=3D'cdrom'>
        <driver name=3D'qemu' type=3D'raw'/>
        <target dev=3D'hdc' bus=3D'ide'/>
        <readonly/>
        <address type=3D'drive' controller=3D'0' bus=3D'1' target=3D'0' uni=
t=3D'0'/>
      </disk>
      <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>
      <controller type=3D'ide' index=3D'0'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x1'/>
      </controller>
      <controller type=3D'usb' index=3D'0'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x2'/>
      </controller>
      <interface type=3D'bridge'>
        <mac address=3D'0c:da:41:1d:ae:f1'/>
        <source bridge=3D'vswitch0'/>
        <model type=3D'virtio'/>
        <driver name=3D'vhost'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' =
function=3D'0x0'/>
      </interface>
      <input type=3D'mouse' bus=3D'ps2'/>
      <input type=3D'keyboard' bus=3D'ps2'/>
      <graphics type=3D'vnc' port=3D'-1' autoport=3D'yes' listen=3D'0.0.0.0=
'>
        <listen type=3D'address' address=3D'0.0.0.0'/>
      </graphics>
      <video>
        <model type=3D'cirrus' vram=3D'16384' heads=3D'1'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0'/>
      </video>
      <memballoon model=3D'virtio'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x09' =
function=3D'0x0'/>
      </memballoon>
    </devices>
  </domain>

  3. The panic stack is
    ... cannot show
    async_page_fault+0x28
    ioread32_rep+0x38
    ata_sff_data_xfer32+0x8a
    ata_pio_sector+0x93
    ata_pio_sectors+0x34
    ata_sff_hsm_move+0x226
    RIP: kthread_data+0x10
    CR2: FFFFFFFF_FFFFFFD8

  4. Change the host os to Redhat 7.2 , the vm is good even memory
  >=3D3.8T.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1562653/+subscriptions

