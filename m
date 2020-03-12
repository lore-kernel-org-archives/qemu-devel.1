Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C37C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF6E206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF6E206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQRK-0007i8-Hj
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jCQQ7-0006Tx-FF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jCQQ6-0005xV-1j
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:10:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:54690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jCQQ5-0005wA-SM
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:10:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jCQQ3-0006K1-Vr
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 16:10:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EF1512E80C9
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 16:10:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Mar 2020 16:04:56 -0000
From: Richard Henderson <rth@twiddle.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=rth@twiddle.net; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pcc-goog rth
X-Launchpad-Bug-Reporter: Peter Collingbourne (pcc-goog)
X-Launchpad-Bug-Modifier: Richard Henderson (rth)
References: <158397461074.11691.9165479040998830806.malonedeb@soybean.canonical.com>
Message-Id: <158402909701.10809.1004399395866602664.malone@soybean.canonical.com>
Subject: [Bug 1867072] Re: ARM: tag bits cleared in FAR_EL1
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 203e460f679e1f630d01f1c5084a3ad1d2d7ec1e
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
Reply-To: Bug 1867072 <1867072@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ho hum, I must have been asleep last night.
Peter only merged 7 of 9 patches.  The final 2 were re-posted:
https://patchew.org/QEMU/20200308012946.16303-1-richard.henderson@linaro.or=
g/

which includes the critical change that affects FAR_ELx.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1867072

Title:
  ARM: tag bits cleared in FAR_EL1

Status in QEMU:
  In Progress

Bug description:
  The ARM Architecture Reference Manual provides the following for
  FAR_EL1:

  "For a Data Abort or Watchpoint exception, if address tagging is
  enabled for the address accessed by the data access that caused the
  exception, then this field includes the tag."

  However, I have found that the tag bits in FAR_EL1 are always clear,
  even if the tag bits were set in the original access.

  I can reproduce the problem on both 4.1.1 and master
  (6e8a73e911f066527e775e04b98f31ebd19db600).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1867072/+subscriptions

