Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9941FC2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 17:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 142BF20789
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 17:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142BF20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMDom-0005ZY-0W
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 13:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMDnX-0004tq-7i
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 13:15:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:45966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMDnV-0005ji-1N
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 13:15:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kMDnS-0002EI-Kz
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 17:15:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 98C8F2E80F1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 17:15:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2020 17:08:27 -0000
From: Thomas Huth <1708215@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: spice windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gunix th-huth
X-Launchpad-Bug-Reporter: Gheorghe Ungureanu (gunix)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <150169387475.3916.9615851037093784733.malonedeb@gac.canonical.com>
Message-Id: <160114010760.10052.18346160217474349899.malone@chaenomeles.canonical.com>
Subject: [Bug 1708215] Re: Windows 10 clipboard bug
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a314d157ca9be8d00eae0214fc0d7dff1cd406e4"; Instance="production"
X-Launchpad-Hash: 12dbbd3d2389b9d61c4726bf236e9edc09af563f
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
Reply-To: Bug 1708215 <1708215@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This sounds like a bug in Spice, and not like a bug in QEMU. If you
still face this problem, please report it to the spice project instead
(see https://www.spice-space.org/support.html).

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1708215

Title:
  Windows 10 clipboard bug

Status in QEMU:
  Invalid

Bug description:
  Hello,

  I am using qemu on arch:
      pacman -Q libvirt qemu linux virt-manager
  libvirt 3.5.0-1
  qemu 2.9.0-2
  linux 4.12.3-1
  virt-manager 1.4.1-2

  I have a windows 10 Guest, with all updates and the following packages in=
stalled in the guest:
  - QEMU guest agent 7.3.2
  - SPICE Guest Tools 0.132

  When I start the VM, I can copy/paste from the host to the guest.
  However, after I use COPY inside the VM, copy/paste is not working any
  more from host to guest. However, I can still copy/paste from guest to
  host.

  To summarize:
  - copy/paste from guest to host works always
  - copy/paste from host to guest works only if copy was not previously use=
d in guest.

  If this bug needs to be reported using another portal or if I can
  provide any further information, please contact me.

  Best Regards,
  gxgung

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1708215/+subscriptions

