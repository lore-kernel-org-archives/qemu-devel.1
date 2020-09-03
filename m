Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AA5C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79EE620709
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EE620709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDlvQ-0007QT-H9
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 05:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kDltR-0003pQ-EJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:50:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:60394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kDltO-0003S3-OQ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:50:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kDltL-0001EJ-9b
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 09:50:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 839A62E80EA
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2020 09:50:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2020 09:38:02 -0000
From: "Tony.LI" <1894071@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bigboy0822
X-Launchpad-Bug-Reporter: Tony.LI (bigboy0822)
X-Launchpad-Bug-Modifier: Tony.LI (bigboy0822)
References: <159912571834.28358.2492164063235416189.malonedeb@soybean.canonical.com>
Message-Id: <159912588237.27717.12873970230588653909.malone@soybean.canonical.com>
Subject: [Bug 1894071] Re: qemu-i386-static ioctl return -14 (Bad Address)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="195cbfa84cb75815472f69dd83d46f006869050b"; Instance="production"
X-Launchpad-Hash: fe0c267e24850e7a4993a20aa76c4f8a524eb1fc
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:31:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1894071 <1894071@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Attachment added: "ioctls.h"
   https://bugs.launchpad.net/qemu/+bug/1894071/+attachment/5407368/+files/=
ioctls.h

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1894071

Title:
  qemu-i386-static ioctl return -14 (Bad Address)

Status in QEMU:
  New

Bug description:
  I use qemu-i386-static on 64 bit ARM.But I don't know how to solve some p=
roblems.
  First I added some ioctl operations.
  Then I tried to do some DRM operations like test.c.
  This is successful when I use qemu-x86_64-static,but it failed when I use=
 qemu-i386-static.
  I can get some strace info like this:

  403 openat(AT_FDCWD,"/dev/dri/card0",O_RDWR|O_LARGEFILE|O_CLOEXEC) =3D 4
  403 ioctl(4,DRM_IOCTL_GET_CAP,{1,0}) =3D 0 ({1,1})
  403 ioctl(4,DRM_IOCTL_MODE_GETRESOURCES,{0,0,0,0,0,0,0,0,0,0,0,0}) =3D 0 =
({0,0,0,0,0,2,2,2,0,16384,0,16384})
  403 brk(NULL) =3D 0x40006000
  403 brk(0x40027000) =3D 0x40027000
  403 brk(0x40028000) =3D 0x40028000
  403 ioctl(4,DRM_IOCTL_MODE_GETRESOURCES,{0,1073766816,1073766832,10737668=
48,0,2,2,2,0,16384,0,16384}) =3D -1 errno=3D14 (Bad address)

  And there are similar errors in other self driven operations.
  I want to know if it is QEMU's problem, so I hope to get some help. =

  Thank you!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1894071/+subscriptions

