Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8220C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836DF2070C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836DF2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBN0J-0003i4-Vd
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 13:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iBMyT-00021v-SM
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iBMyS-0001ak-0M
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:45:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:35386)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iBMyR-0001Yw-Qt
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:45:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iBMyP-0007Hq-1f
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 17:45:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0515B2E80CC
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 17:45:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Sep 2019 17:37:09 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: nathanchance pmaydell
X-Launchpad-Bug-Reporter: Nathan Chancellor (nathanchance)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <156885735889.27264.8945287928013294736.malonedeb@soybean.canonical.com>
Message-Id: <156900102964.5144.14836724327815998118.malone@chaenomeles.canonical.com>
Subject: [Bug 1844597] Re: fc1120a7f5f2d4b601003205c598077d3eb11ad2 causes a
 kernel panic in vfp_init on a clang built kernel
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e6e5f331e2593b52905a48c8165a2dd80c9a8d43
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Bug 1844597 <1844597@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks. I've diagnosed the problem -- when we boot a kernel directly
into non-secure state on an AArch32 CPU which implements EL3, we need to
set the NSACR.{CP11,CP10} bits so that Non-Secure is allowed to use the
FPU, but we weren't doing that. The omission didn't matter until commit
fc1120a7f5 because before that point we were ignoring the NSACR trap
bits entirely... Patch coming up shortly.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1844597

Title:
  fc1120a7f5f2d4b601003205c598077d3eb11ad2 causes a kernel panic in
  vfp_init on a clang built kernel

Status in QEMU:
  New

Bug description:
  Commit 4cdabee7d6d2 ("ARM: configs: aspeed_g5: Enable AST2600") [1] in
  the Linux kernel enabled CONFIG_VFP. When building this config with
  Clang, the resulting kernel does not boot after commit fc1120a7f5
  ("target/arm: Implement NSACR gating of floating point") [2] (present
  since the 4.1.0 release).

  The QEMU command:

  qemu-system-arm -m 512m \
                  -machine romulus-bmc \
                  -no-reboot \
                  -dtb out/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dtb \
                  -initrd rootfs.cpio \
                  -display none \
                  -serial mon:stdio \
                  -kernel ${KBF}/arch/arm/boot/zImage

  If it is needed, the rootfs we are using is provided at a link below
  [3].

  Debugging with QEMU reveals that the kernel panics in vfp_init,
  specifically at the line:

  vfpsid =3D fmrx(FPSID);

  in arch/arm/vfp/vfpmodule.c because of an illegal instruction:

  [    0.058685] VFP support v0.3: =

  [    0.059159] Internal error: Oops - undefined instruction: 0 [#1] SMP A=
RM
  [    0.059525] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.3.0-next-20190=
918-dirty #1
  [    0.059547] Hardware name: Generic DT based system
  [    0.059702] PC is at vfp_init+0x50/0x1f4
  [    0.059721] LR is at vfp_init+0x4c/0x1f4
  [    0.059738] pc : [<80b0383c>]    lr : [<80b03838>]    psr: 60000153
  [    0.059756] sp : 9e497ec0  ip : 00000020  fp : 9e497ed8
  [    0.059773] r10: 00000000  r9 : ffffe000  r8 : 80c06048
  [    0.059792] r7 : 00000000  r6 : 80c0caac  r5 : 80c6c418  r4 : 80b037ec
  [    0.059811] r3 : 00000000  r2 : 339aa372  r1 : 00000000  r0 : 00000012
  [    0.059859] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segm=
ent none
  [    0.059883] Control: 00c5387d  Table: 80004008  DAC: 00000051
  [    0.059997] Process swapper/0 (pid: 1, stack limit =3D 0x(ptrval))
  [    0.060048] Stack: (0x9e497ec0 to 0x9e498000)
  [    0.060205] 7ec0: 80b037ec 80b6bf0c 80b037ec ffffffff 00000000 0000000=
0 9e497f48 80b01100
  [    0.060310] 7ee0: 00000000 9eeff9e0 80a85734 809eb9be 00000000 8014b7f=
4 9eeff9e0 80a85734
  [    0.060408] 7f00: 9e497f48 8014b7f4 000000a4 00000001 00000001 0000000=
0 80b0133c 9e497f38
  [    0.060509] 7f20: 00000000 9eeff9d5 339aa372 80b6be80 80b6bf0c 0000000=
0 00000000 00000000
  [    0.060606] 7f40: 00000000 00000000 9e497f70 80b01864 00000001 0000000=
1 00000000 80b0133c
  [    0.060703] 7f60: 00000001 8085d268 00000000 00000000 9e497f80 80b0175=
8 00000000 00000000
  [    0.060800] 7f80: 9e497f90 80b015e4 00000000 8085d268 9e497fa8 8085d27=
c 00000000 8085d268
  [    0.060897] 7fa0: 00000000 00000000 00000000 801010e8 00000000 0000000=
0 00000000 00000000
  [    0.060993] 7fc0: 00000000 00000000 00000000 00000000 00000000 0000000=
0 00000000 00000000
  [    0.061090] 7fe0: 00000000 00000000 00000000 00000000 00000013 0000000=
0 00000000 00000000
  [    0.061625] [<80b0383c>] (vfp_init) from [<80b01100>] (do_one_initcall=
+0xa8/0x1e0)
  [    0.061722] [<80b01100>] (do_one_initcall) from [<80b01864>] (do_initc=
all_level+0xfc/0x12c)
  [    0.061742] [<80b01864>] (do_initcall_level) from [<80b01758>] (do_bas=
ic_setup+0x2c/0x3c)
  [    0.061759] [<80b01758>] (do_basic_setup) from [<80b015e4>] (kernel_in=
it_freeable+0x68/0x104)
  [    0.061777] [<80b015e4>] (kernel_init_freeable) from [<8085d27c>] (ker=
nel_init+0x14/0x26c)
  [    0.061798] [<8085d27c>] (kernel_init) from [<801010e8>] (ret_from_for=
k+0x14/0x2c)
  [    0.061835] Exception stack(0x9e497fb0 to 0x9e497ff8)
  [    0.061896] 7fa0:                                     00000000 0000000=
0 00000000 00000000
  [    0.061998] 7fc0: 00000000 00000000 00000000 00000000 00000000 0000000=
0 00000000 00000000
  [    0.062080] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
  [    0.062263] Code: e5860000 e59f0174 ebd9d8fc e59f5170 (eef04a10) =

  [    0.062679] ---[ end trace 2d338c91e4e74562 ]---

  Before fc1120a7f5:

  [    0.069418] VFP support v0.3: implementor 41 architecture 1 part 20
  variant b rev 5

  Should you need to reproduce this locally:

  * clang 9.0.0 or later is needed to build this config. If you do not
  have easy access to such a build, we have a clang build script
  available [4] that can help with this:

  % ./build-llvm.py --branch llvmorg-9.0.0-rc6 \
                    --build-stage1-only \
                    --projects clang \
                    --targets ARM

  * Because of an unrelated build issue, linux-next needs to be used (or
  the singular patch that resolves it needs to be cherry-picked on top
  of 4cdabee7d6d2 [5]). The kernel make command used:

  % make -j$(nproc) -s \
         ARCH=3Darm \
         CC=3Dclang \
         CROSS_COMPILE=3Darm-linux-gnueabi- \
         O=3Dout \
         distclean aspeed_g5_defconfig all

  [1]: https://git.kernel.org/linus/4cdabee7d6d2e439fea726a101e448c4ca6837f4
  [2]: https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Dfc1120a7f5f2d4b601=
003205c598077d3eb11ad2
  [3]: https://github.com/ClangBuiltLinux/continuous-integration/blob/800d8=
4bf8c55ee04c50ed4c78144a96d889a91c5/images/arm/rootfs.cpio
  [4]: https://github.com/ClangBuiltLinux/tc-build
  [5]: http://git.armlinux.org.uk/cgit/linux-arm.git/commit/?id=3D7b3948597=
372e5a6b314208ac320362c204b7f0f

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1844597/+subscriptions

