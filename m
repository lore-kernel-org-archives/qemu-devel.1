Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1E1C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 15:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01472078E
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 15:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01472078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEa5U-000269-IU
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 11:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kEa4a-0001JY-J7
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 11:25:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:48992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kEa4Y-0003KZ-4H
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 11:25:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kEa4V-0004wG-Gb
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 15:25:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7589E2E80EA
 for <qemu-devel@nongnu.org>; Sat,  5 Sep 2020 15:25:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2020 15:19:57 -0000
From: kallisti5 <1715203@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kallisti5 pmaydell th-huth
X-Launchpad-Bug-Reporter: kallisti5 (kallisti5)
X-Launchpad-Bug-Modifier: kallisti5 (kallisti5)
References: <150463414707.19543.9931062189110648888.malonedeb@chaenomeles.canonical.com>
Message-Id: <159931919775.32377.17001798687973294531.malone@wampee.canonical.com>
Subject: [Bug 1715203] Re: Maintain Haiku support
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="90a5703803d95539bdb5c0b289b1675630569e1e"; Instance="production"
X-Launchpad-Hash: 9289f9a0af38bced2d411723a5c0a120a890aa59
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/05 10:55:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1715203 <1715203@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

and away we go..

./haiku.x86_64 --image /tmp/haiku.img --build-qemu /home/kallisti5/Code/qemu
Submodule 'dtc' (https://git.qemu.org/git/dtc.git) registered for path 'dtc'
Submodule 'slirp' (https://git.qemu.org/git/libslirp.git) registered for pa=
th 'slirp'
Submodule 'meson' (https://github.com/mesonbuild/meson/) registered for pat=
h 'meson'
Submodule 'ui/keycodemapdb' (https://git.qemu.org/git/keycodemapdb.git) reg=
istered for path 'ui/keycodemapdb'
Submodule 'tests/fp/berkeley-softfloat-3' (https://git.qemu.org/git/berkele=
y-softfloat-3.git) registered for path 'tests/fp/berkeley-softfloat-3'
Submodule 'tests/fp/berkeley-testfloat-3' (https://git.qemu.org/git/berkele=
y-testfloat-3.git) registered for path 'tests/fp/berkeley-testfloat-3'
cross containers  no

NOTE: guest cross-compilers enabled: cc
The Meson build system
Version: 0.55.1
Source dir: /boot/system/cache/tmp/qemu-test.oCwd7u/src
Build dir: /boot/system/cache/tmp/qemu-test.oCwd7u/build
Build type: native build
Project name: qemu
Project version: 5.1.50
C compiler for the host machine: cc (gcc 8.3.0 "cc (2019_05_24) 8.3.0")
C linker for the host machine: cc ld.bfd 2.31.1
Host machine cpu family: x86_64
Host machine cpu: x86_64
../src/meson.build:10: WARNING: Module unstable-keyval has no backwards or =
forwards compatibility and might not exist in future releases.
Program sh found: YES
Program python3 found: YES (/boot/system/bin/python3)
C++ compiler for the host machine: c++ (gcc 8.3.0 "c++ (2019_05_24) 8.3.0")
C++ linker for the host machine: c++ ld.bfd 2.31.1
Configuring ninjatool using configuration
Library m found: YES
Library util found: NO
Library posix_error_mapper found: YES
Library network found: YES
Library bsd found: YES
Found pkg-config: /boot/system/bin/pkg-config (0.29.2)
Run-time dependency pixman-1 found: YES 0.38.4
Library aio found: NO
Run-time dependency zlib found: YES 1.2.11
Run-time dependency xkbcommon found: NO (tried pkgconfig)
Library rt found: NO
Run-time dependency sdl2 found: YES 2.0.10
Run-time dependency sdl2_image found: NO (tried pkgconfig)
Run-time dependency libpng found: YES 1.6.37
Has header "jpeglib.h" : YES =

.
.
/boot/system/cache/tmp/qemu-test.oCwd7u/src/slirp/src/tftp.c:113:50: error:=
 'O_BINARY' undeclared (first use in this function); did you mean 'L_INCR'?
         spt->fd =3D open(spt->filename, O_RDONLY | O_BINARY);
                                                  ^~~~~~~~
                                                  L_INCR
/boot/system/cache/tmp/qemu-test.oCwd7u/src/slirp/src/tftp.c:113:50: note: =
each undeclared identifier is reported only once for each function it appea=
rs in
Makefile:45: recipe for target '/boot/system/cache/tmp/qemu-test.oCwd7u/bui=
ld/slirp/src/tftp.o' failed
make[1]: *** [/boot/system/cache/tmp/qemu-test.oCwd7u/build/slirp/src/tftp.=
o] Error 1
make[1]: Leaving directory '/boot/system/cache/tmp/qemu-test.oCwd7u/src/sli=
rp'
make[1]: *** Waiting for unfinished jobs....
make[1]: Entering directory '/boot/system/cache/tmp/qemu-test.oCwd7u/src/sl=
irp'
  CC      /boot/system/cache/tmp/qemu-test.oCwd7u/build/slirp/src/util.o
make[1]: Leaving directory '/boot/system/cache/tmp/qemu-test.oCwd7u/src/sli=
rp'
make[1]: Entering directory '/boot/system/cache/tmp/qemu-test.oCwd7u/src/sl=
irp'
  CC      /boot/system/cache/tmp/qemu-test.oCwd7u/build/slirp/src/ip6_outpu=
t.o
make[1]: Leaving directory '/boot/system/cache/tmp/qemu-test.oCwd7u/src/sli=
rp'
make[1]: Entering directory '/boot/system/cache/tmp/qemu-test.oCwd7u/src/sl=
irp'
  CC      /boot/system/cache/tmp/qemu-test.oCwd7u/build/slirp/src/state.o
make[1]: Leaving directory '/boot/system/cache/tmp/qemu-test.oCwd7u/src/sli=
rp'
make[1]: Entering directory '/boot/system/cache/tmp/qemu-test.oCwd7u/src/sl=
irp'
  CC      /boot/system/cache/tmp/qemu-test.oCwd7u/build/slirp/src/misc.o
make[1]: Leaving directory '/boot/system/cache/tmp/qemu-test.oCwd7u/src/sli=
rp'
make[1]: Entering directory '/boot/system/cache/tmp/qemu-test.oCwd7u/src/sl=
irp'
  CC      /boot/system/cache/tmp/qemu-test.oCwd7u/build/slirp/src/bootp.o
make[1]: Leaving directory '/boot/system/cache/tmp/qemu-test.oCwd7u/src/sli=
rp'
make[1]: *** wait: No child process.  Stop.
Makefile:178: recipe for target 'slirp/all' failed
make: *** [slirp/all] Error 2
make: *** Waiting for unfinished jobs....
python3 -B /tmp/qemu-test.oCwd7u/src/meson/meson.py introspect --tests | py=
thon3 -B scripts/mtest2make.py > Makefile.mtest
./ninjatool -t ninja2make --omit clean dist uninstall cscope TAGS ctags < b=
uild.ninja > Makefile.ninja


It looks like we have a few out-of-tree patches to fix that:

https://github.com/haikuports/haikuports/blob/master/app-
emulation/qemu/patches/qemu-2.11.1.patchset

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715203

Title:
  Maintain Haiku support

Status in QEMU:
  Incomplete

Bug description:
  It was pointed out that the 2.10 release notes are pushing to drop
  Haiku support.  The qemu port is currently working as-is under Haiku.

  Was there a reason this was recommended? Is there anything Haiku can
  do to keep it from being dropped?

  We're working on a docker container to cross-compile rust-lang for
  Haiku, could this be of some use to qemu when complete?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715203/+subscriptions

