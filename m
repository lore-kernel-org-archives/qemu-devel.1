Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2E1C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 09:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2389C206E7
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 09:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2389C206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEUrp-0007QU-17
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 05:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kEUqK-0005hl-PY
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 05:50:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:58076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kEUqI-0007nf-Lw
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 05:50:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kEUqG-0001tY-8u
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 09:50:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1F1232E8106
 for <qemu-devel@nongnu.org>; Sat,  5 Sep 2020 09:50:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2020 09:43:55 -0000
From: Thomas Huth <1715573@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: marc.2377 th-huth
X-Launchpad-Bug-Reporter: Marc Ranolfi (marc.2377)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <150476969887.8690.16755555210360995739.malonedeb@soybean.canonical.com>
Message-Id: <159929903684.18709.965321711930829362.launchpad@soybean.canonical.com>
Subject: [Bug 1715573] Re: Android-x86_64 guest - "Could not disable
 RealTimeClock events (20160831/evxfevnt-267)";
 UI sluggish, ACPI doesn't work with QEMU 2.10.0
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="90a5703803d95539bdb5c0b289b1675630569e1e"; Instance="production"
X-Launchpad-Hash: 51bb7e725e1d412f0dfa5a53e0eb40d8c2594502
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/05 03:50:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1715573 <1715573@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715573

Title:
  Android-x86_64 guest - "Could not disable RealTimeClock events
  (20160831/evxfevnt-267)"; UI sluggish, ACPI doesn't work with QEMU
  2.10.0

Status in QEMU:
  Fix Released

Bug description:
  I'm running a custom-built Android-x86_64 guest in an Arch Linux host
  with the 4.12.10 kernel.

  Following the latest Arch Linux upgrade to QEMU 2.10.0-1, upon booting
  the virtual machine, I get the error mentioned in the title.
  Afterwards, the virtual machine becomes slower and slower. The ACPI
  functions (the libvirt's Shutdown button, for example) don't work.

  When I downgrade to QEMU 2.9.0-3 everything works fine once again.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715573/+subscriptions

