Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E60C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1A020746
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1A020746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYOIe-0000wS-I9
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 02:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYOHc-0008DW-7z
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:20:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:55778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYOHb-00045u-Cj
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:20:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jYOHY-0007XE-0M
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 06:20:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 012D92E80E7
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 06:20:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2020 06:11:13 -0000
From: post-factum <1873032@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mikegav post-factum stefanha
X-Launchpad-Bug-Reporter: Mikhail Gavrilov (mikegav)
X-Launchpad-Bug-Modifier: post-factum (post-factum)
References: <158696794416.12296.17436515324844466583.malonedeb@soybean.canonical.com>
Message-Id: <158926387342.11689.14836135693898573680.malone@wampee.canonical.com>
Subject: [Bug 1873032] Re: After upgrade qemu to 5.0.0-0.3.rc2.fc33 the
 virtual machine with Windows 10 after a while starts to work very slowly
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 2e0a4c2a304b7e6edb7bac4c69a8aad7df821734
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:05:32
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
Reply-To: Bug 1873032 <1873032@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unofficial x86_64 build of v5.0.0 with those 2 patches for Arch is here:
[1].

[1] https://download.opensuse.org/repositories/home:/post-
factum/Arch/x86_64/

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1873032

Title:
  After upgrade qemu to 5.0.0-0.3.rc2.fc33 the virtual machine with
  Windows 10 after a while starts to work very slowly

Status in QEMU:
  New

Bug description:
  Description of problem:

  After upgrade qemu to 5.0.0-0.3.rc2.fc33 the virtual machine with
  Windows 10 after a while starts to work very slowly

  I created the virtual machine with Windows 10 with the following config:
  - 1 CPU
  - 2GB RAM
  - With network access

  I launch there a web browser there with flash content. =

  And usually, the system (Windows 10) does not work there for more than an=
 hour.
  When the system starts to work very slowly it doesn't respond to "Reboot"=
 and "Shut Down" commands. Only works "Force Reset" and "Force Off". But wh=
en I reboot the system with "Force Reset" it usually stuck at boot at the W=
indows splash screen. https://imgur.com/yGyacDG

  The last version of qemu which not contain this issue is
  5.0.0-0.2.rc0.fc33

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1873032/+subscriptions

