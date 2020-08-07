Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE19C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E2E20748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E2E20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yrw-0006jZ-2V
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3yrC-0005o9-Ex
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:40:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:45084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3yrA-0003q3-MZ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:40:10 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k3yr9-0007hn-DZ
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 09:40:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 63CEB2E8072
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 09:40:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2020 09:27:13 -0000
From: Thomas Huth <1193555@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: techtonik th-huth
X-Launchpad-Bug-Reporter: anatoly techtonik (techtonik)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20130622052746.12679.99865.malonedeb@soybean.canonical.com>
Message-Id: <159679243323.15934.16302755314095010806.malone@wampee.canonical.com>
Subject: [Bug 1193555] Re: Add scale options to window menu
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 991c02d29855de69d102381b23cc46ad9f8fda24
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:41:01
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
Reply-To: Bug 1193555 <1193555@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looking through old bug tickets... is this still an issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1193555

Title:
  Add scale options to window menu

Status in QEMU:
  Incomplete

Bug description:
  This is a workaround against bug #504368, which makes QEMU window text
  blurry if resized. This is a common and annoying problem:

  http://butnottoohard.blogspot.com/2010/01/qemukvm-windows-7-blurry-text.h=
tml
  http://unix.stackexchange.com/questions/60564/how-can-i-restore-default-w=
indow-size-in-kvm-qemu

  =

  The ability to resize window is a feature - it allows to adjust viewport =
of QEMU to the convenient working area. But there should be an option to re=
store the size of the window or scale it like 1:2, 2:1 etc. I don't know ab=
out if that should be exposed to QEMU monitor as some "window <command>" se=
t , but it would be extremely convenient to provide at least Ctrl+Alt+U fun=
ctionality through window level menu.

  Ubuntu 13.04, QEMU 1.4.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1193555/+subscriptions

