Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096DAC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 06:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF8E24655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 06:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF8E24655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuVj4-0004kf-3c
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 01:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iuVhg-0003VP-QI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 01:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iuVhf-0007qi-Le
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 01:10:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:53730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iuVhf-0007q0-GH
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 01:10:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iuVhe-0001Yp-N4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 06:10:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A9CA02E80C0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 06:10:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jan 2020 06:03:13 -0000
From: Thomas Huth <1660010@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee icenowy
X-Launchpad-Bug-Reporter: Icenowy Zheng (icenowy)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20170128060834.11421.45757.malonedeb@soybean.canonical.com>
Message-Id: <157975939413.18576.4969932704607535141.launchpad@gac.canonical.com>
Subject: [Bug 1660010] Re: AArch64 system emulation cannot execute virt uefi
 in 2.7 or 2.8
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b8d1327fd820d6bf500589d6da587d5037c7d88e";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0f05312ab04e884249ea8151ca48eb1b36cfb60e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1660010 <1660010@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1660010

Title:
  AArch64 system emulation cannot execute virt uefi in 2.7 or 2.8

Status in QEMU:
  Incomplete

Bug description:
  The UEFI firmware file is retrieved from
  http://snapshots.linaro.org/components/kernel/linaro-
  edk2/latest/release/qemu64/QEMU_EFI.fd .

  The error is:
  ```
  TODO /var/lib/abbs/build/tmp.p2dMBBlJ0D/qemu-2.7.0/tci.c:1049: tcg_qemu_t=
b_exec()
  /var/lib/abbs/build/tmp.p2dMBBlJ0D/qemu-2.7.0/tci.c:1049: tcg fatal error
  ```

  (both 2.7.0 and 2.8.0 are tested to fail, 2.6.1 works)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1660010/+subscriptions

