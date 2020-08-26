Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329D9C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B9CC20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9CC20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvND-0007qc-6w
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kAvME-0005uO-Sc
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:20:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:42044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kAvMC-0004KI-Gg
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:20:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kAvMA-0002oE-49
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 13:20:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E66242E80EA
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 13:20:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2020 13:14:56 -0000
From: Guirish Salgaonkar <1893040@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange gsalgaon
X-Launchpad-Bug-Reporter: Guirish Salgaonkar (gsalgaon)
X-Launchpad-Bug-Modifier: Guirish Salgaonkar (gsalgaon)
References: <159844225257.1396.12890490778938419036.malonedeb@wampee.canonical.com>
Message-Id: <159844769668.1736.11033155415826590591.malone@wampee.canonical.com>
Subject: [Bug 1893040] Re: External modules retreval using Go1.15 on s390x
 appears to have checksum and ECDSA verification issues
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: 656cf2cd1c1b5d407ff2a5b8f92af156b5852836
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 07:50:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Bug 1893040 <1893040@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes we have observed that the issue persist in later QEMU version too.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1893040

Title:
   External modules retreval using Go1.15 on s390x appears to have
  checksum and ECDSA verification issues

Status in QEMU:
  Incomplete

Bug description:
  We are observing issue while building go-runner image and we suspect it i=
s due to QEMU version being used. As referred in below issue:
  https://github.com/golang/go/issues/40949

  We tried to build go-runner image using go1.15 and register QEMU
  (docker run --rm --privileged multiarch/qemu-user-
  static@sha256:c772ee1965aa0be9915ee1b018a0dd92ea361b4fa1bcab5bbc033517749=
b2af4
  --reset -p yes) as mentioned in PR
  https://github.com/kubernetes/release/pull/1499. We observed below
  failure during build:

  -------------------------------------------------------------------------=
--------
  ERROR: executor failed running [/bin/sh -c CGO_ENABLED=3D0 GOOS=3Dlinux G=
OARCH=3D${ARCH}     go build -ldflags '-s -w -buildid=3D -extldflags "-stat=
ic"'     -o go-runner ${package}]: buildkit-runc did not terminate successf=
ully
  ------
  =C2=A0> [builder 7/7] RUN CGO_ENABLED=3D0 GOOS=3Dlinux GOARCH=3D${ARCH}  =
   go build -ldflags '-s -w -buildid=3D -extldflags "-static"'     -o go-ru=
nner .:
  ------
  failed to solve: rpc error: code =3D Unknown desc =3D executor failed run=
ning [/bin/sh -c CGO_ENABLED=3D0 GOOS=3Dlinux GOARCH=3D${ARCH}     go build=
 -ldflags '-s -w -buildid=3D -extldflags "-static"'     -o go-runner ${pack=
age}]: buildkit-runc did not terminate successfully
  Makefile:52: recipe for target 'container' failed
  make: *** [container] Error 1
  -------------------------------------------------------------------------=
--------

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1893040/+subscriptions

