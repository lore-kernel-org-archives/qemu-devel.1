Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786FAC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C545020663
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C545020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBYu-0006wI-QZ
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 13:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kcBUH-00011P-8K
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:01:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:51174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kcBUC-00089w-LF
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:01:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kcBUA-0001ay-L3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 18:01:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 315912E8143
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 18:01:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2020 17:49:40 -0000
From: Thomas Huth <1691379@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided;
 assignee=philmd@redhat.com; 
X-Launchpad-Bug-Tags: mips64el netbsd
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: uanand009-gmail
X-Launchpad-Bug-Reporter: Utkarsh Anand (uanand009-gmail)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <149500755798.25192.15465936284699398425.malonedeb@gac.canonical.com>
Message-Id: <160494418113.18639.14896967151044553279.launchpad@wampee.canonical.com>
Subject: [Bug 1691379] Re: NetBSD evbmips64el port installation doesn't work
 with qemu-system-mips64el.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 1b20bd9f7bacf6665033782e4a7da12835810430
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 11:16:03
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
Reply-To: Bug 1691379 <1691379@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
     Assignee: (unassigned) =3D> Philippe Mathieu-Daud=C3=A9 (philmd)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1691379

Title:
  NetBSD evbmips64el port installation doesn't work with qemu-system-
  mips64el.

Status in QEMU:
  New

Bug description:
  I successfully installed the NetBSD evbmips64el port on gxemul but was
  unable to install it on qemu. Trying to boot it on qemu takes me to
  the 'db>' prompt. Here's the output and backtrace:

  panic: pcib_isa_intr_string: bogus isa irq 0x0
  kernel: breakpoint trap
  Stopped in pid 0.1 (system) at  netbsd:cpu_Debugger+0x4:        jr      ra
                  bdslot: nop
  db> bt
  0xffffffff805977f0: cpu_Debugger+4 (63061,90000000180003f8,6,ffffffff804c=
2290) ra ffffffff8030acd0 sz 0
  0xffffffff805977f0: vpanic+158 (63061,90000000180003f8,6,ffffffff804c2290=
) ra ffffffff8030ad7c sz 64
  0xffffffff80597830: panic+34 (63061,ffffffff803d65b0,0,40) ra ffffffff801=
09784 sz 96
  0xffffffff80597890: pcib_isa_intr_string+6c (63061,ffffffff803d65b0,0,40)=
 ra ffffffff80149bfc sz 16
  0xffffffff805978a0: uhci_pci_attach+16c (63061,ffffffff803d65b0,0,40) ra =
ffffffff802f0400 sz 176
  0xffffffff80597950: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,40) r=
a ffffffff802f053c sz 64
  0xffffffff80597990: config_found_sm_loc+5c (63061,ffffffff803d65b0,0,40) =
ra ffffffff80121354 sz 64
  0xffffffff805979d0: pci_probe_device+524 (63061,ffffffff803d65b0,0,0) ra =
ffffffff80121548 sz 288
  0xffffffff80597af0: pci_enumerate_bus+1d0 (63061,ffffffff803d65b0,0,0) ra=
 ffffffff8012167c sz 160
  0xffffffff80597b90: pcirescan+5c (63061,ffffffff803d65b0,0,0) ra ffffffff=
801218c4 sz 32
  0xffffffff80597bb0: pciattach+19c (63061,ffffffff803d65b0,0,0) ra fffffff=
f802f0400 sz 80
  0xffffffff80597c00: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,0) ra=
 ffffffff802f053c sz 64
  0xffffffff80597c40: config_found_sm_loc+5c (63061,ffffffff803d65b0,0,0) r=
a ffffffff80108934 sz 64
  0xffffffff80597c80: gt_attach+7c (63061,ffffffff803d65b0,0,0) ra ffffffff=
802f0400 sz 112   =

  0xffffffff80597cf0: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,0) ra=
 ffffffff802f053c sz 64
  0xffffffff80597d30: config_found_sm_loc+5c (63061,ffffffff803d65b0,0,0) r=
a ffffffff801086ac sz 64
  0xffffffff80597d70: mainbus_attach+dc (63061,ffffffff803d65b0,0,0) ra fff=
fffff802f0400 sz 96
  0xffffffff80597dd0: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,0) ra=
 ffffffff80104bf8 sz 64
  0xffffffff80597e10: cpu_configure+28 (63061,ffffffff803d65b0,0,0) ra ffff=
ffff803d5f30 sz 16
  0xffffffff80597e20: main+3a0 (63061,ffffffff803d65b0,0,0) ra ffffffff8010=
00dc sz 128       =

  0xffffffff80597ea0: kernel_text+dc (63061,ffffffff803d65b0,0,0) ra 0 sz 0
  User-level: pid 0.1

  Here's the command that I used:

  Build evbmips64el from source and then launch it from qemu (replace
  the paths relative to your system):

  qemu-system-mips64el -cdrom
  /extra/evbmips64/distrib/evbmips/cdroms/installcd/NetBSD-7.99.71
  -evbmips-mips64el.iso -hda /extra/evbmips64.img -kernel
  /extra/evbmips64/releasedir/evbmips/installation/netbsd-
  INSTALL_MALTA64 -nographic -M malta

  (I've decompressed the kernel)

  Here's the output for qemu-system-mips64el --version :

  QEMU emulator version 2.7.1(qemu-2.7.1-6.fc25), Copyright (c)
  2003-2016 Fabrice Bellard and the QEMU Project developers

  This doesn't look like a NetBSD bug. I've attached a screenshot of the
  working installation using gxemul in the attachments.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1691379/+subscriptions

