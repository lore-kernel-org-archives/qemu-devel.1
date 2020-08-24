Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0E7C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 07:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10202074D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 07:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10202074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA76d-0007Du-Pr
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 03:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kA766-0006nA-Hn
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 03:40:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:49690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kA764-000691-4p
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 03:40:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kA761-0007Hd-8V
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:40:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 071112E8105
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2020 07:31:45 -0000
From: Roman Melnikov <1892684@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: rvem
X-Launchpad-Bug-Reporter: Roman Melnikov (rvem)
X-Launchpad-Bug-Modifier: Roman Melnikov (rvem)
Message-Id: <159825430524.881.7496481108113681693.malonedeb@wampee.canonical.com>
Subject: [Bug 1892684] [NEW] curl and wget segfaults when link has redirects
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: 0e5a57a52ae24c6b0d0d39485d605da5c607fd76
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 03:40:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1892684 <1892684@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,

I've been using qemu-user-static with aarch64 docker images and faced the p=
roblem
using binares from the following release: https://github.com/multiarch/qemu=
-user-static/releases/tag/v5.0.0-2.

curl and wget fails with segmentation fault when trying to fetch something =
from the link
that has some redirects.

In order to reproduce you can run the following:

1) Register qemu on x86_64 machine
   docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
2) Run arm64v8 docker image and try to run wget or curl
   docker run --rm -it arm64v8/ubuntu bash
   $ apt update
   $ apt install curl wget
   $ curl -L http://erratique.ch/software/astring/releases/astring-0.8.3.tbz
   $ wget  http://erratique.ch/software/astring/releases/astring-0.8.3.tbz

This error cannot be reproduced with binaries from eariler release https://=
github.com/multiarch/qemu-user-static/releases/tag/v4.2.0-7.
curl and wget work fine with the given link and don't fail with segfault wh=
en using
older qemu-user-static binaries

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1892684

Title:
  curl and wget segfaults when link has redirects

Status in QEMU:
  New

Bug description:
  Hello,

  I've been using qemu-user-static with aarch64 docker images and faced the=
 problem
  using binares from the following release: https://github.com/multiarch/qe=
mu-user-static/releases/tag/v5.0.0-2.

  curl and wget fails with segmentation fault when trying to fetch somethin=
g from the link
  that has some redirects.

  In order to reproduce you can run the following:

  1) Register qemu on x86_64 machine
     docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
  2) Run arm64v8 docker image and try to run wget or curl
     docker run --rm -it arm64v8/ubuntu bash
     $ apt update
     $ apt install curl wget
     $ curl -L http://erratique.ch/software/astring/releases/astring-0.8.3.=
tbz
     $ wget  http://erratique.ch/software/astring/releases/astring-0.8.3.tbz

  This error cannot be reproduced with binaries from eariler release https:=
//github.com/multiarch/qemu-user-static/releases/tag/v4.2.0-7.
  curl and wget work fine with the given link and don't fail with segfault =
when using
  older qemu-user-static binaries

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1892684/+subscriptions

