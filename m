Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68214C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 05:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 357F7206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 05:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357F7206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbzoF-0005Zt-CM
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 01:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jbznh-0005A2-Qm
 for qemu-devel@nongnu.org; Fri, 22 May 2020 01:00:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:55602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jbznh-0007X1-0u
 for qemu-devel@nongnu.org; Fri, 22 May 2020 01:00:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jbznf-0002pF-D3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 05:00:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 611A12E806F
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 05:00:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2020 04:50:59 -0000
From: Thomas Huth <1878915@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: floppy io-uring
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: felix.von.s stefanha
X-Launchpad-Bug-Reporter: felix (felix.von.s)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <158954872808.31513.13433748579796760766.malonedeb@chaenomeles.canonical.com>
Message-Id: <159012305970.2100.14199326277292947871.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1878915] Re: util/fdmon-io_uring.c:95: get_sqe: Assertion `ret >
 1' failed.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 03cf36e69de2d3f2b9ba8688b90a5d352398b58d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 21:50:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Reply-To: Bug 1878915 <1878915@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878915

Title:
  util/fdmon-io_uring.c:95: get_sqe: Assertion `ret > 1' failed.

Status in QEMU:
  Fix Committed

Bug description:
  qemu 5.0.0, liburing1 0.6-3, Linux 5.6.0-1-686-pae (Debian)

  Stack trace:

  Stack trace of thread 31002:
  #0  0x00000000b7faf1cd __kernel_vsyscall (linux-gate.so.1 + 0x11cd)
  #1  0x00000000b6c618e2 __libc_signal_restore_set (libc.so.6 + 0x348e2)
  #2  0x00000000b6c4a309 __GI_abort (libc.so.6 + 0x1d309)
  #3  0x00000000b6c4a1d1 __assert_fail_base (libc.so.6 + 0x1d1d1)
  #4  0x00000000b6c59929 __GI___assert_fail (libc.so.6 + 0x2c929)
  #5  0x0000000000ba80be get_sqe (qemu-system-i386 + 0x6d00be)
  #6  0x0000000000ba80cb add_poll_add_sqe (qemu-system-i386 + 0x6d00cb)
  #7  0x0000000000ba820c fill_sq_ring (qemu-system-i386 + 0x6d020c)
  #8  0x0000000000ba7145 aio_poll (qemu-system-i386 + 0x6cf145)
  #9  0x0000000000aede63 blk_prw (qemu-system-i386 + 0x615e63)
  #10 0x0000000000aeef95 blk_pread (qemu-system-i386 + 0x616f95)
  #11 0x00000000008abbfa fdctrl_transfer_handler (qemu-system-i386 + 0x3d3b=
fa)
  #12 0x0000000000906c3d i8257_channel_run (qemu-system-i386 + 0x42ec3d)
  #13 0x00000000008ac119 fdctrl_start_transfer (qemu-system-i386 + 0x3d4119)
  #14 0x00000000008ab233 fdctrl_write_data (qemu-system-i386 + 0x3d3233)
  #15 0x0000000000708ae7 memory_region_write_accessor (qemu-system-i386 + 0=
x230ae7)
  #16 0x00000000007059e1 access_with_adjusted_size (qemu-system-i386 + 0x22=
d9e1)
  #17 0x000000000070b931 memory_region_dispatch_write (qemu-system-i386 + 0=
x233931)
  #18 0x00000000006a87a2 address_space_stb (qemu-system-i386 + 0x1d07a2)
  #19 0x0000000000829216 helper_outb (qemu-system-i386 + 0x351216)
  #20 0x00000000b06d9fdc n/a (n/a + 0x0)

  Steps:

  0. qemu-img create -f raw fda.img 3840K
  1. mformat -i fda.img -n 48 -t 80 -h 2
  2. qemu-system-i386 -fda fda.img -hda freedos.qcow2
  3. Attempt to run 'dosfsck a:' in the guest

  According to hw/block/fdc.c, a 3840K image should result in a virtual
  floppy with a geometry of 48 sectors/track x 80 tracks x 2 sides.

  The assert seems bogus either way.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878915/+subscriptions

