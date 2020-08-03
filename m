Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4705C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 01:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58CA2070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 01:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58CA2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2PYf-0004Yl-Eb
	for qemu-devel@archiver.kernel.org; Sun, 02 Aug 2020 21:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2PXy-000476-JH
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 21:45:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:45904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2PXw-0001bw-PL
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 21:45:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k2PXu-0001gd-2A
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 01:45:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0F3372E80DB
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 01:45:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2020 01:37:23 -0000
From: =?utf-8?q?Skyler_M=C3=A4ntysaari?= <1890069@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: samip537
X-Launchpad-Bug-Reporter: =?utf-8?q?Skyler_M=C3=A4ntysaari_=28samip537=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Skyler_M=C3=A4ntysaari_=28samip537=29?=
Message-Id: <159641864326.4737.3834879940434032325.malonedeb@soybean.canonical.com>
Subject: [Bug 1890069] [NEW] QEMU is not allowing multiple cores with mips
 architecture
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: fd93487df980d76ff2bf60d70b35e2f8e18f4010
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/02 21:38:14
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
Reply-To: Bug 1890069 <1890069@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I may have found a bug as when trying to boot up an QEMU VM with the
following command: "qemu-system-mips -M malta -m 512 -hda hda.img
-kernel vmlinux-4.19.0-10-4kc-malta -initrd initrd.img-4.19.0-10-4kc-
malta -append "root=3D/dev/sda1 console=3DttyS0" -nographic -device
e1000,netdev=3Duser.0 -netdev user,id=3Duser.0,hostfwd=3Dtcp::5555-:22 -smp
cores=3D12,threads=3D1,sockets=3D1", it will use up all of the CPU cores on
the host, but not bootup?

Kernel log also shows:
[  100.303136] perf: interrupt took too long (2506 > 2500), lowering kernel=
.perf_event_max_sample_rate to 79750
[  107.656869] perf: interrupt took too long (3195 > 3132), lowering kernel=
.perf_event_max_sample_rate to 62500
[  117.668390] perf: interrupt took too long (4033 > 3993), lowering kernel=
.perf_event_max_sample_rate to 49500
[  217.166763] perf: interrupt took too long (5126 > 5041), lowering kernel=
.perf_event_max_sample_rate to 39000
[  231.910132] perf: interrupt took too long (6445 > 6407), lowering kernel=
.perf_event_max_sample_rate to 31000
[  250.170677] perf: interrupt took too long (8087 > 8056), lowering kernel=
.perf_event_max_sample_rate to 24500
[  285.391451] perf: interrupt took too long (10126 > 10108), lowering kern=
el.perf_event_max_sample_rate to 19750
[  778.588911] perf: interrupt took too long (12770 > 12657), lowering kern=
el.perf_event_max_sample_rate to 15500
[ 1554.825129] perf: interrupt took too long (15982 > 15962), lowering kern=
el.perf_event_max_sample_rate to 12500
[ 1622.838910] hrtimer: interrupt took 14758063 ns
[ 1712.932777] INFO: NMI handler (perf_event_nmi_handler) took too long to =
run: 0.000 msecs
[ 1712.932780] perf: interrupt took too long (59793 > 19977), lowering kern=
el.perf_event_max_sample_rate to 3250


System details:

OS: Ubuntu 20.04
QEMU emulator version 4.2.0 (Debian 1:4.2-3ubuntu6.3)

** Affects: qemu (Ubuntu)
     Importance: Undecided
         Status: New

** Project changed: launchpad =3D> qemu

** Project changed: qemu =3D> qemu (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1890069

Title:
  QEMU is not allowing multiple cores with mips architecture

Status in qemu package in Ubuntu:
  New

Bug description:
  I may have found a bug as when trying to boot up an QEMU VM with the
  following command: "qemu-system-mips -M malta -m 512 -hda hda.img
  -kernel vmlinux-4.19.0-10-4kc-malta -initrd initrd.img-4.19.0-10-4kc-
  malta -append "root=3D/dev/sda1 console=3DttyS0" -nographic -device
  e1000,netdev=3Duser.0 -netdev user,id=3Duser.0,hostfwd=3Dtcp::5555-:22 -s=
mp
  cores=3D12,threads=3D1,sockets=3D1", it will use up all of the CPU cores =
on
  the host, but not bootup?

  Kernel log also shows:
  [  100.303136] perf: interrupt took too long (2506 > 2500), lowering kern=
el.perf_event_max_sample_rate to 79750
  [  107.656869] perf: interrupt took too long (3195 > 3132), lowering kern=
el.perf_event_max_sample_rate to 62500
  [  117.668390] perf: interrupt took too long (4033 > 3993), lowering kern=
el.perf_event_max_sample_rate to 49500
  [  217.166763] perf: interrupt took too long (5126 > 5041), lowering kern=
el.perf_event_max_sample_rate to 39000
  [  231.910132] perf: interrupt took too long (6445 > 6407), lowering kern=
el.perf_event_max_sample_rate to 31000
  [  250.170677] perf: interrupt took too long (8087 > 8056), lowering kern=
el.perf_event_max_sample_rate to 24500
  [  285.391451] perf: interrupt took too long (10126 > 10108), lowering ke=
rnel.perf_event_max_sample_rate to 19750
  [  778.588911] perf: interrupt took too long (12770 > 12657), lowering ke=
rnel.perf_event_max_sample_rate to 15500
  [ 1554.825129] perf: interrupt took too long (15982 > 15962), lowering ke=
rnel.perf_event_max_sample_rate to 12500
  [ 1622.838910] hrtimer: interrupt took 14758063 ns
  [ 1712.932777] INFO: NMI handler (perf_event_nmi_handler) took too long t=
o run: 0.000 msecs
  [ 1712.932780] perf: interrupt took too long (59793 > 19977), lowering ke=
rnel.perf_event_max_sample_rate to 3250

  =

  System details:

  OS: Ubuntu 20.04
  QEMU emulator version 4.2.0 (Debian 1:4.2-3ubuntu6.3)

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1890069/+subscriptions

