Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EBCC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DF52067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DF52067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4kI-0002xz-2F
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 14:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iK4BS-0005iX-S0
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iK4BR-0001zt-OW
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:31:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:57340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iK4BR-0001zV-Iq
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:31:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iK4BP-000524-Mg
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 17:30:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AA3412E80C9
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 17:30:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Oct 2019 17:23:57 -0000
From: Shachar Itzhaky <corwin.amber@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: corwin-amber pmaydell zenojevski
X-Launchpad-Bug-Reporter: Shachar Itzhaky (corwin-amber)
X-Launchpad-Bug-Modifier: Shachar Itzhaky (corwin-amber)
References: <157097450557.5820.4200729468686724078.malonedeb@gac.canonical.com>
Message-Id: <157107383710.5928.6877894875959962008.malone@gac.canonical.com>
Subject: [Bug 1847906] Re: Cocoa display hangs on macOS 10.15 (Catalina)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="af2eefe214bd95389a09b7c956720881bab16807";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4a2787527d57c24bdfc26e58075a56d3afb071a1
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
Reply-To: Bug 1847906 <1847906@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is wonderful! Thank you Peter and Hikaru for this patch. I will try
it ASAP and confirm.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1847906

Title:
  Cocoa display hangs on macOS 10.15 (Catalina)

Status in QEMU:
  New

Bug description:
  I have downloaded the latest stable source tarball 4.1.0 and compiled
  it (i386-softmmu target).

  After opening a black window, QEMU hangs (spinning beach ball).
  When building with `--disable-cocoa --enable-sdl`, display seems to work =
fine.

  The same happened when I tried to build QEMU through HomeBrew and
  MacPorts.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1847906/+subscriptions

