Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A9FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 10:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F8424655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 10:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F8424655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuZKT-0004MU-AU
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 05:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iuZIM-0002zP-Dp
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 05:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iuZIK-0006pK-SZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 05:01:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:49150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iuZIJ-0006k0-1t
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 05:01:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iuZIG-0002RD-F3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 10:00:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 626A72E80CB
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 10:00:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jan 2020 09:52:55 -0000
From: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF?= <1859656@bugs.launchpad.net>
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
X-Launchpad-Bug-Commenters: ltrager paelzer sfeole
X-Launchpad-Bug-Reporter: Sean Feole (sfeole)
X-Launchpad-Bug-Modifier: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer?=
 =?utf-8?q?=29?=
References: <157902669328.14768.4315907500950527119.malonedeb@wampee.canonical.com>
Message-Id: <157977317542.4803.2138107860071652172.malone@soybean.canonical.com>
Subject: [Bug 1859656] Re: [2.6] Unable to reboot s390x KVM machine after
 initial deploy
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b8d1327fd820d6bf500589d6da587d5037c7d88e";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 27612ffc88ca3e44d6d35394912d75315d9a80e2
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

First check - as assumed - the old style config always failed.
It went into netboot, netboot fails and then it bails out.

root@testkvm-bionic-from:~# virsh start netboot --console
Domain netboot started
Connected to domain netboot
Escape character is ^]
done
  Using IPv4 address: 192.168.122.33
  Using TFTP server: 192.168.122.1
Trying pxelinux.cfg files...
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  Receiving data:  0 KBytes
Repeating TFTP read request...
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  Receiving data:  0 KBytes
Repeating TFTP read request...
  TFTP error: ICMP ERROR "port unreachable"
Failed to load OS from network

root@testkvm-bionic-from:~# =

root@testkvm-bionic-from:~# virsh list --all
 Id    Name                           State
----------------------------------------------------
 -     netboot                        shut off


-- -- -- --

The suggested config with bootindex (lets see if that would work on
s390x)

root@testkvm-bionic-from:~# virsh start netboot --console
Domain netboot started
Connected to domain netboot
Escape character is ^]
done
  Using IPv4 address: 192.168.122.33
  Using TFTP server: 192.168.122.1
Trying pxelinux.cfg files...
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  Receiving data:  0 KBytes
Repeating TFTP read request...
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  TFTP error: ICMP ERROR "port unreachable"
  Receiving data:  0 KBytes
Repeating TFTP read request...
  TFTP error: ICMP ERROR "port unreachable"
Failed to load OS from network

by that confirming SFeole again (comment #9 this time).

So no easy workarounds present.

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

