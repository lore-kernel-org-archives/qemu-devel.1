Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264C5C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBE42084E
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBE42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jiH-0007Cc-6B
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j7jTL-0002Ww-Kj
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j7jTF-0006oP-Kt
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:30:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:58514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j7jTF-0006nB-EV
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:30:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j7jTE-0006Ko-0c
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 17:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 02B032E8073
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 17:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Feb 2020 17:24:09 -0000
From: Thierry Briot <1865188@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: tebounet
X-Launchpad-Bug-Reporter: Thierry Briot (tebounet)
X-Launchpad-Bug-Modifier: Thierry Briot (tebounet)
Message-Id: <158291064909.26276.9623855364402088462.malonedeb@gac.canonical.com>
Subject: [Bug 1865188] [NEW] Switching from the monitor to the emulated
 machine with a French keyboard (AZERTY)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 49c25f2c44a6de505df2f96de2bbea3a4e5c0b8e
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
Reply-To: Bug 1865188 <1865188@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hi,
I run qemu in an xterm terminal, with TERM=3Dvt100. My keyboard is french A=
ZERTY.

sudo ./qemu-system-hppa -monitor /dev/pts/2 -k fr  -boot d -drive
if=3Dscsi,bus=3D0,index=3D5,file=3D../../hpux_11iv1.img,format=3Draw -serial
mon:stdio -D qemu1.log -nographic -m 512 -d nochain -cdrom
../../distri/11iv1/'HP-UX_11iv1_B.11.11_TCOE_September_2005_1of4_Core_OS
_Install&Recovery_B6821-10046.iso' -net nic,model=3Dtulip  -net tap

When I want to use the monitor (to change cdrom during the hp-ux
installation process), the characters I type are misinterpreted. For
example, I enter "2" at hp-ux prompt, I see : "412691;82;22". Impossible
to switch from monitor to hp-ux with Ctrl+Alt+1 and Ctrl+Alt+2.

I tried with Debian and Fedora host, TERM=3Dxterm and TERM=3Dvt100, qemu op=
tions -alt-grab and -ctrl-grab, -monitor in the same terminal or an other t=
erminal than hp-ux. Nothing works.
Best regards.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1865188

Title:
  Switching from the monitor to the emulated machine with a French
  keyboard (AZERTY)

Status in QEMU:
  New

Bug description:
  Hi,
  I run qemu in an xterm terminal, with TERM=3Dvt100. My keyboard is french=
 AZERTY.

  sudo ./qemu-system-hppa -monitor /dev/pts/2 -k fr  -boot d -drive
  if=3Dscsi,bus=3D0,index=3D5,file=3D../../hpux_11iv1.img,format=3Draw -ser=
ial
  mon:stdio -D qemu1.log -nographic -m 512 -d nochain -cdrom
  ../../distri/11iv1/'HP-
  UX_11iv1_B.11.11_TCOE_September_2005_1of4_Core_OS
  _Install&Recovery_B6821-10046.iso' -net nic,model=3Dtulip  -net tap

  When I want to use the monitor (to change cdrom during the hp-ux
  installation process), the characters I type are misinterpreted. For
  example, I enter "2" at hp-ux prompt, I see : "412691;82;22".
  Impossible to switch from monitor to hp-ux with Ctrl+Alt+1 and
  Ctrl+Alt+2.

  I tried with Debian and Fedora host, TERM=3Dxterm and TERM=3Dvt100, qemu =
options -alt-grab and -ctrl-grab, -monitor in the same terminal or an other=
 terminal than hp-ux. Nothing works.
  Best regards.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1865188/+subscriptions

