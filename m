Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD40C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E66206CD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E66206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNPZu-0008Et-Ue
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 20:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kNPYT-0007j2-Qw
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 20:01:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:57384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kNPYN-0004nc-SV
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 20:01:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kNPYL-00032v-Bm
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 00:01:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 521B92E80E9
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 00:01:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2020 23:54:40 -0000
From: Fernando Luiz <1821595@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: upstream-bug whpx
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 6-u3untu-h ajbennee eminus fernandobluiz
X-Launchpad-Bug-Reporter: Emin Ghuliev (eminus)
X-Launchpad-Bug-Modifier: Fernando Luiz (fernandobluiz)
References: <155352235092.32006.12315829232895734213.malonedeb@soybean.canonical.com>
Message-Id: <160142368077.3192.15854935917101554025.malone@chaenomeles.canonical.com>
Subject: [Bug 1821595] Re: Failed to emulate MMIO access with
 EmulatorReturnStatus: 2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d685c0a40836eb9844ed835c9700f20633c1d7af"; Instance="production"
X-Launchpad-Hash: a726e4da3d701d35d6353f0642c38febf5968a4f
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 19:10:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.199, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1821595 <1821595@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi. I didnt build Qemu but I downloaded the last version 5.1.0 from
https://qemu.weilnetz.de/w64/ and the error "Failed to emulate MMIO
access with EmulatorReturnStatus: 2" happens when I use -drive if=3Dpflash
or -pflash with -accel whpx.

"qemu-system-x86_64.exe -pflash d:\macWIN\OVMF_CODE.fd -accel whpx
Windows Hypervisor Platform accelerator is operational
qemu-system-x86_64.exe: WHPX: Failed to emulate MMIO access with EmulatorRe=
turnStatus: 2
qemu-system-x86_64.exe: WHPX: Failed to exec a virtual processor"


If I remove pflash and change to -bios "ovmf" the machine works.
qemu-system-x86_64.exe -bios d:\macWIN\OVMF_CODE.fd -accel whpx

If I maintain pflash but remove -accel whpx the machine works too.
qemu-system-x86_64.exe -pflash d:\macWIN\OVMF_CODE.fd

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1821595

Title:
  Failed to emulate MMIO access with EmulatorReturnStatus: 2

Status in QEMU:
  New

Bug description:
  I have compiled qemu with enable-whpx parameter for Hyper-V Platform API =
in Mingw64 . When I tried run with Windows 7 iso file I have faced issue wi=
th the following problem: =

  qemu-system-x86_64.exe: WHPX: Failed to emulate MMIO access with Emulator=
ReturnStatus: 2
  qemu-system-x86_64.exe: WHPX: Failed to exec a virtual processor

  =

  configuration directives:

  ../configure --target-list=3Dx86_64-softmmu,i386-softmmu --enable-lzo\
   --enable-bzip2 --enable-tools --enable-sdl --enable-gtk --enable-hax\
   --enable-vdi --enable-qcow1 --enable-whpx --disable-capstone\
   --disable-werror --disable-stack-protector --prefix=3D"../../QEMU-bin"

  =

  Qemu command line:
  qemu-system-x86_64.exe -m 1024 -cdrom "C:\Users\vmcs\Documents\en_windows=
_7_home_premium_with_sp1_x86_dvd_u_676701.iso" -display sdl -machine q35 -a=
ccel whpx

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1821595/+subscriptions

