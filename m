Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AFACA9ECB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 01:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B32D2083E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 01:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B32D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQLQ5-000726-82
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 21:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iQJtp-0002Vg-7W
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iQJtn-00018T-Cp
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:30:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:41778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iQJtn-00016a-7E
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:30:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iQJtk-0005wL-LL
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 23:30:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7452F2E802A
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 23:30:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Oct 2019 23:22:38 -0000
From: =?utf-8?q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dos-d ernstp
X-Launchpad-Bug-Reporter: Sebastian Krzyszkowiak (dos-d)
X-Launchpad-Bug-Modifier: =?utf-8?q?Ernst_Sj=C3=B6strand_=28ernstp=29?=
References: <154041310239.24736.3249552536528955636.malonedeb@wampee.canonical.com>
Message-Id: <157256415823.28040.17245759353436959286.malone@chaenomeles.canonical.com>
Subject: [Bug 1799792] Re: Broken scaling with gtk,gl=on on a hidpi display
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: aae026b73eea0f59ba821824d344f49f3a6b0582
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Thu, 31 Oct 2019 21:07:16 -0400
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
Reply-To: Bug 1799792 <1799792@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also happens on Ubuntu 19.10

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1799792

Title:
  Broken scaling with gtk,gl=3Don on a hidpi display

Status in QEMU:
  New

Bug description:
  Tested on QEMU 3.0.0 on Arch Linux.

  I'm using a hidpi screen, and therefore use those environment
  variables in order to have GTK+ apps properly scaled:

  GDK_SCALE=3D2
  GDK_DPI_SCALE=3D0.5

  However, QEMU, when launched with "-display gtk,gl=3Don" option, doesn't
  scale the window content properly, as seen on the attached screenshot.

  Switching to "-display gtk,gl=3Doff" and "-display sdl,gl=3Don" makes it
  work fine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1799792/+subscriptions

