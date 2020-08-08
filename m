Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553E0C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 10:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236152075D
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 10:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236152075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4LoB-0004QT-AC
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 06:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k4LnY-000418-7Y
 for qemu-devel@nongnu.org; Sat, 08 Aug 2020 06:09:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:55716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k4LnW-0006aJ-Fu
 for qemu-devel@nongnu.org; Sat, 08 Aug 2020 06:09:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k4LnU-0000nt-Cu
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2020 10:09:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5D87A2E8025
 for <qemu-devel@nongnu.org>; Sat,  8 Aug 2020 10:09:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2020 09:58:06 -0000
From: Thomas Huth <584146@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: product=qemu-kvm; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mjt+launchpad-tls th-huth
X-Launchpad-Bug-Reporter: Michael Tokarev (mjt+launchpad-tls)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20100522092545.29377.46473.malonedeb@soybean.canonical.com>
Message-Id: <159688068691.9477.3755680341582726505.launchpad@wampee.canonical.com>
Subject: [Bug 584146] Re: Virtual fat breaks with -snapshot
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 32e4cad1fd78a2af04df4f9c58a6694bf2927f3d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/08 03:59:35
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
Reply-To: Bug 584146 <584146@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu-kvm (Debian)
   Importance: Unknown =3D> Undecided

** Changed in: qemu-kvm (Debian)
       Status: Confirmed =3D> New

** Changed in: qemu-kvm (Debian)
 Remote watch: Debian Bug tracker #504049 =3D> None

** Package changed: qemu-kvm (Debian) =3D> qemu-kvm

** Changed in: qemu-kvm
       Status: New =3D> Incomplete

** Bug watch removed: Debian Bug tracker #504049
   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D504049

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/584146

Title:
  Virtual fat breaks with -snapshot

Status in QEMU:
  Incomplete
Status in qemu-kvm:
  Incomplete

Bug description:
  When using fat emulation together with snapshot, qemu fails to find
  the directory for the fat "filesystem".

  See Debian bug#504049, http://bugs.debian.org/cgi-
  bin/bugreport.cgi?bug=3D504049 and discussion on qemu-devel with Kevin
  Wolf, http://marc.info/?t=3D126850802800001 for details.

  There's a workaround for this bug: when using full path for
  fat:/dir/name it works.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/584146/+subscriptions

