Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD0AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3131D2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3131D2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbJp0-0001zl-Ab
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jbJoP-0001MO-Kr
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:10:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:48498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jbJoO-000145-AP
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:10:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jbJoM-00023a-C6
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 08:10:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 52F312E8076
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 08:10:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2020 08:01:34 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1879646@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: i386
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <158996169456.22050.5633849401809444729.malonedeb@wampee.canonical.com>
Subject: [Bug 1879646] [NEW] [Feature request] x86: dump MSR features in human
 form
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0385b538081bc4718df6fb844a3afc89729c94ce";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 093ba1c351aef796375d6f7fd99facc122bd3ace
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 03:31:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1879646 <1879646@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

QEMU might fail because host/guest cpu features are not properly
configured:

qemu-system-x86_64: error: failed to set MSR 0x48f to 0x7fefff00036dfb
qemu-system-x86_64: /root/qemu-master/target/i386/kvm.c:2695:
kvm_buf_set_msrs: Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.

To ease debugging, it the MSR features bit could be dumped.

Example in this thread:

https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05593.html

  The high 32 bits are 0111 1111 1110 1111 1111 1111.

  The low 32 bits are  0000 0011 0110 1101 1111 1011.

  The features that are set are the xor, so 0111 1100 1000 0010 0000
0100:

  - bit 2, vmx-exit-nosave-debugctl
  - bit 9, host address space size, is handled automatically by QEMU
  - bit 15, vmx-exit-ack-intr
  - bit 17, vmx-exit-save-pat
  - bit 18, vmx-exit-load-pat
  - bit 19, vmx-exit-save-efer
  - bit 20, vmx-exit-load-efer
  - bit 21, vmx-exit-save-preemption-timer

This output ^^^ is easier to digest.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: i386

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1879646

Title:
  [Feature request] x86: dump MSR features in human form

Status in QEMU:
  New

Bug description:
  QEMU might fail because host/guest cpu features are not properly
  configured:

  qemu-system-x86_64: error: failed to set MSR 0x48f to 0x7fefff00036dfb
  qemu-system-x86_64: /root/qemu-master/target/i386/kvm.c:2695:
  kvm_buf_set_msrs: Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.

  To ease debugging, it the MSR features bit could be dumped.

  Example in this thread:

  https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05593.html

    The high 32 bits are 0111 1111 1110 1111 1111 1111.

    The low 32 bits are  0000 0011 0110 1101 1111 1011.

    The features that are set are the xor, so 0111 1100 1000 0010 0000
  0100:

    - bit 2, vmx-exit-nosave-debugctl
    - bit 9, host address space size, is handled automatically by QEMU
    - bit 15, vmx-exit-ack-intr
    - bit 17, vmx-exit-save-pat
    - bit 18, vmx-exit-load-pat
    - bit 19, vmx-exit-save-efer
    - bit 20, vmx-exit-load-efer
    - bit 21, vmx-exit-save-preemption-timer

  This output ^^^ is easier to digest.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1879646/+subscriptions

