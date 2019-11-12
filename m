Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28B8C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 12:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C5B20679
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 12:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C5B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUV6I-0003ad-13
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 07:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iUV5C-00034k-4c
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 07:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iUV59-0006WD-Jf
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 07:15:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:59848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iUV59-0006W4-Dg
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 07:15:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iUV58-0006HW-7u
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 12:15:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3ACB82E80C8
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 12:15:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Nov 2019 12:08:20 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: crobinso pmaydell
X-Launchpad-Bug-Reporter: Cole Robinson (crobinso)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <157349721480.22191.14354362512617460510.malonedeb@soybean.canonical.com>
Message-Id: <157356050060.22400.2870380016046969133.malone@chaenomeles.canonical.com>
Subject: [Bug 1852115] Re: qemu --static user build fails with fedora rawhide
 glibc-2.30.9000
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 49d60c57adeca201842d4ec5c2e37e693e8e0dd3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1852115 <1852115@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We use stime() to implement the target stime syscall. We should probably
switch to using clock_settime(CLOCK_REALTIME, ...) instead, as that's
what glibc uses internally now to implement its stime():

https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dtime/stime.c;h=3D6ea=
3b6dcc1a393b57b69ca24fbfe8023d9095837;hb=3D12cbde1dae6fa4a9a792b64564c7e0de=
bf7544cc


** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1852115

Title:
  qemu --static user build fails with fedora rawhide glibc-2.30.9000

Status in QEMU:
  Confirmed

Bug description:
  Building qemu latest git 654efcb511d on fedora rawhide fails with this
  configure line:

  ./configure \
  	--static \
  	--disable-system \
  	--enable-linux-user \
  	--disable-werror \
  	--disable-tools \
  	--disable-capstone

  make fails with:

  /usr/bin/ld: linux-user/syscall.o: in function `do_syscall1':
  /root/qemu.git/linux-user/syscall.c:7769: undefined reference to `stime'
  collect2: error: ld returned 1 exit status

  Seems related to this glibc change:
  https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3D12cbde1dae6fa4a9=
a792b64564c7e0debf7544cc

  ...

  +* The obsolete function stime is no longer available to newly linked
  +  binaries and it has been removed from <time.h> header.  This function
  +  has been deprecated in favor of clock_settime.
  +

  # rpm -q glibc
  glibc-2.30.9000-17.fc32.x86_64

  =

  FWIW there's some other messages but I don't think they are fatal:

  /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/9/../../../../lib64/libglib=
-2.0.a(gutils.c.o): in function `g_get_user_database_entry':
  (.text+0x267): warning: Using 'getpwuid' in statically linked application=
s requires at runtime the shared libraries from the glibc version used for =
linking
  /usr/bin/ld: (.text+0xe0): warning: Using 'getpwnam_r' in statically link=
ed applications requires at runtime the shared libraries from the glibc ver=
sion used for linking
  /usr/bin/ld: (.text+0x11e): warning: Using 'getpwuid_r' in statically lin=
ked applications requires at runtime the shared libraries from the glibc ve=
rsion used for linking

  =

  Also, --disable-capstone is required to avoid this error, but it is pre-e=
xisting, not sure if it's a bug, if so I can file a separate one:

    LINK    aarch64-linux-user/qemu-aarch64
  /usr/bin/ld: cannot find -lcapstone
  collect2: error: ld returned 1 exit status

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1852115/+subscriptions

