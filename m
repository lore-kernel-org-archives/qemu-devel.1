Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77293C4332E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BBA720739
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBA720739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEs5D-00048W-Fn
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 06:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jEs3h-0001yk-D9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jEs3g-00060h-1M
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:05:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:34530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jEs3f-00060S-SN
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:05:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jEs3e-0004bP-Uz
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 10:05:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E70A12E80AB
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 10:05:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Mar 2020 09:59:02 -0000
From: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF?= <1866870@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Incomplete; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ahasenack dbaxps0220 dgilbert-h paelzer tstrike34
X-Launchpad-Bug-Reporter: tstrike (tstrike34)
X-Launchpad-Bug-Modifier: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer?=
 =?utf-8?q?=29?=
References: <158386023038.12575.5865810528923078550.malonedeb@soybean.canonical.com>
Message-Id: <158461194220.11915.10998512141124771787.malone@soybean.canonical.com>
Subject: [Bug 1866870] Re: KVM Guest pauses after upgrade to Ubuntu 20.04
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c2c8bd268b8eca6cbb5b580977c3b676445878ee
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
Reply-To: Bug 1866870 <1866870@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Turns out 1.12 is a fairly old build and the working version in Ubuntu was =
from in Disco, therefore about a year ago.
=3D> https://launchpad.net/ubuntu/+source/seabios/1.12.0-1/+build/16284605

Therefore I built it in Eoan and even Disco.
As an overview:
Disco: gcc 4:8.3.0-1ubuntu3   binutils 2.32-7ubuntu4
Eoan:  gcc 4:9.2.1-3.1ubuntu1 binutils 2.33-2ubuntu1.2
Focal: gcc 4:9.2.1-3.1ubuntu1 binutils 2.34-4ubuntu1

I ended up with these binaries to test:
./git-built-in-eoan/rel-1.12/bios.bin Breaks
./git-built-in-eoan/rel-1.13/bios.bin Breaks
./git-built-in-disco/rel-1.13/bios.bin Works
./git-built-in-disco/rel-1.12/bios.bin Works
./git-built-in-focal/head/bios.bin Breaks
./git-built-in-focal/rel-1.12/bios.bin Breaks
./git-built-in-focal/rel-1.13/bios.bin Breaks
./packaging/disco-seabios_1.12.0-1/bios.bin Works
./packaging/focal-seabios_1.13.0-1/bios.bin Breaks

To summarize:
- qemu breaks on chips of the Penryn generation
- it only breaks if the seabios bios is executed
- does not really depend on seabios or qemu version
- but it depends on seabios build environment

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1866870

Title:
  KVM Guest pauses after upgrade to Ubuntu 20.04

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  Incomplete

Bug description:
  Symptom:
  Error unpausing domain: internal error: unable to execute QEMU command 'c=
ont': Resetting the Virtual Machine is required

  Traceback (most recent call last):
    File "/usr/share/virt-manager/virtManager/asyncjob.py", line 75, in cb_=
wrapper
      callback(asyncjob, *args, **kwargs)
    File "/usr/share/virt-manager/virtManager/asyncjob.py", line 111, in tm=
pcb
      callback(*args, **kwargs)
    File "/usr/share/virt-manager/virtManager/object/libvirtobject.py", lin=
e 66, in newfn
      ret =3D fn(self, *args, **kwargs)
    File "/usr/share/virt-manager/virtManager/object/domain.py", line 1311,=
 in resume
      self._backend.resume()
    File "/usr/lib/python3/dist-packages/libvirt.py", line 2174, in resume
      if ret =3D=3D -1: raise libvirtError ('virDomainResume() failed', dom=
=3Dself)
  libvirt.libvirtError: internal error: unable to execute QEMU command 'con=
t': Resetting the Virtual Machine is required

  =

  ---

  As outlined here:
  https://bugs.launchpad.net/qemu/+bug/1813165/comments/15

  After upgrade, all KVM guests are in a default pause state. Even after
  forcing them off via virsh, and restarting them the guests are paused.

  These Guests are not nested.

  A lot of diganostic information are outlined in the previous bug
  report link provided. The solution mentioned in previous report had
  been allegedly integrated into the downstream updates.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1866870/+subscriptions

