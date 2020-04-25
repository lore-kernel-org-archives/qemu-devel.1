Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D01C54FCB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 12:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C2320700
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 12:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C2320700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSJkQ-0004EQ-3C
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 08:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jSJj7-0003ac-LY
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 08:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jSJix-0001Rf-Fn
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 08:16:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:33040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jSJiw-00017d-Vy
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 08:15:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jSJiu-0005mE-Rs
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2020 12:15:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CF33D2E80E7
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2020 12:15:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2020 11:58:05 -0000
From: Juerg Haefliger <1875012@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=eoan; sourcepackage=qemu;
 component=main; status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=focal; sourcepackage=qemu; 
 component=main; status=New; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: juergh
X-Launchpad-Bug-Reporter: Juerg Haefliger (juergh)
X-Launchpad-Bug-Modifier: Juerg Haefliger (juergh)
Message-Id: <158781588544.26077.10592453455728808856.malonedeb@soybean.canonical.com>
Subject: [Bug 1875012] [NEW] KVM internal error. Suberror: 1 -- emulation
 failure
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="486bbbd6cb608f8eb468ed0d08689a349dfabe49";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ec6af8669dac22af16f8a4bdd5e7029731b17135
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 08:15:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1875012 <1875012@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Trying to boot a core20 amd64 image on an amd64 Eoan or Focal host via
libvirt leads to:

KVM internal error. Suberror: 1
emulation failure
RAX=3D0000000000000000 RBX=3D000000003bdcd5c0 RCX=3D000000003ff1d030 RDX=3D=
00000000000019a0
RSI=3D00000000000000ff RDI=3D000000003bd73ee0 RBP=3D000000003bd73e40 RSP=3D=
000000003ff1d1f8
R8 =3D000000003df52168 R9 =3D0000000000000000 R10=3Dffffffffffffffff R11=3D=
000000003bd44c40
R12=3D000000003bd76500 R13=3D000000003bd73e00 R14=3D0000000000020002 R15=3D=
000000003df4b483
RIP=3D00000000000b0000 RFL=3D00210246 [---Z-P-] CPL=3D0 II=3D0 A20=3D1 SMM=
=3D0 HLT=3D0
ES =3D0030 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
CS =3D0038 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
SS =3D0030 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
DS =3D0030 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
FS =3D0030 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
GS =3D0030 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
LDT=3D0000 0000000000000000 0000ffff 00008200 DPL=3D0 LDT
TR =3D0000 0000000000000000 0000ffff 00008b00 DPL=3D0 TSS64-busy
GDT=3D     000000003fbee698 00000047
IDT=3D     000000003f2d8018 00000fff
CR0=3D80010033 CR2=3D0000000000000000 CR3=3D000000003fc01000 CR4=3D00000668
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=3D=
0000000000000000 =

DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000d00
Code=3D00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <ff> ff =
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff ff ff

** Affects: qemu (Ubuntu)
     Importance: Undecided
         Status: New

** Affects: qemu (Ubuntu Eoan)
     Importance: Undecided
         Status: New

** Affects: qemu (Ubuntu Focal)
     Importance: Undecided
         Status: New

** Also affects: qemu (Ubuntu)
   Importance: Undecided
       Status: New

** No longer affects: qemu

** Also affects: qemu (Ubuntu Focal)
   Importance: Undecided
       Status: New

** Also affects: qemu (Ubuntu Eoan)
   Importance: Undecided
       Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1875012

Title:
  KVM internal error. Suberror: 1 -- emulation failure

Status in qemu package in Ubuntu:
  New
Status in qemu source package in Eoan:
  New
Status in qemu source package in Focal:
  New

Bug description:
  Trying to boot a core20 amd64 image on an amd64 Eoan or Focal host via
  libvirt leads to:

  KVM internal error. Suberror: 1
  emulation failure
  RAX=3D0000000000000000 RBX=3D000000003bdcd5c0 RCX=3D000000003ff1d030 RDX=
=3D00000000000019a0
  RSI=3D00000000000000ff RDI=3D000000003bd73ee0 RBP=3D000000003bd73e40 RSP=
=3D000000003ff1d1f8
  R8 =3D000000003df52168 R9 =3D0000000000000000 R10=3Dffffffffffffffff R11=
=3D000000003bd44c40
  R12=3D000000003bd76500 R13=3D000000003bd73e00 R14=3D0000000000020002 R15=
=3D000000003df4b483
  RIP=3D00000000000b0000 RFL=3D00210246 [---Z-P-] CPL=3D0 II=3D0 A20=3D1 SM=
M=3D0 HLT=3D0
  ES =3D0030 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
  CS =3D0038 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
  SS =3D0030 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
  DS =3D0030 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
  FS =3D0030 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
  GS =3D0030 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
  LDT=3D0000 0000000000000000 0000ffff 00008200 DPL=3D0 LDT
  TR =3D0000 0000000000000000 0000ffff 00008b00 DPL=3D0 TSS64-busy
  GDT=3D     000000003fbee698 00000047
  IDT=3D     000000003f2d8018 00000fff
  CR0=3D80010033 CR2=3D0000000000000000 CR3=3D000000003fc01000 CR4=3D000006=
68
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000 =

  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
  EFER=3D0000000000000d00
  Code=3D00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <ff> f=
f ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff ff ff

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1875012/+subscriptions

