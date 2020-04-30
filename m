Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E8EC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C97242072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97242072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9hX-0000bB-UJ
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jU9ay-0003WO-DU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jU9ap-0000nt-7I
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:51:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:36388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jU9ao-0000ij-NU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:51:10 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jU9am-0007kE-O4
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 13:51:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B08AD2E802D
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 13:51:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2020 13:40:59 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: gdb
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: laurent-vivier mkdolata
X-Launchpad-Bug-Reporter: Marek Dolata (mkdolata)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <157740016424.15105.4522605454597916967.malonedeb@wampee.canonical.com>
Message-Id: <158825406038.4508.17705569912212790954.launchpad@soybean.canonical.com>
Subject: [Bug 1857640] Re: qemu-system-i386 registers clobbered after gdb set
 due to k_gs_base bug in gdbstub
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e7bbeb3a2e7b99dea75f78172da4ceaf1a0e489e
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 09:35:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1857640 <1857640@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1857640

Title:
  qemu-system-i386 registers clobbered after gdb set due to k_gs_base
  bug in gdbstub

Status in QEMU:
  Fix Released

Bug description:
  Due to a bug in /target/i386/gdbstub.c, setting registers in gdb
  causes the ones following k_gs_base to get clobbered.

  I'm using qemu version 4.2.50 on an msys64 and start qemu's i386 with
  a gdb server.

  $ qemu-system-i386 -version
  QEMU emulator version 4.2.50 (v4.2.0-363-gdd5b0f9549-dirty)
  Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

  $ qemu-system-i386 -gdb tcp::29096 -S
  C:\msys64\usr\local\qemu-system-i386.exe: invalid accelerator kvm
  C:\msys64\usr\local\qemu-system-i386.exe: falling back to tcg

  =

  I start a gdb client, connect to the server, display the register state, =
set k_gs_base, display the register state again, and notice an issue. (Sett=
ing other registers also clobbers the ones after k_gs_base).

  $ gdb -q
  (gdb) target remote :29096
  ...
  (gdb) info regs
  ...
  gs_base        0x0      0
  k_gs_base      0x0      0
  cr0            0x60000010       [ CD NW ET ]
  cr2            0x0      0
  ...
  (gdb) set $k_gs_base =3D 0x41414141
  (gdb) info regs
  ...
  gs_base        0x0      0
  k_gs_base      0x0      0
  cr0            0x41414151       [ CD WP ET PE ]
  cr2            0x60000010       1610612752
  ...

  =

  In the gdbstub code, I notice that the read and write functions are not s=
ymmetric for IDX_SEG_REGS + 8, which corresponds to k_gs_base.

  $ cat /usr/local/src/qemu-4.2.0/target/i386/gdbstub.c
  ...
  int x86_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
  {
  ...
          case IDX_SEG_REGS + 8:
  #ifdef TARGET_X86_64
              if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
                  return gdb_get_reg64(mem_buf, env->kernelgsbase);
              }
              return gdb_get_reg32(mem_buf, env->kernelgsbase);
  #else
              return gdb_get_reg32(mem_buf, 0);
  #endif
  ...
  }
  ...
  int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
  {
  ...
  #ifdef TARGET_X86_64
          case IDX_SEG_REGS + 8:
              if (env->hflags & HF_CS64_MASK) {
                  env->kernelgsbase =3D ldq_p(mem_buf);
                  return 8;
              }
              env->kernelgsbase =3D ldl_p(mem_buf);
              return 4;
  #endif
  ...
  }
  ...

  =

  I change the write function, rebuild, and verify that the issue is resolv=
ed.

  $ cat /usr/local/src/qemu-4.2.0/target/i386/gdbstub.c
  int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
  {
  ...
          case IDX_SEG_REGS + 8:
  #ifdef TARGET_X86_64
              if (env->hflags & HF_CS64_MASK) {
                  env->kernelgsbase =3D ldq_p(mem_buf);
                  return 8;
              }
              env->kernelgsbase =3D ldl_p(mem_buf);
              return 4;
  #else
              return 4;
  #endif
  ...
  }
  ...

  $ make
  ...
  $ make install
  ...

  $ qemu-system-i386 -gdb tcp::29096 -S

  $ gdb -q
  (gdb) target remote :29096
  ...
  (gdb) info regs
  ...
  gs_base        0x0      0
  k_gs_base      0x0      0
  cr0            0x60000010       [ CD NW ET ]
  cr2            0x0      0
  ...
  (gdb) set $k_gs_base =3D 0x41414141
  (gdb) info regs
  ...
  gs_base        0x0      0
  k_gs_base      0x0      0
  cr0            0x60000010       [ CD NW ET ]
  cr2            0x0      0
  ...

  =

  I'll submit the patch below.

  $ diff gdbstub.c gdbstub.c.bkp
  353d352
  <         case IDX_SEG_REGS + 8:
  354a354
  >         case IDX_SEG_REGS + 8:
  362,363d361
  < #else
  <             return 4;

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1857640/+subscriptions

