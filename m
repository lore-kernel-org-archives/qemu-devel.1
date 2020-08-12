Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F77C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 06:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E7B20781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 06:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E7B20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5kc5-0003vm-HN
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 02:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5kb8-0002ed-VH
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 02:50:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:49796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5kb7-0003ag-9b
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 02:50:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k5kb5-00043H-SQ
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 06:50:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D5EEE2E808B
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 06:50:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2020 06:44:39 -0000
From: John Paul Adrian Glaubitz <1815911@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: anarchetic glaubitz laurent-vivier th-huth
X-Launchpad-Bug-Reporter: John Paul Adrian Glaubitz (glaubitz)
X-Launchpad-Bug-Modifier: John Paul Adrian Glaubitz (glaubitz)
References: <155015240171.6215.11220706309348619396.malonedeb@soybean.canonical.com>
Message-Id: <159721467970.26332.7793954831830318240.malone@gac.canonical.com>
Subject: [Bug 1815911] Re: aptitude crashes qemu-m68k with handle_cpu_signal
 received signal outside vCPU context
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8570d384238e8e2f107ec580b0a4d47f1b61757c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 02:20:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1815911 <1815911@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just verified it with a very recently compiled version of QEMU from git
master and, indeed, the bug seems to be fixed as I can no longer
reproduce the crash. The command executes correctly.

I guess it's safe to mark this as fixed.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815911

Title:
  aptitude crashes qemu-m68k with handle_cpu_signal received signal
  outside vCPU context

Status in QEMU:
  Incomplete

Bug description:
  When building a package with sbuild on Debian, sbuild can use aptitude
  to resolve dependencies.

  Recently, some changes introduced to aptitude or related packages
  cause qemu to crash:

  (sid-m68k-sbuild)root@nofan:/# aptitude -y --without-recommends -o Dpkg::=
Options::=3D--force-confold -o Aptitude::CmdLine::Ignore-Trust-Violations=
=3Dfalse -o Aptitude::ProblemResolver::StepScore=3D100 -o Aptitude::Problem=
Resolver::SolutionCost=3D"safety, priority, non-default-versions" -o Aptitu=
de::ProblemResolver::Hints::KeepDummy=3D"reject sbuild-build-depends-core-d=
ummy :UNINST" -o Aptitude::ProblemResolver::Keep-All-Level=3D55000 -o Aptit=
ude::ProblemResolver::Remove-Essential-Level=3Dmaximum install vim
  Warning: Invalid locale (please review locale settings, this might lead t=
o problems later):
    locale::facet::_S_create_c_locale name not valid
  The following NEW packages will be installed:
    libgpm2{a} vim vim-common{a} vim-runtime{a} xxd{a} =

  0 packages upgraded, 5 newly installed, 0 to remove and 1 not upgraded.
  Need to get 7225 kB/7260 kB of archives. After unpacking 33.5 MB will be =
used.
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6019=
d1bf
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x601b=
64ab
  Segmentation fault
  (sid-m68k-sbuild)root@nofan:/#

  The crash does not reproduce on real hardware running Debian unstable.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815911/+subscriptions

