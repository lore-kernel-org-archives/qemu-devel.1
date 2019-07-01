Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150D9C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4B6208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4B6208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhrZW-0006t4-IR
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 04:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35275)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hhrYa-0006N3-K3
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hhrYZ-0003M7-8S
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:21:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:49072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hhrYZ-0003LJ-2Z
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:20:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hhrYX-0001VS-2v
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 08:20:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0CEC22E80CC
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2019 08:20:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jul 2019 08:05:49 -0000
From: Lukas Durfina <1774149@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: arnaudalies-py lukasdurfina
X-Launchpad-Bug-Reporter: mou (arnaudalies-py)
X-Launchpad-Bug-Modifier: Lukas Durfina (lukasdurfina)
References: <152766936065.4012.2532535303592891582.malonedeb@chaenomeles.canonical.com>
Message-Id: <156196834916.18147.11463146522291037635.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18991";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 3f8727bc0f1f346ae02404ffc76c32542f09e295
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1774149] Re: qemu-user x86_64 x86 gdb call
 function from gdb doesn't work
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
Reply-To: Bug 1774149 <1774149@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It seems the issue is related to gdb code:
set_gdbarch_call_dummy_location (gdbarch, ON_STACK);

What is going on?
The breakpoint is stored on stack and for the first time the address has a =
flag PAGE_WRITE.
After a call, the address does not have anymore the flag PAGE_WRITE. It is =
changed in method tb_page_add() (file: accel/tcg/translate-all.c).

I am thinking more about gdbstub.c.
If there is handled packet M for writing data to memory, it should always w=
rite data to given address.
Reason: you are debugging and you want to verify various scenarios, so chan=
ging different values on different places may be needed.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1774149

Title:
  qemu-user x86_64 x86 gdb call function from gdb doesn't work

Status in QEMU:
  New

Bug description:
  While running qemu user x86_64 x86 with gdb server, calling functions
  are not working.

  Here is how to reproduce it:

  run in a terminal:
  $ qemu-x86_64 -g 12345 -L / /bin/ls

  In another terminal run gdb:
  (gdb) file /bin/ls
  (gdb) target remote :12345
  (gdb) b _init
  (gdb) c
  (gdb) call malloc(1)
  Could not fetch register "fs_base"; remote failure reply 'E14'

  In other cases we also got the error:
  Could not fetch register "orig_rax"; remote failure reply 'E14'

  Here is how I patched it (it is only a workaround):

  diff --git a/gdbstub.c b/gdbstub.c
  index 2a94030..5749efe 100644
  --- a/gdbstub.c
  +++ b/gdbstub.c
  @@ -668,6 +668,11 @@ static int gdb_read_register(CPUState *cpu, uint8_t =
*mem_buf, int reg)
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0return r->get_reg(env, mem_buf, reg - r->base_reg);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
  +#ifdef TARGET_X86_64
  +    return 8;
  +#elif TARGET_I386
  +    return 4;
  +#endif
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
  =C2=A0}

  (Our guess for this issue was, gdb is requesting for 'fake' registers
  to know register size)

  Once we patched that, we got another problem while calling functions
  from gdb: We could call functions, but only once.

  Here is how to reproduce it:
  run in a terminal:
  $ qemu-x86_64 -g 12345 -L / /bin/ls

  In another terminal run gdb:
  (gdb) file /bin/ls
  (gdb) target remote :12345
  (gdb) b _init
  (gdb) c
  (gdb) call malloc(1)
  $1 =3D (void *) 0x620010
  (gdb) call malloc(1)
  Cannot access memory at address 0x40007ffb8f

  Here is how we patched it to make it work:

  diff --git a/exec.c b/exec.c
  index 03238a3..d303922 100644
  --- a/exec.c
  +++ b/exec.c
  @@ -2833,7 +2833,7 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong=
 addr,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(flags & PAGE_=
VALID))
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0return -1;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (is_write) {
  -            if (!(flags & PAGE_WRITE))
  +            if (!(flags & (PAGE_WRITE | PAGE_WRITE_ORG)))
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0/* XXX: this code should not depend on lock_user */
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if (!(p =3D lock_user(VERIFY_WRITE, addr, l, 0)))

  From what we saw, there is a page which is passed to read-only after
  first execution, and gdb need to write on that page to put a
  breakpoint. (on the stack to get function return)

  We suspect this is linked to this:
  https://qemu.weilnetz.de/w64/2012/2012-06-28/qemu-tech.html#Self_002dmodi=
fying-code-and-translated-code-invalidation

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1774149/+subscriptions

