Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68239C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9F0208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9F0208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBxKT-00060g-Ek
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 05:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jBxJR-0004jR-5W
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jBxJP-0003RR-Ol
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:06:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:50142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jBxJP-0003R0-I7
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:05:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jBxJO-0008KF-Ej
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 09:05:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 671AE2E80CB
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 09:05:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Mar 2020 08:50:45 -0000
From: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF?= <1866870@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Incomplete; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: paelzer tstrike34
X-Launchpad-Bug-Reporter: tstrike (tstrike34)
X-Launchpad-Bug-Modifier: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer?=
 =?utf-8?q?=29?=
References: <158386023038.12575.5865810528923078550.malonedeb@soybean.canonical.com>
Message-Id: <158391664561.12393.1493673542331710592.malone@soybean.canonical.com>
Subject: [Bug 1866870] Re: KVM Guest pauses after upgrade to Ubuntu 20.04
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: bd7e9a835a5846a2bd060d423995688aee076630
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

I first checked the related known fixes from the old case that is linked.
Just in case if we might miss one in Ubuntu 20.04 that you are using.


Kernel:
=3D> https://marc.info/?l=3Dkvm&m=3D155085391830663&w=3D2
Tested and verified https://bugs.launchpad.net/qemu/+bug/1813165/comments/13
This got upstream and is in:
$ git describe --contains ad7dc69aeb231
v5.0-rc8~1^2~2
That we'd clearly have in Focal being on 5.4

qemu
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D9c1f8f4493e8355d0e48f7d1e=
ebdf86893ba082d
Other fixes related to the topic are in qemu 2.8

On seabios disabling of SMM
- https://bugzilla.redhat.com/show_bug.cgi?id=3D1378006
- https://bugzilla.redhat.com/show_bug.cgi?id=3D1464654#c21
The following is from >=3D1.12.0-1 (was enabled by default before)
There is a small (for old qemu) and large binary (new qemu):
 42 build/bios.bin:                                                        =
          =

 43 # A stripped-down version of bios, to fit in 128Kb, for qemu <=3D 1.7  =
            =

 44 =C2=BB=C2=B7=C2=B7=C2=B7$(call build-bios,bios,QEMU=3Dy ROM_SIZE=3D128 =
PVSCSI=3Dn BOOTSPLASH=3Dn XEN=3Dn USB_OHCI=3Dn USB_XHCI=3Dn USB_UAS=3Dn SDC=
ARD=3Dn TCGBIOS=3Dn MPT_SCSI=3Dn NVME=3Dn USE_SMM=3Dn VGAHOOKS=3Dn)
 45 build/bios-256k.bin:                                                   =
          =

 46 =C2=BB=C2=B7=C2=B7=C2=B7$(call build-bios,bios,QEMU=3Dy ROM_SIZE=3D256)

Note: if we are out of options we could try testing to set USE_SMM=3Dn
here, but lets check other details first.

But as already explained on the linked bug 1813165:
"If you're seeing "KVM internal error. Suberror: 1" it can be multiple thin=
gs, not necessarily the same bug."

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

