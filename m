Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2041DC54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A5D206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A5D206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYDzf-00080M-7w
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 15:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYDym-0006sw-7D
 for qemu-devel@nongnu.org; Mon, 11 May 2020 15:20:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:34002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYDyk-0002QQ-VF
 for qemu-devel@nongnu.org; Mon, 11 May 2020 15:20:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jYDyj-0000ul-0P
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 19:20:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id F1B9F2E810C
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 19:20:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2020 19:13:15 -0000
From: Stefan Hajnoczi <1873032@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mikegav stefanha
X-Launchpad-Bug-Reporter: Mikhail Gavrilov (mikegav)
X-Launchpad-Bug-Modifier: Stefan Hajnoczi (stefanha)
References: <158696794416.12296.17436515324844466583.malonedeb@soybean.canonical.com>
Message-Id: <158922439535.5318.13256361260432807372.malone@chaenomeles.canonical.com>
Subject: [Bug 1873032] Re: After upgrade qemu to 5.0.0-0.3.rc2.fc33 the
 virtual machine with Windows 10 after a while starts to work very slowly
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 2d2b32cf044fe0cc37824765245fc71b9eb0f37e
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 11:35:34
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

Please try this patch series: https://lists.gnu.org/archive/html/qemu-
devel/2020-05/msg02728.html

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

