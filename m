Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA9AC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF7C2068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF7C2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7YI-0007Si-DK
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kc7UV-00031O-IU
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:45:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:33878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kc7UT-0002qV-3s
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:45:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kc7UQ-0000es-Bd
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 13:45:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 565072E8042
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 13:45:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2020 13:36:34 -0000
From: Thomas Huth <1687578@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h jemmy858585
X-Launchpad-Bug-Reporter: Lidong Chen (jemmy858585)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20170502092542.26484.80835.malonedeb@chaenomeles.canonical.com>
Message-Id: <160492899493.17771.6670156126806528378.launchpad@soybean.canonical.com>
Subject: [Bug 1687578] Re: when migrate vm, reboot in guest os,
 the guest os sometime hang
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 35666eeea22eb080b330b59ac0263f6e3a1425b1
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:40:52
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
Reply-To: Bug 1687578 <1687578@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1687578

Title:
  when migrate vm, reboot in guest os, the guest os sometime hang

Status in QEMU:
  Incomplete

Bug description:
  qemu version:v2.9.0-rc5 release

  1.virsh migrate --live 165cf436-312f-47e7-90f2-f8aa63f34893 --copy-storag=
e-inc qemu+ssh://10.59.163.38/system
  2.run reboot in guest os, add reboot in /etc/rc.local
  3.guest os hang sometime.

  strace output of qemu:

  ppoll([{fd=3D9, events=3DPOLLIN}, {fd=3D8, events=3DPOLLIN}, {fd=3D4, eve=
nts=3DPOLLIN}, {fd=3D6, events=3DPOLLIN}, {fd=3D30, events=3DPOLLIN}, {fd=
=3D31, events=3DPOLLIN}], 6, {0, 0}, NULL, 8) =3D 0 (Timeout)
  ppoll([{fd=3D9, events=3DPOLLIN}, {fd=3D8, events=3DPOLLIN}, {fd=3D4, eve=
nts=3DPOLLIN}, {fd=3D6, events=3DPOLLIN}, {fd=3D30, events=3DPOLLIN}, {fd=
=3D31, events=3DPOLLIN}], 6, {0, 698000000}, NULL, 8) =3D 0 (Timeout)
  poll([{fd=3D20, events=3DPOLLOUT}], 1, 0)   =3D 1 ([{fd=3D20, revents=3DP=
OLLOUT|POLLHUP}])
  ppoll([{fd=3D9, events=3DPOLLIN}, {fd=3D8, events=3DPOLLIN}, {fd=3D4, eve=
nts=3DPOLLIN}, {fd=3D6, events=3DPOLLIN}, {fd=3D30, events=3DPOLLIN}, {fd=
=3D31, events=3DPOLLIN}], 6, {0, 999000000}, NULL, 8^C <unfinished ...>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1687578/+subscriptions

