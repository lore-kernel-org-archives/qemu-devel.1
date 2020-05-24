Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51778C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 17:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277B22073B
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 17:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277B22073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcuXd-0004Il-Dm
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 13:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jcuX7-0003ty-5j
 for qemu-devel@nongnu.org; Sun, 24 May 2020 13:35:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:48592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jcuX5-00062Y-R7
 for qemu-devel@nongnu.org; Sun, 24 May 2020 13:35:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jcuX3-0001MZ-SX
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 17:35:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D3F602E8078
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 17:35:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2020 17:27:44 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1880424@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <159034126455.806.14576501511642959242.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1880424] [NEW] I/O write make imx_epit_reset() crash
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5b57269326eea4fa376f2a5c0c5abec339035069
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 13:35:30
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
Reply-To: Bug 1880424 <1880424@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

libFuzzer found:

qemu-fuzz-arm: hw/core/ptimer.c:377: void ptimer_transaction_begin(ptimer_s=
tate *): Assertion `!s->in_transaction' failed.
=3D=3D6041=3D=3D ERROR: libFuzzer: deadly signal
    #8 0x7fcaba320565 in __GI___assert_fail (/lib64/libc.so.6+0x30565)
    #9 0x563b46f91637 in ptimer_transaction_begin (qemu-fuzz-arm+0x1af1637)
    #10 0x563b476cc4c6 in imx_epit_reset (qemu-fuzz-arm+0x222c4c6)
    #11 0x563b476cd004 in imx_epit_write (qemu-fuzz-arm+0x222d004)
    #12 0x563b46582377 in memory_region_write_accessor (qemu-fuzz-arm+0x10e=
2377)
    #13 0x563b46581ee3 in access_with_adjusted_size (qemu-fuzz-arm+0x10e1ee=
3)
    #14 0x563b46580a83 in memory_region_dispatch_write (qemu-fuzz-arm+0x10e=
0a83)
    #15 0x563b463c5022 in flatview_write_continue (qemu-fuzz-arm+0xf25022)
    #16 0x563b463b4ea2 in flatview_write (qemu-fuzz-arm+0xf14ea2)
    #17 0x563b463b49d4 in address_space_write (qemu-fuzz-arm+0xf149d4)

Reproducer:

qemu-system-arm -M kzm -display none -S -qtest stdio << 'EOF'
writel 0x53f94000 0x110000
EOF

qemu-system-arm: hw/core/ptimer.c:377: ptimer_transaction_begin: Assertion =
`!s->in_transaction' failed.
Aborted (core dumped)

(gdb) bt
#1  0x00007f4aa4daa895 in abort () at /lib64/libc.so.6
#2  0x00007f4aa4daa769 in _nl_load_domain.cold () at /lib64/libc.so.6
#3  0x00007f4aa4db8566 in annobin_assert.c_end () at /lib64/libc.so.6
#4  0x000055ee85400164 in ptimer_transaction_begin (s=3D0x55ee873bc4c0) at =
hw/core/ptimer.c:377
#5  0x000055ee855c7936 in imx_epit_reset (dev=3D0x55ee871725c0) at hw/timer=
/imx_epit.c:111
#6  0x000055ee855c7d1b in imx_epit_write (opaque=3D0x55ee871725c0, offset=
=3D0, value=3D1114112, size=3D4) at hw/timer/imx_epit.c:209
#7  0x000055ee8513db85 in memory_region_write_accessor (mr=3D0x55ee871728f0=
, addr=3D0, value=3D0x7fff3012d6f8, size=3D4, shift=3D0, mask=3D4294967295,=
 attrs=3D...) at memory.c:483
#8  0x000055ee8513dd96 in access_with_adjusted_size (addr=3D0, value=3D0x7f=
ff3012d6f8, size=3D4, access_size_min=3D1, access_size_max=3D4, access_fn=
=3D
    0x55ee8513daa2 <memory_region_write_accessor>, mr=3D0x55ee871728f0, att=
rs=3D...) at memory.c:545
#9  0x000055ee85140cbd in memory_region_dispatch_write (mr=3D0x55ee871728f0=
, addr=3D0, data=3D1114112, op=3DMO_32, attrs=3D...) at memory.c:1477
#10 0x000055ee850deba5 in flatview_write_continue (fv=3D0x55ee87181bd0, add=
r=3D1408843776, attrs=3D..., ptr=3D0x7fff3012d900, len=3D4, addr1=3D0, l=3D=
4, mr=3D0x55ee871728f0) at exec.c:3147
#11 0x000055ee850decf3 in flatview_write (fv=3D0x55ee87181bd0, addr=3D14088=
43776, attrs=3D..., buf=3D0x7fff3012d900, len=3D4) at exec.c:3190
#12 0x000055ee850df05d in address_space_write (as=3D0x55ee8730a560, addr=3D=
1408843776, attrs=3D..., buf=3D0x7fff3012d900, len=3D4) at exec.c:3289

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: arm

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1880424

Title:
  I/O write make imx_epit_reset() crash

Status in QEMU:
  New

Bug description:
  libFuzzer found:

  qemu-fuzz-arm: hw/core/ptimer.c:377: void ptimer_transaction_begin(ptimer=
_state *): Assertion `!s->in_transaction' failed.
  =3D=3D6041=3D=3D ERROR: libFuzzer: deadly signal
      #8 0x7fcaba320565 in __GI___assert_fail (/lib64/libc.so.6+0x30565)
      #9 0x563b46f91637 in ptimer_transaction_begin (qemu-fuzz-arm+0x1af163=
7)
      #10 0x563b476cc4c6 in imx_epit_reset (qemu-fuzz-arm+0x222c4c6)
      #11 0x563b476cd004 in imx_epit_write (qemu-fuzz-arm+0x222d004)
      #12 0x563b46582377 in memory_region_write_accessor (qemu-fuzz-arm+0x1=
0e2377)
      #13 0x563b46581ee3 in access_with_adjusted_size (qemu-fuzz-arm+0x10e1=
ee3)
      #14 0x563b46580a83 in memory_region_dispatch_write (qemu-fuzz-arm+0x1=
0e0a83)
      #15 0x563b463c5022 in flatview_write_continue (qemu-fuzz-arm+0xf25022)
      #16 0x563b463b4ea2 in flatview_write (qemu-fuzz-arm+0xf14ea2)
      #17 0x563b463b49d4 in address_space_write (qemu-fuzz-arm+0xf149d4)

  Reproducer:

  qemu-system-arm -M kzm -display none -S -qtest stdio << 'EOF'
  writel 0x53f94000 0x110000
  EOF

  qemu-system-arm: hw/core/ptimer.c:377: ptimer_transaction_begin: Assertio=
n `!s->in_transaction' failed.
  Aborted (core dumped)

  (gdb) bt
  #1  0x00007f4aa4daa895 in abort () at /lib64/libc.so.6
  #2  0x00007f4aa4daa769 in _nl_load_domain.cold () at /lib64/libc.so.6
  #3  0x00007f4aa4db8566 in annobin_assert.c_end () at /lib64/libc.so.6
  #4  0x000055ee85400164 in ptimer_transaction_begin (s=3D0x55ee873bc4c0) a=
t hw/core/ptimer.c:377
  #5  0x000055ee855c7936 in imx_epit_reset (dev=3D0x55ee871725c0) at hw/tim=
er/imx_epit.c:111
  #6  0x000055ee855c7d1b in imx_epit_write (opaque=3D0x55ee871725c0, offset=
=3D0, value=3D1114112, size=3D4) at hw/timer/imx_epit.c:209
  #7  0x000055ee8513db85 in memory_region_write_accessor (mr=3D0x55ee871728=
f0, addr=3D0, value=3D0x7fff3012d6f8, size=3D4, shift=3D0, mask=3D429496729=
5, attrs=3D...) at memory.c:483
  #8  0x000055ee8513dd96 in access_with_adjusted_size (addr=3D0, value=3D0x=
7fff3012d6f8, size=3D4, access_size_min=3D1, access_size_max=3D4, access_fn=
=3D
      0x55ee8513daa2 <memory_region_write_accessor>, mr=3D0x55ee871728f0, a=
ttrs=3D...) at memory.c:545
  #9  0x000055ee85140cbd in memory_region_dispatch_write (mr=3D0x55ee871728=
f0, addr=3D0, data=3D1114112, op=3DMO_32, attrs=3D...) at memory.c:1477
  #10 0x000055ee850deba5 in flatview_write_continue (fv=3D0x55ee87181bd0, a=
ddr=3D1408843776, attrs=3D..., ptr=3D0x7fff3012d900, len=3D4, addr1=3D0, l=
=3D4, mr=3D0x55ee871728f0) at exec.c:3147
  #11 0x000055ee850decf3 in flatview_write (fv=3D0x55ee87181bd0, addr=3D140=
8843776, attrs=3D..., buf=3D0x7fff3012d900, len=3D4) at exec.c:3190
  #12 0x000055ee850df05d in address_space_write (as=3D0x55ee8730a560, addr=
=3D1408843776, attrs=3D..., buf=3D0x7fff3012d900, len=3D4) at exec.c:3289

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1880424/+subscriptions

