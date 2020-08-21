Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C608C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E89CC2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89CC2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Cpl-0007bk-1r
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k9Cp7-0006jO-5i
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:35:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:36334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k9Cp3-0000R0-QE
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:35:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k9Cp2-0005ea-AG
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 19:35:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4B5232E80DB
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 19:35:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2020 19:28:02 -0000
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
References: <159803800981.15495.12589210706265225996.malonedeb@soybean.canonical.com>
Message-Id: <159803808232.4383.10439516322185191070.malone@gac.canonical.com>
Subject: [Bug 1892544] Re: meson qemu 5.2 can not built with msys2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: f61ffaeb67cdc093f7f41324e7faac757a3fe180
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 13:35:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

error output
```
$ ../qemu.org/configure \
>   --python=3Dpython3 \
>   --cross-prefix=3Dx86_64-w64-mingw32- --enable-gtk --enable-sdl \
>   --enable-capstone=3Dgit \
>   --enable-stack-protector \
>   --enable-gnutls \
>   --enable-nettle \
>   --enable-vnc \
>   --enable-vnc-sasl \
>   --enable-vnc-jpeg \
>   --enable-vnc-png \
>   --enable-membarrier \
>   --enable-slirp=3Dgit \
>   --disable-kvm \
>   --enable-hax \
>   --enable-whpx \
>   --disable-spice \
>   --enable-lzo \
>   --enable-snappy \
>   --enable-bzip2 \
>   --enable-vdi \
>   --enable-qcow1 \
>   --enable-tools \
>   --enable-libusb \
>   --enable-usb-redir \
>   --disable-libnfs \
>   --enable-libssh
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'aarch64-softmmu/qemu-system-aarch64': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'alpha-softmmu/qemu-system-alpha': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'arm-softmmu/qemu-system-arm': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'avr-softmmu/qemu-system-avr': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'cris-softmmu/qemu-system-cris': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'hppa-softmmu/qemu-system-hppa': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'i386-softmmu/qemu-system-i386': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'lm32-softmmu/qemu-system-lm32': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'm68k-softmmu/qemu-system-m68k': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'microblazeel-softmmu/qemu-system-microblazeel': No such file or direct=
ory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'microblaze-softmmu/qemu-system-microblaze': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'mips64el-softmmu/qemu-system-mips64el': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'mips64-softmmu/qemu-system-mips64': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'mipsel-softmmu/qemu-system-mipsel': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'mips-softmmu/qemu-system-mips': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'moxie-softmmu/qemu-system-moxie': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'nios2-softmmu/qemu-system-nios2': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'or1k-softmmu/qemu-system-or1k': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'ppc64-softmmu/qemu-system-ppc64': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'ppc-softmmu/qemu-system-ppc': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'riscv32-softmmu/qemu-system-riscv32': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'riscv64-softmmu/qemu-system-riscv64': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'rx-softmmu/qemu-system-rx': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 's390x-softmmu/qemu-system-s390x': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'sh4eb-softmmu/qemu-system-sh4eb': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'sh4-softmmu/qemu-system-sh4': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'sparc64-softmmu/qemu-system-sparc64': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'sparc-softmmu/qemu-system-sparc': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'tricore-softmmu/qemu-system-tricore': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'unicore32-softmmu/qemu-system-unicore32': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'x86_64-softmmu/qemu-system-x86_64': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'xtensaeb-softmmu/qemu-system-xtensaeb': No such file or directory
ln: =E6=97=A0=E6=B3=95=E5=88=9B=E5=BB=BA=E7=AC=A6=E5=8F=B7=E9=93=BE=E6=8E=
=A5 'xtensa-softmmu/qemu-system-xtensa': No such file or directory
cross containers  no

NOTE: guest cross-compilers enabled: cc
The Meson build system
Version: 0.55.0
Source dir: E:/CI-Cor-Ready/xemu/qemu.org
Build dir: E:/CI-Cor-Ready/xemu/qemu.org-x64
Build type: cross build
Using 'PKG_CONFIG_PATH' from environment with value: 'C:\\CI-Tools\\msys64\=
\mingw64\\lib\\pkgconfig;C:\\CI-Tools\\msys64\\mingw64\\share\\pkgconfig'
Project name: qemu
Project version: 5.1.50
C compiler for the build machine: cc (gcc 10.2.0 "cc (Rev1, Built by MSYS2 =
project) 10.2.0")
C linker for the build machine: cc ld.bfd 2.34
C compiler for the host machine: x86_64-w64-mingw32-gcc (gcc 10.2.0 "x86_64=
-w64-mingw32-gcc (Rev1, Built by MSYS2 project) 10.2.0")
C linker for the host machine: x86_64-w64-mingw32-gcc ld.bfd 2.34
Build machine cpu family: x86_64
Build machine cpu: x86_64
Host machine cpu family: x86
Host machine cpu: x86_64
Target machine cpu family: x86
Target machine cpu: x86_64
../qemu.org/meson.build:9: WARNING: Module unstable-keyval has no backwards=
 or forwards compatibility and might not exist in future releases.
Program sh found: YES
Program python3 found: YES (C:/CI-Tools/msys64/mingw64/bin/python3.exe)
C++ compiler for the host machine: x86_64-w64-mingw32-g++ (gcc 10.2.0 "x86_=
64-w64-mingw32-g++ (Rev1, Built by MSYS2 project) 10.2.0")
C++ linker for the host machine: x86_64-w64-mingw32-g++ ld.bfd 2.34
Configuring ninjatool using configuration
Library m found: YES
Library util found: NO
Library ws2_32 found: YES
Library winmm found: YES
Windows resource compiler: GNU windres (GNU Binutils) 2.34
Library aio found: NO
Library rt found: NO
Found pkg-config: C:\CI-Tools\msys64\mingw64\bin/x86_64-w64-mingw32-pkg-con=
fig.EXE (0.29.2)
Using 'PKG_CONFIG_PATH' from environment with value: 'C:\\CI-Tools\\msys64\=
\mingw64\\lib\\pkgconfig;C:\\CI-Tools\\msys64\\mingw64\\share\\pkgconfig'
Run-time dependency sdl2 found: YES 2.0.12
Found CMake: NO
Run-time dependency sdl-image found: NO (tried pkgconfig and cmake)
Using 'PKG_CONFIG_PATH' from environment with value: 'C:\\CI-Tools\\msys64\=
\mingw64\\lib\\pkgconfig;C:\\CI-Tools\\msys64\\mingw64\\share\\pkgconfig'
Run-time dependency libpng found: YES 1.6.37
Has header "jpeglib.h" : YES
Library jpeg found: YES
Has header "sasl/sasl.h" : YES
Library sasl2 found: YES
Configuring config-host.h using configuration
Program scripts/minikconf.py found: YES
Configuring aarch64-softmmu-config-target.h using configuration
Configuring aarch64-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/aarch64-so=
ftmmu-config-devices.mak.d
Configuring aarch64-softmmu-config-devices.h using configuration
Configuring alpha-softmmu-config-target.h using configuration
Configuring alpha-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/alpha-soft=
mmu-config-devices.mak.d
Configuring alpha-softmmu-config-devices.h using configuration
Configuring arm-softmmu-config-target.h using configuration
Configuring arm-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/arm-softmm=
u-config-devices.mak.d
Configuring arm-softmmu-config-devices.h using configuration
Configuring avr-softmmu-config-target.h using configuration
Configuring avr-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/avr-softmm=
u-config-devices.mak.d
Configuring avr-softmmu-config-devices.h using configuration
Configuring cris-softmmu-config-target.h using configuration
Configuring cris-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/cris-softm=
mu-config-devices.mak.d
Configuring cris-softmmu-config-devices.h using configuration
Configuring hppa-softmmu-config-target.h using configuration
Configuring hppa-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/hppa-softm=
mu-config-devices.mak.d
Configuring hppa-softmmu-config-devices.h using configuration
Configuring i386-softmmu-config-target.h using configuration
Configuring i386-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/i386-softm=
mu-config-devices.mak.d
Configuring i386-softmmu-config-devices.h using configuration
Configuring lm32-softmmu-config-target.h using configuration
Configuring lm32-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/lm32-softm=
mu-config-devices.mak.d
Configuring lm32-softmmu-config-devices.h using configuration
Configuring m68k-softmmu-config-target.h using configuration
Configuring m68k-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/m68k-softm=
mu-config-devices.mak.d
Configuring m68k-softmmu-config-devices.h using configuration
Configuring microblazeel-softmmu-config-target.h using configuration
Configuring microblazeel-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/microblaze=
el-softmmu-config-devices.mak.d
Configuring microblazeel-softmmu-config-devices.h using configuration
Configuring microblaze-softmmu-config-target.h using configuration
Configuring microblaze-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/microblaze=
-softmmu-config-devices.mak.d
Configuring microblaze-softmmu-config-devices.h using configuration
Configuring mips64el-softmmu-config-target.h using configuration
Configuring mips64el-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/mips64el-s=
oftmmu-config-devices.mak.d
Configuring mips64el-softmmu-config-devices.h using configuration
Configuring mips64-softmmu-config-target.h using configuration
Configuring mips64-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/mips64-sof=
tmmu-config-devices.mak.d
Configuring mips64-softmmu-config-devices.h using configuration
Configuring mipsel-softmmu-config-target.h using configuration
Configuring mipsel-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/mipsel-sof=
tmmu-config-devices.mak.d
Configuring mipsel-softmmu-config-devices.h using configuration
Configuring mips-softmmu-config-target.h using configuration
Configuring mips-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/mips-softm=
mu-config-devices.mak.d
Configuring mips-softmmu-config-devices.h using configuration
Configuring moxie-softmmu-config-target.h using configuration
Configuring moxie-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/moxie-soft=
mmu-config-devices.mak.d
Configuring moxie-softmmu-config-devices.h using configuration
Configuring nios2-softmmu-config-target.h using configuration
Configuring nios2-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/nios2-soft=
mmu-config-devices.mak.d
Configuring nios2-softmmu-config-devices.h using configuration
Configuring or1k-softmmu-config-target.h using configuration
Configuring or1k-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/or1k-softm=
mu-config-devices.mak.d
Configuring or1k-softmmu-config-devices.h using configuration
Configuring ppc64-softmmu-config-target.h using configuration
Configuring ppc64-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/ppc64-soft=
mmu-config-devices.mak.d
Configuring ppc64-softmmu-config-devices.h using configuration
Configuring ppc-softmmu-config-target.h using configuration
Configuring ppc-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/ppc-softmm=
u-config-devices.mak.d
Configuring ppc-softmmu-config-devices.h using configuration
Configuring riscv32-softmmu-config-target.h using configuration
Configuring riscv32-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/riscv32-so=
ftmmu-config-devices.mak.d
Configuring riscv32-softmmu-config-devices.h using configuration
Configuring riscv64-softmmu-config-target.h using configuration
Configuring riscv64-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/riscv64-so=
ftmmu-config-devices.mak.d
Configuring riscv64-softmmu-config-devices.h using configuration
Configuring rx-softmmu-config-target.h using configuration
Configuring rx-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/rx-softmmu=
-config-devices.mak.d
Configuring rx-softmmu-config-devices.h using configuration
Configuring s390x-softmmu-config-target.h using configuration
Configuring s390x-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/s390x-soft=
mmu-config-devices.mak.d
Configuring s390x-softmmu-config-devices.h using configuration
Configuring sh4eb-softmmu-config-target.h using configuration
Configuring sh4eb-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/sh4eb-soft=
mmu-config-devices.mak.d
Configuring sh4eb-softmmu-config-devices.h using configuration
Configuring sh4-softmmu-config-target.h using configuration
Configuring sh4-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/sh4-softmm=
u-config-devices.mak.d
Configuring sh4-softmmu-config-devices.h using configuration
Configuring sparc64-softmmu-config-target.h using configuration
Configuring sparc64-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/sparc64-so=
ftmmu-config-devices.mak.d
Configuring sparc64-softmmu-config-devices.h using configuration
Configuring sparc-softmmu-config-target.h using configuration
Configuring sparc-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/sparc-soft=
mmu-config-devices.mak.d
Configuring sparc-softmmu-config-devices.h using configuration
Configuring tricore-softmmu-config-target.h using configuration
Configuring tricore-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/tricore-so=
ftmmu-config-devices.mak.d
Configuring tricore-softmmu-config-devices.h using configuration
Configuring unicore32-softmmu-config-target.h using configuration
Configuring unicore32-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/unicore32-=
softmmu-config-devices.mak.d
Configuring unicore32-softmmu-config-devices.h using configuration
Configuring x86_64-softmmu-config-target.h using configuration
Configuring x86_64-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/x86_64-sof=
tmmu-config-devices.mak.d
Configuring x86_64-softmmu-config-devices.h using configuration
Configuring xtensaeb-softmmu-config-target.h using configuration
Configuring xtensaeb-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/xtensaeb-s=
oftmmu-config-devices.mak.d
Configuring xtensaeb-softmmu-config-devices.h using configuration
Configuring xtensa-softmmu-config-target.h using configuration
Configuring xtensa-softmmu-config-devices.mak with command
Reading depfile: E:/CI-Cor-Ready/xemu/qemu.org-x64/meson-private/xtensa-sof=
tmmu-config-devices.mak.d
Configuring xtensa-softmmu-config-devices.h using configuration
Program scripts/grepy.sh found: YES
Configuring config-all-devices.mak with command
Program scripts/hxtool found: YES
Program scripts/shaderinclude.pl found: YES
Program scripts/qapi-gen.py found: YES
Program scripts/qemu-version.sh found: YES
Run-time dependency threads found: YES
Program keycodemapdb/tools/keymap-gen found: YES
Program scripts/decodetree.py found: YES
Program ../scripts/modules/module_block.py found: YES
Program x86_64-w64-mingw32-nm found: YES
Program scripts/undefsym.sh found: YES
Program scripts/feature_to_c.sh found: YES
Program wixl found: NO
Program bzip2 found: YES
Configuring 50-edk2-i386-secure.json using configuration
Configuring 50-edk2-x86_64-secure.json using configuration
Configuring 60-edk2-aarch64.json using configuration
Configuring 60-edk2-arm.json using configuration
Configuring 60-edk2-i386.json using configuration
Configuring 60-edk2-x86_64.json using configuration
Program diff found: YES
Build targets in project: 331

qemu 5.1.50

            Install prefix: c:/Program Files/QEMU
            BIOS directory: c:/Program Files/QEMU
             firmware path: ${prefix}/share/qemu-firmware
          binary directory: c:/Program Files/QEMU
         library directory: c:/Program Files/QEMU/lib
          module directory: c:/Program Files/QEMU/lib
         libexec directory: c:/Program Files/QEMU/libexec
         include directory: c:/Program Files/QEMU/include
          config directory: c:/Program Files/QEMU
     local state directory: queried at runtime
           Build directory: E:/CI-Cor-Ready/xemu/qemu.org-x64
               Source path: E:/CI-Cor-Ready/xemu/qemu.org
                GIT binary: git
            GIT submodules: ui/keycodemapdb tests/fp/berkeley-testfloat-3 t=
ests/fp/berkeley-softfloat-3 meson dtc capstone slirp
                C compiler: x86_64-w64-mingw32-gcc
           Host C compiler: cc
              C++ compiler: x86_64-w64-mingw32-g++
                   ARFLAGS: rv
                    CFLAGS: -O2 -g -fPIE -DPIE -mthreads -std=3Dgnu99 -Wall
               QEMU_CFLAGS: -IC:/CI-Tools/msys64/mingw64/include/pixman-1 -=
I/e/CI-Cor-Ready/xemu/qemu.org/dtc/libfdt -Werror -U_FORTIFY_SOURCE -D_FORT=
IFY_SOURCE=3D2 -IC:/CI-Tools/msys64/mingw64/include -pthread -mms-bitfields=
 -IC:/CI-Tools/msys64/mingw64/include -IC:/CI-Tools/msys64/mingw64/include/=
glib-2.0 -IC:/CI-Tools/msys64/mingw64/lib/glib-2.0/include -IC:/CI-Tools/ms=
ys64/mingw64/include -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_=
LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wundef -Wwrite-stri=
ngs -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv  -Wold-st=
yle-declaration -Wold-style-definition -Wtype-limits -Wformat-security -Wfo=
rmat-y2k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs -We=
ndif-labels -Wexpansion-to-defined -Wno-missing-include-dirs -Wno-shift-neg=
ative-value -Wno-psabi -fstack-protector-strong -IC:/CI-Tools/msys64/mingw6=
4/include -IC:/CI-Tools/msys64/mingw64/include/p11-kit-1 -IC:/CI-Tools/msys=
64/mingw64/include -I/e/CI-Cor-Ready/xemu/qemu.org/capstone/include
              QEMU_LDFLAGS: -L/e/CI-Cor-Ready/xemu/qemu.org-x64/dtc/libfdt =
-m64  -fstack-protector-strong
                      make: make
                   install: install
                    python: C:/CI-Tools/msys64/mingw64/bin/python3.exe (ver=
sion: 3.8)
              sphinx-build:
               genisoimage:
             slirp support: YES
                      smbd: "/usr/sbin/smbd"
            module support: NO
                  host CPU: x86
           host endianness: little
               target list: aarch64-softmmu alpha-softmmu arm-softmmu avr-s=
oftmmu cris-softmmu hppa-softmmu i386-softmmu lm32-softmmu m68k-softmmu mic=
roblazeel-softmmu microblaze-softmmu mips64el-softmmu mips64-softmmu mipsel=
-softmmu mips-softmmu moxie-softmmu nios2-softmmu or1k-softmmu ppc64-softmm=
u ppc-softmmu riscv32-softmmu riscv64-softmmu rx-softmmu s390x-softmmu sh4e=
b-softmmu sh4-softmmu sparc64-softmmu sparc-softmmu tricore-softmmu unicore=
32-softmmu x86_64-softmmu xtensaeb-softmmu xtensa-softmmu
             gprof enabled: NO
            sparse enabled: NO
            strip binaries: YES
                  profiler: NO
              static build: YES
               SDL support: YES
         SDL image support: NO
               GTK support: YES
            GTK GL support: NO
               VTE support: NO
              TLS priority: "NORMAL"
            GNUTLS support: YES
                 libgcrypt: NO
                    nettle: YES
                       XTS: YES
                  libtasn1: YES
                       PAM: NO
             iconv support: YES
            curses support: NO
             virgl support: NO
              curl support: YES
           mingw32 support: YES
             Audio drivers: dsound
      Block whitelist (rw):
      Block whitelist (ro):
            VirtFS support: NO
         Multipath support: NO
               VNC support: YES
          VNC SASL support: YES
          VNC JPEG support: YES
           VNC PNG support: YES
               xen support: NO
            brlapi support: NO
             Documentation: NO
                       PIE: YES
               vde support: NO
            netmap support: NO
         Linux AIO support: NO
    Linux io_uring support: NO
        ATTR/XATTR support: NO
             Install blobs: YES
       malloc trim support: NO
              RDMA support: NO
            PVRDMA support: NO
               fdt support: YES
                membarrier: YES
            preadv support: NO
                 fdatasync: NO
                   madvise: NO
             posix_madvise: NO
            posix_memalign: NO
         libcap-ng support: NO
         vhost-net support: NO
      vhost-crypto support: NO
        vhost-scsi support: NO
       vhost-vsock support: NO
        vhost-user support: NO
     vhost-user-fs support: NO
        vhost-vdpa support: NO
            Trace backends: log
             spice support: NO
               rbd support: NO
            xfsctl support: NO
         smartcard support: NO
                    libusb: YES
             usb net redir: YES
            OpenGL support: NO
            OpenGL dmabufs: NO
          libiscsi support: NO
            libnfs support: NO
         build guest agent: YES
           QGA VSS support: NO
         QGA w32 disk info: YES
           QGA MSI support: NO
           seccomp support: NO
         coroutine backend: win32
            coroutine pool: YES
         debug stack usage: NO
           mutex debugging: NO
              crypto afalg: NO
         GlusterFS support: NO
                      gcov: NO
               TPM support: NO
            libssh support: YES
             QOM debugging: YES
      Live block migration: YES
               lzo support: YES
            snappy support: YES
             bzip2 support: YES
             lzfse support: NO
              zstd support: YES
         NUMA host support: NO
                   libxml2: YES
          tcmalloc support: NO
          jemalloc support: NO
         avx2 optimization: YES
      avx512f optimization: NO
       replication support: YES
             bochs support: YES
             cloop support: YES
               dmg support: YES
           qcow v1 support: YES
               vdi support: YES
             vvfat support: YES
               qed support: YES
         parallels support: YES
          sheepdog support: YES
                  capstone: YES
           libpmem support: NO
         libdaxctl support: NO
                   libudev: NO
           default devices: YES
            plugin support: NO
           fuzzing support: NO
                       gdb: /mingw64/bin/gdb
          thread sanitizer: NO
                  rng-none: NO
             Linux keyring: NO

Traceback (most recent call last):
  File "E:/CI-Cor-Ready/xemu/qemu.org/meson/mesonbuild/mesonmain.py", line =
131, in run
    return options.run_func(options)
  File "E:/CI-Cor-Ready/xemu/qemu.org/meson/mesonbuild/msetup.py", line 245=
, in run
    app.generate()
  File "E:/CI-Cor-Ready/xemu/qemu.org/meson/mesonbuild/msetup.py", line 159=
, in generate
    self._generate(env)
  File "E:/CI-Cor-Ready/xemu/qemu.org/meson/mesonbuild/msetup.py", line 215=
, in _generate
    intr.backend.generate()
  File "E:/CI-Cor-Ready/xemu/qemu.org/meson/mesonbuild/backend/ninjabackend=
.py", line 483, in generate
    ninja =3D environment.detect_ninja_command_and_version(log=3DTrue)
  File "E:/CI-Cor-Ready/xemu/qemu.org/meson/mesonbuild/environment.py", lin=
e 167, in detect_ninja_command_and_version
    p, found =3D Popen_safe([n, '--version'])[0:2]
  File "E:/CI-Cor-Ready/xemu/qemu.org/meson/mesonbuild/mesonlib.py", line 1=
197, in Popen_safe
    p, o, e =3D Popen_safe_legacy(args, write=3Dwrite, stdout=3Dstdout, std=
err=3Dstderr, **kwargs)
  File "E:/CI-Cor-Ready/xemu/qemu.org/meson/mesonbuild/mesonlib.py", line 1=
213, in Popen_safe_legacy
    p =3D subprocess.Popen(args, universal_newlines=3DFalse, close_fds=3DFa=
lse,
  File "C:/CI-Tools/msys64/mingw64/lib/python3.8/subprocess.py", line 854, =
in __init__
    self._execute_child(args, executable, preexec_fn, close_fds,
  File "C:/CI-Tools/msys64/mingw64/lib/python3.8/subprocess.py", line 1307,=
 in _execute_child
    hp, ht, pid, tid =3D _winapi.CreateProcess(executable, args,
OSError: [WinError 193] %1 =E4=B8=8D=E6=98=AF=E6=9C=89=E6=95=88=E7=9A=84 Wi=
n32 =E5=BA=94=E7=94=A8=E7=A8=8B=E5=BA=8F=E3=80=82

ERROR: meson setup failed
```

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

