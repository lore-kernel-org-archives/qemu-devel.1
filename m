Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734C6C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4812524E0F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4812524E0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46144 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY2D1-0000oZ-Ip
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 01:42:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hY2C3-0000EQ-3L
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hY2Bs-00050o-73
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:41:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:43644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hY2Bq-0004xy-CN
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:40:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hY2Bo-0007Mg-OV
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 05:40:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B7D672E8055
	for <qemu-devel@nongnu.org>; Tue,  4 Jun 2019 05:40:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Jun 2019 05:32:12 -0000
From: Andrew Randrianasulu <1831545@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: regression
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: andrew-randrianasulu
X-Launchpad-Bug-Reporter: Andrew Randrianasulu (andrew-randrianasulu)
X-Launchpad-Bug-Modifier: Andrew Randrianasulu (andrew-randrianasulu)
Message-Id: <155962633298.7880.15982922254182327026.malonedeb@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 28f5b459c1830303ecb982c948de042387dcbe53
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1831545] [NEW] "accel/tcg: demacro cputlb" break
 qemu-system-x86_64 on 32-bit x86 host
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1831545 <1831545@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

As described in https://lists.gnu.org/archive/html/qemu-
devel//2019-05/msg07362.html I run into TCG regression in qemu-git.

Unfortunately, fix from bug https://bugs.launchpad.net/qemu/+bug/1830872
seems to be nonn-effective for my case.

For reproduction (on 32-bit x86 host, in my case Slackware with gcc
5.5.0):

./configure --target-list=3Dx86_64-softmmu --disable-werror --enable-
debug-tcg

make (-j5 in my case)

try to boot any 64-bit kernel:

x86_64-softmmu/qemu-system-x86_64 -kernel /boot/bzImage-4.12.0-x64
-accel tcg

result is - qemu appear to hang right after "Booting the kernel" line.
Decompression (xz) was ok.

Tested with qemu-git commit  e2a58ff493a2e00db3e963c1839c5374500110f2

32-bit OS can be booted fine, and -enable-kvm also allow 64 bit
kernel/os to boot.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: regression

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1831545

Title:
  "accel/tcg: demacro cputlb" break qemu-system-x86_64 on 32-bit x86
  host

Status in QEMU:
  New

Bug description:
  As described in https://lists.gnu.org/archive/html/qemu-
  devel//2019-05/msg07362.html I run into TCG regression in qemu-git.

  Unfortunately, fix from bug
  https://bugs.launchpad.net/qemu/+bug/1830872 seems to be nonn-
  effective for my case.

  For reproduction (on 32-bit x86 host, in my case Slackware with gcc
  5.5.0):

  ./configure --target-list=3Dx86_64-softmmu --disable-werror --enable-
  debug-tcg

  make (-j5 in my case)

  try to boot any 64-bit kernel:

  x86_64-softmmu/qemu-system-x86_64 -kernel /boot/bzImage-4.12.0-x64
  -accel tcg

  result is - qemu appear to hang right after "Booting the kernel" line.
  Decompression (xz) was ok.

  Tested with qemu-git commit  e2a58ff493a2e00db3e963c1839c5374500110f2

  32-bit OS can be booted fine, and -enable-kvm also allow 64 bit
  kernel/os to boot.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1831545/+subscriptions

