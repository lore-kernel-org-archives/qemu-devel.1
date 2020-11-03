Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5A0C388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC1952080D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1952080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka27U-00068P-Pk
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 14:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1ka25e-0005GP-Kn
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 14:35:36 -0500
Received: from indium.canonical.com ([91.189.90.7]:35916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1ka25b-0007ba-7D
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 14:35:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ka25Y-0002vr-Vo
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 19:35:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EEE2C2E811E
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 19:35:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2020 19:26:01 -0000
From: Rui Prior <1902777@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: vmx whpx
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: rcprior
X-Launchpad-Bug-Reporter: Rui Prior (rcprior)
X-Launchpad-Bug-Modifier: Rui Prior (rcprior)
References: <160443143159.15248.310211538041972922.malonedeb@wampee.canonical.com>
Message-Id: <160443156142.8671.14782499734113352488.malone@soybean.canonical.com>
Subject: [Bug 1902777] Re: qemu with whpx acceleration crashes with vmx=on
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="96ff31b88b65a0d0ea73b89333fe7c4a2669d8fb"; Instance="production"
X-Launchpad-Hash: d590f4a3fead28d3d66f04d02bba8debfc383871
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 14:35:28
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
Reply-To: Bug 1902777 <1902777@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Forgot to say: qemu version 5.1.0

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1902777

Title:
  qemu with whpx acceleration crashes with vmx=3Don

Status in QEMU:
  New

Bug description:
  Under Windows 10, qemu crashes when using whpx acceleration and the vmx=
=3Don option.  The reported error is
    qemu-system-x86_64.exe: WHPX: Unexpected VP exit code 4
  Before the error, it reports
    Windows Hypervisor Platform accelerator is operational

  The command line is the following:
    "C:\Program Files\qemu\qemu-system-x86_64.exe" -accel whpx -cpu qemu64,=
vmx=3Don
  It crashes with any model of CPU as long as the "vmx=3Don" option is adde=
d.  Without this option it runs fine (but no nested virtualization).

  My processor is an Intel i7-10510U, and I am running Windows 10 2004
  (build 19041.572).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1902777/+subscriptions

