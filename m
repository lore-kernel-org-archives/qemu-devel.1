Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3075FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 19:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26332073B
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 19:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26332073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcZhp-0003p6-8Q
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 15:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jcZhI-0003It-79
 for qemu-devel@nongnu.org; Sat, 23 May 2020 15:20:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:35508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jcZhG-0001I6-VF
 for qemu-devel@nongnu.org; Sat, 23 May 2020 15:20:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jcZhF-0001l3-6Q
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 19:20:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2CC0B2E806E
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 19:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2020 19:13:47 -0000
From: =?utf-8?q?H=C3=A9ctor_Molinero_Fern=C3=A1ndez?=
 <1880332@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: hectormf
X-Launchpad-Bug-Reporter: =?utf-8?q?H=C3=A9ctor_Molinero_Fern=C3=A1ndez_=28?=
 =?utf-8?q?hectormf=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?H=C3=A9ctor_Molinero_Fern=C3=A1ndez_=28?=
 =?utf-8?q?hectormf=29?=
Message-Id: <159026122753.1613.8522405227035466257.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1880332] [NEW] Possible regression in QEMU 5.0.0 after
 CVE-2020-10702 (segmentation fault)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 835ff6675406b442a58c8707e0977d27b75789ca
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 14:10:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Reply-To: Bug 1880332 <1880332@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I've come across a very specific situation, but I'm sure it could be
replicated in other cases.

In QEMU 5.0.0 when I use user emulation with a cURL binary for aarch64
and connect to a server using TLS 1.2 and ECDHE-ECDSA-CHACHA20-POLY1305
cypher a segmentation fault occurs.

I attach a Dockerfile that reproduces this crash and the strace output
with and without the de0b1bae6461f67243282555475f88b2384a1eb9 commit
reverted.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "crash-replication.zip"
   https://bugs.launchpad.net/bugs/1880332/+attachment/5375960/+files/crash=
-replication.zip

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1880332

Title:
  Possible regression in QEMU 5.0.0 after CVE-2020-10702 (segmentation
  fault)

Status in QEMU:
  New

Bug description:
  I've come across a very specific situation, but I'm sure it could be
  replicated in other cases.

  In QEMU 5.0.0 when I use user emulation with a cURL binary for aarch64
  and connect to a server using TLS 1.2 and ECDHE-ECDSA-
  CHACHA20-POLY1305 cypher a segmentation fault occurs.

  I attach a Dockerfile that reproduces this crash and the strace output
  with and without the de0b1bae6461f67243282555475f88b2384a1eb9 commit
  reverted.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1880332/+subscriptions

