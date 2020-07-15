Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98236C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 06:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 672B82067D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 06:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672B82067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvbGY-0004aV-D5
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 02:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jvbFt-0004BW-ET
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 02:51:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:47238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jvbFr-0003Se-CP
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 02:51:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jvbFl-0001PR-6p
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 06:50:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 42F482E812E
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 06:50:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2020 06:36:22 -0000
From: Laurent Vivier <1886811@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=Laurent@vivier.eu; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=debian; sourcepackage=qemu; component=main;
 status=Confirmed; importance=Unknown; assignee=None; 
X-Launchpad-Bug-Tags: linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: emojifreak laurent-vivier
X-Launchpad-Bug-Reporter: Ryutaroh Matsumoto (emojifreak)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <159420830935.32230.13858618076699173558.malonedeb@gac.canonical.com>
Message-Id: <159479498312.12873.6504596310802927399.malone@gac.canonical.com>
Subject: [Bug 1886811] Re: systemd complains Failed to enqueue loopback
 interface start request: Operation not supported
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d2b2a02e6681624f2b31a7eb5642edafb2be750e
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:50:56
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
Reply-To: Bug 1886811 <1886811@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed here:

65b261a63a48 linux-user: add netlink RTM_SETLINK command
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D65b261a63a48fbb3b11193361=
d4ea0c38a3c3dfd

** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1886811

Title:
  systemd complains Failed to enqueue loopback interface start request:
  Operation not supported

Status in QEMU:
  Fix Committed
Status in qemu package in Ubuntu:
  New
Status in qemu package in Debian:
  Confirmed

Bug description:
  This symptom seems similar to
  https://bugs.launchpad.net/qemu/+bug/1823790

  Host Linux: Debian 11 Bullseye (testing) on x84-64 architecture
  qemu version: latest git of git commit hash eb2c66b10efd2b914b56b20ae9065=
5914310c925
  compiled with "./configure --static --disable-system" =


  Down stream bug report at https://bugs.debian.org/cgi-bin/bugreport.cgi?b=
ug=3D964289
  Bug report (closed) to systemd: https://github.com/systemd/systemd/issues=
/16359

  systemd in armhf and armel (both little endian 32-bit) containers fail to=
 start with
  Failed to enqueue loopback interface start request: Operation not support=
ed

  How to reproduce on Debian (and probably Ubuntu):
  mmdebstrap --components=3D"main contrib non-free" --architectures=3Darmhf=
 --variant=3Dimportant bullseye /var/lib/machines/armhf-bullseye
  systemd-nspawn -D /var/lib/machines/armhf-bullseye -b

  When "armhf" architecture is replaced with "mips" (32-bit big endian) or =
"ppc64"
  (64-bit big endian), the container starts up fine.

  The same symptom is also observed with "powerpc" (32-bit big endian)
  architecture.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1886811/+subscriptions

