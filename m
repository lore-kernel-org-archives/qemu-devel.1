Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE4CC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 18:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E384F2072D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 18:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E384F2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTqX3-0006tr-RP
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 14:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kTqVw-0006RJ-Ds
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 14:01:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:45938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kTqVr-0004VD-EJ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 14:01:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kTqVn-0000r5-Tu
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 18:00:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 942C02E8079
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 18:00:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2020 17:51:30 -0000
From: Artyom Tarasenko <1874504@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: sparc64 vfio
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: atar4qemu gh975223
X-Launchpad-Bug-Reporter: Graeme Brett Houston BSc (gh975223)
X-Launchpad-Bug-Modifier: Artyom Tarasenko (atar4qemu)
References: <158766417277.8728.12362820918014730192.malonedeb@gac.canonical.com>
Message-Id: <160295709043.8105.11947952191280664104.malone@chaenomeles.canonical.com>
Subject: [Bug 1874504] Re: VFIO passthrough spits out thousands of messages
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="58bb2f3096f16f0e0acc917602669aecb4ffaf54"; Instance="production"
X-Launchpad-Hash: 3758b47d0348f91acdcedba519f3362839bd2715
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 14:01:00
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
Reply-To: Bug 1874504 <1874504@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Is this a regression? Can you please bisect to the first commit where it
happened?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1874504

Title:
  VFIO passthrough spits out thousands of messages

Status in QEMU:
  New

Bug description:
  started qemu as:
  sudo qemu-system-sparc64 -device vfio-pci,host=3D0b:05.0,x-no-mmap=3Don,b=
us=3DpciB

  messages received thousands of times:

  qemu-system-sparc64: -device vfio-pci,host=3D0b:05.0,x-no-mmap=3Don,bus=
=3DpciB: iommu has granularity incompatible with target AS
  qemu-system-sparc64: -device vfio-pci,host=3D0b:05.0,x-no-mmap=3Don,bus=
=3DpciB: iommu map to non memory area 4079c000

  qemu version (think telling a lie as sure its 5.0)
  QEMU emulator version 4.2.92
  Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers

  pci device being passed through:

  0b:05.0 Display controller [0380]: 3DLabs Permedia II 2D+3D [3d3d:0009] (=
rev 01)
  	Subsystem: Tech-Source Permedia II 2D+3D [1227:0006]
  	Flags: medium devsel, IRQ 11
  	Memory at 83000000 (32-bit, non-prefetchable) [disabled] [size=3D128K]
  	Memory at 82800000 (32-bit, non-prefetchable) [disabled] [size=3D8M]
  	Memory at 82000000 (32-bit, non-prefetchable) [disabled] [size=3D8M]
  	Expansion ROM at 83020000 [disabled] [size=3D64K]
  	Capabilities: <access denied>
  	Kernel driver in use: vfio-pci

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1874504/+subscriptions

