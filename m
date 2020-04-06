Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22FDC2BA18
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 08:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97076206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 08:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97076206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLNAm-00072V-N9
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 04:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jLN9p-0006cF-8T
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 04:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jLN9o-0004QT-4E
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 04:31:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:53160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jLN9n-0004Py-V2
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 04:31:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jLN9l-0002r4-Km
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 08:30:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9AC342E8111
 for <qemu-devel@nongnu.org>; Mon,  6 Apr 2020 08:30:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Apr 2020 08:17:54 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Won't Fix; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: palba pmaydell
X-Launchpad-Bug-Reporter: Pierre A (palba)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <158613346274.21545.13304739575422127974.malonedeb@gac.canonical.com>
Message-Id: <158616107495.12209.12610219335872558669.malone@chaenomeles.canonical.com>
Subject: [Bug 1871005] Re: build fails on CLOCK_MONOTONIC
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 236564923716fcff036b0b89fc3d5e9c9aa6e04e
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

Hi; I'm afraid that OSX 10.11 "El Capitan" isn't a supported build
platform for QEMU. Our official support policy is that we support the
two most recent versions (currently 10.14 Mojave and 10.15 Catalina);
QEMU may also run on some earlier OSX versions we don't support, but we
don't guarantee that or carry workarounds for missing functionality on
those earlier versions. In this particular case, CLOCK_MONOTONIC was
added to OSX 10.12 "Sierra".


** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1871005

Title:
  build fails on CLOCK_MONOTONIC

Status in QEMU:
  Won't Fix

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

