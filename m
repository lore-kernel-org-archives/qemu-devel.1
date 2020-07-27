Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B084EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 889E820714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889E820714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04KY-00015n-RD
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k04Jr-0008Vk-3b
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:41:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:60028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k04Jp-0002Un-1Z
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:41:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k04Jk-0003C6-LK
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 14:41:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B10772E8142
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 14:41:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2020 14:32:44 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1863526@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm nvic
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd pmaydell
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <158189363238.15370.16875925531014106433.malonedeb@soybean.canonical.com>
Message-Id: <159586036593.29789.8085109342091080379.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1863526] Re: NVIC CCR register not 8-bit accessible using
 Cortex-M4
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e85d0ab92e2924d39b8285aeae075a01d25eff06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 31c154b416f4c650a068f0575509f26059b9b7c8
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 09:56:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1863526 <1863526@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Incomplete =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863526

Title:
  NVIC CCR register not 8-bit accessible using Cortex-M4

Status in QEMU:
  Invalid

Bug description:
  Head at commit b29c3e23f64938.

  Running with '-d unimp,guest_errors -trace nvic\*' I get:

  8871@1581892794.295746:nvic_sysreg_read NVIC sysreg read addr 0xd88 data =
0xf00000 size 4
  8871@1581892794.295752:nvic_sysreg_write NVIC sysreg write addr 0xd88 dat=
a 0xf00000 size 4
  8871@1581892794.297780:nvic_sysreg_write NVIC sysreg write addr 0xd08 dat=
a 0x4200 size 4
  8871@1581892794.298040:nvic_sysreg_write NVIC sysreg write addr 0xd15 dat=
a 0x0 size 1
  NVIC: Bad write of size 1 at offset 0xd15
  8871@1581892794.298081:nvic_sysreg_write NVIC sysreg write addr 0xd16 dat=
a 0x0 size 1
  NVIC: Bad write of size 1 at offset 0xd16
  8871@1581892794.298116:nvic_sysreg_write NVIC sysreg write addr 0xd17 dat=
a 0x0 size 1
  NVIC: Bad write of size 1 at offset 0xd17
  8871@1581892794.298156:nvic_sysreg_write NVIC sysreg write addr 0xd18 dat=
a 0x0 size 1
  8871@1581892794.298161:nvic_set_prio NVIC set irq 4 secure-bank 0 priorit=
y 0
  8871@1581892794.298164:nvic_recompute_state NVIC state recomputed: vectpe=
nding 0 vectpending_prio 256 exception_prio 256
  8871@1581892794.298168:nvic_irq_update NVIC vectpending 0 pending prio 25=
6 exception_prio 256: setting irq line to 0
  8871@1581892794.298201:nvic_sysreg_write NVIC sysreg write addr 0xd19 dat=
a 0x0 size 1
  8871@1581892794.298206:nvic_set_prio NVIC set irq 5 secure-bank 0 priorit=
y 0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863526/+subscriptions

