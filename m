Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F60C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D0420870
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D0420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS322-0006tv-2M
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 14:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kS2zJ-0003mK-0J
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:56:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:34220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kS2z7-0007Fs-2E
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:55:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kS2z4-00078b-0B
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 18:55:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BE86F2E8104
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 18:55:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2020 18:48:18 -0000
From: Gannet <1775702@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: windows10
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aderumier-odiso costinel giox069 h-sieger ken20001
 lemosov
X-Launchpad-Bug-Reporter: Giovanni Panozzo (giox069)
X-Launchpad-Bug-Modifier: Gannet (ken20001)
References: <152840439622.3676.18260529468873821664.malonedeb@chaenomeles.canonical.com>
Message-Id: <160252849854.16378.4147869928717169060.malone@chaenomeles.canonical.com>
Subject: [Bug 1775702] Re: High host CPU load and slower guest after upgrade
 guest OS Windows 10 to ver 1803
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="781851f4dc11c93bc506eb54e6a0d35c919a1ce6"; Instance="production"
X-Launchpad-Hash: 51dfe2bfeafd5a4a042fbd2495945055f2f33872
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 14:55:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1775702 <1775702@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that C:\Program Files (x86)\SPICE Guest
Tools\drivers\Balloon\w10\amd64/blnsvr.exe intensively requesting
something in WMI-provider-host. And there are a lot of errors in event
logs about it also.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1775702

Title:
  High host CPU load and slower guest after upgrade guest OS Windows 10
  to ver 1803

Status in QEMU:
  New

Bug description:
  After upgrading Windows 10 guest to version 1803, guests VM runs
  slower and there is high host CPU load even when guest is almost idle.
  Did not happened with windows 10 up to version 1709.

  See my 1st report here:
  https://askubuntu.com/questions/1033985/kvm-high-host-cpu-load-after-upgr=
ading-vm-to-windows-10-1803

  Another user report is here:
  https://lime-technology.com/forums/topic/71479-windows-10-vm-cpu-usage/

  Tested on: Ubuntu 16.04 with qemu 2.5.0 and i3-3217U, Arch with qemu
  2.12 i5-7200U, Ubuntu 18.04 qemu 2.11.1 AMD FX-4300. All three
  platform showing the same slowdown and higher host cpu load with
  windows 10 1803 VM compared to windows 10 1709 VM.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1775702/+subscriptions

