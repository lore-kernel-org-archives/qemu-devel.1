Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41D9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC6A821D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6A821D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSlZw-0005Lt-ML
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 14:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kSlXy-0004TH-0M
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:30:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:43696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kSlXv-0003JA-OR
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:30:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kSlXt-00048x-JY
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 18:30:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 92CF82E8053
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 18:30:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2020 18:17:28 -0000
From: Damian Tometzki <1899728@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell th-huth tometzki
X-Launchpad-Bug-Reporter: Damian Tometzki (tometzki)
X-Launchpad-Bug-Modifier: Damian Tometzki (tometzki)
References: <160265051683.3148.7226301603216219676.malonedeb@soybean.canonical.com>
Message-Id: <160269944894.29924.17811709952604858190.malone@gac.canonical.com>
Subject: [Bug 1899728] Re: Qemu-5.1.0 build from source man entry not found
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="781851f4dc11c93bc506eb54e6a0d35c919a1ce6"; Instance="production"
X-Launchpad-Hash: ed27c52bd5c9fd4accbed54ed8a0af114226daf4
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 14:30:41
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
Reply-To: Bug 1899728 <1899728@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello together,

build with enable-docs and install the required packages now it works
with man qemu.

Many thanks for you help

Problem resolved :-)

Best regards
Damian


** Changed in: qemu
       Status: Incomplete =3D> Confirmed

** Changed in: qemu
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1899728

Title:
  Qemu-5.1.0 build from source man entry not found

Status in QEMU:
  Fix Released

Bug description:
  Hello together,

  i build qemu-5.1.0 from source on centos 8 withe the following
  command:

  ../configure --prefix=3D/usr --target-list=3Dx86_64-softmmu,x86_64-linux-
  user

  make -j4

  make install

  The build and the installation finished successfully. But when i try
  the command

  man qemu-system-x86_64

  i got the message "No manual entry found". What i do wrong ?

  Best regards
  Damian

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1899728/+subscriptions

