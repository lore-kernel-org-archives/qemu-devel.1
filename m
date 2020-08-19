Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB39FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F01206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F01206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Nqi-0006ui-T6
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 09:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8Npm-0004so-Nz; Wed, 19 Aug 2020 09:08:54 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:33227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8Npj-0006LD-TM; Wed, 19 Aug 2020 09:08:54 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.48])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id ECA7551EFC66;
 Wed, 19 Aug 2020 15:08:47 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 15:08:46 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00210155c51-b542-4f98-aca2-e7a02f4ad345,
 56ABA3BD09B5898CED80C8E013D4E39E9C6048D1) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 0/8] spapr/xive: Activate StoreEOI in P10 compat guests
Date: Wed, 19 Aug 2020 15:08:35 +0200
Message-ID: <20200819130843.2230799-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 2c5fd92c-b7b9-471d-9261-4ff2517f48e3
X-Ovh-Tracer-Id: 2620813511378963238
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddtkedggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedvuedtvdeikeekuefhkedujeejgffggffhtefglefgveevfeeghfdvgedtleevnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 09:08:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

The first patch is a little improvement on how we deal with priorities
reserved by the hypervisor. The rest is about activating StoreEOI safely
on a host supporting it, P10 hosts are the target but experimental
P9 firmwares activate also StoreEOI.

The patchset adds a new KVM device command KVM_DEV_XIVE_GRP_SOURCE_INFO
(yet to be sent but nothing really complex) which lets QEMU query the
XIVE characteristics of the underlying HW interrupts. It also enforces
StoreEOI on P10 compat guests only to make sure that P9 compat guests
can not be migrated to a P9 host with StoreEOI activated. Nevertheless,
as this is useful, a new Spapr IRQ backend 'xive-storeeoi' allows the
user run a P9 compat guest with StoreEOI enabled.

Please comment because there might be a better alternative to address
these needs. 

Thanks,

C.

Cédric Le Goater (8):
  spapr/xive: Add a 'hv-prio' property to represent the KVM escalation
    priority
  linux-headers: Update for KVM_DEV_XIVE_GRP_SOURCE_INFO
  spapr/xive: Query the characteristics of a source in KVM
  spapr/xive: Activate StoreEOI for POWER10 only
  spapr/xive: Enforce the load-after-store ordering
  spapr/xive: Activate StoreEOI by default
  spapr/xive: Use the xics flag to check for XIVE-only IRQ backends
  spapr/xive: Introduce a XIVE StoreEOI IRQ backend

 include/hw/ppc/spapr_irq.h      |  1 +
 include/hw/ppc/spapr_xive.h     |  5 +++
 include/hw/ppc/xive.h           |  8 +++++
 linux-headers/asm-powerpc/kvm.h |  8 +++++
 hw/intc/spapr_xive.c            | 56 ++++++++++++++++++++++-----------
 hw/intc/spapr_xive_kvm.c        | 38 ++++++++++++++++++++++
 hw/intc/xive.c                  |  6 ++++
 hw/ppc/spapr.c                  |  6 +++-
 hw/ppc/spapr_irq.c              | 36 ++++++++++++++++++++-
 9 files changed, 143 insertions(+), 21 deletions(-)

-- 
2.25.4


