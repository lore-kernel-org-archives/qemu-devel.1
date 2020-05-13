Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A87CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77961206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77961206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYr0v-0005az-Jz
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 09:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYr0J-0005AC-5X
 for qemu-devel@nongnu.org; Wed, 13 May 2020 09:00:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:47162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYr0H-00046p-Tc
 for qemu-devel@nongnu.org; Wed, 13 May 2020 09:00:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jYr0F-0000Pe-OZ
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 13:00:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B7F6B2E8105
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 13:00:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2020 12:54:15 -0000
From: Hans-Christoph Steiner <1878413@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=binfmt-support; status=New; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: eighthave
X-Launchpad-Bug-Reporter: Hans-Christoph Steiner (eighthave)
X-Launchpad-Bug-Modifier: Hans-Christoph Steiner (eighthave)
Message-Id: <158937445580.17636.3003420565047461193.malonedeb@soybean.canonical.com>
Subject: [Bug 1878413] [NEW] /proc/sys/fs/binfmt_misc/ empty even though
 binfmt_misc is loaded
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0385b538081bc4718df6fb844a3afc89729c94ce";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: fb725a82017e27ae256ccc8ab78a2773e2f91130
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 07:25:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1878413 <1878413@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

_apksigner_ uses binfmt to execute via _jarwrapper_, since it is a JAR.
We have a test suite that relies on _apksigner_ working.  It was running
fine in Ubuntu/bionic.  Since it was pegged to LTS, it got upgraded to
Ubuntu/focal and it stopped working.  This is likely because
/proc/sys/fs/binfmt_misc/ is totally empty.  The "binfmt_misc" kernel
module shows as loaded:

$ grep binfmt /proc/modules
binfmt_misc 20480 1 - Live 0xffffffffc0452000

This relies on binfmt support in gitlab.com's CI runner setup, based on Doc=
ker.  binfmt works in containers there, for example on Ubuntu/bionic:
https://gitlab.com/fdroid/fdroidserver/-/jobs/516857857

Something in Ubuntu/focal broke this when running focal in the container on=
 the same Docker host runners:
https://gitlab.com/fdroid/fdroidserver/-/jobs/547148092

Debian's ci.debian.net lxc runners also have a similar problem, it might be=
 related:
https://salsa.debian.org/ci-team/debian-ci-config/-/issues/1

** Affects: binfmt-support
     Importance: Undecided
         Status: New

** Project changed: qemu =3D> binfmt-support

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878413

Title:
  /proc/sys/fs/binfmt_misc/ empty even though binfmt_misc is loaded

Status in binfmt-support:
  New

Bug description:
  _apksigner_ uses binfmt to execute via _jarwrapper_, since it is a
  JAR.  We have a test suite that relies on _apksigner_ working.  It was
  running fine in Ubuntu/bionic.  Since it was pegged to LTS, it got
  upgraded to Ubuntu/focal and it stopped working.  This is likely
  because /proc/sys/fs/binfmt_misc/ is totally empty.  The "binfmt_misc"
  kernel module shows as loaded:

  $ grep binfmt /proc/modules
  binfmt_misc 20480 1 - Live 0xffffffffc0452000

  This relies on binfmt support in gitlab.com's CI runner setup, based on D=
ocker.  binfmt works in containers there, for example on Ubuntu/bionic:
  https://gitlab.com/fdroid/fdroidserver/-/jobs/516857857

  Something in Ubuntu/focal broke this when running focal in the container =
on the same Docker host runners:
  https://gitlab.com/fdroid/fdroidserver/-/jobs/547148092

  Debian's ci.debian.net lxc runners also have a similar problem, it might =
be related:
  https://salsa.debian.org/ci-team/debian-ci-config/-/issues/1

To manage notifications about this bug go to:
https://bugs.launchpad.net/binfmt-support/+bug/1878413/+subscriptions

