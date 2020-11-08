Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F24CC388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69841206ED
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69841206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbhHg-0005l5-IX
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 04:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbhGY-0004RS-Qo
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:45:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:57398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbhGX-0001mi-0V
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:45:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kbhGV-0000bY-Ny
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 09:45:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B12982E811E
 for <qemu-devel@nongnu.org>; Sun,  8 Nov 2020 09:45:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2020 09:39:43 -0000
From: Thomas Huth <1647683@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee julian-codesourcery pmaydell th-huth
X-Launchpad-Bug-Reporter: Julian Brown (julian-codesourcery)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20161206113915.26308.72810.malonedeb@wampee.canonical.com>
Message-Id: <160482838321.28971.7064663583943500801.malone@chaenomeles.canonical.com>
Subject: [Bug 1647683] Re: Bad interaction between tb flushing & gdb stub
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 267268f0d5e7c92840fb83cc583d88c782e7e886
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 04:10:58
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
Reply-To: Bug 1647683 <1647683@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix had been included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Da9353fe897ca2687e5b338

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1647683

Title:
  Bad interaction between tb flushing & gdb stub

Status in QEMU:
  Fix Released

Bug description:
  I have been working on a series of patches for ARM big-endian system
  mode support, using QEMU as a bare-metal simulator for the GDB test
  suite. At some point I realised that these tests were not running
  reliably on the QEMU master branch, even without my patches applied.
  (I.e., in little-endian mode.)

  Running QEMU under GDB in the test harness via Valgrind, using
  something akin to:

  (gdb) target remote | valgrind --tool=3Dmemcheck qemu-arm-system [...]

  leads to intermittent (and quite hard-to-reproduce) segfaults in QEMU
  of the form:

  =3D=3D52333=3D=3D Process terminating with default action of signal 11 (S=
IGSEGV)
  =3D=3D52333=3D=3D  Access not within mapped region at address 0x24
  =3D=3D52333=3D=3D    at 0x1D55F2: tb_page_remove (translate-all.c:1026)
  =3D=3D52333=3D=3D    by 0x1D58B4: tb_phys_invalidate (translate-all.c:111=
9)
  =3D=3D52333=3D=3D    by 0x1D63AA: tb_invalidate_phys_page_range (translat=
e-all.c:1519)
  =3D=3D52333=3D=3D    by 0x1D66D7: tb_invalidate_phys_addr (translate-all.=
c:1714)
  =3D=3D52333=3D=3D    by 0x1CBA7F: breakpoint_invalidate (exec.c:704)
  =3D=3D52333=3D=3D    by 0x1CC01F: cpu_breakpoint_remove_by_ref (exec.c:86=
9)
  =3D=3D52333=3D=3D    by 0x1CBF97: cpu_breakpoint_remove (exec.c:857)
  =3D=3D52333=3D=3D    by 0x218FAA: gdb_breakpoint_remove (gdbstub.c:717)
  =3D=3D52333=3D=3D    by 0x219E35: gdb_handle_packet (gdbstub.c:1035)
  =3D=3D52333=3D=3D    by 0x21AF62: gdb_read_byte (gdbstub.c:1459)
  =3D=3D52333=3D=3D    by 0x21B096: gdb_chr_receive (gdbstub.c:1672)
  =3D=3D52333=3D=3D    by 0x3AF2BC: qemu_chr_be_write_impl (qemu-char.c:419)

  These crashes didn't happen on a 2.6-era QEMU, so I bisected and
  discovered the commit 3359baad36889b83df40b637ed993a4b816c4906 ("tcg:
  Make tb_flush() thread safe") appears to be the thing that triggers
  this intermittent failure. Reverting the patch on the branch tip makes
  the crashes go away.

  Unfortunately I don't currently have a way to trigger the segfaults
  outside of Mentor Graphics's test infrastructure, which I can't share.

  Does anyone know a reason that this might be happening, or suggestions
  of how I might further debug this? Maybe a missed tb flush in the gdb
  stub code, somewhere?

  Thanks!

  Julian

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1647683/+subscriptions

