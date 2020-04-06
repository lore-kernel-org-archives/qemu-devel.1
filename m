Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC54C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 01:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3066A2068E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 01:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3066A2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rkmorris.us
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLG9W-0003Ry-Bv
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 21:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jLG8X-000323-On
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 21:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jLG8W-0003lw-Gv
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 21:01:13 -0400
Received: from indium.canonical.com ([91.189.90.7]:42576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jLG8W-0003kx-4g
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 21:01:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jLG8U-0001oF-IE
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 01:01:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 731792E8108
 for <qemu-devel@nongnu.org>; Mon,  6 Apr 2020 01:01:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Apr 2020 00:51:45 -0000
From: Russell Morris <ubuntu@rkmorris.us>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 6-u3untu-h eminus
X-Launchpad-Bug-Reporter: Emin Ghuliev (eminus)
X-Launchpad-Bug-Modifier: Russell Morris (6-u3untu-h)
References: <155352235092.32006.12315829232895734213.malonedeb@soybean.canonical.com>
Message-Id: <158613430543.23887.16301552370281152983.malone@soybean.canonical.com>
Subject: [Bug 1821595] Re: Failed to emulate MMIO access with
 EmulatorReturnStatus: 2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 39f70b03aa6ffc44fca0dba386ef543c741bf415
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
Reply-To: Bug 1821595 <1821595@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Having a similar issue here, running "QEMU emulator version 4.2.91
(v5.0.0-rc1-31-g146aa0f104-dirty)"

Configuration / build command line,
./configure --cross-prefix=3Dx86_64-w64-mingw32- --target-list=3Dx86_64-sof=
tmmu --enable-whpx --enable-fdt --enable-gtk --enable-vnc --disable-pie --e=
nable-opengl && make -j16 && make -j16 installer

And the QEMU command line,
qemu-system-x86_64.exe \
    -m 2G \
    -machine q35 \
    -cpu Penryn \
    -accel whpx \
    -device isa-applesmc,osk=3D"ourhardworkbythesewordsguardedpleasedontste=
al(c)AppleComputerInc" \
    -smbios type=3D2 \
    -drive if=3Dpflash,format=3Draw,readonly,file=3D"./firmware/OVMF_CODE.f=
d"\
    -drive if=3Dpflash,format=3Draw,file=3D"./firmware/OVMF_VARS-1024x768.f=
d" \
    -usb -device usb-kbd -device usb-mouse \
    -netdev user,id=3Dnet0 \
    -device e1000-82545em,netdev=3Dnet0,id=3Dnet0,mac=3D52:54:00:c9:18:27 \
    -device ich9-ahci,id=3Dsata \
    -drive id=3DESP,if=3Dnone,format=3Dqcow2,file=3DESP.qcow2 \
    -device ide-hd,bus=3Dsata.2,drive=3DESP \
    -drive id=3DInstallMedia,format=3Draw,if=3Dnone,file=3DBaseSystem.img \
    -device ide-hd,bus=3Dsata.3,drive=3DInstallMedia \
    -drive id=3DSystemDisk,if=3Dnone,file=3DMyDisk.qcow2 \
    -device ide-hd,bus=3Dsata.4,drive=3DSystemDisk \


If I remove (only), -accel whpx \ =3D> Then it all runs, just very slowly ;=
-).

Any suggestions, things to try?

Thanks!

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

