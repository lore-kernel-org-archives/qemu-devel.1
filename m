Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F46C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 12:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36E920675
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 12:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36E920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1V1E-0006AM-Hd
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 07:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j1V02-0005Ms-1O
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 07:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j1V00-0008Rf-U6
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 07:50:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:56372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j1V00-0008PD-P4
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 07:50:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j1Uzy-00072C-8O
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 12:50:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1FCE42E80D4
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 12:50:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Feb 2020 12:42:29 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kawakami-k laurent-vivier pmaydell
X-Launchpad-Bug-Reporter: Kentaro Kawakami (kawakami-k)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <158099412478.8645.15882160651412694280.malonedeb@chaenomeles.canonical.com>
Message-Id: <158142495000.9078.6180187757258278383.malone@chaenomeles.canonical.com>
Subject: [Bug 1862167] Re: Variation of SVE register size (qemu-user-aarch64)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5f14772c76bce1fea68a8f20b0704ade10c70a42
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
Reply-To: Bug 1862167 <1862167@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Note also that the vector length in SVE is not fixed -- you should be
writing your guest code to support arbitrary vector lengths, because
otherwise it will not run on all SVE-supporting CPUs.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1862167

Title:
  Variation of SVE register size (qemu-user-aarch64)

Status in QEMU:
  New

Bug description:
  Specification of ARMv8-A SVE extention allows various values =E2=80=8B=E2=
=80=8Bfor the
  size of the SVE register. On the other hand, it seems that the current
  qemu-aarch64 supports only the maximum length of 2048 bits as the SVE
  register size. I am writing an assembler program for a CPU that is
  compliant with ARMv8-A + SVE and has a 512-bit SVE register, but when
  this is run with qemu-user-aarch64, a 2048-bit load / store
  instruction is executed This causes a segmentation fault. Shouldn't
  qeum-user-aarch64 have an option to specify the SVE register size?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1862167/+subscriptions

