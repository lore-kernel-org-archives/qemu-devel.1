Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EBDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC3A20723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC3A20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnej6-0006pG-PV
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jneiW-00064Z-QY
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:55:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:49500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jneiT-0005Q3-IO
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:55:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jneiQ-0004bm-TS
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 08:55:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B8A472E8109
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 08:55:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2020 08:40:59 -0000
From: Harshit Monish <1884728@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: harshitm
X-Launchpad-Bug-Reporter: Harshit Monish (harshitm)
X-Launchpad-Bug-Modifier: Harshit Monish (harshitm)
Message-Id: <159290165958.6424.14085230914697784861.malonedeb@soybean.canonical.com>
Subject: [Bug 1884728] [NEW] facing build error for qemu-4.0.0 on SUSE11 OS
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c51e5bbb255a2428d9faab993caf10e48edc8ff1
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

Public bug reported:

I am trying to compile qemu-4.0.0 on suse11 OS and facing the following err=
or on the console:
ERROR: sizeof(size_t) doesn't match GLIB_SIZEOF_SIZE_T.
       You probably need to set PKG_CONFIG_LIBDIR
       to point to the right pkg-config files for your
       build target

Looking into the config.log file following is the error that is listed:

config-temp/qemu-conf.c:12:11: error: 'WACS_DEGREE' undeclared (first use i=
n this function)
   add_wch(WACS_DEGREE);
           ^
config-temp/qemu-conf.c:12:11: note: each undeclared identifier is reported=
 only once for each function it appears in

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

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "attaching the config.log file."
   https://bugs.launchpad.net/bugs/1884728/+attachment/5386371/+files/confi=
g.log

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

