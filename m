Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296AAC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF36B2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF36B2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Cph-0007Vi-54
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k9Cp4-0006hi-UZ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:35:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:36306)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k9Cp2-0000PF-T0
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:35:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k9Cp1-0005eD-1T
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 19:35:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 08D542E80DB
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 19:35:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2020 19:26:49 -0000
From: Yonggang Luo <1892544@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: luoyonggang
X-Launchpad-Bug-Reporter: Yonggang Luo (luoyonggang)
X-Launchpad-Bug-Modifier: Yonggang Luo (luoyonggang)
Message-Id: <159803800981.15495.12589210706265225996.malonedeb@soybean.canonical.com>
Subject: [Bug 1892544] [NEW] meson qemu 5.2 can not built with msys2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: 69d65a180e7a6ce75cd5b7a41a8635751e47773a
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 13:35:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1892544 <1892544@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

pacman -S base-devel mingw-w64-x86_64-toolchain git
pacman -S mingw-w64-x86_64-python mingw-w64-x86_64-python-setuptools
pacman -S mingw-w64-x86_64-spice-protocol

cd /mingw64/bin
cp x86_64-w64-mingw32-gcc-ar.exe x86_64-w64-mingw32-ar.exe
cp x86_64-w64-mingw32-gcc-ranlib.exe x86_64-w64-mingw32-ranlib.exe
cp windres.exe x86_64-w64-mingw32-windres.exe
cp nm.exe x86_64-w64-mingw32-nm.exe
cp objcopy.exe x86_64-w64-mingw32-objcopy.exe
cd ~
cd qemu.org-x64


../qemu.org/configure \
  --python=3Dpython3 \
  --cross-prefix=3Dx86_64-w64-mingw32- --enable-gtk --enable-sdl \
  --enable-capstone=3Dgit \
  --enable-stack-protector \
  --enable-gnutls \
  --enable-nettle \
  --enable-vnc \
  --enable-vnc-sasl \
  --enable-vnc-jpeg \
  --enable-vnc-png \
  --enable-membarrier \
  --enable-slirp=3Dgit \
  --disable-kvm \
  --enable-hax \
  --enable-whpx \
  --disable-spice \
  --enable-lzo \
  --enable-snappy \
  --enable-bzip2 \
  --enable-vdi \
  --enable-qcow1 \
  --enable-tools \
  --enable-libusb \
  --enable-usb-redir \
  --disable-libnfs \
  --enable-libssh

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1892544

Title:
  meson qemu 5.2 can not built with msys2

Status in QEMU:
  New

Bug description:
  pacman -S base-devel mingw-w64-x86_64-toolchain git
  pacman -S mingw-w64-x86_64-python mingw-w64-x86_64-python-setuptools
  pacman -S mingw-w64-x86_64-spice-protocol

  cd /mingw64/bin
  cp x86_64-w64-mingw32-gcc-ar.exe x86_64-w64-mingw32-ar.exe
  cp x86_64-w64-mingw32-gcc-ranlib.exe x86_64-w64-mingw32-ranlib.exe
  cp windres.exe x86_64-w64-mingw32-windres.exe
  cp nm.exe x86_64-w64-mingw32-nm.exe
  cp objcopy.exe x86_64-w64-mingw32-objcopy.exe
  cd ~
  cd qemu.org-x64

  =

  ../qemu.org/configure \
    --python=3Dpython3 \
    --cross-prefix=3Dx86_64-w64-mingw32- --enable-gtk --enable-sdl \
    --enable-capstone=3Dgit \
    --enable-stack-protector \
    --enable-gnutls \
    --enable-nettle \
    --enable-vnc \
    --enable-vnc-sasl \
    --enable-vnc-jpeg \
    --enable-vnc-png \
    --enable-membarrier \
    --enable-slirp=3Dgit \
    --disable-kvm \
    --enable-hax \
    --enable-whpx \
    --disable-spice \
    --enable-lzo \
    --enable-snappy \
    --enable-bzip2 \
    --enable-vdi \
    --enable-qcow1 \
    --enable-tools \
    --enable-libusb \
    --enable-usb-redir \
    --disable-libnfs \
    --enable-libssh

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1892544/+subscriptions

