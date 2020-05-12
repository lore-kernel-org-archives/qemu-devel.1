Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68A4C2D0F8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 22:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4E420740
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 22:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4E420740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYdHV-0004tL-Bi
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 18:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYdGu-0004PD-Oo
 for qemu-devel@nongnu.org; Tue, 12 May 2020 18:21:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:36508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYdGt-0005v7-3y
 for qemu-devel@nongnu.org; Tue, 12 May 2020 18:21:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jYdGr-0006PC-3k
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 22:21:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E28592E8115
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 22:21:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2020 22:07:05 -0000
From: Roman Bolshakov <1844946@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: hvf
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: nanoant
X-Launchpad-Bug-Reporter: Adam Strzelecki (nanoant)
X-Launchpad-Bug-Modifier: Roman Bolshakov (roolebo)
X-Launchpad-Bug-Duplicate: 1823831
References: <156918728216.32759.756692081712593785.malonedeb@wampee.canonical.com>
Message-Id: <158932122613.29675.4568053267058634051.launchpad@soybean.canonical.com>
Subject: [Bug 1844946] Re: macOS HVF broken with WinXP after Aug 21 2018
 92d5f1a414
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="013b6f2a3f3ba130b50b9eee1a89957ee38a5c15";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d79bdc0be7e3d94d705030ddaf8f99ff47be09a2
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 18:06:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1844946 <1844946@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

*** This bug is a duplicate of bug 1823831 ***
    https://bugs.launchpad.net/bugs/1823831

** Tags added: hvf

** Changed in: qemu
       Status: New =3D> Fix Released

** This bug has been marked a duplicate of bug 1823831
   BSD bootloader halts with hypervisor.framework

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1844946

Title:
  macOS HVF broken with WinXP after Aug 21 2018 92d5f1a414

Status in QEMU:
  Fix Released

Bug description:
  I use macOS with own built Qemu to run old XP system that I have migrated=
 from physical machine. My setup is very simple qemu-system-x86_64 with arg=
s:
  -machine pc,accel=3Dhvf,usb=3Doff,vmport=3Doff
  -cpu host
  -vga std
  -m 2048
  -drive file=3D"$img",format=3Dqcow2,cache=3Dnone,detect-zeroes=3Don
  -usb -device usb-tablet

  Unfortunately as soon I enable HVF with first 2 lines WinXP SP3 hangs
  on boot (famous mup.sys). It works fine in TCG.

  I dived into the code checking the differences between HVF, KVM and
  HAXM and my analysis is:

  1. Sergio Andres Gomez Del Real b7394c8394 - replaces explicit
  VMCS_GUEST_INTERRUPTIBILITY checks with hflags/hflags2.

  2. Paolo Bonzini 92d5f1a414 - changes hflags/hflags2 behavior which
  breaks in the end HVF interrupt handling and makes WinXP unable to
  boot. NOTE: This does not break I believe KVM and HAXM as they still
  do explicit check instead what HVF does in 1. That's why it was
  probably not reported and Qemu macOS users are rather niche ;)

  Reverting 92d5f1a414 makes WinXP boot well and work flawlessly.
  Unfortunately b7394c8394 is not easy anymore as too many changes on the w=
ay, so it may be not an option.

  This can be reproduced simply by installing /Users/ono/VM/ISO/en_windows_=
xp_professional_with_service_pack_3_x86_cd_vl_x14-73974.iso
  with HAL as "Standard PC" selectable with F5 on first run.

  I can also provide fresh ~600MB qcow2 image (without activation key
  entered yet) that is created before boot that fails. No need for full
  XP installation to test that.

  Nevertheless I would really appreciate Paolo looking into this.
  Many thanks for great software,
  Adam

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1844946/+subscriptions

