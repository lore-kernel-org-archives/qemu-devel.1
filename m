Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDF8C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133FC22296
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133FC22296
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQAW-0000e0-DU
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60200)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hvQA1-0008Lb-OM
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hvQA0-0004iq-7f
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:55:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:38222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hvQA0-0004ga-28
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:55:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hvQ9y-0002kF-Je
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 17:55:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 935BC2E80C7
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 17:55:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Aug 2019 17:46:27 -0000
From: Aaron Hill <1839367@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: techsavvy8989
X-Launchpad-Bug-Reporter: Aaron Hill (techsavvy8989)
X-Launchpad-Bug-Modifier: Aaron Hill (techsavvy8989)
Message-Id: <156519998798.13922.14288436816599615545.malonedeb@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19015";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 9a5259a8635c426e2c5e8b3b1eb8b3b79a38f793
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1839367] [NEW] Wrong interrupts generated for
 I.MX6 FEC controller
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
Reply-To: Bug 1839367 <1839367@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

The imx_eth_update function in hw/net/imx_fec.c has the following
comment
(https://github.com/qemu/qemu/blob/864ab314f1d924129d06ac7b571f105a2b76a4b2=
/hw/net/imx_fec.c#L421-L445):

    /*
     * Previous versions of qemu had the ENET_INT_MAC and ENET_INT_MAC
     * interrupts swapped. This worked with older versions of Linux (4.14
     * and older) since Linux associated both interrupt lines with Ethernet
     * MAC interrupts. Specifically,
     * - Linux 4.15 and later have separate interrupt handlers for the MAC =
and
     *   timer interrupts. Those versions of Linux fail with versions of QE=
MU
     *   with swapped interrupt assignments.
     * - In linux 4.14, both interrupt lines were registered with the Ether=
net
     *   MAC interrupt handler. As a result, all versions of qemu happen to
     *   work, though that is accidental.
     * - In Linux 4.9 and older, the timer interrupt was registered directly
     *   with the Ethernet MAC interrupt handler. The MAC interrupt was
     *   redirected to a GPIO interrupt to work around erratum ERR006687.
     *   This was implemented using the SOC's IOMUX block. In qemu, this GP=
IO
     *   interrupt never fired since IOMUX is currently not supported in qe=
mu.
     *   Linux instead received MAC interrupts on the timer interrupt.
     *   As a result, qemu versions with the swapped interrupt assignment w=
ork,
     *   albeit accidentally, but qemu versions with the correct interrupt
     *   assignment fail.
     *
     * To ensure that all versions of Linux work, generate ENET_INT_MAC
     * interrrupts on both interrupt lines. This should be changed if and w=
hen
     * qemu supports IOMUX.
     */

Unfortunately, this behavior causes the QNX Sabrelite BSP
(http://blackberry.qnx.com/en/developers/bsp) to hang on ethernet
initialization. This is caused by the fact that QEMU is firing the
ENET_INT_TS_TIMER timer interrupt unexpectedly (when the ENET_INT_MAC
flag is set). The BSP functions correctly on the actual hardware, but it
is unable to handle the deliberately incorrect interrupt firing by QEMU.

>From reading the comment, it appears that this behavior is necessary to
support certain versions of Linux. However, it would be very useful to
be able to restore the correct interrupt behavior (possibly via a
command-line flag).

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1839367

Title:
  Wrong interrupts generated for I.MX6 FEC controller

Status in QEMU:
  New

Bug description:
  The imx_eth_update function in hw/net/imx_fec.c has the following
  comment
  (https://github.com/qemu/qemu/blob/864ab314f1d924129d06ac7b571f105a2b76a4=
b2/hw/net/imx_fec.c#L421-L445):

      /*
       * Previous versions of qemu had the ENET_INT_MAC and ENET_INT_MAC
       * interrupts swapped. This worked with older versions of Linux (4.14
       * and older) since Linux associated both interrupt lines with Ethern=
et
       * MAC interrupts. Specifically,
       * - Linux 4.15 and later have separate interrupt handlers for the MA=
C and
       *   timer interrupts. Those versions of Linux fail with versions of =
QEMU
       *   with swapped interrupt assignments.
       * - In linux 4.14, both interrupt lines were registered with the Eth=
ernet
       *   MAC interrupt handler. As a result, all versions of qemu happen =
to
       *   work, though that is accidental.
       * - In Linux 4.9 and older, the timer interrupt was registered direc=
tly
       *   with the Ethernet MAC interrupt handler. The MAC interrupt was
       *   redirected to a GPIO interrupt to work around erratum ERR006687.
       *   This was implemented using the SOC's IOMUX block. In qemu, this =
GPIO
       *   interrupt never fired since IOMUX is currently not supported in =
qemu.
       *   Linux instead received MAC interrupts on the timer interrupt.
       *   As a result, qemu versions with the swapped interrupt assignment=
 work,
       *   albeit accidentally, but qemu versions with the correct interrupt
       *   assignment fail.
       *
       * To ensure that all versions of Linux work, generate ENET_INT_MAC
       * interrrupts on both interrupt lines. This should be changed if and=
 when
       * qemu supports IOMUX.
       */

  Unfortunately, this behavior causes the QNX Sabrelite BSP
  (http://blackberry.qnx.com/en/developers/bsp) to hang on ethernet
  initialization. This is caused by the fact that QEMU is firing the
  ENET_INT_TS_TIMER timer interrupt unexpectedly (when the ENET_INT_MAC
  flag is set). The BSP functions correctly on the actual hardware, but
  it is unable to handle the deliberately incorrect interrupt firing by
  QEMU.

  From reading the comment, it appears that this behavior is necessary
  to support certain versions of Linux. However, it would be very useful
  to be able to restore the correct interrupt behavior (possibly via a
  command-line flag).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1839367/+subscriptions

