Return-Path: <SRS0=tUBQ=3B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D5FC32771
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 03:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4542084D
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 03:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4542084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqU2H-0005OU-K4
	for qemu-devel@archiver.kernel.org; Sat, 11 Jan 2020 22:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iqTFz-0002Ct-Qo
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 21:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iqTFy-0002JV-C5
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 21:45:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:42980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iqTFy-00027x-4a
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 21:45:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iqTFv-00071Y-PL
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2020 02:45:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BC0592E806B
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2020 02:45:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jan 2020 02:36:12 -0000
From: Joey Adams <joeyadams3.14159@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: joeyadams3-14159
X-Launchpad-Bug-Reporter: Joey Adams (joeyadams3-14159)
X-Launchpad-Bug-Modifier: Joey Adams (joeyadams3-14159)
Message-Id: <157879657262.5123.4155249157481007374.malonedeb@gac.canonical.com>
Subject: [Bug 1859310] [NEW] libvirt probing fails due to assertion failure
 with KVM and 'none' machine type
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 7852d7551eb2af107a57027b88d828453de7610d
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Sat, 11 Jan 2020 22:34:49 -0500
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

Public bug reported:

Using libvirt on Ubuntu 19.10, I get the following error when I try to
set <emulator> to the latest qemu from git (commit dc65a5bdc9):

    error: internal error: Failed to start QEMU binary /usr/local/bin
/qemu-system-x86_64 for probing:
/home/joey/git/qemu/target/i386/kvm.c:2176:kvm_arch_init: Object
0x564bfd5c3200 is not an instance of type x86-machine

Qemu command line to reproduce:

    sudo x86_64-softmmu/qemu-system-x86_64 -machine 'none,accel=3Dkvm'

Commit ed9e923c3c (Dec 12, 2019) introduced the issue by removing an
object_dynamic_cast call.  In this scenario, kvm_arch_init is passed an
instance of "none-machine" instead of "x86-machine".

The following one-line change to target/i386/kvm.c reintroduces the
cast:

     if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
+        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
         x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
         smram_machine_done.notify =3D register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);
     }

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859310

Title:
  libvirt probing fails due to assertion failure with KVM and 'none'
  machine type

Status in QEMU:
  New

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

