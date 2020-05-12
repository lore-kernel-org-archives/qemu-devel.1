Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653FDC54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 05:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6AE20736
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 05:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6AE20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYNaO-00023E-BE
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 01:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYNZm-0001WM-Sk
 for qemu-devel@nongnu.org; Tue, 12 May 2020 01:35:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:51366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYNZl-00054W-QL
 for qemu-devel@nongnu.org; Tue, 12 May 2020 01:35:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jYNZj-00046y-Uz
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 05:35:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E66C12E8107
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 05:35:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2020 05:27:49 -0000
From: Thomas Huth <1844635@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public Security
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: yes
X-Launchpad-Bug-Commenters: guangming1100 th-huth
X-Launchpad-Bug-Reporter: guangming liu (guangming1100)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <156888216450.5144.14810121266968903921.malonedeb@chaenomeles.canonical.com>
Message-Id: <158926127020.5900.10563999453315283792.launchpad@soybean.canonical.com>
Subject: [Bug 1844635] Re: qemu bug where load linux kernel
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 94d088d35335049b19d976379e904fa8aa12342e
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:05:32
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
Reply-To: Bug 1844635 <1844635@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Information type changed from Private Security to Public Security

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1844635

Title:
  qemu bug where load linux kernel

Status in QEMU:
  Fix Released

Bug description:
  i found a qemu bug ,when the qemu start and parse the kernel file .

  This vulnerability can be exploited.

  thanks

  /****

  =

  (gdb) set args -nodefaults -device pc-testdev -device isa-debug-exit,ioba=
se=3D0xf4,iosize=3D0x4 -vnc none -serial stdio -device pci-testdev -machine=
 accel=3Dkvm -m 2048  -smp 2 -cpu host -machine kernel_irqchip=3Dsplit -ker=
nel poc1
  (gdb) r
  Starting program: /usr/bin/qemu-system-x86_64 -nodefaults -device pc-test=
dev -device isa-debug-exit,iobase=3D0xf4,iosize=3D0x4 -vnc none -serial std=
io -device pci-testdev -machine accel=3Dkvm -m 2048  -smp 2 -cpu host -mach=
ine kernel_irqchip=3Dsplit -kernel ./poc/poc1
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
  [New Thread 0x7fffe9a03700 (LWP 30066)]
  [New Thread 0x7fffe9202700 (LWP 30068)]
  [New Thread 0x7fffe8a01700 (LWP 30069)]

  Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
  __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-ve=
c-unaligned-erms.S:249
  249	../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S: No such fil=
e or directory.
  (gdb) bt
  #0  0x00007ffff2390b1f in __memmove_avx_unaligned_erms () at ../sysdeps/x=
86_64/multiarch/memmove-vec-unaligned-erms.S:249
  #1  0x00005555559ebdcf in rom_copy ()
  #2  0x00005555558dd1b3 in load_multiboot ()
  #3  0x00005555558de1c3 in  ()
  #4  0x00005555558e19d1 in pc_memory_init ()
  #5  0x00005555558e4ee3 in  ()
  #6  0x00005555559e8500 in machine_run_board_init ()
  #7  0x0000555555834959 in main ()
  (gdb) c
  Continuing.
  Couldn't get registers: No such process.
  Couldn't get registers: No such process.
  (gdb) [Thread 0x7fffe8a01700 (LWP 30069) exited]
  [Thread 0x7fffe9202700 (LWP 30068) exited]
  [Thread 0x7fffe9a03700 (LWP 30066) exited]

  Program terminated with signal SIGSEGV, Segmentation fault.
  The program no longer exists.

  ***/

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1844635/+subscriptions

