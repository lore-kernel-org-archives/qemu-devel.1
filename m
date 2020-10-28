Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EB9C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 23:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75460207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 23:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75460207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXuvF-0005IK-A2
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 19:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kXuuG-0004rV-5c
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 19:31:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:58808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kXuu8-0000tF-7p
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 19:31:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kXuu3-0006ZM-T4
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 23:30:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DA4022E8132
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 23:30:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2020 23:18:49 -0000
From: Toolybird <1897194@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: toolybird
X-Launchpad-Bug-Reporter: Toolybird (toolybird)
X-Launchpad-Bug-Modifier: Toolybird (toolybird)
References: <160099760002.12687.16674244939663721246.malonedeb@soybean.canonical.com>
Message-Id: <160392712965.8291.3574436073498985353.malone@soybean.canonical.com>
Subject: [Bug 1897194] Re: Test failure in test-crypto-secret.c
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="96ff31b88b65a0d0ea73b89333fe7c4a2669d8fb"; Instance="production"
X-Launchpad-Hash: f74a8d329728f24b46df28de3ec4df97c0e7b8e9
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 19:30:52
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
Reply-To: Bug 1897194 <1897194@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> systemd-nspawn containers don't have CAP_SYS_ADMIN

Above statement is utter bollocks. Please ignore..


I finally got to the bottom of all this and now have the test suite passing.

- don't use `--disable-keyring', it's busted

- systemd-nspawn containers need to be configured with additional
capabilities/syscalls (see below)

I noticed another test failing (postcopy-ram in tests/qtest/migration-
test.c). It needs access to munlockall which is covered by CAP_IPC_LOCK
capability.

Here is my .nspawn config needed to get the test suite passing inside a
systemd-nspawn container:

[Exec]
Capability=3DCAP_IPC_LOCK
SystemCallFilter=3Dadd_key keyctl

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1897194

Title:
  Test failure in test-crypto-secret.c

Status in QEMU:
  Invalid

Bug description:
  When running qemu test suite I'm seeing a test failure:

  ERROR:../qemu/tests/test-crypto-secret.c:144:test_secret_keyring_good:
  assertion failed: (key >=3D 0)

  Host is Arch Linux running in the standard Arch build environment
  (essentially an nspawn container).

  I first noticed this at release of 5.1.0 but it's still there on
  current trunk. For 5.1.0 I was able to sidestep the issue by building
  with `--disable-keyring' but this no longer works (I think due to
  9866a33cbb7046891dec3dcc9ca2015828673afe)

  Any clues on what might be the cause? Not sure how to debug.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1897194/+subscriptions

