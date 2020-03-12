Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F34C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF24020674
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF24020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCPbl-0003Nb-2d
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 11:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jCPYk-0006GO-DW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jCPYh-0001O2-VS
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:15:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:37470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jCPYh-0001Mh-Ot
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:15:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jCPYg-00058i-NS
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 15:15:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B03E62E80C7
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 15:15:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Mar 2020 15:08:24 -0000
From: Andreas Hasenack <andreas@canonical.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Incomplete; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ahasenack dbaxps0220 paelzer tstrike34
X-Launchpad-Bug-Reporter: tstrike (tstrike34)
X-Launchpad-Bug-Modifier: Andreas Hasenack (ahasenack)
References: <158386023038.12575.5865810528923078550.malonedeb@soybean.canonical.com>
Message-Id: <158402570490.10911.16893017657926766440.malone@soybean.canonical.com>
Subject: [Bug 1866870] Re: KVM Guest pauses after upgrade to Ubuntu 20.04
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6db16abb2587bbffd6d4e0bfa6974cbee18d353c
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

After changing cpu to <cpu mode=3D'host-model'/>:


I got this log (still in a paused state):
char device redirected to /dev/pts/3 (label charserial0)
2020-03-12T15:06:22.560159Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(48EH).vmx-vnmi-pending [bit 22]
2020-03-12T15:06:22.560708Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(48EH).vmx-secondary-ctls [bit 31]
2020-03-12T15:06:22.560971Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(48BH).vmx-apicv-xapic [bit 0]
2020-03-12T15:06:22.561208Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(48DH).vmx-vnmi [bit 5]
2020-03-12T15:06:22.561392Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(480H).vmx-ins-outs [bit 54]
KVM internal error. Suberror: 1
emulation failure
EAX=3D00000000 EBX=3D00000000 ECX=3D000086d4 EDX=3D00000000
ESI=3D00000000 EDI=3D00000000 EBP=3D000086d4 ESP=3D00006d7c
EIP=3D00007acf EFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HLT=
=3D0
ES =3D0000 00000000 ffffffff 00809300
CS =3Df000 000f0000 ffffffff 00809b00
SS =3D0000 00000000 ffffffff 00809300
DS =3D0000 00000000 ffffffff 00809300
FS =3D0000 00000000 ffffffff 00809300
GS =3D0000 00000000 ffffffff 00809300
LDT=3D0000 00000000 0000ffff 00008200
TR =3D0000 00000000 0000ffff 00008b00
GDT=3D     000f6200 00000037
IDT=3D     00000000 000003ff
CR0=3D00000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=3D=
0000000000000000 =

DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000000
Code=3Db8 90 d9 00 00 66 e8 6b f7 ff ff 66 b8 0a 00 00 00 e9 61 f2 <f3> 0f =
1e fb 66 57 66 56 66 53 66 53 66 89 c7 67 66 89 14 24 66 89 ce 66 e8 15 f8 =
ff ff 88

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

