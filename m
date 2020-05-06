Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6E7C47256
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B0D21582
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B0D21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWLw8-0001GR-N0
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 11:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jWLva-0000rD-BU
 for qemu-devel@nongnu.org; Wed, 06 May 2020 11:25:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:38490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jWLvY-0002Yu-Tg
 for qemu-devel@nongnu.org; Wed, 06 May 2020 11:25:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jWLvW-0001uv-62
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 15:25:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 246112E8107
 for <qemu-devel@nongnu.org>; Wed,  6 May 2020 15:25:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2020 15:14:02 -0000
From: Matthew <1877136@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: matmal01
X-Launchpad-Bug-Reporter: Matthew (matmal01)
X-Launchpad-Bug-Modifier: Matthew (matmal01)
Message-Id: <158877804267.5105.15160019007007013161.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1877136] [NEW] Qemu GDB Arm core registers XML description not
 valid for M-profile
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 7d6518587c3ccb091cc493a9dcb10f11a2ea129e
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 08:46:02
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
Reply-To: Bug 1877136 <1877136@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

When trying to debug an armv7-m binary running on Qemu, GDB makes some
mistakes due to mistakenly believing the target is not M-profile.

One observable is that backtraces over signal handlers are not handled
correctly -- since the special M-profile EXC_RETURN value is not
recognised.  That happens because GDB doesn't think the target is
M-profile.

This happens because GDB sees a reported feature set from the Qemu
remote connection that includes the feature `org.gnu.gdb.arm.core`.

As described in the GDB online docs, for "M-profile targets (e.g. Cortex-M3=
), the =E2=80=98org.gnu.gdb.arm.core=E2=80=99 feature is replaced by =E2=80=
=98org.gnu.gdb.arm.m-profile=E2=80=99"
https://sourceware.org/gdb/current/onlinedocs/gdb/ARM-Features.html

>From a scan of the Qemu source code on commit
ea1329bb3a8d5cd25b70e3dbf73e7ded4d5ad756 it seems that when emulating an
arm core it uses `arm-core.xml` unconditionally for
`CPUClass->gdb_core_xml_file`, and that means the only feature provided
is `org.gnu.gdb.arm.core`.

Note that even though there is a command to set the architecture in GDB, se=
tting the target architecture to an M-profile core is still not a valid wor=
karound.
This is because the target description overrides everything in setting the =
`is_m` attribute within GDB.

Reproduction of the observable:
Using the examples here https://git.linaro.org/people/peter.maydell/m-profi=
le-tests.git/tree/ .
Build the examples, and run =

```
qemu-system-arm -s -S -no-reboot -M lm3s6965evb -m 16 -serial stdio -displa=
y none -net nic -net user,restrict=3Don -d guest_errors,unimp -kernel test3=
-kern.bin
```

Then in a GDB session
```
vshcmd: > arm-none-eabi-gdb -q                                             =
                                                                           =
                                            =

(gdb)
vshcmd: > file test3-kern.elf
Reading symbols from test3-kern.elf...
(gdb)
vshcmd: > target remote localhost:1234
Remote debugging using localhost:1234
_start () at init-m.S:53
53        mov r0, #0
(gdb)
vshcmd: > show architecture
The target architecture is set automatically (currently armv7)
(gdb)
vshcmd: > break svc
Breakpoint 1 at 0x6fc: svc. (2 locations)
(gdb)
vshcmd: > cont
Continuing.

Breakpoint 1, svc () at test3.c:16
16          int test =3D SEQ();
(gdb)
vshcmd: > bt
#0  svc () at test3.c:16
#1  0xfffffff8 in ?? ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb)
vshcmd: > print/x $lr
$1 =3D 0xfffffff9
(gdb)
```

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: arm

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1877136

Title:
  Qemu GDB Arm core registers XML description not valid for M-profile

Status in QEMU:
  New

Bug description:
  When trying to debug an armv7-m binary running on Qemu, GDB makes some
  mistakes due to mistakenly believing the target is not M-profile.

  One observable is that backtraces over signal handlers are not handled
  correctly -- since the special M-profile EXC_RETURN value is not
  recognised.  That happens because GDB doesn't think the target is
  M-profile.

  This happens because GDB sees a reported feature set from the Qemu
  remote connection that includes the feature `org.gnu.gdb.arm.core`.

  As described in the GDB online docs, for "M-profile targets (e.g. Cortex-=
M3), the =E2=80=98org.gnu.gdb.arm.core=E2=80=99 feature is replaced by =E2=
=80=98org.gnu.gdb.arm.m-profile=E2=80=99"
  https://sourceware.org/gdb/current/onlinedocs/gdb/ARM-Features.html

  From a scan of the Qemu source code on commit
  ea1329bb3a8d5cd25b70e3dbf73e7ded4d5ad756 it seems that when emulating
  an arm core it uses `arm-core.xml` unconditionally for
  `CPUClass->gdb_core_xml_file`, and that means the only feature
  provided is `org.gnu.gdb.arm.core`.

  Note that even though there is a command to set the architecture in GDB, =
setting the target architecture to an M-profile core is still not a valid w=
orkaround.
  This is because the target description overrides everything in setting th=
e `is_m` attribute within GDB.

  Reproduction of the observable:
  Using the examples here https://git.linaro.org/people/peter.maydell/m-pro=
file-tests.git/tree/ .
  Build the examples, and run =

  ```
  qemu-system-arm -s -S -no-reboot -M lm3s6965evb -m 16 -serial stdio -disp=
lay none -net nic -net user,restrict=3Don -d guest_errors,unimp -kernel tes=
t3-kern.bin
  ```

  Then in a GDB session
  ```
  vshcmd: > arm-none-eabi-gdb -q                                           =
                                                                           =
                                              =

  (gdb)
  vshcmd: > file test3-kern.elf
  Reading symbols from test3-kern.elf...
  (gdb)
  vshcmd: > target remote localhost:1234
  Remote debugging using localhost:1234
  _start () at init-m.S:53
  53        mov r0, #0
  (gdb)
  vshcmd: > show architecture
  The target architecture is set automatically (currently armv7)
  (gdb)
  vshcmd: > break svc
  Breakpoint 1 at 0x6fc: svc. (2 locations)
  (gdb)
  vshcmd: > cont
  Continuing.

  Breakpoint 1, svc () at test3.c:16
  16          int test =3D SEQ();
  (gdb)
  vshcmd: > bt
  #0  svc () at test3.c:16
  #1  0xfffffff8 in ?? ()
  Backtrace stopped: previous frame identical to this frame (corrupt stack?)
  (gdb)
  vshcmd: > print/x $lr
  $1 =3D 0xfffffff9
  (gdb)
  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1877136/+subscriptions

