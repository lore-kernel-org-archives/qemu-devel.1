Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AF1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD42F207DA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD42F207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd84E-0000N5-Sv
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jd82Y-0007n3-BD
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:00:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:40542)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jd82U-0007Jh-AK
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:00:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jd82S-0005u0-1S
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:00:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0779B2E8052
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:00:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2020 07:50:46 -0000
From: Rajas Kakodkar <1880518@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: rajaskakodkar
X-Launchpad-Bug-Reporter: Rajas Kakodkar (rajaskakodkar)
X-Launchpad-Bug-Modifier: Rajas Kakodkar (rajaskakodkar)
Message-Id: <159039304634.8018.14704731502559290875.malonedeb@gac.canonical.com>
Subject: [Bug 1880518] [NEW] issue while installing docker inside s390x
 container
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4ed5aa7f24021549c7b4e9e8af32261293384472
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 02:00:57
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
Reply-To: Bug 1880518 <1880518@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

This is in reference to https://github.com/multiarch/qemu-user-static/issue=
s/108.
I am facing issue while installing docker inside s390x container under qemu=
 on Ubuntu 18.04 host running on amd64.
Following are the contents of /proc/sys/fs/binfmt_misc/qemu-s390x on Intel =
host after running =

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
enabled
interpreter /usr/bin/qemu-s390x-static
flags: F
offset 0
magic 7f454c4602020100000000000000000000020016
mask ffffffffffffff00fffffffffffffffffffeffff
I could get docker service up with the following trick. =

printf '{"iptables": false,"ip-masq": false,"bridge": "none" }' > /etc/dock=
er/daemon.json
But even though docker service comes up, images are not getting pulled, doc=
ker pull fails with the following error.
failed to register layer: Error processing tar file(exit status 1):

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1880518

Title:
  issue while installing docker inside s390x container

Status in QEMU:
  New

Bug description:
  This is in reference to https://github.com/multiarch/qemu-user-static/iss=
ues/108.
  I am facing issue while installing docker inside s390x container under qe=
mu on Ubuntu 18.04 host running on amd64.
  Following are the contents of /proc/sys/fs/binfmt_misc/qemu-s390x on Inte=
l host after running =

  docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
  enabled
  interpreter /usr/bin/qemu-s390x-static
  flags: F
  offset 0
  magic 7f454c4602020100000000000000000000020016
  mask ffffffffffffff00fffffffffffffffffffeffff
  I could get docker service up with the following trick. =

  printf '{"iptables": false,"ip-masq": false,"bridge": "none" }' > /etc/do=
cker/daemon.json
  But even though docker service comes up, images are not getting pulled, d=
ocker pull fails with the following error.
  failed to register layer: Error processing tar file(exit status 1):

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1880518/+subscriptions

