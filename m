Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9EAC4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 08:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32E22067B
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 08:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32E22067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOdBn-00089A-3c
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 04:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kOdAl-0007LQ-Ed
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 04:45:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:50660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kOdAj-0003NN-DW
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 04:45:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kOdAh-0007lv-Gc
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 08:45:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7A3CB2E80DB
 for <qemu-devel@nongnu.org>; Sat,  3 Oct 2020 08:45:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2020 08:36:01 -0000
From: Thomas Huth <1898084@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Triaged; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pere-jobs th-huth
X-Launchpad-Bug-Reporter: Ophir LOJKINE (pere-jobs)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <160157283310.5327.3681752113841049978.malonedeb@soybean.canonical.com>
Message-Id: <160171416109.9249.1662688515943745211.malone@wampee.canonical.com>
Subject: [Bug 1898084] Re: Assertion failed: (buf_len != 0), function soread, 
 file socket.c, line 183.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d50d1e75c500726862802414f880ee3e3bb759bf"; Instance="production"
X-Launchpad-Hash: ce2e0801c9fe66ba52792247524d6f5fccd44bae
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 03:55:45
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
Reply-To: Bug 1898084 <1898084@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libslirp is a separate project now, and I see that you already reported
it there (https://gitlab.freedesktop.org/slirp/libslirp/-/issues/29), so
I'm closing this QEMU ticket now.

** Bug watch added: gitlab.freedesktop.org/slirp/libslirp/-/issues #29
   https://gitlab.freedesktop.org/slirp/libslirp/-/issues/29

** Changed in: qemu
       Status: New =3D> Invalid

** Changed in: qemu
       Status: Invalid =3D> Triaged

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1898084

Title:
  Assertion failed: (buf_len !=3D 0), function soread, file socket.c, line
  183.

Status in QEMU:
  Triaged

Bug description:
  I have a virtual raspberry py that I am running qemu 5.1.0 for MacOS.

  Here is the command line I used:

  qemu-system-arm \
    -M versatilepb \
    -cpu arm1176 \
    -m 256 \
    -drive file=3D2020-08-20-raspios-buster-armhf-lite.img,if=3Dnone,index=
=3D0,media=3Ddisk,format=3Draw,id=3Ddisk0 \
    -device virtio-blk-pci,drive=3Ddisk0,disable-modern=3Don,disable-legacy=
=3Doff \
    -net nic -net user,hostfwd=3Dtcp::5022-:22 \
    -dtb versatile-pb-buster-5.4.51.dtb \
    -kernel kernel-qemu-5.4.51-buster \
    -append "root=3D/dev/vda2 panic=3D1" \
    -no-reboot \
    -serial stdio

  When trying to ssh from another machine while docker was running
  inside the VM, I got the following error:

  Assertion failed: (buf_len !=3D 0), function soread, file /private/tmp/qe=
mu-20200813-13289-1g95loa/qemu-5.1.0/slirp/src/socket.c, line 183
  ../boot.sh: line 12:  8592 Abort trap: 6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1898084/+subscriptions

