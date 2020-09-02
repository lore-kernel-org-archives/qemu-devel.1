Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB43C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BD5207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BD5207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDZ2X-0005EB-Mx
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 16:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kDZ0l-0003LI-LS
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 16:05:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:51142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kDZ0j-0006Nl-IK
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 16:05:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kDZ0g-0001RI-Mr
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 20:05:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A9E842E80DB
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 20:05:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2020 19:57:49 -0000
From: =?utf-8?q?Jes=C3=BAs_Sanz_del_Rey?= <1893807@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jesussanz2003
X-Launchpad-Bug-Reporter: =?utf-8?q?Jes=C3=BAs_Sanz_del_Rey_=28jesussanz200?=
 =?utf-8?q?3=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Jes=C3=BAs_Sanz_del_Rey_=28jesussanz200?=
 =?utf-8?q?3=29?=
References: <159897706621.21998.10972908941872978580.malonedeb@chaenomeles.canonical.com>
Message-Id: <159907666954.21830.1806881520227536993.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1893807] Re: Crash when launching windows qemu version from WSL2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="195cbfa84cb75815472f69dd83d46f006869050b"; Instance="production"
X-Launchpad-Hash: ea1376171a84aba264fd10a68e999f8fc5101135
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 16:05:35
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
Reply-To: Bug 1893807 <1893807@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Tags added: windows

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1893807

Title:
  Crash when launching windows qemu version from WSL2

Status in QEMU:
  New

Bug description:
  Version: 5.1.0
  Command line from WSL2:
  qemu-system-x86_64.exe -hdd /home/jesus/proyectos/RWivOS/bin/RELEASE/imag=
e.hdd -m 4G -smp 4 -machine q35 -debugcon stdio

  OS: Windows 10(64 bits) from WSL2 Ubuntu 18.04

  The error:
  ERROR:/home/stefan/src/qemu/repo.or.cz/qemu/ar7/block.c:1325:bdrv_open_dr=
iver: assertion
  =C2=A0failed: (is_power_of_2(bs->bl.request_alignment))

  The problem i'm seeing when i lauch from wsl2 only occurs when
  launched with argument -hdd from WSL2, if i launch it from Windows
  pointing to the WSL path where the file is stored works.

  It occurs on other versions, i tried 4.1.0 too.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1893807/+subscriptions

