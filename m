Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F0AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A3522D2C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A3522D2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mtX-0003A3-Hn
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mlG-0001DC-Rl
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:45:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:36210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mlB-0002lW-B4
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:45:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k8ml9-0007nq-79
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:45:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 264EA2E8105
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:45:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2020 15:36:20 -0000
From: Thomas Huth <1872113@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: docs
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kekepower pmaydell
X-Launchpad-Bug-Reporter: =?utf-8?q?Stig-=C3=98rjan_Smelror_=28kekepower=29?=
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <158654057369.6269.6354060003943218170.malonedeb@chaenomeles.canonical.com>
Message-Id: <159793778166.4954.16783677147577034537.launchpad@gac.canonical.com>
Subject: [Bug 1872113] Re: qemu docs fails to build with Sphinx 3.0.x
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: 31c908823475bca8f28ea70377945b714a39e689
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 10:50:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1872113 <1872113@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1872113

Title:
  qemu docs fails to build with Sphinx 3.0.x

Status in QEMU:
  Fix Released

Bug description:
  We've just updated Sphinx to version 3.0.1 and qemu fails to build the
  docs with this version.

  Here's the relevant section in the build log.

  CONFDIR=3D"/etc/qemu" /usr/bin/sphinx-build-3  -W -b html -D version=3D4.=
2.92 -D release=3D"4.2.92 (qemu-5.0.0-0.rc2.0.1.mga8)" -d .doctrees/devel-h=
tml /home/iurt/rpmbuild/BUILD/qemu-5.0.0-rc2/docs/devel docs/devel
  Running Sphinx v3.0.1
  making output directory... done
  building [mo]: targets for 0 po files that are out of date
  building [html]: targets for 14 source files that are out of date
  updating environment: [new config] 14 added, 0 changed, 0 removed
  reading sources... [  7%] bitops
  reading sources... [ 14%] decodetree
  reading sources... [ 21%] index
  reading sources... [ 28%] kconfig
  reading sources... [ 35%] loads-stores
  reading sources... [ 42%] memory
  reading sources... [ 50%] migration
  reading sources... [ 57%] reset
  reading sources... [ 64%] s390-dasd-ipl
  reading sources... [ 71%] secure-coding-practices
  reading sources... [ 78%] stable-process
  reading sources... [ 85%] tcg
  reading sources... [ 92%] tcg-plugins
  reading sources... [100%] testing

  Warning, treated as error:
  /home/iurt/rpmbuild/BUILD/qemu-5.0.0-rc2/docs/../include/exec/memory.h:3:=
Type must be either just a name or a typedef-like declaration.
  If just a name:
  =C2=A0=C2=A0Error in declarator or parameters
  =C2=A0=C2=A0Invalid C declaration: Expected identifier in nested name, go=
t keyword: struct [error at 6]
  =C2=A0=C2=A0=C2=A0=C2=A0struct MemoryListener
  =C2=A0=C2=A0=C2=A0=C2=A0------^
  If typedef-like declaration:
  =C2=A0=C2=A0Error in declarator or parameters
  =C2=A0=C2=A0Invalid C declaration: Expected identifier in nested name. [e=
rror at 21]
  =C2=A0=C2=A0=C2=A0=C2=A0struct MemoryListener
  =C2=A0=C2=A0=C2=A0=C2=A0---------------------^

  make: *** [Makefile:1095: docs/devel/index.html] Error 2
  make: *** Waiting for unfinished jobs....

  I found this commit for memory.h that includes the section that faults.
  https://github.com/qemu/qemu/commit/5d248213180749e674fbccbacc6ee9c38499a=
bb3#diff-d892cbf314945b44699534cc1de4ebbd

  You can see the whole build log here.
  https://pkgsubmit.mageia.org/uploads/failure/cauldron/core/release/202004=
10161120.tv.duvel.699/log/qemu-5.0.0-0.rc2.0.1.mga8/build.0.20200410161338.=
log

  System: Mageia Cauldron

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1872113/+subscriptions

