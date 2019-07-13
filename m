Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC4AC31E40
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 16:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8E32064A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 16:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8E32064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmKqI-0000fW-I0
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 12:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49931)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hmKq0-0008Gf-Dl
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 12:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hmKpz-0008PF-3o
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 12:25:28 -0400
Received: from indium.canonical.com ([91.189.90.7]:48886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hmKpy-0008Oc-Ts
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 12:25:27 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hmKpx-0007Mo-4R
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2019 16:25:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1EB7C2E80BA
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2019 16:25:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jul 2019 15:46:28 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1836453@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <156303278818.15899.18047331425183338168.malonedeb@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: c519ba5221c03cf746fd14cb6769826aea279f06
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1836453] [NEW] "qemu-nsis\*.bmp" -> no files
 found" when building with MXE
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
Reply-To: Bug 1836453 <1836453@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Already reported for 4.0:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg07005.html

host: Docker qemu:debian-win32-cross

$ make installer
(cd /tmp/qemu-nsis; \
         for i in qemu-system-*.exe; do \
           arch=3D${i%.exe}; \
           arch=3D${arch#qemu-system-}; \
           echo Section \"$arch\" Section_$arch; \
           echo SetOutPath \"\$INSTDIR\"; \
           echo File \"\${BINDIR}\\$i\"; \
           echo SectionEnd; \
         done \
        ) >/tmp/qemu-nsis/system-emulations.nsh
makensis -V2 -NOCD \
                -DCONFIG_DOCUMENTATION=3D"y" \
                 \
                -DBINDIR=3D"/tmp/qemu-nsis" \
                 \
                -DSRCDIR=3D"/source/qemu" \
                -DOUTFILE=3D"qemu-setup-4.0.90.exe" \
                -DDISPLAYVERSION=3D"4.0.90" \
                /source/qemu/qemu.nsi
File: "/tmp/qemu-nsis\*.bmp" -> no files found.
Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] |
   /oname=3Doutfile one_file_only)
Error in script "/source/qemu/qemu.nsi" on line 122 -- aborting creation pr=
ocess
Makefile:1077: recipe for target 'qemu-setup-4.0.90.exe' failed
make: *** [qemu-setup-4.0.90.exe] Error 1

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: windows

** Tags added: windows

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1836453

Title:
  "qemu-nsis\*.bmp" -> no files found" when building with MXE

Status in QEMU:
  New

Bug description:
  Already reported for 4.0:
  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg07005.html

  host: Docker qemu:debian-win32-cross

  $ make installer
  (cd /tmp/qemu-nsis; \
           for i in qemu-system-*.exe; do \
             arch=3D${i%.exe}; \
             arch=3D${arch#qemu-system-}; \
             echo Section \"$arch\" Section_$arch; \
             echo SetOutPath \"\$INSTDIR\"; \
             echo File \"\${BINDIR}\\$i\"; \
             echo SectionEnd; \
           done \
          ) >/tmp/qemu-nsis/system-emulations.nsh
  makensis -V2 -NOCD \
                  -DCONFIG_DOCUMENTATION=3D"y" \
                   \
                  -DBINDIR=3D"/tmp/qemu-nsis" \
                   \
                  -DSRCDIR=3D"/source/qemu" \
                  -DOUTFILE=3D"qemu-setup-4.0.90.exe" \
                  -DDISPLAYVERSION=3D"4.0.90" \
                  /source/qemu/qemu.nsi
  File: "/tmp/qemu-nsis\*.bmp" -> no files found.
  Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] |
     /oname=3Doutfile one_file_only)
  Error in script "/source/qemu/qemu.nsi" on line 122 -- aborting creation =
process
  Makefile:1077: recipe for target 'qemu-setup-4.0.90.exe' failed
  make: *** [qemu-setup-4.0.90.exe] Error 1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1836453/+subscriptions

