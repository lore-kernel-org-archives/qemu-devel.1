Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E0CC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6449C20BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6449C20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSc2E-00081P-7x
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 04:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kSc1b-0007bu-RL
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:20:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:49462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kSc1Y-0007QY-Hs
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:20:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kSc1W-00011B-O6
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:20:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B2FF62E80DE
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:20:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2020 08:14:34 -0000
From: Pavel Dovgalyuk <1899082@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: acceptance pc replay test x86
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cleber-gnu dovgalyuk
X-Launchpad-Bug-Reporter: Cleber Rosa (cleber-gnu)
X-Launchpad-Bug-Modifier: Pavel Dovgalyuk (dovgalyuk)
References: <160219062643.30310.16188463455229225461.malonedeb@gac.canonical.com>
Message-Id: <160266327475.31314.8318848512751822972.malone@wampee.canonical.com>
Subject: [Bug 1899082] Re: ReplayKernel.test_x86_64_pc fails intermittently
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="781851f4dc11c93bc506eb54e6a0d35c919a1ce6"; Instance="production"
X-Launchpad-Hash: fb63da7ca5d36a1ca59970692492c7095a25ae24
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 00:50:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1899082 <1899082@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I traced this bug to hw/char/serial.c/serial_ioport_read

Bug disappears when I add qemu_log("serial_ioport_read %x %x\n",
(int)addr, ret); into the end of this function.

I suppose that there is avocado (or socket) io synchronization problem,
because running the same test without avocado works normally.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1899082

Title:
  ReplayKernel.test_x86_64_pc fails intermittently

Status in QEMU:
  New

Bug description:
  Even though this acceptance test is already skipped on GitLab CI, the
  intermittent failures can be seen on other environments too.

  The record phase works fine, but during the replay phase fail to
  finish booting the kernel (until the expected place):

  16:34:47 DEBUG| [    0.034498] Last level dTLB entries: 4KB 0, 2MB 0, 4MB=
 0, 1GB 0
  16:34:47 DEBUG| [    0.034790] Spectre V2 : Spectre mitigation: LFENCE no=
t serializing, switching to generic retpoline
  16:34:47 DEBUG| [    0.035093] Spectre V2 : Mitigation: Full generic retp=
oline
  16:34:47 DEBUG| [    0.035347] Spectre V2 : Spectre v2 / SpectreRSB mitig=
ation: Filling RSB on context switch
  16:34:47 DEBUG| [    0.035667]
  16:36:02 ERROR| =

  16:36:02 ERROR| Reproduced traceback from: /home/cleber/src/avocado/avoca=
do/avocado/core/test.py:767
  16:36:02 ERROR| Traceback (most recent call last):
  16:36:02 ERROR|   File "/var/lib/users/cleber/build/qemu/tests/acceptance=
/replay_kernel.py", line 92, in test_x86_64_pc
  16:36:02 ERROR|     self.run_rr(kernel_path, kernel_command_line, console=
_pattern, shift=3D5)
  16:36:02 ERROR|   File "/var/lib/users/cleber/build/qemu/tests/acceptance=
/replay_kernel.py", line 73, in run_rr
  16:36:02 ERROR|     False, shift, args, replay_path)
  16:36:02 ERROR|   File "/var/lib/users/cleber/build/qemu/tests/acceptance=
/replay_kernel.py", line 55, in run_vm
  16:36:02 ERROR|     self.wait_for_console_pattern(console_pattern, vm)
  16:36:02 ERROR|   File "/var/lib/users/cleber/build/qemu/tests/acceptance=
/boot_linux_console.py", line 53, in wait_for_console_pattern
  16:36:02 ERROR|     vm=3Dvm)
  16:36:02 ERROR|   File "/var/lib/users/cleber/build/qemu/tests/acceptance=
/avocado_qemu/__init__.py", line 130, in wait_for_console_pattern
  16:36:02 ERROR|     _console_interaction(test, success_message, failure_m=
essage, None, vm=3Dvm)
  16:36:02 ERROR|   File "/var/lib/users/cleber/build/qemu/tests/acceptance=
/avocado_qemu/__init__.py", line 82, in _console_interaction
  16:36:02 ERROR|     msg =3D console.readline().strip()
  16:36:02 ERROR|   File "/usr/lib64/python3.7/socket.py", line 575, in rea=
dinto
  16:36:02 ERROR|     def readinto(self, b):
  16:36:02 ERROR|   File "/home/cleber/src/avocado/avocado/avocado/plugins/=
runner.py", line 77, in sigterm_handler
  16:36:02 ERROR|     raise RuntimeError("Test interrupted by SIGTERM")
  16:36:02 ERROR| RuntimeError: Test interrupted by SIGTERM
  16:36:02 ERROR| =


  On my workstation, I can replicate the failure roughly once every 50
  runs.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1899082/+subscriptions

