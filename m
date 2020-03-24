Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A11C54EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 04:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF7720724
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 04:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF7720724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGb9j-0006wG-0r
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 00:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jGb8a-0005KH-72
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 00:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jGb8Z-0005m9-47
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 00:26:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:37020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jGb8Y-0005lf-Uj
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 00:25:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jGb8V-0001UC-J6
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 04:25:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 648682E80DB
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 04:25:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Mar 2020 04:17:20 -0000
From: Launchpad Bug Tracker <1660010@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee icenowy janitor
X-Launchpad-Bug-Reporter: Icenowy Zheng (icenowy)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20170128060834.11421.45757.malonedeb@soybean.canonical.com>
Message-Id: <158502344106.22792.4847673435949757161.malone@loganberry.canonical.com>
Subject: [Bug 1660010] Re: AArch64 system emulation cannot execute virt uefi
 in 2.7 or 2.8
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 63e659c34df18b9983a6862b83d7d0e75b3eb7a5
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1660010

Title:
  AArch64 system emulation cannot execute virt uefi in 2.7 or 2.8

Status in QEMU:
  Expired

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

