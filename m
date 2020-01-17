Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8071C33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 01:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4B92072E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 01:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4B92072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isG16-0003m2-JG
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 20:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1isG0H-0003L2-Hr
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 20:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1isG0D-0000FJ-Fk
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 20:00:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:60298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1isG0D-0000Cx-9p
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 20:00:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1isG0B-0006RA-Q0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 01:00:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BDDA72E8048
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 01:00:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jan 2020 00:55:09 -0000
From: mcandre <andrew.pennebaker@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: andrew-pennebaker
X-Launchpad-Bug-Reporter: mcandre (andrew-pennebaker)
X-Launchpad-Bug-Modifier: mcandre (andrew-pennebaker)
Message-Id: <157922250983.5290.10201589814072308267.malonedeb@wampee.canonical.com>
Subject: [Bug 1860056] [NEW] mips binaries segfault
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="f1052173880d8dae43faa7c2fc45da1b42227143";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: bd8b1c84c3f73c8f3fcfb6526a40928fa580d150
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
Reply-To: Bug 1860056 <1860056@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello World appears to segfault with qemu mips, on a Debian 10.0.0
Buster amd64 host.

Example:


$ cat mips/test/hello.cpp =

#include <iostream>
using std::cout;

int main() {
    cout << "Hello World!\n";
    return 0;
}

$ mips-linux-gnu-g++ -o hello hello.cpp && ./hello
qemu: uncaught target signal 11 (Segmentation fault) - core dumped

Note that 64-bit MIPS and little endian 32-bit MIPS qemu work fine. The
problem is limited to big endian 32-bit MIPS.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1860056

Title:
  mips binaries segfault

Status in QEMU:
  New

Bug description:
  Hello World appears to segfault with qemu mips, on a Debian 10.0.0
  Buster amd64 host.

  Example:

  =

  $ cat mips/test/hello.cpp =

  #include <iostream>
  using std::cout;

  int main() {
      cout << "Hello World!\n";
      return 0;
  }

  $ mips-linux-gnu-g++ -o hello hello.cpp && ./hello
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped

  Note that 64-bit MIPS and little endian 32-bit MIPS qemu work fine.
  The problem is limited to big endian 32-bit MIPS.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1860056/+subscriptions

