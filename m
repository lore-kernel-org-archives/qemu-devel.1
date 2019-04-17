Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCB6C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 12:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F8462173C
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 12:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8462173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51809 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGjZv-000457-PE
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 08:22:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGjYg-0003U2-AG
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGjYf-0002WG-5S
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:20:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:34796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGjYe-0002So-Sa
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:20:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGjYb-0006qx-Hl
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 12:20:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D00F72E80D5
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 12:20:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Apr 2019 12:12:32 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
	assignee=rth@twiddle.net; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell rth zhroma
X-Launchpad-Bug-Reporter: Roman Zhuykov (zhroma)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <155534806981.13632.6401186723464432088.malonedeb@gac.canonical.com>
Message-Id:
 <155550315295.13229.8649741771076151370.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 9af5d069910619134579ccaba01e8c137b5c17e2
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1824853] Re: 4.0.0-rc3 crashes with
 tcg/tcg.c:3952: tcg_gen_code: Assertion `s->gen_insn_end_off[num_insns] ==
 off' failed
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
Reply-To: Bug 1824853 <1824853@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417121232.k9qUZIDw7JF0i1Bu1HP1mCD7FGt1HlDgO3GUXjcMoKI@z>

Unfortunately the fix is too big for this point in the 4.0 release
cycle; it'll go into 4.1.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824853

Title:
  4.0.0-rc3 crashes with tcg/tcg.c:3952: tcg_gen_code: Assertion
  `s->gen_insn_end_off[num_insns] =3D=3D off' failed

Status in QEMU:
  In Progress

Bug description:
  I tried to bootstrap and regtested gcc trunk (gcc svn rev 270278,
  datestamp 20190411) inside my arm64-gentoo installation under qemu-
  system-aarch64.

  Qemu version was 4.0.0-rc3 and -cpu cortex-a57. Qemu configured with
  only --target-list=3Daarch64-softmmu,aarch64-linux-user and compiled
  using gcc "version 5.5.0 20171010 (Ubuntu 5.5.0-12ubuntu1~16.04)".

  Executable created from gcc/testsuite/gcc.target/aarch64/advsimd-
  intrinsics/vldX.c compiled with -O2 crashed the whole qemu-system.

  To investigate a bit I also manually run
  ~/gcc/inst/trunk/bin/gcc ~/gcc/src/trunk/gcc/testsuite/gcc.target/aarch64=
/advsimd-intrinsics/vldX.c
  with different options like:
  -O0 -lm -o d0.exe
  -O1 -lm -o d1.exe
  -O2 -lm -o d2.exe
  -O0 -static -lm -o s0.exe
  -O1 -static -lm -o s1.exe
  -O2 -static -lm -o s2.exe

  So, now I have 6 different arm64 executables created with different optim=
ization levels. O0 and O1 versions run ok.
  Three sN.exe static executables I've also tried in qemu user mode (with s=
ame -cpu), no issue in user mode.

  And inside qemu-system I can see that
  running "d2.exe" (attached) gives:
  tcg/tcg.c:3952: tcg_gen_code: Assertion `s->gen_insn_end_off[num_insns] =
=3D=3D off' failed.

  And running "s2.exe" gives:
  tcg/tcg.c:320: set_jmp_reset_offset: Assertion `s->tb_jmp_reset_offset[wh=
ich] =3D=3D off' failed.

  It seems like this test is an counter-example for logic that
  "tcg_ctx->nb_ops < 4000" implies tcg will fit into 16-bit signed size
  (see tcg_op_buf_full comments).

  Richard's changes in abebf92597186 and 9f754620651d were not enough, tran=
slation block must be smaller, or we have to find some proper way to bail o=
ut when buffer overflows.
  I don't know why this situation is not caught by code_gen_highwater logic=
 in tcg.c

  I've also tried this "bail out" patch

  diff --git a/tcg/tcg.c b/tcg/tcg.c
  --- a/tcg/tcg.c
  +++ b/tcg/tcg.c
  @@ -3949,7 +3949,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *t=
b)
                   size_t off =3D tcg_current_code_size(s);
                   s->gen_insn_end_off[num_insns] =3D off;
                   /* Assert that we do not overflow our stored offset.  */
  -                assert(s->gen_insn_end_off[num_insns] =3D=3D off);
  +                if (s->gen_insn_end_off[num_insns] !=3D off)
  +                  return -1;
               }
               num_insns++;
               for (i =3D 0; i < TARGET_INSN_START_WORDS; ++i) {

  But then running "d2.exe" just hangs the whole qemu-system. It seems
  that when tcg_gen_code return -1 (like in highwater logic mentioned
  before), we just re-call it again and again.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824853/+subscriptions

