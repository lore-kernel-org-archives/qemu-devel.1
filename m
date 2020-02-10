Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8DCC352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6696A2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6696A2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j19wd-0003mN-Gj
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 09:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j19vi-0002AU-1s
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 09:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j19vg-0000Tr-MI
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 09:20:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:49550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j19vg-0000TM-HF
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 09:20:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j19vf-0002Uq-8S
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 14:20:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 015D52E80DE
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 14:20:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Feb 2020 14:13:54 -0000
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
X-Launchpad-Bug-Commenters: fheimes ltrager paelzer sfeole
X-Launchpad-Bug-Reporter: Sean Feole (sfeole)
X-Launchpad-Bug-Modifier: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer?=
 =?utf-8?q?=29?=
References: <157902669328.14768.4315907500950527119.malonedeb@wampee.canonical.com>
Message-Id: <158134403431.19711.4414252229802680097.malone@wampee.canonical.com>
Subject: [Bug 1859656] Re: [2.6] Unable to reboot s390x KVM machine after
 initial deploy
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 948a758a6421af4fe638786577cf58eddcb62a9f
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

** Attachment added: "Guest XML "as it was once working""
   https://bugs.launchpad.net/maas/+bug/1859656/+attachment/5327027/+files/=
vm1-as-deployed-by-maas.xml

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

