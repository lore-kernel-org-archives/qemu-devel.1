Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706EAC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 07:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445FE20714
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 07:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445FE20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkMne-0004no-JA
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 03:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jkMn7-0004Mx-85
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 03:10:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:44380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jkMn4-0004Tm-SN
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 03:10:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jkMn2-0004wr-F7
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 07:10:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 670192E8105
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 07:10:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2020 07:01:34 -0000
From: felix <1860914@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: felix.von.s
X-Launchpad-Bug-Reporter: felix (felix.von.s)
X-Launchpad-Bug-Modifier: felix (felix.von.s)
References: <158004768486.19485.8886711795112517187.malonedeb@gac.canonical.com>
Message-Id: <159211809481.5557.12495482906058306543.malone@chaenomeles.canonical.com>
Subject: [Bug 1860914] Re: QEMU prepends pathnames to command lines of
 Multiboot kernels and modules, contrary to the specification
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b190cebbf563f89e480a8b57f641753c8196bda0";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 522c919741d67af5d4cf8e07b1a5e1c2971886f6
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 03:10:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1860914 <1860914@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Patch added: "cmdline.patch"
   https://bugs.launchpad.net/qemu/+bug/1860914/+attachment/5383658/+files/=
cmdline.patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1860914

Title:
  QEMU prepends pathnames to command lines of Multiboot kernels and
  modules, contrary to the specification

Status in QEMU:
  New

Bug description:
  When QEMU is launched with the -kernel option to boot a Multiboot
  image, the command line passed in the -append option is additionally
  prefixed the pathname of the kernel image and a space. Likewise,
  module command lines passed in the -initrd option are passed with the
  module pathname and a space prepended. At the very least the former is
  contary to what is prescribed in the Multiboot specification, version
  0.6.96[0], which says in =C2=A73.3:

  > General-purpose boot loaders should allow user a complete control on
  command line independently of other factors like image name.

  With respect to module command lines, the spec is less clear, but GNU
  GRUB2 (the de facto reference implementation) does not prepend
  pathnames to command lines of either. I haven't tested GRUB legacy,
  but I assume it exhibits the same behaviour. It would be strange if
  passing pathnames was in fact intended; bootloader pathnames are
  useless to the loaded kernel, which may potentially have a completely
  different view of the file system from the bootloader.

  Also, given that a kernel pathname may contain spaces, skipping it in
  the command line cannot be done reliably, while loading a Multiboot
  module from a pathname that contains spaces is outright impossible.

  Found in 4.2.0, but latest git master apparently behaves the same.

  [0]: https://www.gnu.org/software/grub/manual/multiboot/multiboot.html

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1860914/+subscriptions

