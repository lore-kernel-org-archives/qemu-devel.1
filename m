Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B59C5517A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 05:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2221721707
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 05:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2221721707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV6H4-00040U-6D
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 01:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kV6F5-0002iF-1g
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 01:00:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:34740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kV6F2-0000Dn-6Z
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 01:00:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kV6Ez-0002tW-C4
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 05:00:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 57E8D2E80AB
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 05:00:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2020 04:51:44 -0000
From: Andrej Krutak <1856834@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: powerpc ppc softmmu virtio
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: andree182 ecsdn laurent-vivier
X-Launchpad-Bug-Reporter: ecsdn (ecsdn)
X-Launchpad-Bug-Modifier: Andrej Krutak (andree182)
References: <157666458990.14847.6716769636962803095.malonedeb@wampee.canonical.com>
Message-Id: <160325590462.26910.4506787046271023299.malone@wampee.canonical.com>
Subject: [Bug 1856834] Re: PCI broken in qemu ppc e500 in v2.12.0 and other
 versions
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="82ef3cb779698368c64f0c310863c3535f60eea0"; Instance="production"
X-Launchpad-Hash: 984371916144405a072c249bc2e545191fa8f4c4
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 01:00:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1856834 <1856834@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sorry, above I meant "virtio-blk freeze" (no virtio_rng). But in any
case it's obviously not directly related to this bug, so disregard it...
Sorry for the noise.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1856834

Title:
  PCI broken in qemu ppc e500 in v2.12.0 and other versions

Status in QEMU:
  New

Bug description:
  The same qemu -M mpc... command that works on qemu-system-ppc version
  2.8.0 freezes guest on bootup and shows error for qemu-system-ppc
  version 4.2.0release and 4.19dirtygit:

  qemu-system-ppc: virtio-blk failed to set guest notifier (-24), ensure -a=
ccel kvm is set.
  qemu-system-ppc: virtio_bus_start_ioeventfd: failed. Fallback to userspac=
e (slower).

  ends/freezes at:
  nbd: registered device at major 43
  =C2=A0vda:

  I'm using -drive file=3D/home/me/rawimage.dd,if=3Dvirtio and works fine in
  version 2.8.0 installed with apt-get install (Ubuntu 17.04) and also
  with 2.8.0 official release from git/github that I compiled/built
  myself. But both of the newer releases fail on the same exact machine
  same config.

  I also noticed that qemu-2.8.0 was fine with mtd but the newer ones I tri=
ed weren't, ie gave
  qemu-system-ppc: -drive if=3Dmtd: machine type does not support if=3Dmtd,=
bus=3D0,unit=3D0
  (but I removed -drive if=3Dmtd since wasn't using it anyway)

  I also tried on windows but I think virtio doesn't work on windows
  hosts at all? On windows host it fails the same way, even version 2.12
  as well as 4.1.10...

  used:
  ./configure --prefix=3D/opt/... --enable-fdt --enable-kvm --enable-debug

  (basically all steps the same on same exact system same config, yet
  2.8.0 works fine whether apt-get installed or built from source while
  the others I built, 4.19/4.2.0 or 2.12/4.1.10(win) don't.)

  In case newer qemu versions act weird on various kernels, I did try with =
both vmlinuz-4.10.0-19-generic and vmlinuz-4.13.12-041312-generic (I didn't=
 compile them but I can provide config-..files. This is on Ubuntu 17.04 x86=
_64 host emulating e500v2 cpm guest, ie -M mpc... GUEST kernel 2.6.32.44 wh=
ich is why I can't use -M ppce500 instead..)
  tx
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ecs

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1856834/+subscriptions

