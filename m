Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B46CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07525218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07525218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxUc-000684-3x
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ihxTi-0005B2-Av
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ihxTg-0005u6-OO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:12:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:37180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ihxTg-0005qf-GU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:12:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ihxTe-0000oo-42
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 15:12:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0C44F2E80D2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 15:12:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Dec 2019 15:04:21 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell soso7885
X-Launchpad-Bug-Reporter: Phil.Chang (soso7885)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <157512714096.22533.6951833586552059273.malonedeb@chaenomeles.canonical.com>
Message-Id: <157676786125.28173.10172593326175598738.malone@chaenomeles.canonical.com>
Subject: [Bug 1854577] Re: unable to boot arm64 image
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c4ca178f06a31ab05b954f273077d6ce3dd50be9
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1854577 <1854577@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You don't say anything about the kernel image you're trying to boot, but
"nothing happens" is the expected result of trying to run a kernel which
is not correctly configured to run on QEMU. You can debug in the same
way you would debug "my kernel didn't boot on real hardware": try the
gdb debugstub, try looking at the kernel config and comparing against a
working version, etc.

https://translatedcode.wordpress.com/2017/07/24/installing-debian-on-
qemus-64-bit-arm-virt-board/ is an example of a working setup of an
aarch64 guest, which is probably a good place to start.


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1854577

Title:
  unable to boot arm64 image

Status in QEMU:
  Invalid

Bug description:
  Hi

  Now I facing boot linux-5.3 arm64 image failed, without any log, just
  hang here.

  Host machine: ubuntu-18.04 with 4.15.0-70-generic kernel
  Qemu version: qemu-system-aarch64-version 4.1.0
  use command: qemu-system-aarch64 -kernel <IAMGE> -append "console=3DttyAM=
A0" -m 2048M -smp 2 -M virt -cpu cortex-a57 -nographic

  could anyone teach me how to debug this?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1854577/+subscriptions

