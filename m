Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD29C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 17:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618C02078B
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 17:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618C02078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMDxo-0002Ys-DL
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 13:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMDxG-000288-1R
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 13:25:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:46940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMDxE-0006xI-8q
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 13:25:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kMDxC-0002xF-Gf
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 17:25:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 556B22E80E9
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 17:25:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2020 17:18:12 -0000
From: Thomas Huth <1637511@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: rm-anracon th-huth
X-Launchpad-Bug-Reporter: moenchmeyer (rm-anracon)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20161028134113.28825.36828.malonedeb@wampee.canonical.com>
Message-Id: <160114069256.12223.16827733594200141701.malone@soybean.canonical.com>
Subject: [Bug 1637511] Re: Armitage crashes KVM guest with Kali2016.2 for QXL
 video
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a314d157ca9be8d00eae0214fc0d7dff1cd406e4"; Instance="production"
X-Launchpad-Hash: 24e89b74237d958af08514663969ce8c18917925
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 13:05:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1637511 <1637511@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Is this still an issue with the latest version? Did you ever report it
to the Spice project?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1637511

Title:
  Armitage crashes KVM guest with Kali2016.2 for QXL video

Status in QEMU:
  Incomplete

Bug description:
  I recently got a strange bug which seems to be related to qemu-kvm and
  QXL. I came here via the hints of the KVM web-site for KVM/qemu bug
  tracking. But, I am not sure whether this is the right bug-tracker at
  all. Please advise me if I placed the report wrongly.

  I installed Kali2016.2 as a KVM guest on a Opensuse Leap 42.1 host
  (fully updated). The KVM guest machine was configured to use a spice
  display and QXL video. Everything OK with the installation with the
  exception of one major application with a Java interface - Armitage.

  Armitage is correctly configured and starts (with some minor Java
  errors) and opens its interface (msf console, target window  etc.)
  Trying to open the 2 specific menu points "Hosts" or "Attack" in the
  menu bar leads to something very strange: The screen flickers, then
  the whole login session is stopped and a standard login window opens.
  This happens independently of the setting for the type of Armitage
  target window (graphical or table like)

  Why do I report this bug here? =

  Because it happens with the QXL graphical video interface ONLY - not with=
 video=3Dvga or vmvga ! Neither does the bug occur when Armitage is started=
 in a ssh (-X) session from the host. =


  So, it is closely related to qemu-kvm AND QXL and the Java interaction
  with both.

  I really wonder what in the world can make 2 specific menu points of a
  Java application crash a KVM guest and restart a login shell in Kali
  only when QXL is used?

  qemu-kvm version : 2.3.1
  Kernel version of OS LEAP 42.1: Linux 4.1.31-30-default           =


  I have described the bug also to the Kali people - see
  https://bugs.kali.org/view.php?id=3D3698

  Please inform me what further data are required - if this is relevant
  in this bug-tracker at all.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1637511/+subscriptions

