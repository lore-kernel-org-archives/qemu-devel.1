Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A537C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 17:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2233620792
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 17:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2233620792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxwH2-0002KY-Fn
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 13:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jxwG5-0001ov-Em
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 13:40:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:49824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jxwG3-0000jq-De
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 13:40:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jxwG1-0006ye-Ei
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 17:40:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5D39F2E80EC
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 17:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2020 17:29:26 -0000
From: Jason <1888417@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: force-stop hangs nvidia pci reboot
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lightninjay
X-Launchpad-Bug-Reporter: Jason (lightninjay)
X-Launchpad-Bug-Modifier: Jason (lightninjay)
Message-Id: <159535256686.7592.12361820079263274205.malonedeb@wampee.canonical.com>
Subject: [Bug 1888417] [NEW] Latest QEMU git build on Arch linux causes PCI
 Passthrough host to hang on guest reboot.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 3fa82cc9717a66445bdab20a69eed8540461c4fe
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 13:40:49
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
Reply-To: Bug 1888417 <1888417@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Current Arch linux release, up-to-date as of 7/21/2020.

Running a windows 7 virtual machine (also happens with windows 10,
possibly more OSes), with an nvidia GTX 1060 passthrough, if the VM is
attempted to be restarted, either through the guest interface, or by
libvirt's gui interface "Virtual Machine Manager", it hangs in a
"paused" state once the VM shutsdown, and just before the reboot can
take place.  A force-stop of the VM allows the VM to be properly booted
without any disk error checks, alluding to a clean shutdown, but failed
reboot.  The VM can be properly shutdown using the guests shutdown
function, or the libvirt manager shutdown, without any hangs.  Reverting
to Arch stable build QEMU 5.0.0-7 fixes the issue.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: force-stop hangs nvidia pci reboot

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1888417

Title:
  Latest QEMU git build on Arch linux causes PCI Passthrough host to
  hang on guest reboot.

Status in QEMU:
  New

Bug description:
  Current Arch linux release, up-to-date as of 7/21/2020.

  Running a windows 7 virtual machine (also happens with windows 10,
  possibly more OSes), with an nvidia GTX 1060 passthrough, if the VM is
  attempted to be restarted, either through the guest interface, or by
  libvirt's gui interface "Virtual Machine Manager", it hangs in a
  "paused" state once the VM shutsdown, and just before the reboot can
  take place.  A force-stop of the VM allows the VM to be properly
  booted without any disk error checks, alluding to a clean shutdown,
  but failed reboot.  The VM can be properly shutdown using the guests
  shutdown function, or the libvirt manager shutdown, without any hangs.
  Reverting to Arch stable build QEMU 5.0.0-7 fixes the issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1888417/+subscriptions

