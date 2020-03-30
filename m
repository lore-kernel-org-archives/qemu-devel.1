Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F64AC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EEEE20714
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEEE20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIr4d-00023A-6a
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 05:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jIr3Z-0000QW-Jl
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jIr3Y-0005Wv-2H
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:50:09 -0400
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:59005)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jIr3X-0005TY-O3
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:50:08 -0400
Received: from player729.ha.ovh.net (unknown [10.110.103.132])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 433532744B4
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 11:49:59 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player729.ha.ovh.net (Postfix) with ESMTPSA id 6C50E110F4F99;
 Mon, 30 Mar 2020 09:49:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 0/7] target/ppc: Add support for Radix partition-scoped
 translation
Date: Mon, 30 Mar 2020 11:49:39 +0200
Message-Id: <20200330094946.24678-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 13890790104737156070
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.40.108
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
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

The Radix tree translation model currently supports process-scoped
translation for the PowerNV machine (Hypervisor mode) and for the
pSeries machine (Guest mode). Guests running under an emulated
Hypervisor (PowerNV machine) require a new type of Radix translation,
called partition-scoped, which is missing today.

The Radix tree translation is a 2 steps process. The first step,
process-scoped translation, converts an effective Address to a guest
real address, and the second step, partition-scoped translation,
converts a guest real address to a host real address.

There are difference cases to covers :=20

* Hypervisor real mode access: no Radix translation.

* Hypervisor or host application access (quadrant 0 and 3) with
  relocation on: process-scoped translation.

* Guest OS real mode access: only partition-scoped translation.

* Guest OS real or guest application access (quadrant 0 and 3) with
  relocation on: both process-scoped translation and partition-scoped
  translations.

* Hypervisor access in quadrant 1 and 2 with relocation on: both
  process-scoped translation and partition-scoped translations.

The radix tree partition-scoped translation is performed using tables
pointed to by the first double-word of the Partition Table Entries and
process-scoped translation uses tables pointed to by the Process Table
Entries (second double-word of the Partition Table Entries).

Both partition-scoped and process-scoped translations process are
identical and thus the radix tree traversing code is largely reused.
However, errors in partition-scoped translations generate hypervisor
exceptions.

Based on work from Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Thanks,

C.

C=C3=A9dric Le Goater (6):
  target/ppc: Introduce a relocation bool in  ppc_radix64_handle_mmu_faul=
t()
  target/ppc: Assert if HV mode is set when running under a pseries machi=
ne
  target/ppc: Introduce ppc_radix64_xlate() for Radix tree translation
  target/ppc: Rework ppc_radix64_walk_tree() for partition-scoped transla=
tion
  target/ppc: Extend ppc_radix64_check_prot() with a 'partition_scoped' b=
ool
  target/ppc: Add support for Radix partition-scoped translation

Suraj Jitindar Singh (1):
  target/ppc: Enforce that the root page directory size must be at least
    5

 target/ppc/cpu.h         |   3 +
 target/ppc/excp_helper.c |   3 +-
 target/ppc/mmu-radix64.c | 411 +++++++++++++++++++++++++++++----------
 3 files changed, 308 insertions(+), 109 deletions(-)

--=20
2.21.1


