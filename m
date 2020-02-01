Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCB8C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 16:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721D0206E3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 16:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721D0206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixvMk-0006EF-Jj
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 11:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ixvM5-0005X3-Gf
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 11:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ixvM4-0001BC-An
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 11:10:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:49038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ixvM4-00018X-4y
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 11:10:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ixvM2-0003Fo-4O
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 16:10:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1A6882E80C0
 for <qemu-devel@nongnu.org>; Sat,  1 Feb 2020 16:10:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Feb 2020 16:03:50 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Won't Fix; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell unclegluk
X-Launchpad-Bug-Reporter: Sergey Lunkin (unclegluk)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <158055475004.19181.5169686507307672959.malonedeb@gac.canonical.com>
Message-Id: <158057303012.8324.16075138831015981732.malone@chaenomeles.canonical.com>
Subject: [Bug 1861551] Re: Errors while compiling source
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: da8899ba5c2f0febcdd85dd468c47ecb88af95af
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
Reply-To: Bug 1861551 <1861551@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi. The CLOCK_MONOTONIC facility was added in OSX 10.12; the version of
OSX you're using is too old to build QEMU on, I'm afraid. QEMU's policy
is to support the last two releases of OSX, so at the moment that's
10.14 and 10.15. Compiling on older versions might work, but it also
might not, as you've discovered.


** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1861551

Title:
  Errors while compiling source

Status in QEMU:
  Won't Fix

Bug description:
  OS type: Mac OS X 10.11.6
  List of errors:
  qemu-io-cmds.c:837:5: warning: implicit declaration of function 'clock_ge=
ttime' is invalid in C99 [-Wimplicit-function-declaration]
      clock_gettime(CLOCK_MONOTONIC, &t1);
      ^
  qemu-io-cmds.c:837:19: error: use of undeclared identifier 'CLOCK_MONOTON=
IC'
      clock_gettime(CLOCK_MONOTONIC, &t1);
                    ^
  qemu-io-cmds.c:843:19: error: use of undeclared identifier 'CLOCK_MONOTON=
IC'
      clock_gettime(CLOCK_MONOTONIC, &t2);
                    ^
  qemu-io-cmds.c:970:19: error: use of undeclared identifier 'CLOCK_MONOTON=
IC'
      clock_gettime(CLOCK_MONOTONIC, &t1);
                    ^
  qemu-io-cmds.c:972:19: error: use of undeclared identifier 'CLOCK_MONOTON=
IC'
      clock_gettime(CLOCK_MONOTONIC, &t2);
                    ^
  qemu-io-cmds.c:1184:19: error: use of undeclared identifier 'CLOCK_MONOTO=
NIC'
      clock_gettime(CLOCK_MONOTONIC, &t1);
                    ^
  qemu-io-cmds.c:1194:19: error: use of undeclared identifier 'CLOCK_MONOTO=
NIC'
      clock_gettime(CLOCK_MONOTONIC, &t2);
                    ^
  qemu-io-cmds.c:1306:19: error: use of undeclared identifier 'CLOCK_MONOTO=
NIC'
      clock_gettime(CLOCK_MONOTONIC, &t1);
                    ^
  qemu-io-cmds.c:1308:19: error: use of undeclared identifier 'CLOCK_MONOTO=
NIC'
      clock_gettime(CLOCK_MONOTONIC, &t2);
                    ^
  qemu-io-cmds.c:1351:19: error: use of undeclared identifier 'CLOCK_MONOTO=
NIC'
      clock_gettime(CLOCK_MONOTONIC, &t2);
                    ^
  qemu-io-cmds.c:1383:19: error: use of undeclared identifier 'CLOCK_MONOTO=
NIC'
      clock_gettime(CLOCK_MONOTONIC, &t2);
                    ^
  qemu-io-cmds.c:1518:19: error: use of undeclared identifier 'CLOCK_MONOTO=
NIC'
      clock_gettime(CLOCK_MONOTONIC, &ctx->t1);
                    ^
  qemu-io-cmds.c:1663:23: error: use of undeclared identifier 'CLOCK_MONOTO=
NIC'
          clock_gettime(CLOCK_MONOTONIC, &ctx->t1);
                        ^
  qemu-io-cmds.c:1885:19: error: use of undeclared identifier 'CLOCK_MONOTO=
NIC'
      clock_gettime(CLOCK_MONOTONIC, &t1);
                    ^
  qemu-io-cmds.c:1887:19: error: use of undeclared identifier 'CLOCK_MONOTO=
NIC'
      clock_gettime(CLOCK_MONOTONIC, &t2);
                    ^
  1 warning and 14 errors generated.
  make: *** [qemu-io-cmds.o] Error 1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1861551/+subscriptions

