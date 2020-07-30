Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3001EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C262074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C262074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k16jX-0005x4-7X
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 07:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k16hP-0003Qb-Gi
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:26:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:36412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k16hN-000555-BF
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:26:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k16hL-0008Vl-Er
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 11:26:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6C6872E80D2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 11:26:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2020 11:10:21 -0000
From: Peter Maydell <1884728@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: harshitm pmaydell
X-Launchpad-Bug-Reporter: Harshit Monish (harshitm)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <159290165958.6424.14085230914697784861.malonedeb@soybean.canonical.com>
Message-Id: <159610742259.15668.8139067498206465921.launchpad@wampee.canonical.com>
Subject: [Bug 1884728] Re: facing build error for qemu-4.0.0 on SUSE11 OS
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4feff074cda563ec7bf4933f0633e51053bfb9a4
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 07:16:04
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
Reply-To: Bug 1884728 <1884728@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> Incomplete

** Changed in: qemu
       Status: Incomplete =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1884728

Title:
  facing build error for qemu-4.0.0 on SUSE11 OS

Status in QEMU:
  Invalid

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

