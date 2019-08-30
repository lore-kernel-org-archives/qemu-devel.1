Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE270C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 17:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A924120659
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 17:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A924120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3l5P-0002fN-AQ
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 13:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i3l32-0001aF-1W
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 13:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i3l2u-0007gQ-L5
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 13:50:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:36496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i3l2p-0007c7-0D
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 13:50:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i3l2l-0007oA-C8
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 17:50:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4E8902E80CD
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 17:50:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Aug 2019 17:40:47 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1841990@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ppc64 testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 7-pc philmd
X-Launchpad-Bug-Reporter: Paul Clarke (7-pc)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <156711057074.6835.13599471410604217618.malonedeb@soybean.canonical.com>
Message-Id: <156718684766.17269.8694556958029730446.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 38244aaac7cb550f0b127b98b63fd8b3b1e3b45e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1841990] Re: instruction 'denbcdq' misbehaving
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
Reply-To: Bug 1841990 <1841990@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This seems related to this change:

commit ef96e3ae9698d6726a8113f448c82985a9f31ff5
Author: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date:   Wed Jan 2 09:14:22 2019 +0000

    target/ppc: move FP and VMX registers into aligned vsr register array
    =

    The VSX register array is a block of 64 128-bit registers where the fir=
st 32
    registers consist of the existing 64-bit FP registers extended to 128-b=
it
    using new VSR registers, and the last 32 registers are the VMX 128-bit
    registers as show below:
    =

                64-bit               64-bit
        +--------------------+--------------------+
        |        FP0         |                    |  VSR0
        +--------------------+--------------------+
        |        FP1         |                    |  VSR1
        +--------------------+--------------------+
        |        ...         |        ...         |  ...
        +--------------------+--------------------+
        |        FP30        |                    |  VSR30
        +--------------------+--------------------+
        |        FP31        |                    |  VSR31
        +--------------------+--------------------+
        |                  VMX0                   |  VSR32
        +-----------------------------------------+
        |                  VMX1                   |  VSR33
        +-----------------------------------------+
        |                  ...                    |  ...
        +-----------------------------------------+
        |                  VMX30                  |  VSR62
        +-----------------------------------------+
        |                  VMX31                  |  VSR63
        +-----------------------------------------+
    =

    In order to allow for future conversion of VSX instructions to use TCG =
vector
    operations, recreate the same layout using an aligned version of the ex=
isting
    vsr register array.
    =

    Since the old fpr and avr register arrays are removed, the existing cal=
lers
    must also be updated to use the correct offset in the vsr register arra=
y. This
    also includes switching the relevant VMState fields over to using subar=
rays
    to make sure that migration is preserved.

@@ -1055,11 +1053,10 @@ struct CPUPPCState {
-    /* VSX registers */
-    uint64_t vsr[32];
+    /* VSX registers (including FP and AVR) */
+    ppc_vsr_t vsr[64] QEMU_ALIGNED(16);

The denbcdq helper is:

#define DFP_HELPER_ENBCD(op, size)                                         =
  \
void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *b, uint32_t s)   =
  \
{                                                                          =
  \
[...]
    if ((size) =3D=3D 64) {                                                =
      \
        t[0] =3D dfp.t64[0];                                               =
    \
    } else if ((size) =3D=3D 128) {                                        =
      \
        t[0] =3D dfp.t64[HI_IDX];                                          =
    \
        t[1] =3D dfp.t64[LO_IDX];                                          =
    \
    }                                                                      =
  \
}

t[1] doesn't point to the proper vsr register anymore.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1841990

Title:
  instruction 'denbcdq' misbehaving

Status in QEMU:
  New

Bug description:
  Instruction 'denbcdq' appears to have no effect.  Test case attached.

  On ppc64le native:
  --
  gcc -g -O -mcpu=3Dpower9 bcdcfsq.c test-denbcdq.c -o test-denbcdq
  $ ./test-denbcdq
  0x00000000000000000000000000000000
  0x0000000000000000000000000000000c
  0x22080000000000000000000000000000
  $ ./test-denbcdq 1
  0x00000000000000000000000000000001
  0x0000000000000000000000000000001c
  0x22080000000000000000000000000001
  $ ./test-denbcdq $(seq 0 99)
  0x00000000000000000000000000000064
  0x0000000000000000000000000000100c
  0x22080000000000000000000000000080
  --

  With "qemu-ppc64le -cpu power9"
  --
  $ qemu-ppc64le -cpu power9 -L [...] ./test-denbcdq
  0x00000000000000000000000000000000
  0x0000000000000000000000000000000c
  0x0000000000000000000000000000000c
  $ qemu-ppc64le -cpu power9 -L [...] ./test-denbcdq 1
  0x00000000000000000000000000000001
  0x0000000000000000000000000000001c
  0x0000000000000000000000000000001c
  $ qemu-ppc64le -cpu power9 -L [...] ./test-denbcdq $(seq 100)
  0x00000000000000000000000000000064
  0x0000000000000000000000000000100c
  0x0000000000000000000000000000100c
  --

  I started looking at the code, but I got confused rather quickly.
  Could be related to endianness? I think denbcdq arrived on the scene
  before little-endian was a big deal.  Maybe something to do with
  utilizing implicit floating-point register pairs...  I don't think the
  right data is getting to helper_denbcdq, which would point back to the
  gen_fprp_ptr uses in dfp-impl.inc.c (GEN_DFP_T_FPR_I32_Rc).  (Maybe?)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1841990/+subscriptions

