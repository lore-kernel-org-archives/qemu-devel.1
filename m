Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5FFC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA1E215A5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA1E215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaKZj-0002AX-7P
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 09:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iaK8d-0003qD-PY
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iaK8a-0004mh-9c
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:47:17 -0500
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:57334)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iaK8a-0004Qx-1M
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:47:16 -0500
Received: from player688.ha.ovh.net (unknown [10.108.54.119])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 8301F1B721D
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 14:47:11 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id 3E161C94B198;
 Thu, 28 Nov 2019 13:47:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 0/7] target/ppc: Implement KVM support under TCG (final steps)
Date: Thu, 28 Nov 2019 14:46:53 +0100
Message-Id: <20191128134700.16091-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 14978690886735596518
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeijedgheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucffohhmrghinhepohiilhgrsghsrdhorhhgnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieekkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.52.147
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

This is a resend of Suraj's series adding KVM support to the QEMU
PowerNV machine under TCG :

  http://patchwork.ozlabs.org/cover/1094658/
 =20
I have addressed the comments and kept for later the final patch
adding partition scoped radix tree translation. I need to educate
myself a bit more on the topic first.

Thanks,

C.=20

C=C3=A9dric Le Goater (1):
  target/ppc: add support for Hypervisor Facility Unavailable Exception

Suraj Jitindar Singh (6):
  target/ppc: Implement the VTB for HV access
  target/ppc: Work [S]PURR implementation and add HV support
  target/ppc: Add SPR ASDR
  target/ppc: Add SPR TBU40
  target/ppc: Add privileged message send facilities
  target/ppc: Enforce that the root page directory size must be at least =
5

 include/hw/ppc/ppc.h            |   4 +-
 target/ppc/cpu.h                |  11 ++++
 target/ppc/helper.h             |   9 +++
 hw/ppc/ppc.c                    |  46 +++++++++++---
 linux-user/ppc/cpu_loop.c       |   5 ++
 target/ppc/excp_helper.c        |  52 ++++++++++++++--
 target/ppc/misc_helper.c        |  46 ++++++++++++++
 target/ppc/mmu-radix64.c        |   3 +
 target/ppc/timebase_helper.c    |  20 ++++++
 target/ppc/translate.c          |  30 +++++++++
 target/ppc/translate_init.inc.c | 105 +++++++++++++++++++++++++++-----
 11 files changed, 297 insertions(+), 34 deletions(-)

--=20
2.21.0


