Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95ACC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA0E208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA0E208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mpD-0005tk-1n
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mlL-0001IO-1h
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:46:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:36572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mlH-0002mS-4Q
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:45:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k8mlE-0007mo-QE
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:45:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C4E6A2E80F1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:45:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2020 15:40:10 -0000
From: Thomas Huth <1859310@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: joeyadams3-14159
X-Launchpad-Bug-Reporter: Joey Adams (joeyadams3-14159)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <157879657262.5123.4155249157481007374.malonedeb@gac.canonical.com>
Message-Id: <159793801108.1396.10766045204851000519.launchpad@wampee.canonical.com>
Subject: [Bug 1859310] Re: libvirt probing fails due to assertion failure with
 KVM and 'none' machine type
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: e8040aedc1d9fa900ef8e12f90209e3cc5f48fb6
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 10:50:55
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
Reply-To: Bug 1859310 <1859310@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859310

Title:
  libvirt probing fails due to assertion failure with KVM and 'none'
  machine type

Status in QEMU:
  Fix Released

Bug description:
  Using libvirt on Ubuntu 19.10, I get the following error when I try to
  set <emulator> to the latest qemu from git (commit dc65a5bdc9):

      error: internal error: Failed to start QEMU binary /usr/local/bin
  /qemu-system-x86_64 for probing:
  /home/joey/git/qemu/target/i386/kvm.c:2176:kvm_arch_init: Object
  0x564bfd5c3200 is not an instance of type x86-machine

  Qemu command line to reproduce:

      sudo x86_64-softmmu/qemu-system-x86_64 -machine 'none,accel=3Dkvm'

  Commit ed9e923c3c (Dec 12, 2019) introduced the issue by removing an
  object_dynamic_cast call.  In this scenario, kvm_arch_init is passed
  an instance of "none-machine" instead of "x86-machine".

  The following one-line change to target/i386/kvm.c reintroduces the
  cast:

       if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
  +        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
           x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
           smram_machine_done.notify =3D register_smram_listener;
           qemu_add_machine_init_done_notifier(&smram_machine_done);
       }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1859310/+subscriptions

