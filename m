Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC36AFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE9C21848
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE9C21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4vp-0003dA-ME
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:08:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iT4uV-0002Ao-3P
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iT4uU-0003Ho-0t
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:06:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:60026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iT4uT-0003GO-RX
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:06:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iT4uS-0004RU-2S
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 14:06:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0257E2E8C1D
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 14:06:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Nov 2019 13:59:31 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1844814@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: trace
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <156899381888.13411.12132927689585572811.malonedeb@gac.canonical.com>
Message-Id: <157322157143.19186.7727677830125402109.malone@wampee.canonical.com>
Subject: [Bug 1844814] Re: trace: SystemTap documentation out of date
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a9d3a8132de872cc72cfcb4074cde5404ccd24e9
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
Reply-To: Bug 1844814 <1844814@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed by commit bd200384c515 (trace: add --group=3Dall to tracing.txt).

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1844814

Title:
  trace: SystemTap documentation out of date

Status in QEMU:
  Fix Committed

Bug description:
  The docs/devel/tracing.txt help suggest:

      scripts/tracetool.py --backends=3Ddtrace --format=3Dstap \
                           --binary path/to/qemu-binary \
                           --target-type system \
                           --target-name x86_64 \
                           <trace-events-all >qemu.stp

  but since commit 2098c56a9bc this comment is outdated:

    $ scripts/tracetool.py --backends=3Ddtrace --format=3Dstap \
      --binary mips-softmmu/qemu-system-mips \
      --target-type system \
      --target-name mips trace-events-all
    Error: group name is required

  The offending commit seems:

  commit 2098c56a9bc5901e145fa5d4759f075808811685
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Wed Jan 25 16:14:14 2017 +0000

      trace: move setting of group name into Makefiles

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1844814/+subscriptions

