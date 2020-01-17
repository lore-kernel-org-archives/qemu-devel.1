Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91CCC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60AA920728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AA920728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isWK9-0004k6-5t
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1isWJT-0004DZ-5x
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1isWJP-0006Po-A9
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:25:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:60606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1isWJP-0006OJ-42
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:25:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1isWJN-0004ij-HW
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 18:25:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7F3142E80C0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 18:25:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jan 2020 18:19:38 -0000
From: Richard Henderson <rth@twiddle.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: linux-user ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: patrickmeiring rth
X-Launchpad-Bug-Reporter: Patrick Meiring (patrickmeiring)
X-Launchpad-Bug-Modifier: Richard Henderson (rth)
References: <157921754479.22473.5594149461755090250.malonedeb@gac.canonical.com>
Message-Id: <157928517887.4712.2210982312409298134.malone@wampee.canonical.com>
Subject: [Bug 1860053] Re: Possible lack of precision when calling
 clock_gettime via vDSO on user mode ppc64le
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="f1052173880d8dae43faa7c2fc45da1b42227143";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4295e0990b1f28729d15e682812aa759a46b07f9
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
Reply-To: Bug 1860053 <1860053@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU does not implement any vDSO, so this cannot be the explanation.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1860053

Title:
  Possible lack of precision when calling clock_gettime via vDSO on user
  mode ppc64le

Status in QEMU:
  New

Bug description:
  Occurs on QEMU v4.2.0 run on docker (via the qemu-user-static:v4.2.0-2
  image) on an AMD64 Ubuntu 18.04.3 LTS machine provided by travis-
  ci.org.

  From golang's https://github.com/golang/go/issues/36592:

  It was discovered that golang's time.NewTicker() and time.Sleep()
  malfunction when a compiled application was run via QEMU's ppc64le
  emulator in user mode.

  The methods did not malfunction on actual PowerPC hardware or when the
  same golang application was compiled for golang's arm, arm64 or 386
  targets and was run via user mode QEMU on the same system.

  Curiously, the methods also worked when the program was compiled under
  go 1.11, but do malfunction in go 1.12 and 1.13.

  It was identified the change in behaviour was most likely attributable to=
 golang switching to using vSDO for calling clock_gettime() on PowerPC 64 a=
rchitectures in 1.12. I.E:
  https://github.com/golang/go/commit/dbd8af74723d2c98cbdcc70f7e2801f69b57a=
c5b

  We therefore suspect there may be a bug in QEMU's user-mode emulation
  of ppc64le as relates to vDSO calls to clock_gettime().

  The nature of the malfunction of time.NewTicker() and time.Sleep() is
  such that sleeps or ticks with a granularity of less than one second
  do not appear to be possible (they all revert to 1 second
  sleeps/ticks). Could it be that the nanoseconds field of
  clock_gettime() is getting lost in the vDSO version but not in the
  syscall? Or some other issue calling these methods via vDSO?

  Thanks in advance.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1860053/+subscriptions

