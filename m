Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FDCC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 00:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB0F2072A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 00:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB0F2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLFyv-0001wQ-BD
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 20:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jLFyJ-0001RC-B1
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 20:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jLFyI-0001Im-76
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 20:50:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:39956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jLFyI-0001Hl-1q
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 20:50:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jLFyG-0000Vh-Lx
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 00:50:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 872B92E8106
 for <qemu-devel@nongnu.org>; Mon,  6 Apr 2020 00:50:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Apr 2020 00:37:42 -0000
From: Pierre A <1871005@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: palba
X-Launchpad-Bug-Reporter: Pierre A (palba)
X-Launchpad-Bug-Modifier: Pierre A (palba)
Message-Id: <158613346274.21545.13304739575422127974.malonedeb@gac.canonical.com>
Subject: [Bug 1871005] [NEW] build fails on CLOCK_MONOTONIC
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9125fc65aff949d8f86bd3ecbdf6a31b05f4a8f2
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
Reply-To: Bug 1871005 <1871005@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Moc OS X.11.6 El Capitan

build fails on this

/Users/alba/Downloads/qemu-5.0.0-rc1/include/qemu/timer.h:843:9: warning: =

      implicit declaration of function 'clock_gettime' is invalid in C99
      [-Wimplicit-function-declaration]
        clock_gettime(CLOCK_MONOTONIC, &ts);
        ^
/Users/alba/Downloads/qemu-5.0.0-rc1/include/qemu/timer.h:843:23: error: us=
e of
      undeclared identifier 'CLOCK_MONOTONIC'
        clock_gettime(CLOCK_MONOTONIC, &ts);
                      ^
1 warning and 1 error generated.
make: *** [trace/control.o] Error 1

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1871005

Title:
  build fails on CLOCK_MONOTONIC

Status in QEMU:
  New

Bug description:
  Moc OS X.11.6 El Capitan

  build fails on this

  /Users/alba/Downloads/qemu-5.0.0-rc1/include/qemu/timer.h:843:9: warning: =

        implicit declaration of function 'clock_gettime' is invalid in C99
        [-Wimplicit-function-declaration]
          clock_gettime(CLOCK_MONOTONIC, &ts);
          ^
  /Users/alba/Downloads/qemu-5.0.0-rc1/include/qemu/timer.h:843:23: error: =
use of
        undeclared identifier 'CLOCK_MONOTONIC'
          clock_gettime(CLOCK_MONOTONIC, &ts);
                        ^
  1 warning and 1 error generated.
  make: *** [trace/control.o] Error 1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1871005/+subscriptions

