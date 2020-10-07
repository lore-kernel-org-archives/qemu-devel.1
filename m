Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EB9C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7893F2173E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7893F2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQEUm-000780-Dk
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 14:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQERb-0004xt-TT
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:45:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:34618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQERZ-00023X-9x
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:45:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kQERX-0004IN-Ch
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 18:45:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5C4822E80DE
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 18:45:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2020 18:39:05 -0000
From: Thomas Huth <1723488@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: th-huth ubuntu-weilnetz widgetii
X-Launchpad-Bug-Reporter: Dmitry Ilyin (widgetii)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <150791693020.21864.9239859411466983104.malonedeb@gac.canonical.com>
Message-Id: <160209594603.10020.13043204437696618806.malone@wampee.canonical.com>
Subject: [Bug 1723488] Re: HAX on Windows, memory lease error
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d50d1e75c500726862802414f880ee3e3bb759bf"; Instance="production"
X-Launchpad-Hash: 852492f8060ddd81361045b983629936c2cc99f7
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 12:55:34
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
Reply-To: Bug 1723488 <1723488@bugs.launchpad.net>
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
https://bugs.launchpad.net/bugs/1723488

Title:
  HAX on Windows, memory lease error

Status in QEMU:
  Incomplete

Bug description:
  Today I tried to use QEMU on Windows 8.1 x64 with Intel HAX.

  Command line: qemu-system-x86_64.exe -accel hax -m 8000 -hda
  /opt/disk/ubuntu.img -cdrom /opt/iso/ubuntu-17.04-server-amd64.iso

  Host machine has 32Gb physical memory, I got error:

  HAX is working and emulator runs in fast virt mode.
  **
  ERROR:A:/msys64/home/admin/git/qemu/target/i386/hax-mem.c:210:hax_process=
_section: assertion failed: (size <=3D UINT32_MAX)

  When using -m 4000 (and below) everything is fine. But if I try use
  >4000 and <8000 I get crash with errors:

  HAX is working and emulator runs in fast virt mode.
  hax_transaction_commit: Failed mapping @0x0000000100000000+0x78800000 fla=
gs 00
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request
  VCPU shutdown request

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1723488/+subscriptions

