Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78A0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5022070B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5022070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhBVs-0007Re-Re
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 08:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jhBUs-0006l1-G5
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 08:30:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:49714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jhBUp-0000eH-Qj
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 08:30:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jhBUn-0004RR-Ux
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 12:30:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E8E772E80BA
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2020 12:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2020 12:17:27 -0000
From: Hajin Jang <1882123@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm armhf debian regression
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: joveler pmaydell
X-Launchpad-Bug-Reporter: Hajin Jang (joveler)
X-Launchpad-Bug-Modifier: Hajin Jang (joveler)
References: <159129432300.4081.5698403082350753204.malonedeb@soybean.canonical.com>
Message-Id: <159135944766.31675.4523233204978552419.malone@gac.canonical.com>
Subject: [Bug 1882123] Re: ARM cpu emulation regression on QEMU 4.2.0
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ef9fc486e875d54078fa61cf91e898b895125d89";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 2cf87dc320abf0faf909db8afb31df3c040d3de0
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 04:10:55
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
Reply-To: Bug 1882123 <1882123@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I pinpointed the exact commits which affected the regression.

[QEMU 4.2.0-rc0 : illegal hardware instruction]
- Introduced in commit af28822
https://github.com/qemu/qemu/commit/af2882289951e58363d714afd16f80050685fa29
The commit affected LDREX/STREX translation, and broke dotnet command from =
.NET Core SDK.

[QEMU 4.2.0-rc2 : .NET SEHException]
- Introduced in commit 655b026
https://github.com/qemu/qemu/commit/655b02646dc175dc10666459b0a1e4346fc8d46a
The commit fixes STREX a bit. As a result, dotnet command is now executable=
 except JIT compiling. =



I also tested lastest HEAD from the master, and it still has the SEHExcepti=
on regression.
(Tested commit is 66234fee9c2d37bfbc523aa8d0ae5300a14cc10e)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1882123

Title:
  ARM cpu emulation regression on QEMU 4.2.0

Status in QEMU:
  New

Bug description:
  [*] Summary

  Latest QEMU has an ARM CPU emulation regression.
  Regression is reproducible by building any C# project with .NET Core SDK =
3.1.300 on Debian 10 armhf guest OS.

  Releases affected: QEMU 4.2.0, 5.0.0
  Releases not affected: QEMU 4.1.0, QEMU 4.1.1

  [*] Detail

  .NET Core SDK 3.1 fails to run on Debian 10 emulated by qemu-system-
  arm.

  I occasionally test my C# projects on the virtual armhf/arm64 system
  emulated by QEMU. MSBuild, a build engine of the .NET Core SDK,
  crashes on QEMU 4.2.0 or later. The crash only happens when MSBuild
  tries to do any JIT compiling (dotnet build / dotnet test).

  I attached the MSBuild crash logs. MSBuild always crashes with
  SEHException, which means it tried to call C binary from .NET binary.

  I think the ARM CPU emulation regression happened between QEMU 4.1.1 ~
  4.2.0. The issue affects QEMU 4.2.0 and 5.0.0. QEMU 4.1.0, 4.1.1, and
  real Raspberry Pi 2 are not affected by this issue, and .NET Core SDK
  works completely fine.

  [*] Environment

  [Host OS]
  Distribution: Linux Mint 19.3 amd64
  CPU: AMD Ryzen 5 3600
  Kernel: Ubuntu 5.3.0-51-generic

  [QEMU Guest OS]
  Distribution: Debian 10 Buster armhf
  Kernel: Debian 4.19.0-9-armmp-lpae
  .NET Core SDK: 3.1.300

  [Raspberry Pi 2]
  Distribution: Raspberry Pi OS Buster armhf
  Kernel: 4.19.118-v7+

  [Tested C# Projects]
  This is a list of C# projects I have tested on QEMU and RPI2.
  - https://github.com/ied206/Joveler.DynLoader
  - https://github.com/ied206/Joveler.Compression
  - https://github.com/ied206/ManagedWimLib

  [QEMU Launch Arguments]
  qemu-system-arm \
  =C2=A0=C2=A0=C2=A0=C2=A0-smp 3 -M virt -m 4096 \
  =C2=A0=C2=A0=C2=A0=C2=A0-kernel vmlinuz-4.19.0-9-armmp-lpae \
  =C2=A0=C2=A0=C2=A0=C2=A0-initrd initrd.img-4.19.0-9-armmp-lpae \
  =C2=A0=C2=A0=C2=A0=C2=A0-append "root=3D/dev/vda2" \
  =C2=A0=C2=A0=C2=A0=C2=A0-drive if=3Dnone,file=3Ddebian_arm.qcow2,format=
=3Dqcow2,id=3Dhd \
  =C2=A0=C2=A0=C2=A0=C2=A0-device virtio-blk-device,drive=3Dhd \
  =C2=A0=C2=A0=C2=A0=C2=A0-netdev user,id=3Dmynet,hostfwd=3Dtcp::<PORT>-:22=
 \
  =C2=A0=C2=A0=C2=A0=C2=A0-device virtio-net-device,netdev=3Dmynet \
  =C2=A0=C2=A0=C2=A0=C2=A0-device virtio-rng-device

  [QEMU Configure Arguments]
  ./configure --enable-spice --enable-gtk --enable-vnc-jpeg --enable-vnc-pn=
g --enable-avx2 --enable-libusb --enable-opengl --enable-virglrenderer --en=
able-kvm --enable-system --enable-modules --audio-drv-list=3Dpa

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1882123/+subscriptions

