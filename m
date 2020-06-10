Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE09C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 17:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B51204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 17:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B51204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj475-0007Nj-1C
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 13:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jj45y-0006nv-Jv
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 13:00:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:46684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jj45x-0003yx-35
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 13:00:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jj45u-0006FC-NH
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 17:00:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AAD2E2E8106
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 17:00:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2020 16:53:54 -0000
From: "Laszlo Ersek \(Red Hat\)" <1882671@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Confirmed; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor lersek vvaltchev
X-Launchpad-Bug-Reporter: Vladislav K. Valtchev (vvaltchev)
X-Launchpad-Bug-Modifier: Laszlo Ersek (Red Hat) (lersek)
References: <159169936514.32294.8785049859239547612.malonedeb@gac.canonical.com>
Message-Id: <159180803476.8114.4541490092043850606.malone@gac.canonical.com>
Subject: [Bug 1882671] Re: qemu-system-x86_64 (ver 4.2) stuck at boot with
 OVMF bios
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b190cebbf563f89e480a8b57f641753c8196bda0";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d7546103f60c2893fc8409b3d0eb2d6a0410f5e2
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 11:11:22
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

Vladislav,

The OVMF debug log ends like this (with UEFI protocol GUIDs decoded as
their textual identifiers in edk2):

> [Security] 3rd party image[6D19D18] can be loaded after EndOfDxe: PciRoot=
(0x0)/Pci(0x3,0x0)/Offset(0x16400,0x4B1FF).
> InstallProtocolInterface: [EfiLoadedImageProtocol] 6D187C0
> Loading driver at 0x00006B1F000 EntryPoint=3D0x00006B25497 82540em.efi
> InstallProtocolInterface: [EfiLoadedImageDevicePathProtocol] 6D18498
> ProtectUefiImageCommon - 0x6D187C0
>   - 0x0000000006B1F000 - 0x00000000000B6E60
> InstallProtocolInterface: [EfiDriverBindingProtocol] 6B50C00
> InstallProtocolInterface: [EfiComponentName2Protocol] 6B50BD0
> ASSERT /home/jenkins/workspace/edk2/rpms/build/edk2-g6ff7c838d0/MdeModule=
Pkg/Core/Dxe/Image/Image.c(1676): Image->Tpl =3D=3D gEfiCurrentTpl

This final log snippet confirms that a UEFI device driver called
"82540em.efi" is being loaded and started from the option ROM BAR of the
PCI device that is at slot 3, function 0, of the root bridge.

When this UEFI device driver is started, it trips an assert in the
platform firmware. Namely, in the CoreStartImage() function in the
"MdeModulePkg/Core/Dxe/Image/Image.c" source file of edk2:

  //
  // Image has completed.  Verify the tpl is the same
  //
  ASSERT (Image->Tpl =3D=3D gEfiCurrentTpl);

This suggests that the "82540em.efi" driver exits its entry point
function after having raised, but not having restored, the TPL (Task
Priority Level). In other words, the symptom indicates a bug in the UEFI
driver.

I *suspect* (but am not sure) that you are using an e1000 emulated NIC,
and the "82540em.efi" driver exposed in its oprom comes from the iPXE
project:

src/drivers/net/intel.c:        PCI_ROM ( 0x8086, 0x100e, "82540em",
"82540EM", 0 ),

Therefore I suspect a bug in the iPXE version that the Ubuntu 20.04
upgrade brought to you.

(I can see a number of TPL-related patches in the iPXE git history,
around Feb-Mar 2018. And QEMU loads the iPXE oprom into the emulated
NICs ROM BAR.)

Please try installing different versions of the iPXE package on your
Ubuntu host, and re-run your test (without changing any other elements
of your setup).

Thanks.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1882671

Title:
  qemu-system-x86_64 (ver 4.2) stuck at boot with OVMF bios

Status in QEMU:
  New
Status in qemu package in Ubuntu:
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
https://bugs.launchpad.net/qemu/+bug/1882671/+subscriptions

