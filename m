Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB59C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B297720809
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B297720809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMnTO-00079Y-N1
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 03:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMnSj-0006hM-MI
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 03:20:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:48818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kMnSh-0005Z7-Fj
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 03:20:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kMnSf-0005NH-FX
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 07:20:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6ED2C2E8053
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 07:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2020 07:15:04 -0000
From: Teodori Serge <1815721@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bmeng-cn rtos.pharos teodori-serge
X-Launchpad-Bug-Reporter: RTOS Pharos (rtos.pharos)
X-Launchpad-Bug-Modifier: Teodori Serge (teodori-serge)
References: <155004342499.19242.14077661245921319117.malonedeb@soybean.canonical.com>
Message-Id: <160127730458.12748.1569963738240456264.malone@soybean.canonical.com>
Subject: [Bug 1815721] Re: RISC-V PLIC enable interrupt for multicore
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a314d157ca9be8d00eae0214fc0d7dff1cd406e4"; Instance="production"
X-Launchpad-Hash: fae988fa7bd3a7447f461a5e158b3cdcc7b8fe45
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:20:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -67
X-Spam_score: -6.8
X-Spam_bar: ------
X-Spam_report: (-6.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.078, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Reply-To: Bug 1815721 <1815721@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello as far as I can tell, there is a major problem with PLIC
implementation. When decompiling DTB on virt board with X harts, I see
that hartid 0 has MEI and SEI, hartid 1 has MEI and SEI, etc... But when
configuring context 1 (hartid 0 SEI) no interrupt is generated, but
context 0, 2, 4 etc... work. So for me the problem is within PLIC or
RISC-V implementation... If anyone wants to correct it, I can help. Best
regards. Serge Teodori

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815721

Title:
  RISC-V PLIC enable interrupt for multicore

Status in QEMU:
  New

Bug description:
  Hello all,

  There is a bug in Qemu related to the enabling of external interrupts
  for multicores (Virt machine).

  After correcting Qemu as described in #1815078
  (https://bugs.launchpad.net/qemu/+bug/1815078), when we try to enable
  interrupts for core 1 at address 0x0C00_2080 we don't seem to be able
  to trigger an external interrupt  (e.g. UART0).

  This works perfectly for core 0, but fore core 1 it does not work at
  all. I assume that given bug #1815078 does not enable any external
  interrupt then this feature has not been tested. I tried to look at
  the qemu source code but with no luck so far.

  I guess the problem is related to function parse_hart_config (in
  sfive_plic.c) that initializes incorrectly the
  plic->addr_config[addrid].hartid, which is later on read in
  sifive_plic_update. But this is a guess.

  Best regards,
  Pharos team

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815721/+subscriptions

