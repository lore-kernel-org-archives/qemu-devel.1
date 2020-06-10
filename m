Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B71AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 23:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D25520760
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 23:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D25520760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjA75-0003kk-LT
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 19:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jjA6P-0003Ly-SX
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 19:25:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:52848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jjA6N-0006ta-Sy
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 19:25:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jjA6L-0003VN-EL
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 23:25:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5DB332E810E
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 23:25:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2020 23:17:46 -0000
From: "Laszlo Ersek \(Red Hat\)" <1882671@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=ipxe; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=ipxe; component=main;
 status=Confirmed; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor lersek vvaltchev
X-Launchpad-Bug-Reporter: Vladislav K. Valtchev (vvaltchev)
X-Launchpad-Bug-Modifier: Laszlo Ersek (Red Hat) (lersek)
References: <159169936514.32294.8785049859239547612.malonedeb@gac.canonical.com>
Message-Id: <159183106698.6395.17435419830579655737.malone@chaenomeles.canonical.com>
Subject: [Bug 1882671] Re: qemu-system-x86_64 (ver 4.2) stuck at boot with
 OVMF bios
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b190cebbf563f89e480a8b57f641753c8196bda0";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 2f0ff1f09fef3b8bdfad9674c864fc7889d986e9
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 19:25:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1882671 <1882671@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Vlad,

the ipxe-qemu package in Ubuntu (1.0.0+git-20190109.133f4c4-0ubuntu3) is
built with DOWNLOAD_PROTO_HTTPS enabled (in "src/config/general.h").
According to the Ubuntu changelog, this is a new feature added in
"1.0.0+git-20190109.133f4c4-0ubuntu1".

With DOWNLOAD_PROTO_HTTPS enabled, I can reproduce the issue locally,
with iPXE built from source at git commit 133f4c4 (which you report the
issue for), and also at current iPXE master (9ee70fb95bc2).

The issue does not reproduce (with DOWNLOAD_PROTO_HTTPS enabled) at
commit fbe8c52d. This suggests the problem should be bisectable.

If I disable DOWNLOAD_PROTO_HTTPS, then the problem goes away even at
133f4c4 (i.e., the issue is masked).

I've used current edk2 master to test with (14c7ed8b51f6).

Viewed at 133f4c4:

The DOWNLOAD_PROTO_HTTPS feature test macro seems to result in iPXE
attempting to gather entropy. (Likely for setting up TLS connections.)
For entropy gathering, iPXE seems to use an EFI timer, and to measure
jitter across one timer tick. In this, iPXE plays some tricks with the
UEFI TPL (Task Priority Level).

In general, iPXE seems to want to run at TPL_CALLBACK most of the time,
to mask the timer interrupt in most code locations, and drops down to
TPL_APPLICATION only when it actively wants a timer callback (for the
jitter collection, see above).

When the iPXE driver is launched, the StartImage() UEFI boot service
takes a note of the current TPL. It is TPL_APPLICATION (value 4). Then
iPXE seems to perform the above trickery with TPL_CALLBACK & entropy
collection. Finally, after installing EfiDriverBindingProtocol and
EfiComponentName2Protocol, the iPXE driver exits (as expected from a
UEFI driver model driver -- the entry point function is only supposed to
perform some setup steps & install some protocol interfaces). At this
point, StartImage() verifies whether the TPL has been restored to the
same as it was before launching the driver.

Unfortunately, something about the TPL manipulations in iPXE is
unbalanced, because I see the following TPL changes:

- raise: APPLICATION (4) -> CALLBACK (8)
- raise: CALLBACK (8) -> NOTIFY (16)
- raise: NOTIFY (16) -> NOTIFY (16)
- restore: NOTIFY (16) -> NOTIFY (16)
- restore: NOTIFY (16) -> CALLBACK (8)

Note that the final "restore: CALLBACK (8) -> APPLICATION (4)"
transition is missing, before iPXE exits. This is what StartImage()
catches and reports with the failed ASSERT().

So, as I mentioned, the problem is bisectable. Here's the bisection log:

> git bisect start
> # bad: [9ee70fb95bc266885ff88be228b044a2bb226eeb] [efi] Attempt to
> # connect our driver directly if ConnectController fails
> git bisect bad 9ee70fb95bc266885ff88be228b044a2bb226eeb
> # bad: [133f4c47baef6002b2ccb4904a035cda2303c6e5] [build] Handle
> # R_X86_64_PLT32 from binutils 2.31
> git bisect bad 133f4c47baef6002b2ccb4904a035cda2303c6e5
> # good: [fbe8c52d0d9cdb3d6f5fe8be8edab54618becc1f] [ena] Fix spurious
> # uninitialised variable warning on older versions of gcc
> git bisect good fbe8c52d0d9cdb3d6f5fe8be8edab54618becc1f
> # bad: [bc85368cdd311fe68ffcf251e7e8e90c14f8a9dc] [librm] Ensure that
> # inline code symbols are unique
> git bisect bad bc85368cdd311fe68ffcf251e7e8e90c14f8a9dc
> # bad: [0778418e29ea16fc897fc5b6e497054f5ba86ebd] [golan] Do not
> # assume all devices are identical
> git bisect bad 0778418e29ea16fc897fc5b6e497054f5ba86ebd
> # good: [f672a27b34220865b403df519593f382859559e0] [efi] Raise TPL
> # within EFI_USB_IO_PROTOCOL entry points
> git bisect good f672a27b34220865b403df519593f382859559e0
> # bad: [d8c500b7945e57023dde5bd0be2b0e40963315d9] [efi] Drop to
> # TPL_APPLICATION when gathering entropy
> git bisect bad d8c500b7945e57023dde5bd0be2b0e40963315d9
> # good: [c84f9d67272beaed98f98bf308471df16340a3be] [iscsi] Parse IPv6
> # address in root path
> git bisect good c84f9d67272beaed98f98bf308471df16340a3be
> # first bad commit: [d8c500b7945e57023dde5bd0be2b0e40963315d9] [efi]
> # Drop to TPL_APPLICATION when gathering entropy

The bisection fingers d8c500b7945e ("[efi] Drop to TPL_APPLICATION when
 gathering entropy", 2018-03-12) as first bad commit.

Feel free to report this problem on the upstream iPXE mailing list.

Regarding Ubuntu downstream, you should be able to work around this
issue by #undef-ing DOWNLOAD_PROTO_HTTPS again, in
"src/config/general.h" -- *minimally* in the CONFIG=3Dqemu build(s). That
is, in the ipxe-qemu subpackage.

That's because in a CONFIG=3Dqemu build, you totally don't need (or even
*use*) the iPXE HTTPS infrastructure (the entropy gathering that trips
the ASSERT seems spurious to me, with CONFIG=3Dqemu). With CONFIG=3Dqemu,
iPXE provides the UEFI SNP (Simple Network Protocol) interface on top of
the e1000 NIC, and the crypto stuff (if any) is done by the platform
firmware (edk2 / OVMF).



** Project changed: qemu =3D> ipxe

** Package changed: qemu (Ubuntu) =3D> ipxe (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1882671

Title:
  qemu-system-x86_64 (ver 4.2) stuck at boot with OVMF bios

Status in iPXE:
  New
Status in ipxe package in Ubuntu:
  Confirmed

Bug description:
  The version of QEMU (4.2.0) packaged for Ubuntu 20.04 hangs
  indefinitely at boot if an OVMF bios is used. This happens ONLY with
  qemu-system-x86_64. qemu-system-i386 works fine with the latest ia32
  OVMF bios.

  NOTE[1]: the same identical OVMF bios works fine on QEMU 2.x packaged wit=
h Ubuntu 18.04.
  NOTE[2]: reproducing the fatal bug requires *no* operating system:

     qemu-system-x86_64 -bios OVMF-pure-efi.fd

  On its window QEMU gets stuck at the very first stage:
     "Guest has not initialized the display (yet)."

  NOTE[3]: QEMU gets stuck no matter if KVM is used or not.

  NOTE[4]: By adding the `-d int` option it is possible to observe that
  QEMU is, apparently, stuck in an endless loop of interrupts. For the
  first few seconds, registers' values vary quickly, but at some point
  they reach a final value, while the interrupt counter increments:

    2568: v=3D68 e=3D0000 i=3D0 cpl=3D0 IP=3D0038:0000000007f1d225 pc=3D000=
0000007f1d225 SP=3D0030:0000000007f0c8d0 env->regs[R_EAX]=3D0000000000000000
  RAX=3D0000000000000000 RBX=3D0000000007f0c920 RCX=3D0000000000000000 RDX=
=3D0000000000000001
  RSI=3D0000000006d18798 RDI=3D0000000000008664 RBP=3D0000000000000000 RSP=
=3D0000000007f0c8d0
  R8 =3D0000000000000001 R9 =3D0000000000000089 R10=3D0000000000000000 R11=
=3D0000000007f2c987
  R12=3D0000000000000000 R13=3D0000000000000000 R14=3D0000000007087901 R15=
=3D0000000000000000
  RIP=3D0000000007f1d225 RFL=3D00000246 [---Z-P-] CPL=3D0 II=3D0 A20=3D1 SM=
M=3D0 HLT=3D0
  ES =3D0030 0000000000000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
  CS =3D0038 0000000000000000 ffffffff 00af9a00 DPL=3D0 CS64 [-R-]
  SS =3D0030 0000000000000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
  DS =3D0030 0000000000000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
  FS =3D0030 0000000000000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
  GS =3D0030 0000000000000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
  LDT=3D0000 0000000000000000 0000ffff 00008200 DPL=3D0 LDT
  TR =3D0000 0000000000000000 0000ffff 00008b00 DPL=3D0 TSS64-busy
  GDT=3D     00000000079eea98 00000047
  IDT=3D     000000000758f018 00000fff
  CR0=3D80010033 CR2=3D0000000000000000 CR3=3D0000000007c01000 CR4=3D000006=
68
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000 =

  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
  CCS=3D0000000000000044 CCD=3D0000000000000000 CCO=3DEFLAGS  =

  EFER=3D0000000000000d00

  =

  NOTE[5]: Just to better help the investigation of the bug, I'd like to re=
mark that the issue is NOT caused by an endless loop of triple-faults. I tr=
ied with -d cpu_reset and there is NO such loop. No triple fault whatsoever.

  NOTE[6]: The OVMF version used for the test has been downloaded from:
  https://www.kraxel.org/repos/jenkins/edk2/edk2.git-ovmf-x64-0-20200515.13=
98.g6ff7c838d0.noarch.rpm

  but the issue is the same with older OVMF versions as well.

  =

  Please take a look at it, as the bug is NOT a corner case. QEMU 4.2.0 can=
not boot with an UEFI firmware (OVMF) while virtualizing a x86_64 machine A=
T ALL.

  Thank you very much,
  Vladislav K. Valtchev

To manage notifications about this bug go to:
https://bugs.launchpad.net/ipxe/+bug/1882671/+subscriptions

