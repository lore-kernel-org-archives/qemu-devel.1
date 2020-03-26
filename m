Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AF5C2D0EF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C29E20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C29E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHZ6c-00041F-J3
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jHZ4K-0000P0-Mc
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jHZ4J-0002Pk-Da
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:25:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:52094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jHZ4J-0002P5-6U
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:25:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jHZ4H-0007T5-Lg
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 20:25:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9CA5F2E80C3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 20:25:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Mar 2020 20:15:29 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: manuel-reimer pmaydell
X-Launchpad-Bug-Reporter: Manuel Reimer (manuel-reimer)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
X-Launchpad-Bug-Duplicate: 1805913
References: <158524525185.11288.13431171964395831782.malonedeb@soybean.canonical.com>
Message-Id: <158525372926.7516.9257796400730201385.malone@wampee.canonical.com>
Subject: [Bug 1869241] Re: svn checkout fails with E000075 "Value too large
 for defined data type"
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: bbdcde7609730f6b54f613eb7922e49cf9bdb7e3
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
Reply-To: Bug 1869241 <1869241@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

*** This bug is a duplicate of bug 1805913 ***
    https://bugs.launchpad.net/bugs/1805913

Hi; thanks for the bug report. This is a duplicate of LP:1805913. It requir=
es a host kernel change to fix this bug (which is being discussed but hasn'=
t been written yet). Otherwise the only known workarounds are:
 * downgrade the guest (arm) glibc to 2.27 or earlier
 * use a filesystem on the host which is not ext3/ext4 (often not practical)


** This bug has been marked a duplicate of bug 1805913
   readdir() returns NULL (errno=3DEOVERFLOW) for 32-bit user-static qemu o=
n 64-bit host

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1869241

Title:
  svn checkout fails with E000075 "Value too large for defined data
  type"

Status in QEMU:
  New

Bug description:
  I try to autobuild for ARM7 with qemu-arm-static. Part of this is
  downloading source via SVN.

  Whenever I try to download a SVN repository I get the following
  output:

  =C2=A0=C2=A0=C2=A0=C2=A0svn: E000075: Can't read directory '...': Value t=
oo large for
  defined data type

  This is the repository I'm trying to check out:
  https://svn.baycom.de/repos/vdr-mcli-plugin/

  qemu-arm-static version is 4.2.0

  I've also tried older versions without change.

  Platform I try to emulate is armv7h (Arch Linux ARM for Raspberry Pi
  2)

  Host system is AMD64

  This can be reproduced 100% of the time. Here I have the issue
  happening on Travis CI:

  https://travis-ci.com/github/VDR4Arch/vdr4arch/jobs/304839747#L9944

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1869241/+subscriptions

