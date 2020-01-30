Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9669CC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A529206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A529206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix7jX-0000as-Kf
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ix7ip-0008Al-2m
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ix7io-0003fU-1X
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:10:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:48320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ix7in-0003fE-Se
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:10:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ix7im-0001HV-Oz
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 11:10:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B8F712E8024
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 11:10:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jan 2020 10:57:59 -0000
From: Wojtek Lewandowski <1861394@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jurand0289
X-Launchpad-Bug-Reporter: Wojtek Lewandowski (jurand0289)
X-Launchpad-Bug-Modifier: Wojtek Lewandowski (jurand0289)
References: <158038104311.4545.16494729596486297372.malonedeb@soybean.canonical.com>
Message-Id: <158038187935.5055.5715094452594841397.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1861394] Re: qemu-system-riscv64 hangs after poweroff linux
 command
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b8d1327fd820d6bf500589d6da587d5037c7d88e";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9451f963e1eb69c8d705a08cae5d7e1a862860c9
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
Reply-To: Bug 1861394 <1861394@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Description changed:

  QEMU Version : v4.2.0-773-g43d1455-dirty (commit
  43d1455cf84283466e5c22a217db5ef4b8197b14)
  =

  Command: qemu-system-riscv64 -machine virt -kernel ./bbl -nographic
  -initrd rootfs.cpio.gz -append "root=3D/dev/ram console=3DttyS0"
  =

  Host:LSB Version:    :core-4.1-amd64:core-4.1-noarch
  Distributor ID: CentOS
  Description:    CentOS Linux release 7.7.1908 (Core)
  Release:        7.7.1908
  Codename:       Core
  =

- =

- Problem: after boot, when type poweroff -f it hangs (not quitting). I hav=
e tested this for x86_64, and aarch64 and it works fine. The problem appear=
s only for risv64(of those mentioned). Last time i have checked it worked a=
lso for riscv64 and it was on the d0f90e1423b4f412adc620eee93e8bfef8af4117 =
commit
+ Problem: after boot, when type poweroff -f it hangs (not quitting). I
+ have tested this for x86_64, and aarch64 and it works fine. The problem
+ appears only for risv64(of those mentioned). Last time I have checked,
+ it worked  for all the mentioned architectures. It was on the
+ d0f90e1423b4f412adc620eee93e8bfef8af4117 commit

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1861394

Title:
  qemu-system-riscv64 hangs after poweroff linux command

Status in QEMU:
  New

Bug description:
  QEMU Version : v4.2.0-773-g43d1455-dirty (commit
  43d1455cf84283466e5c22a217db5ef4b8197b14)

  Command: qemu-system-riscv64 -machine virt -kernel ./bbl -nographic
  -initrd rootfs.cpio.gz -append "root=3D/dev/ram console=3DttyS0"

  Host:LSB Version:    :core-4.1-amd64:core-4.1-noarch
  Distributor ID: CentOS
  Description:    CentOS Linux release 7.7.1908 (Core)
  Release:        7.7.1908
  Codename:       Core

  Problem: after boot, when type poweroff -f it hangs (not quitting). I
  have tested this for x86_64, and aarch64 and it works fine. The
  problem appears only for risv64(of those mentioned). Last time I have
  checked, it worked  for all the mentioned architectures. It was on the
  d0f90e1423b4f412adc620eee93e8bfef8af4117 commit

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1861394/+subscriptions

