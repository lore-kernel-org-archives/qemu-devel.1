Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4781CC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04E9207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04E9207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igp8m-0002vE-Lm
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 07:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1igp86-0002Py-L7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1igp85-0008O0-EB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:05:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:40978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1igp85-0008Ju-8Y
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:05:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1igp83-0001V0-Ih
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 12:05:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 873F62E80C3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 12:05:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Dec 2019 11:58:44 -0000
From: dcb <1856549@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dcb314
X-Launchpad-Bug-Reporter: dcb (dcb314)
X-Launchpad-Bug-Modifier: dcb (dcb314)
References: <157649490094.7480.17075229014510714852.malonedeb@soybean.canonical.com>
Message-Id: <157649752475.4226.12810383033052233683.malone@chaenomeles.canonical.com>
Subject: [Bug 1856549] Re: qemu-4.2.0/hw/misc/mac_via.c: 2 * bad test ?
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 78a563d3786c1ab12e23a105654f782168fb8a98
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
Reply-To: Bug 1856549 <1856549@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

gcc compiler flag -Wduplicated-cond will catch this kind of problem.

You might want to switch it on in your builds. It has been available for
over a year.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1856549

Title:
  qemu-4.2.0/hw/misc/mac_via.c: 2 * bad test ?

Status in QEMU:
  New

Bug description:
  1.

  qemu-4.2.0/hw/misc/mac_via.c:417:27: style: Expression is always false
  because 'else if' condition matches previous condition at line 412.
  [multiCondition]

                  } else if ((m->data_out & 0xf3) =3D=3D 0xa1) {
  ...
                  } else if ((m->data_out & 0xf3) =3D=3D 0xa1) {

  2.

  qemu-4.2.0/hw/misc/mac_via.c:467:27: style: Expression is always false
  because 'else if' condition matches previous condition at line 463.
  [multiCondition]

  Duplicate.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1856549/+subscriptions

