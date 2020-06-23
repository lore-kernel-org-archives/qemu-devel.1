Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EA7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B9C20738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B9C20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnf2V-0006oL-HI
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jnf1t-0006OA-3Y
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:15:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:52382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jnf1q-0008Ah-AV
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:15:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jnf1o-0006fz-5B
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 09:15:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 258312E80E7
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 09:15:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2020 09:09:50 -0000
From: Peter Maydell <1884728@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: harshitm pmaydell
X-Launchpad-Bug-Reporter: Harshit Monish (harshitm)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <159290165958.6424.14085230914697784861.malonedeb@soybean.canonical.com>
Message-Id: <159290339093.17802.1234849895711932446.malone@chaenomeles.canonical.com>
Subject: [Bug 1884728] Re: facing build error for qemu-4.0.0 on SUSE11 OS
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e9e8454a0b170824a5e2dd16ca4a8146720746a4
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 03:45:43
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
Reply-To: Bug 1884728 <1884728@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The part of the log you quote isn't the part which caused the failure.
This bit is:


funcs: do_compiler do_cc compile_prog main
lines: 92 128 3672 0
/grid/avs/install/xcelium/1803/latest//tools/cdsgcc/gcc/bin/64bit/gcc -pthr=
ead -I/grid/common/pkgs/glib/v2.56.1/include/glib-2.0 -I/grid/common/pkgs/g=
lib/v2.56.1/lib/glib-2.0/include -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_B=
ITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -W=
undef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common=
 -fwrapv -std=3Dgnu99 -fPIC -I/grid/cva/p4_04/harshitm/ltssm_sj/panda/dev/s=
rc//Xtor/include -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wne=
sted-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifier=
s -Wold-style-declaration -Wold-style-definition -Wtype-limits -Wno-missing=
-braces -o config-temp/qemu-conf.exe config-temp/qemu-conf.c -m64 -L/grid/c=
va/p4_04/harshitm/ltssm_sj/panda/dev/src//Xtor/lib -L/usr/lib/ -pthread -L/=
grid/common/pkgs/glib/v2.56.1/lib -lgthread-2.0 -lrt -lglib-2.0
ld: skipping incompatible /usr/lib//librt.so when searching for -lrt
ld: skipping incompatible /usr/lib//librt.a when searching for -lrt
ld: skipping incompatible /usr/lib//libpthread.so when searching for -lpthr=
ead
ld: skipping incompatible /usr/lib//libpthread.a when searching for -lpthre=
ad
ld: skipping incompatible /usr/lib//libc.so when searching for -lc
ld: skipping incompatible /usr/lib//libc.a when searching for -lc
/grid/common/pkgs/glib/v2.56.1/lib/libglib-2.0.so: undefined reference to `=
pthread_setname_np@GLIBC_2.12'
collect2: error: ld returned 1 exit status


That is, we tried to link against libglib, and it failed, because the compi=
ler couldn't find a working pthread library. I see from your configure opti=
ons that you're specifying a different C compiler and also different librar=
ies:

'--cc=3D/grid/avs/install/xcelium/1803/latest//tools/cdsgcc/gcc/bin/64bit/g=
cc'
'--extra-cflags=3D-I/grid/cva/p4_04/harshitm/ltssm_sj/panda/dev/src//Xtor/i=
nclude'
'--extra-ldflags=3D-L/grid/cva/p4_04/harshitm/ltssm_sj/panda/dev/src//Xtor/=
lib'
'--extra-ldflags=3D-L/usr/lib/'
'--cxx=3D/usr/bin/g++'

This is what's causing your problem -- the compile has picked up a
version of libglib from whatever this /grid/ stuff is
(/grid/common/pkgs/glib/v2.56.1/lib/libglib-2.0.so) but you're trying to
get it to look for system libraries in /usr/lib when they are not
compatible with the toolchain you're using (ld complains about them
being incompatible). Trying to use this /grid/ gcc and the system g++ is
probably not going to work very well either.

I think you need to either:
 (1) drop all this /grid/ tooling and use the system compiler and libraries=
 to build QEMU
 (2) don't try to use the system compiler and libraries at all, instead mak=
e sure you have all the libraries and tools you need in /grid/ (including t=
he C++ compiler and the pthread library and the C library), and don't tell =
configure to add the system libraries to the search path

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1884728

Title:
  facing build error for qemu-4.0.0 on SUSE11 OS

Status in QEMU:
  New

Bug description:
  I am trying to compile qemu-4.0.0 on suse11 OS and facing the following e=
rror on the console:
  ERROR: sizeof(size_t) doesn't match GLIB_SIZEOF_SIZE_T.
         You probably need to set PKG_CONFIG_LIBDIR
         to point to the right pkg-config files for your
         build target

  Looking into the config.log file following is the error that is
  listed:

  config-temp/qemu-conf.c:12:11: error: 'WACS_DEGREE' undeclared (first use=
 in this function)
     add_wch(WACS_DEGREE);
             ^
  config-temp/qemu-conf.c:12:11: note: each undeclared identifier is report=
ed only once for each function it appears in

  ld: skipping incompatible /usr/lib//libc.so when searching for -lc
  ld: skipping incompatible /usr/lib//libc.a when searching for -lc
  /tmp/ccmme6E4.o: In function `main':
  qemu-conf.c:(.text+0x2b): undefined reference to `resize_term'
  qemu-conf.c:(.text+0x32): undefined reference to `stdscr'
  qemu-conf.c:(.text+0x49): undefined reference to `waddnwstr'
  qemu-conf.c:(.text+0x50): undefined reference to `stdscr'
  qemu-conf.c:(.text+0x67): undefined reference to `waddnwstr'
  qemu-conf.c:(.text+0x6e): undefined reference to `_nc_wacs'
  qemu-conf.c:(.text+0x7f): undefined reference to `stdscr'
  qemu-conf.c:(.text+0x8d): undefined reference to `wadd_wch'
  collect2: error: ld returned 1 exit status

  Following are the details of the tools versions:
  OS version =3D SUSE Linux Enterprise Server 11 (x86_64)
  python =3D v2.7.10
  glib =3D v2.56.1
  gcc =3D v4.8.3
  sdl2 =3D v2.0.12

  Can someone help me understand the cause of this error?

  regards,
  Harshit

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1884728/+subscriptions

