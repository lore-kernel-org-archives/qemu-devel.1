Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E02C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0779206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0779206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0tL-0005b1-T7
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kX0rt-0004ot-Ud
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:40:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:45038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kX0rr-0007Ep-QJ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:40:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kX0rq-0005W3-1h
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 11:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0215C2E812F
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 11:40:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2020 11:32:58 -0000
From: "Cheol-Woo,Myung" <1901532@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cwmyung
X-Launchpad-Bug-Reporter: Cheol-Woo,Myung (cwmyung)
X-Launchpad-Bug-Modifier: Cheol-Woo,Myung (cwmyung)
Message-Id: <160371197903.29636.2526014342409272320.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1901532] [NEW] Assertion failure `mr != NULL' failed through
 usb-ehci
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bc5a16cfdc4ba776ecdf84a052201ef8fb1f3321"; Instance="production"
X-Launchpad-Hash: 926139494c467a5f472bba827ed10fcde97f60ce
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 04:15:38
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
Reply-To: Bug 1901532 <1901532@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,

Using hypervisor fuzzer, hyfuzz, I found an assertion failure through
usb-ehci.

This was found in version 5.0.1 (stable-5.0).

--------

qemu-system-i386: src/qemu-repro/exec.c:3581: address_space_unmap: Assertio=
n `mr !=3D NULL' failed.
[1]    14721 abort      src/qemu-repro/build/i386-softmmu/qemu-system-i386


To reproduce the assertion failure, please run the QEMU with following comm=
and line.

```
$ qemu-system-i386 -drive file=3D./hyfuzz.img,index=3D0,media=3Ddisk,format=
=3Draw -m 512 -drive if=3Dnone,id=3Dstick,file=3D./usbdisk.img -device usb-=
ehci,id=3Dehci -device usb-storage,bus=3Dehci.0,drive=3Dstick
```

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "attachment.zip"
   https://bugs.launchpad.net/bugs/1901532/+attachment/5427245/+files/attac=
hment.zip

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1901532

Title:
  Assertion failure `mr !=3D NULL' failed through usb-ehci

Status in QEMU:
  New

Bug description:
  Hello,

  Using hypervisor fuzzer, hyfuzz, I found an assertion failure through
  usb-ehci.

  This was found in version 5.0.1 (stable-5.0).

  --------

  qemu-system-i386: src/qemu-repro/exec.c:3581: address_space_unmap: Assert=
ion `mr !=3D NULL' failed.
  [1]    14721 abort      src/qemu-repro/build/i386-softmmu/qemu-system-i386

  =

  To reproduce the assertion failure, please run the QEMU with following co=
mmand line.

  ```
  $ qemu-system-i386 -drive file=3D./hyfuzz.img,index=3D0,media=3Ddisk,form=
at=3Draw -m 512 -drive if=3Dnone,id=3Dstick,file=3D./usbdisk.img -device us=
b-ehci,id=3Dehci -device usb-storage,bus=3Dehci.0,drive=3Dstick
  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1901532/+subscriptions

