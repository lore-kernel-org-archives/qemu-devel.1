Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA14C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A64227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A64227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0MT-0005gt-9s
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ii0HW-0008KG-AK
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ii0HT-0001Qv-V1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:12:13 -0500
Received: from 13.mo7.mail-out.ovh.net ([87.98.150.175]:59804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ii0HT-0001BW-Lo
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:12:11 -0500
Received: from player734.ha.ovh.net (unknown [10.108.16.187])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id BE0B9136407
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 19:12:08 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id CBC01D6D6210;
 Thu, 19 Dec 2019 18:12:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 00/13] ppc/pnv: remove the use of qdev_get_machine() and
 get_system_memory()
Date: Thu, 19 Dec 2019 19:11:42 +0100
Message-Id: <20191219181155.32530-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 13652662271723408358
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdduuddguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.150.175
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

The PowerNV and sPAPR machine use qdev_get_machine() and
get_system_memory() in some places. This is not a good modeling
pratice and it should be avoided. This series replaces the uses of
these routines with a set of QOM properties and aliases.

Thanks,

C.

Changes since v1:

 - fixed a missing assert(chip->system_memory)
 - introduced a XivePresenter link under XiveTCTX
=20
C=C3=A9dric Le Goater (5):
  ppc/pnv: Modify the powerdown notifier to get the PowerNV machine
  ppc/pnv: Introduce a "system-memory" property
  ppc/pnv: Introduce a "xics" property alias under the PSI model
  ppc/pnv: Introduce a "xics" property under the POWER8 chip
  xive: Add a "presenter" link property to the TCTX object

Greg Kurz (8):
  spapr/xive: Use device_class_set_parent_realize()
  pnv/xive: Use device_class_set_parent_realize()
  spapr, pnv, xive: Add a "xive-fabric" link to the XIVE router
  xive: Use the XIVE fabric link under the XIVE router
  ppc/pnv: Add an "nr-threads" property to the base chip class
  ppc/pnv: Add a "pnor" const link property to the BMC internal
    simulator
  spapr/xive: Deduce the SpaprXive pointer from XiveTCTX::xptr
  pnv/xive: Deduce the PnvXive pointer from XiveTCTX::xptr

 include/hw/ppc/pnv.h        |  9 ++--
 include/hw/ppc/pnv_psi.h    |  1 +
 include/hw/ppc/pnv_xive.h   | 12 +++++
 include/hw/ppc/spapr_xive.h | 10 ++++
 include/hw/ppc/xive.h       | 13 +++--
 hw/intc/pnv_xive.c          | 23 ++++++---
 hw/intc/spapr_xive.c        | 14 +++++-
 hw/intc/spapr_xive_kvm.c    |  9 ++--
 hw/intc/xive.c              | 28 +++++++++--
 hw/ppc/pnv.c                | 94 ++++++++++++++++++++++++-------------
 hw/ppc/pnv_bmc.c            |  8 ++--
 hw/ppc/pnv_psi.c            | 22 ++++-----
 hw/ppc/spapr_irq.c          |  2 +
 13 files changed, 172 insertions(+), 73 deletions(-)

--=20
2.21.0


