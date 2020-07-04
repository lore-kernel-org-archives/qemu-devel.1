Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30223C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 12:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5CB2084C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 12:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5CB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrhB1-0004iU-4I
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 08:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jrh9u-0004BT-S2
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 08:20:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:50498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jrh9s-0006Fy-1r
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 08:20:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jrh9n-0001w8-M3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 12:20:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8FF982E810A
 for <qemu-devel@nongnu.org>; Sat,  4 Jul 2020 12:20:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2020 12:12:48 -0000
From: Thomas Huth <1886225@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd th-huth
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <159380302138.1124.12942774814113194933.malonedeb@chaenomeles.canonical.com>
Message-Id: <159386476830.32747.17430690777060542623.malone@chaenomeles.canonical.com>
Subject: [Bug 1886225] Re: [Feature request] Oracle Solaris 11.4 VM image
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4e9ddb400ef1a3c922f5249faabcc38655dc114d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:20:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1886225 <1886225@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Solaris is not open anymore, so I don't think that you can get a
distributable VM so easily.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1886225

Title:
  [Feature request] Oracle Solaris 11.4 VM image

Status in QEMU:
  New

Bug description:
  We already have handy VMs to build QEMU within:

  $ git grep -l basevm.BaseVM
  tests/vm/centos
  tests/vm/fedora
  tests/vm/freebsd
  tests/vm/netbsd
  tests/vm/openbsd
  tests/vm/ubuntu.i386

  Some people have interest in building QEMU on Solaris:
  https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01429.html

  To help them it would be useful to have a Solaris VM.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1886225/+subscriptions

