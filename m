Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1ADC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 04:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C756A2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 04:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C756A2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtkca-00068B-4U
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 00:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jtkc2-0005gw-BG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 00:26:14 -0400
Received: from indium.canonical.com ([91.189.90.7]:53502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jtkc0-0001Xs-4z
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 00:26:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jtkbw-0000Vt-1B
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 04:26:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CC01A2E8124
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 04:26:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2020 04:17:26 -0000
From: Launchpad Bug Tracker <1877526@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: agpr123 janitor th-huth
X-Launchpad-Bug-Reporter: Prashant (agpr123)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <158892251663.4400.3590186641467240793.malonedeb@chaenomeles.canonical.com>
Message-Id: <159435464671.10725.7510666587256131622.malone@loganberry.canonical.com>
Subject: [Bug 1877526] Re: KVM internal crash
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5cd30eb0ae1a7f602545ccc5c1e17c1816b0a251
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:26:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1877526 <1877526@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1877526

Title:
  KVM internal crash

Status in QEMU:
  Expired

Bug description:
  Hi,
  I am new to this. (apologies if I miss something)

  I see the following error on my host mc when I run an application on
  my QEMU based VM running ubuntu linux:

  Code=3D4d 39 c8 7f 64 0f 1f 40 00 4d 8d 40 80 49 81 f8 80 00 00 00 <66> 0=
f 7f 07 66 0f 7f 47 10 66 0f 7f 47 20 66 0f 7f 47 30
  66 0f 7f 47 40 66 0f 7f 47 50 66
  KVM internal error. Suberror: 1
  emulation failure
  RAX=3D00007fffeb85a000 RBX=3D00000000069ee400 RCX=3D0000000000000000 RDX=
=3D0000000000000000
  RSI=3D0000000000000000 RDI=3D00007fffeb85a000 RBP=3D00007fffffff9570 RSP=
=3D00007fffffff9548
  R8 =3D0000000000000f80 R9 =3D0000000001000000 R10=3D0000000000000000 R11=
=3D0000003694e83f3a
  R12=3D0000000000000000 R13=3D0000000000000000 R14=3D0000000000000000 R15=
=3D0000000006b75350
  RIP=3D0000003694e8443b RFL=3D00010206 [-----P-] CPL=3D3 II=3D0 A20=3D1 SM=
M=3D0 HLT=3D0
  ES =3D0000 0000000000000000 ffffffff 00000000
  CS =3D0033 0000000000000000 ffffffff 00a0fb00 DPL=3D3 CS64 [-RA]
  SS =3D002b 0000000000000000 ffffffff 00c0f300 DPL=3D3 DS   [-WA]
  DS =3D0000 0000000000000000 ffffffff 00000000
  FS =3D0000 00007ffff45b5720 ffffffff 00000000
  GS =3D0000 0000000000000000 ffffffff 00000000
  LDT=3D0000 0000000000000000 ffffffff 00000000
  TR =3D0040 ffff88047fd13140 00002087 00008b00 DPL=3D0 TSS64-busy
  GDT=3D	 ffff88047fd04000 0000007f
  IDT=3D	 ffffffffff57c000 00000fff
  CR0=3D80050033 CR2=3D00007ffff7ff4000 CR3=3D000000046cb38000 CR4=3D000006=
e0
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000
  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
  EFER=3D0000000000000d01

  This occurs with qemu-kvm version(host m/c has RHEL 6.6) :
  Name        : qemu-kvm
  Arch        : x86_64
  Epoch       : 2
  Version     : 0.12.1.2
  Release     : 2.506.el6_10.7

  I have another m/c with RHEL 7.5, and the same test case passes with the =
1.5.3 version.
  yum info qemu-kvm
  Name        : qemu-kvm
  Arch        : x86_64
  Epoch       : 10
  Version     : 1.5.3

  How do I investigate this?
  I would need to patch up the qemu-kvm on the host to get this fixed, I th=
ink.

  Please let me know if I need to provide more info, (and what?)

  Regards,
  Prashant

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1877526/+subscriptions

