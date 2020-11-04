Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D97C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 23:00:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E924206FA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 23:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E924206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaRlX-0007hf-BX
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 18:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaRkf-0007HR-2V
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 17:59:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:37962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaRkd-0000Ja-4j
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 17:59:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaRka-00080d-Sk
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 22:59:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D00CE2E8133
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 22:59:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2020 22:46:19 -0000
From: John Snow <1294227@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cdall jnsnow m-smarduch pmaydell
X-Launchpad-Bug-Reporter: Mario Smarduch (m-smarduch)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <20140318172403.30474.3932.malonedeb@soybean.canonical.com>
Message-Id: <160452997932.28892.6044621806314649636.malone@chaenomeles.canonical.com>
Subject: [Bug 1294227] Re: migration wrong handling of KVM_GET_DIRTY_LOG ioctl
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: f4fb87811905bedeeb768a5a01488d4c0a826f71
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 17:35:34
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
Reply-To: Bug 1294227 <1294227@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Moving this bug back to Confirmed to move it out of "In progress" state.
We still check for only -1 upstream.

** Changed in: qemu
       Status: In Progress =3D> Confirmed

** Changed in: qemu
     Assignee: Christoffer Dall (cdall) =3D> (unassigned)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1294227

Title:
  migration wrong handling of KVM_GET_DIRTY_LOG ioctl

Status in QEMU:
  Confirmed

Bug description:
  In the code below kvm_vm_ioctl(...) can return --errno !=3D -1 from ioctl=
 call,  but return only checks for -1. =

  Found during KVM-ARM migration which apperead to go through but was actua=
lly failing getting =

  memslot dirty bitmap.

  static int kvm_physical_sync_dirty_bitmap(....)
  {
   ....
   if(kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) =3D=3D -1) {
     - err out
   }
   ... continue
  }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1294227/+subscriptions

