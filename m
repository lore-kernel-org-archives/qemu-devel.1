Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6FCC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718A220790
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718A220790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX29L-0001ay-9Z
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kX27U-0000o7-0S
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:01:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:58158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kX27P-0002NV-Lj
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:01:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kX27N-0005mR-Jf
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:00:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 89C252E8134
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:00:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2020 12:45:57 -0000
From: Thomas Huth <1901440@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: player-001 th-huth
X-Launchpad-Bug-Reporter: Dave G (player-001)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <160365777400.12451.12378376347775649238.malonedeb@soybean.canonical.com>
Message-Id: <160371635750.30384.277782006879559371.malone@gac.canonical.com>
Subject: [Bug 1901440] Re: Instability in IVSHMEM after updating QEMU 4.2 ->
 5.0
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bc5a16cfdc4ba776ecdf84a052201ef8fb1f3321"; Instance="production"
X-Launchpad-Hash: e9f61fdaea9d824e6f069a976b98e7dbfaf61d1f
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 04:15:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1901440 <1901440@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ok, so I'm moving this to the Ubuntu bug tracker.

** Project changed: qemu =3D> qemu (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1901440

Title:
  Instability in IVSHMEM after updating QEMU 4.2 -> 5.0

Status in qemu package in Ubuntu:
  New

Bug description:
  Updating Ubuntu from 20.08 to 20.10 which updates QEMU from 4.2 to 5.0
  results in the virtual machines freezing when the IVSHMEM interface is
  active.  This workstation typically runs several windows 10 virtual
  machines that are accessed locally:  two using the spice viewer and
  one that uses an passthrough assigned GPU accessed through a viewer
  called Looking Glass.  Looking Glass uses the IVSHMEM device interface
  to pass captured frames from the windows virtual machine to the linux
  host for display by a viewer application.

  This workstation was 100% stable under Ubuntu 20.08 (QEMU 4.2).  It
  handled a variety of heavy loads all day it never froze or crashed.
  It became unstable under Ubuntu 20.10 (QEMU 5.0), seemingly triggered
  by high levels of SHM activity.  I was able to reliably reproduce the
  problem when playing a video in the looking-glass vm while playing
  another video in a spice vm.  Other scenarios would also trigger this
  problem less reliably, but this video playback scenario would trigger
  it after 3-5 minutes of playback.

  The result of this new instability would manifest itself by all
  running vms on the host freezing but the host was not visibly
  effected.  I could find no warnings or errors in any relevant system
  or QEMU logs.  It wasn't just spice, when I accessed the gpu-passthru
  vm via directly assigned devices it was frozen, still outputting video
  of the last frame before the crash.  All vms would have to be force-
  shutdown and the host rebooted to regain vm functionality.  Just
  forcing shutdown and restarting a vm would result in showing 'running'
  status but it would be frozen and inaccessible until system reboot.

  I suspect this is a QEMU host / kernel error for several reasons:
  Having to reboot the host, insensitivity to VM changes including
  virtio-win version, etc.  I suspect it's related to IVSHMEM due to the
  correlation of the freeze to the looking-glass related activity.

  This might be kernel / PCIe / power management related in some way.
  While experimenting to troubleshoot this issue I was able to trigger
  the error more quickly by disabling PCIe power management in the BIOS.

  The system was 100% stable under QEMU 5.0 when not running the
  looking-glass vm, quite stable when the looking-glass vm was idle or
  lightly used, but appeared increasingly unstable as SHM activity
  increased.

  Sorry if this is a bit anecdotal, this is my work machine and
  unfortunately today I was forced to rollback restore to Ubuntu 20.08
  (QEMU 4.2) from backup so I can work on Monday.  The system returned
  to 100% stability after returning to 20.08.

  If requested I can restore the Ubuntu 20.10 snapshot to reproduce &
  gather information as directed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1901440/+subscriptions

