Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8E9C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 19:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9062D2070C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 19:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9062D2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsAMl-0005ri-Kp
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 15:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jsALd-0004u8-Qz
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 15:30:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:59412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jsALb-00037b-Na
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 15:30:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jsALZ-0001Wx-0p
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 19:30:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 01FAC2E802B
 for <qemu-devel@nongnu.org>; Sun,  5 Jul 2020 19:30:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2020 19:24:58 -0000
From: Wilson-q <1886343@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: wilson-q
X-Launchpad-Bug-Reporter: Wilson-q (wilson-q)
X-Launchpad-Bug-Modifier: Wilson-q (wilson-q)
Message-Id: <159397709821.1977.12730820791239292652.malonedeb@wampee.canonical.com>
Subject: [Bug 1886343] [NEW] configure has non-posix bash syntax
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 023fc4fa9dfddb342e50eb1ab13ba76c1f4b4731
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 15:30:41
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
Reply-To: Bug 1886343 <1886343@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

which gives an error when run on a system that uses dash for /bin/sh.

The problem is at line 6464 which has
    if test "$have_keyring" =3D=3D "yes"
the double equal sign is non-posix bash syntax that isn't accepted by posix=
 shells like dash.  This was added 2020-05-25 according to git blame so loo=
ks like a recent problem.

On an Ubuntu 20.04 system with top of tree sources I get
gondor:2027$ ../qemu/configure --prefix=3D/home/wilson/FOSS/qemu/install-qe=
mu-tmp --target-list=3Driscv64-linux-user,riscv64-softmmu,riscv32-linux-use=
r,riscv32-softmmu
../qemu/configure: 6464: test: yes: unexpected operator
...

configure completes OK, so this is a minor problem.  It is just one
configure test that is failing to work properly.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1886343

Title:
  configure has non-posix bash syntax

Status in QEMU:
  New

Bug description:
  which gives an error when run on a system that uses dash for /bin/sh.

  The problem is at line 6464 which has
      if test "$have_keyring" =3D=3D "yes"
  the double equal sign is non-posix bash syntax that isn't accepted by pos=
ix shells like dash.  This was added 2020-05-25 according to git blame so l=
ooks like a recent problem.

  On an Ubuntu 20.04 system with top of tree sources I get
  gondor:2027$ ../qemu/configure --prefix=3D/home/wilson/FOSS/qemu/install-=
qemu-tmp --target-list=3Driscv64-linux-user,riscv64-softmmu,riscv32-linux-u=
ser,riscv32-softmmu
  ../qemu/configure: 6464: test: yes: unexpected operator
  ...

  configure completes OK, so this is a minor problem.  It is just one
  configure test that is failing to work properly.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1886343/+subscriptions

