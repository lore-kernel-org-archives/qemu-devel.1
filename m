Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EBDC4CEC7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 23:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B16A206CD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 23:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B16A206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8YYx-0008SV-Cs
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 19:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i8YXz-0007yh-LG
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 19:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i8YXy-0000QP-9w
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 19:30:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:41082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i8YXy-0000Q3-4j
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 19:30:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i8YXw-0000XB-Nl
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 23:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AC1862E80C8
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 23:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2019 23:20:51 -0000
From: John Snow <1843852@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jnsnow
X-Launchpad-Bug-Reporter: John Snow (jnsnow)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
Message-Id: <156833045171.17307.14707838609727225916.malonedeb@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 037a5333f01f9f30f100b141903a74bf7d9e8a05
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1843852] [NEW] QEMU does not express a dependency
 on perl-Test-Harness
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
Reply-To: Bug 1843852 <1843852@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

This is a minor thing; in Fedora you can install most of the developer
dependencies by issuing something like `dnf builddep qemu-kvm` and this
takes care of just about everything such that you can run ./configure
and make.

For "make check" though, configure doesn't catch that you'll need perl-
Test-Harness; so it fails halfway through the check routine, and you'll
see this:

```
Can't locate TAP/Parser.pm in @INC (you may need to install the TAP::Parser=
 module) (@INC contains: /usr/local/lib64/perl5 /usr/local/share/perl5 /usr=
/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl /usr/lib64/perl5 /usr=
/share/perl5) at ./scripts/tap-driver.pl line 30.
BEGIN failed--compilation aborted at ./scripts/tap-driver.pl line 30.
make: *** [/home/jhuston/src/qemu/tests/Makefile.include:905: check-unit] E=
rror 2
```

I'm not sure how we should express this dependency; it shouldn't be a
requirement for building, but it IS a dependency for testing. We
probably ought not let users skip the qapi tests just because they don't
have the perl requirement met.

(And, separately, the Fedora package should list this as a builddep, but
that's not an issue for here.)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1843852

Title:
  QEMU does not express a dependency on perl-Test-Harness

Status in QEMU:
  New

Bug description:
  This is a minor thing; in Fedora you can install most of the developer
  dependencies by issuing something like `dnf builddep qemu-kvm` and
  this takes care of just about everything such that you can run
  ./configure and make.

  For "make check" though, configure doesn't catch that you'll need
  perl-Test-Harness; so it fails halfway through the check routine, and
  you'll see this:

  ```
  Can't locate TAP/Parser.pm in @INC (you may need to install the TAP::Pars=
er module) (@INC contains: /usr/local/lib64/perl5 /usr/local/share/perl5 /u=
sr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl /usr/lib64/perl5 /u=
sr/share/perl5) at ./scripts/tap-driver.pl line 30.
  BEGIN failed--compilation aborted at ./scripts/tap-driver.pl line 30.
  make: *** [/home/jhuston/src/qemu/tests/Makefile.include:905: check-unit]=
 Error 2
  ```

  I'm not sure how we should express this dependency; it shouldn't be a
  requirement for building, but it IS a dependency for testing. We
  probably ought not let users skip the qapi tests just because they
  don't have the perl requirement met.

  (And, separately, the Fedora package should list this as a builddep,
  but that's not an issue for here.)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1843852/+subscriptions

