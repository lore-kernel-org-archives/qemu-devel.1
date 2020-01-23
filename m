Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF58C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E5A2253D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E5A2253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuasg-00068I-2C
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iuar4-0004mY-Id
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iuar3-0003fm-29
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:40:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:34802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iuar2-0003fN-Sp
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:40:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iuar1-0003dO-F1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:40:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6FD262E80CE
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:40:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jan 2020 11:34:30 -0000
From: Frank Heimes <1859656@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=maas; status=New; importance=Undecided;
 assignee=lee.trager@canonical.com; 
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: product=ubuntu-z-systems; status=Triaged; importance=High;
 assignee=maas; 
X-Launchpad-Bug-Tags: s390x
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fheimes ltrager paelzer sfeole
X-Launchpad-Bug-Reporter: Sean Feole (sfeole)
X-Launchpad-Bug-Modifier: Frank Heimes (fheimes)
References: <157902669328.14768.4315907500950527119.malonedeb@wampee.canonical.com>
Message-Id: <157977927077.4717.3663394926831163556.malone@soybean.canonical.com>
Subject: [Bug 1859656] Re: [2.6] Unable to reboot s390x KVM machine after
 initial deploy
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b8d1327fd820d6bf500589d6da587d5037c7d88e";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 319e728340cd7dfbf493add17a2166db36a52377
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
Reply-To: Bug 1859656 <1859656@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I took the time and recreated a MAAS setup (latest stable 2.2) on s390x and=
 it looks like this:
- I could start a deployment and ran through the states:
   - Power On, Commissioning (Performing PXE boot)
   - Power On, Commissioning (Gathering Information)
   - Power On, Ready
   - Power Off, Ready
  (I may have have missed some states in between.)
- Power Off, Ready is the final state at that point
  and on the console it's:
$ virsh list --all
 Id    Name                           State
----------------------------------------------------
 -     vm1                            shut off
- xml VM definition is:
$ virsh dumpxml vm1
<domain type=3D'kvm'>
  <name>vm1</name>
  <uuid>0f7d1d61-9368-4bfe-8c65-c709e90e8780</uuid>
  <memory unit=3D'KiB'>1048576</memory>
  <currentMemory unit=3D'KiB'>1048576</currentMemory>
  <vcpu placement=3D'static'>1</vcpu>
  <os>
    <type arch=3D's390x' machine=3D's390-ccw-virtio-bionic'>hvm</type>
    <boot dev=3D'network'/>
    <boot dev=3D'hd'/>
  </os>
  <features>
    <acpi/>
    <apic/>
    <pae/>
  </features>
  <clock offset=3D'utc'/>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <devices>
    <emulator>/usr/bin/kvm</emulator>
    <disk type=3D'file' device=3D'disk'>
      <driver name=3D'qemu' type=3D'raw'/>
      <source file=3D'/var/lib/libvirt/maas-images/6addbfeb-ff2c-4350-b34d-=
11a56ea34f1d'/>
      <target dev=3D'vda' bus=3D'virtio'/>
      <serial>6addbfeb-ff2c-4350-b34d-11a56ea34f1d</serial>
      <address type=3D'ccw' cssid=3D'0xfe' ssid=3D'0x0' devno=3D'0x0002'/>
    </disk>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:ea:11:5f'/>
      <source network=3D'default'/>
      <model type=3D'virtio'/>
      <address type=3D'ccw' cssid=3D'0xfe' ssid=3D'0x0' devno=3D'0x0001'/>
    </interface>
    <console type=3D'pty'>
      <log file=3D'/var/log/libvirt/qemu/vm1-serial0.log' append=3D'off'/>
      <target type=3D'sclp' port=3D'0'/>
    </console>
    <memballoon model=3D'virtio'>
      <address type=3D'ccw' cssid=3D'0xfe' ssid=3D'0x0' devno=3D'0x0000'/>
    </memballoon>
    <panic model=3D's390'/>
  </devices>
</domain>

So it largely looks like assumed (after initially reading the bug),
PXE itself seems to work, but the boot issue it due to:
    <boot dev=3D'network'/>
    <boot dev=3D'hd'/>

That confirms the situation (on s390x and MAAS 2.6.2)m but it still
raises the question why it seem to have worked with 2.6.0?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859656

Title:
  [2.6] Unable to reboot s390x KVM machine after initial deploy

Status in MAAS:
  New
Status in QEMU:
  Incomplete
Status in Ubuntu on IBM z Systems:
  Triaged

Bug description:
  MAAS version: 2.6.1 (7832-g17912cdc9-0ubuntu1~18.04.1)
  Arch: S390x

  Appears that MAAS can not find the s390x bootloader to boot from the
  disk, not sure how maas determines this.  However this was working in
  the past. I had originally thought that if the maas machine was
  deployed then it defaulted to boot from disk.

  If I force the VM to book from disk, the VM starts up as expected.

  Reproduce:

  - Deploy Disco on S390x KVM instance
  - Reboot it

  on the KVM console...

  Connected to domain s2lp6g001
  Escape character is ^]
  done
  =C2=A0=C2=A0Using IPv4 address: 10.246.75.160
  =C2=A0=C2=A0Using TFTP server: 10.246.72.3
  =C2=A0=C2=A0Bootfile name: 'boots390x.bin'
  =C2=A0=C2=A0Receiving data:  0 KBytes
  =C2=A0=C2=A0TFTP error: file not found: boots390x.bin
  Trying pxelinux.cfg files...
  =C2=A0=C2=A0Receiving data:  0 KBytes
  =C2=A0=C2=A0Receiving data:  0 KBytes
  Failed to load OS from network

  =3D=3D> /var/log/maas/rackd.log <=3D=3D
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] boots39=
0x.bin requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/6=
5a9ca43-9541-49be-b315-e2ca85936ea2 requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
1-52-54-00-e5-d7-bb requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF64BA0 requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF64BA requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF64B requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF64 requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF6 requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
A requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
 requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/d=
efault requested by 10.246.75.160

To manage notifications about this bug go to:
https://bugs.launchpad.net/maas/+bug/1859656/+subscriptions

