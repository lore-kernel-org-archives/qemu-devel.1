Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07741C282DD
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 04:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2B020863
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 04:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2B020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34229 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCzSj-0002HZ-0q
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 00:31:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hCzRF-0001DK-4S
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 00:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hCzRD-0007uW-Ml
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 00:29:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:47092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hCzRD-0007u7-ED
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 00:29:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hCzRC-0007mo-I3
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 04:29:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 790A32E8084
	for <qemu-devel@nongnu.org>; Sun,  7 Apr 2019 04:29:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Apr 2019 04:17:23 -0000
From: Launchpad Bug Tracker <1545024@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor pmaydell th-huth w-fe2ix-0
X-Launchpad-Bug-Reporter: Klaftenegger Felix (w-fe2ix-0)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20160212151339.32708.72568.malonedeb@gac.canonical.com>
Message-Id:
 <155461064348.28623.13017141328882015551.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e0013a20b25504c3a10d5dec3c82210a4bb36809
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1545024] Re: compiling on armv7 crashes compile
 qlx.o
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1545024 <1545024@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190407041723.HCGJ5W8bZC_GkGdVydBR9TPqUMLv7Yvo_tGQlFyw-BY@z>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1545024

Title:
  compiling on armv7 crashes compile qlx.o

Status in QEMU:
  Expired

Bug description:
  If i try to compile qemu on armv7 cpu i get this error:

    LINK  qemu-nbd
    CC    qemu-img.o
    LINK  qemu-img
    LINK  qemu-io
    LINK  qemu-bridge-helper
    CC    qmp-marshal.o
    CC    hw/display/qxl.o
  {standard input}: Assembler messages:
  {standard input}:1704: Error: bad instruction `lock'
  {standard input}:1704: Error: bad instruction `addl $0,0(%rsp)'
  {standard input}:1864: Error: bad instruction `lock'
  {standard input}:1864: Error: bad instruction `addl $0,0(%rsp)'
  {standard input}:5239: Error: bad instruction `lock'
  {standard input}:5239: Error: bad instruction `addl $0,0(%rsp)'
  {standard input}:5731: Error: bad instruction `lock'
  {standard input}:5731: Error: bad instruction `addl $0,0(%rsp)'
  {standard input}:11923: Error: bad instruction `lock'
  {standard input}:11923: Error: bad instruction `addl $0,0(%rsp)'
  {standard input}:13960: Error: bad instruction `lock'
  {standard input}:13960: Error: bad instruction `addl $0,0(%rsp)'
  {standard input}:14349: Error: bad instruction `lock'
  {standard input}:14349: Error: bad instruction `addl $0,0(%rsp)'
  /home/fleixi/git/qemu/rules.mak:57: recipe for target 'hw/display/qxl.o' =
failed
  make: *** [hw/display/qxl.o] Error 1

  Build options are:

   ./configure --target-list=3Di386-softmmu
  Install prefix    /usr/local
  BIOS directory    /usr/local/share/qemu
  binary directory  /usr/local/bin
  library directory /usr/local/lib
  module directory  /usr/local/lib/qemu
  libexec directory /usr/local/libexec
  include directory /usr/local/include
  config directory  /usr/local/etc
  local state directory   /usr/local/var
  Manual directory  /usr/local/share/man
  ELF interp prefix /usr/gnemul/qemu-%M
  Source path       /home/fleixi/git/qemu
  C compiler        cc
  Host C compiler   cc
  C++ compiler      c++
  Objective-C compiler cc
  ARFLAGS           rv
  CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -pthread -I=
/usr/include/glib-2.0 -I/usr/lib/arm-linux-gnueabihf/glib-2.0/include  -g -=
mcpu=3Dcortex-a15.cortex-a7 -mfloat-abi=3Dhard -mfpu=3Dneon-vfpv4 -O2 -pipe=
 -ffast-math -ftree-vectorize -mvectorize-with-neon-quad -fstack-protector =
--param=3Dssp-buffer-size=3D4
  QEMU_CFLAGS       -I/usr/include/pixman-1   -Werror  -D_GNU_SOURCE -D_FIL=
E_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decl=
s -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -=
fno-common  -Wendif-labels -Wmissing-include-dirs -Wempty-body -Wnested-ext=
erns -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-=
style-declaration -Wold-style-definition -Wtype-limits -fstack-protector-st=
rong   -I/usr/include/libpng12  -I/usr/local/include/spice-server -I/usr/lo=
cal/include -I/usr/local/include/spice-1 -I/usr/include/glib-2.0 -I/usr/lib=
/arm-linux-gnueabihf/glib-2.0/include -I/usr/include/pixman-1 =

  LDFLAGS           -Wl,--warn-common -g =

  make              make
  install           install
  python            python -B
  smbd              /usr/sbin/smbd
  module support    no
  host CPU          arm
  host big endian   no
  target list       i386-softmmu
  tcg debug enabled no
  gprof enabled     no
  sparse enabled    no
  strip binaries    yes
  profiler          no
  static build      no
  pixman            system
  SDL support       no
  GTK support       yes
  GTK GL support    no
  GNUTLS support    no
  GNUTLS hash       no
  libgcrypt         no
  nettle            no
  libtasn1          no
  VTE support       no
  curses support    no
  virgl support     no
  curl support      yes
  mingw32 support   no
  Audio drivers     oss
  Block whitelist (rw) =

  Block whitelist (ro) =

  VirtFS support    no
  VNC support       yes
  VNC SASL support  yes
  VNC JPEG support  yes
  VNC PNG support   yes
  xen support       no
  brlapi support    no
  bluez  support    yes
  Documentation     no
  PIE               no
  vde support       no
  netmap support    no
  Linux AIO support no
  ATTR/XATTR support yes
  Install blobs     yes
  KVM support       yes
  RDMA support      no
  TCG interpreter   no
  fdt support       no
  preadv support    yes
  fdatasync         yes
  madvise           yes
  posix_madvise     yes
  sigev_thread_id   yes
  uuid support      no
  libcap-ng support no
  vhost-net support yes
  vhost-scsi support yes
  Trace backends    log
  spice support     yes (0.12.10/0.12.6)
  rbd support       no
  xfsctl support    no
  smartcard support no
  libusb            no
  usb net redir     no
  OpenGL support    no
  libiscsi support  no
  libnfs support    no
  build guest agent yes
  QGA VSS support   no
  QGA w32 disk info no
  QGA MSI support   no
  seccomp support   no
  coroutine backend ucontext
  coroutine pool    yes
  GlusterFS support no
  Archipelago support no
  gcov              gcov
  gcov enabled      no
  TPM support       yes
  libssh2 support   no
  TPM passthrough   no
  QOM debugging     yes
  vhdx              no
  lzo support       no
  snappy support    no
  bzip2 support     yes
  NUMA host support no
  tcmalloc support  no
  jemalloc support  no

  testet with  qemu-git branch stable-2.4 and git master

  Shoulded the configure detecting "bigendian" too?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1545024/+subscriptions

