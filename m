Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11338C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956B32186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956B32186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoUwg-00058M-ID
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33612)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hoUwV-0004jQ-Nz
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hoUwO-0001sh-53
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:37:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:48550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hoUwM-00013B-B5
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:36:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hoUuy-0001ks-28
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 15:35:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0B04B2E8079
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 15:35:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jul 2019 15:28:23 -0000
From: Alex <1829242@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h nevilad
X-Launchpad-Bug-Reporter: Alex (nevilad)
X-Launchpad-Bug-Modifier: Alex (nevilad)
References: <155792850856.14868.18260779757728395853.malonedeb@gac.canonical.com>
Message-Id: <156355010347.30608.1795745222291897418.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e57bd49970091941fab09b7f7dcb851d756b3c58
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1829242] Re: qemu on windows host exits after
 savevm command
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
Reply-To: Bug 1829242 <1829242@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running the operation under debugger catches this error:
Critical error detected c0000374
(2314.a54): Break instruction exception - code 80000003 (first chance)
ntdll!RtlIsNonEmptyDirectoryReparsePointAllowed+0x72:
00007ffe`0780b2d2 cc              int     3

This error means that a heap corruption was detected. To find the place whe=
re the corruption occured, I've ran qemu under appverifier, which is some k=
ind of ASAN\MSAN for windows.
The tool caught an access violation, the callstack seems to be not full, sa=
ve_snapshot calls qemu_savevm_state_iterate, then a call to ram_save_iterat=
e, then ram_find_and_save_block. But the address of the exception does not =
correspond to this function.
Disassembling qemu and searching for this address, I've found that it proba=
bly corresponds to this snippet in ram_save_host_page:
    do {
        /* Check the pages is dirty and if it is send it */
        if (!migration_bitmap_clear_dirty(rs, pss->block, pss->page)) {
            pss->page++;
            continue;
        }

The missing callstack part is probably ram_find_and_save_block calling ram_=
save_host_page at this place:
        if (found) {
            pages =3D ram_save_host_page(rs, &pss, last_stage);
        }

It seems that the compiler inlined several functions to ram_find_and_save_b=
lock and that is the reason for the partial stack.
Since I am still unable to see local variable values during debugging, I ca=
n't give more info now. =

I think the bug can be found when running qemu on linux with ASAN\MSAN. Whe=
n this does not find the bug, I do more debugging.
I want mention that the caught access violation is due to reading an invali=
d address. The bug found without appverifier is due to writing to an invali=
d address, so there may be several bugs.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1829242

Title:
  qemu on windows host exits after savevm command

Status in QEMU:
  New

Bug description:
  I'm running qemu-system-i386.exe 3.1.0 with this command line:
  "C:\Program Files\qemu\qemu-system-i386.exe"  -L C:\user\qemu\pc-bios\ -n=
ame win7 -m 4G -uuid 564db62e-e031-b5cf-5f34-a75f8cefa98e -rtc base=3Dlocal=
time -accel hax -hdd C:\VirtualMachines\Dev\Win10x64_VS17\swap.qcow "C:\Vir=
tualMachines\qemu\qemu_win7.qcow"
  Host OS Windows 10 x64, guest OS Wondows 7 x86.

  Wait till the OS loads, go to compat_monitor0 tab and enter command:
  savevm loaded_win
  After a few seconds qemu exits, running it another time and entering comm=
and:
  info snapshots
  says "There is no snapshot available". I've tried rinning it with -accel =
tcg, with same results. I've tried less memory (1G), same results.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1829242/+subscriptions

