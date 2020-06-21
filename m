Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E928C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 11:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462CB22280
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 11:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462CB22280
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmyQc-0007Tq-H3
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 07:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jmyPq-00073K-Nj
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 07:45:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:45932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jmyPo-0002xl-Nc
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 07:45:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jmyPm-0001Dm-Qx
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 11:45:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C34552E80E7
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 11:45:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2020 11:38:19 -0000
From: Seal Sealy <1884425@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cutefatseal331
X-Launchpad-Bug-Reporter: Seal Sealy (cutefatseal331)
X-Launchpad-Bug-Modifier: Seal Sealy (cutefatseal331)
Message-Id: <159273949988.14781.1194342587449588493.malonedeb@wampee.canonical.com>
Subject: [Bug 1884425] [NEW] MIPS64EL emu hangs at reboot
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5f36e088018625c351a9be70b16309c6533167b3
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/21 07:45:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1884425 <1884425@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

QEMU Release version: 5.0.50 (v5.0.0-1411-g26bf4a2921-dirty)

Full command line: qemu-system-mips64el -hda nt4svr.qcow2 -M magnum -L .
-global ds1225y.filename=3Dnvram  -global ds1225y.size=3D8200 -net nic -net
user -cdrom en_winnt_4.0_svr.iso

Host machine: Windows 10 1909 64-bit, QEMU running under WSL with the
latest Kali distro and the latest Xming.

Guest machine: MIPS64EL Magnum machine, no OS needs to be installed to
reproduce - just change some stuff in the Setup program and try to exit

Note: Custom ROM with Windows NT support used, NTPROM.RAW used from
http://hpoussineau.free.fr/qemu/firmware/magnum-4000/setup.zip

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1884425

Title:
  MIPS64EL emu hangs at reboot

Status in QEMU:
  New

Bug description:
  QEMU Release version: 5.0.50 (v5.0.0-1411-g26bf4a2921-dirty)

  Full command line: qemu-system-mips64el -hda nt4svr.qcow2 -M magnum -L
  . -global ds1225y.filename=3Dnvram  -global ds1225y.size=3D8200 -net nic
  -net user -cdrom en_winnt_4.0_svr.iso

  Host machine: Windows 10 1909 64-bit, QEMU running under WSL with the
  latest Kali distro and the latest Xming.

  Guest machine: MIPS64EL Magnum machine, no OS needs to be installed to
  reproduce - just change some stuff in the Setup program and try to
  exit

  Note: Custom ROM with Windows NT support used, NTPROM.RAW used from
  http://hpoussineau.free.fr/qemu/firmware/magnum-4000/setup.zip

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1884425/+subscriptions

