Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CDCC282DC
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 13:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D332792A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 13:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D332792A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49314 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXQjx-00036n-F1
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 09:41:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hXQjA-0002lX-Ho
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 09:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hXQj9-00032M-2f
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 09:40:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:46662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hXQj8-00031d-RP
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 09:40:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hXQj7-0006nf-FI
	for <qemu-devel@nongnu.org>; Sun, 02 Jun 2019 13:40:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 69DF22E8055
	for <qemu-devel@nongnu.org>; Sun,  2 Jun 2019 13:40:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Jun 2019 13:30:29 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee lersek
X-Launchpad-Bug-Reporter: Laszlo Ersek (Red Hat) (lersek)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <155912118291.12579.8926874795813611531.malonedeb@soybean.canonical.com>
	<155947076950.12691.8450256339566609756.malone@soybean.canonical.com>
Message-Id: <875zpodsi2.fsf@zen.linaroharston>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 831c101525966702506c2e86104620c25ef7e455
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: Re: [Qemu-devel] [Bug 1830872] Re: AARCH64 to ARMv7 mistranslation
 in TCG
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1830872 <1830872@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190602133029.uMDzLXNMkQFko5i0A54rJMEqk0o01IK8yhCOmYFg-O4@z>

Laszlo Ersek (Red Hat) <lersek@redhat.com> writes:

> Possibly related:
> [Qemu-devel] "accel/tcg: demacro cputlb" break qemu-system-x86_64
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg07362.html
>
> (qemu-system-x86_64 fails to boot 64-bit kernel under TCG accel when
> QEMU is built for i686)
>
> Note to self: try to reprodouce the present issue with QEMU built at
> eed5664238ea^ -- this LP has originally been filed about the tree at
> a4f667b67149, and that commit contains eed5664238ea. So checking at
> eed5664238ea^ might reveal a difference.

Oops. Looks like tests/tcg/multiarch/system/memory.c didn't cover enough
cases.

--
Alex Benn=C3=A9e

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1830872

Title:
  AARCH64 to ARMv7 mistranslation in TCG

Status in QEMU:
  New

Bug description:
  The following guest code:

  https://github.com/tianocore/edk2/blob/3604174718e2afc950c3cc64c64ba5165c=
8692bd/MdePkg/Library/BaseMemoryLibOptDxe/AArch64/CopyMem.S

  implements, in hand-optimized aarch64 assembly, the CopyMem() edk2 (EFI
  Development Kit II) library function. (CopyMem() basically has memmove()
  semantics, to provide a standard C analog here.) The relevant functions
  are InternalMemCopyMem() and __memcpy().

  When TCG translates this aarch64 code to x86_64, everything works
  fine.

  When TCG translates this aarch64 code to ARMv7, the destination area of
  the translated CopyMem() function becomes corrupted -- it differs from
  the intended source contents. Namely, in every 4096 byte block, the
  8-byte word at offset 4032 (0xFC0) is zeroed out in the destination,
  instead of receiving the intended source value.

  I'm attaching two hexdumps of the same destination area:

  - "good.txt" is a hexdump of the destination area when CopyMem() was
    translated to x86_64,

  - "bad.txt" is a hexdump of the destination area when CopyMem() was
    translated to ARMv7.

  In order to assist with the analysis of this issue, I disassembled the
  aarch64 binary with "objdump". Please find the listing in
  "DxeCore.objdump", attached. The InternalMemCopyMem() function starts at
  hex offset 2b2ec. The __memcpy() function starts at hex offset 2b180.

  And, I ran the guest on the ARMv7 host with "-d
  in_asm,op,op_opt,op_ind,out_asm". Please find the log in
  "tcg.in_asm.op.op_opt.op_ind.out_asm.log", attached.

  The TBs that correspond to (parts of) the InternalMemCopyMem() and
  __memcpy() functions are scattered over the TCG log file, but the offset
  between the "nice" disassembly from "DxeCore.objdump", and the in-RAM
  TBs in the TCG log, can be determined from the fact that there is a
  single prfm instruction in the entire binary. The instruction's offset
  is 0x2b180 in "DxeCore.objdump" -- at the beginning of the __memcpy()
  function --, and its RAM address is 0x472d2180 in the TCG log. Thus the
  difference (=3D the load address of DxeCore.efi) is 0x472a7000.

  QEMU was built at commit a4f667b67149 ("Merge remote-tracking branch
  'remotes/cohuck/tags/s390x-20190521-3' into staging", 2019-05-21).

  The reproducer command line is (on an ARMv7 host):

    qemu-system-aarch64 \
      -display none \
      -machine virt,accel=3Dtcg \
      -nodefaults \
      -nographic \
      -drive if=3Dpflash,format=3Draw,file=3D$prefix/share/qemu/edk2-aarch6=
4-code.fd,readonly \
      -drive if=3Dpflash,format=3Draw,file=3D$prefix/share/qemu/edk2-arm-va=
rs.fd,snapshot=3Don \
      -cpu cortex-a57 \
      -chardev stdio,signal=3Doff,mux=3Don,id=3Dchar0 \
      -mon chardev=3Dchar0,mode=3Dreadline \
      -serial chardev:char0

  The apparent symptom is an assertion failure *in the guest*, such as

  > ASSERT [DxeCore]
  > /home/lacos/src/upstream/qemu/roms/edk2/MdePkg/Library/BaseLib/String.c=
(1090):
  > Length < _gPcd_FixedAtBuild_PcdMaximumAsciiStringLength

  but that is only a (distant) consequence of the CopyMem()
  mistranslation, and resultant destination area corruption.

  Originally reported in the following two mailing list messages:
  - http://mid.mail-archive.com/9d2e260c-c491-03d2-9b8b-b57b72083f77@redhat=
.com
  - http://mid.mail-archive.com/f1cec8c0-1a9b-f5bb-f951-ea0ba9d276ee@redhat=
.com

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1830872/+subscriptions

