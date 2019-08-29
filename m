Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818FAC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C882166E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C882166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3MQM-0007vg-Dj
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 11:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i3MOd-00072z-Cw
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i3MOa-000808-HW
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:31:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:33164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i3MOa-0007o7-8r
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:31:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i3MOP-0000w6-E5
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 15:31:21 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6641D2E8DEE
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 15:31:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Aug 2019 15:16:25 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1837094@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: slirp
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <156347205992.30489.16276823737610194084.malonedeb@soybean.canonical.com>
Message-Id: <156709178560.18928.14276054697857640775.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19034";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 19876535f36261ec5c9985fdab5edbb5ccd4cb6e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1837094] Re: UndefinedBehaviorSanitizer crash
 around slirp::ip_reass()
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
Reply-To: Bug 1837094 <1837094@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recent libslirp patch 126c04ac (explained in e0be8043) changed
ip_reass(), so this bug might be fixed.

https://gitlab.freedesktop.org/slirp/libslirp/commit/126c04ac
https://gitlab.freedesktop.org/slirp/libslirp/commit/e0be8043

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1837094

Title:
  UndefinedBehaviorSanitizer crash around slirp::ip_reass()

Status in QEMU:
  New

Bug description:
  tag: v4.1.0-rc1

  ./configure --enable-sanitizers --extra-cflags=3D-O1

  =3D=3D26130=3D=3DERROR: UndefinedBehaviorSanitizer: SEGV on unknown addre=
ss 0x000000000008 (pc 0x0000561ad346d588 bp 0x7fff6ee9f940 sp 0x7fff6ee9f8e=
8 T26130)
  =3D=3D26130=3D=3DThe signal is caused by a WRITE memory access.
  =3D=3D26130=3D=3DHint: address points to the zero page.
  =C2=A0=C2=A0=C2=A0=C2=A0#0 0x0000561ad346d587 in ip_deq() at slirp/src/ip=
_input.c:411:55
  =C2=A0=C2=A0=C2=A0=C2=A0#1 0x0000561ad346cffb in ip_reass() at slirp/src/=
ip_input.c:304:9
  =C2=A0=C2=A0=C2=A0=C2=A0#2 0x0000561ad346cb6f in ip_input() at slirp/src/=
ip_input.c:184:18

  I only had access to the last packet which isn't the culprit, I'm now
  seeing how to log the network traffic of the guest to provide more
  useful information.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1837094/+subscriptions

