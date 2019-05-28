Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA80C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 04:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB80208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 04:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB80208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56964 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVThS-0005Gb-D3
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 00:26:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hVTgH-0004XD-MG
	for qemu-devel@nongnu.org; Tue, 28 May 2019 00:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hVTgG-0004zp-HT
	for qemu-devel@nongnu.org; Tue, 28 May 2019 00:25:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:35964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hVTgG-0004yP-By
	for qemu-devel@nongnu.org; Tue, 28 May 2019 00:25:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hVTgC-0005UD-P4
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 04:25:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A191D2E80D3
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 04:25:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 May 2019 04:17:53 -0000
From: Launchpad Bug Tracker <1817846@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor pmaydell rtos.pharos
X-Launchpad-Bug-Reporter: RTOS Pharos (rtos.pharos)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <155125434202.29829.12830631606462823569.malonedeb@chaenomeles.canonical.com>
Message-Id: <155901707363.30715.3868810881729444482.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 0a2df3bb1a79754d06da7935318a77ac059084c0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1817846] Re: Qemu 3.1 Aarch64 TLBI VAE1, x0
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1817846 <1817846@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1817846

Title:
  Qemu 3.1 Aarch64 TLBI VAE1, x0

Status in QEMU:
  Expired

Bug description:
  Hello,

  In my code I'm trying to remove some permissions to a 4KiB MMU
  descriptor. After that I invalidate the MMU with

  TLBI VAE1, x0

  where x0 is the start of the address of the 4 KiB page.

  In Qemu 2.12 this did not work, but I worked around it with:

  =

      /* invalidate the address */
      TLBI VAE1, x0

  =

      /*****************************************************************/
      /*****************************************************************/
      /* NOTE: THIS IS A TRICK FOR QEMU!!!!!!!!!!!!                        =
                                       */
      /* Apparently we have to change the TTBR0_EL1 when we change a descri=
ptor (especially to remove permissions) */
      /* Otherwise qemu (2.12) will continue with the same descriptor with =
permissions!                          **/
     /*****************************************************************/
     /*****************************************************************/
       =

      /* do a trick (in qemu) */
      mrs     x1 , TTBR0_EL1

      ldr     x2 , =3DkernelTable0Table

      msr     TTBR0_EL1 , x2

      isb

      msr     TTBR0_EL1 , x1

      /* return from function */
      ret

  =

  That is, I just replaced the TTBR0_EL1 with a temporary value, and then r=
estored it. (guess qemu 2.12 just needed to reload the values again).

  However, even this procedure is not working with qemu 3.1. (I just
  tested again with qemu 2.12 and the code works fine, with qemu 3.1 it
  does not).

  Thanks,
  Pharos team

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1817846/+subscriptions

