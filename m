Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02B2C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757252070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757252070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEtJl-0001AW-Fk
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 07:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jEtJ6-0000kc-K1
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jEtJ5-0008Nq-2h
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:25:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:47132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jEtJ4-0007sm-Su
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:25:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jEtJ2-00042b-Rx
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 11:25:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CE2042E80CC
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 11:25:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Mar 2020 11:18:15 -0000
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
Message-Id: <158461669535.28890.6799674105255888769.malone@gac.canonical.com>
Subject: [Bug 1866870] Re: KVM Guest pauses after upgrade to Ubuntu 20.04
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c6a1d1701fe32367ff2e82e11cbff88f0e2158aa
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

Starting from the Disco build env that I had I changed the packages

Step #1 binutils:
Unpacking binutils-x86-64-linux-gnu (2.33-2ubuntu1.2) over (2.32-7ubuntu4) =
...
Unpacking libbinutils:amd64 (2.33-2ubuntu1.2) over (2.32-7ubuntu4) ...
Unpacking binutils (2.33-2ubuntu1.2) over (2.32-7ubuntu4) ...
Unpacking binutils-common:amd64 (2.33-2ubuntu1.2) over (2.32-7ubuntu4) ...

=3D> Still working

Step #2 gcc:
Unpacking libubsan1:amd64 (9.2.1-9ubuntu2) over (9.1.0-2ubuntu2~19.04) ...
Unpacking libtsan0:amd64 (9.2.1-9ubuntu2) over (9.1.0-2ubuntu2~19.04) ...
Unpacking gcc-9-base:amd64 (9.2.1-9ubuntu2) over (9.1.0-2ubuntu2~19.04) ...
Unpacking libstdc++6:amd64 (9.2.1-9ubuntu2) over (9.1.0-2ubuntu2~19.04) ...
Unpacking libquadmath0:amd64 (9.2.1-9ubuntu2) over (9.1.0-2ubuntu2~19.04) .=
..
Unpacking liblsan0:amd64 (9.2.1-9ubuntu2) over (9.1.0-2ubuntu2~19.04) ...
Unpacking libitm1:amd64 (9.2.1-9ubuntu2) over (9.1.0-2ubuntu2~19.04) ...
Unpacking libgomp1:amd64 (9.2.1-9ubuntu2) over (9.1.0-2ubuntu2~19.04) ...
Unpacking libcc1-0:amd64 (9.2.1-9ubuntu2) over (9.1.0-2ubuntu2~19.04) ...
Unpacking libatomic1:amd64 (9.2.1-9ubuntu2) over (9.1.0-2ubuntu2~19.04) ...
Unpacking libasan5:amd64 (9.2.1-9ubuntu2) over (9.1.0-2ubuntu2~19.04) ...
Unpacking libgcc1:amd64 (1:9.2.1-9ubuntu2) over (1:9.1.0-2ubuntu2~19.04) ...
Unpacking libisl21:amd64 (0.21-2) ...
Unpacking cpp-9 (9.2.1-9ubuntu2) ...
Unpacking libgcc-9-dev:amd64 (9.2.1-9ubuntu2) ...
Unpacking gcc-9 (9.2.1-9ubuntu2) ...
Unpacking libstdc++-9-dev:amd64 (9.2.1-9ubuntu2) ...
Unpacking g++-9 (9.2.1-9ubuntu2) ...
Unpacking g++ (4:9.2.1-3.1ubuntu1) over (4:8.3.0-1ubuntu3) ...
Unpacking gcc (4:9.2.1-3.1ubuntu1) over (4:8.3.0-1ubuntu3) ...
Unpacking cpp (4:9.2.1-3.1ubuntu1) over (4:8.3.0-1ubuntu3) ...

=3D> now it is breaking

One thing that we have seen to cause breakage in other cases was the new de=
fault to enable:
  -fcf-protection

The code already carries quite a bunch of similar "no" rules:
COMMONCFLAGS +=3D $(call cc-option,$(CC),-nopie,)
COMMONCFLAGS +=3D $(call cc-option,$(CC),-fno-pie,)
COMMONCFLAGS +=3D $(call cc-option,$(CC),-fno-stack-protector,)
COMMONCFLAGS +=3D $(call cc-option,$(CC),-fno-stack-protector-all,)
COMMONCFLAGS +=3D $(call cc-option,$(CC),-fstack-check=3Dno,)
COMMONCFLAGS +=3D $(call cc-option,$(CC),-Wno-address-of-packed-member,)

Lets add to that:
COMMONCFLAGS +=3D $(call cc-option,$(CC),-fcf-protection=3Dnone,)

=3D> That made it work \o/ !

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

