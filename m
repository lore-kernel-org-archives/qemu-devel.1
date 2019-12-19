Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891E7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 07:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1446E206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 07:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1446E206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihqHt-0007TD-N4
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 02:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ihqGI-0005p0-0e
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 02:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ihqGG-0000Wp-Id
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 02:30:17 -0500
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:38207)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ihqGG-00009c-64
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 02:30:16 -0500
Received: from player714.ha.ovh.net (unknown [10.108.16.238])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 66B68129AC3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 08:30:12 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id 24FF7D671CA4;
 Thu, 19 Dec 2019 07:30:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 00/10] ppc/pnv: remove the use of qdev_get_machine() and
 get_system_memory()
Date: Thu, 19 Dec 2019 08:29:51 +0100
Message-Id: <20191219073001.26790-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2811372068876159974
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddutddguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedugedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.46.122
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

The work is mostly complete. We still need to link the XiveTCTX to its
XiveRouter or XivePresenter under the sPAPR machine.

Thanks,

C.

C=C3=A9dric Le Goater (4):
  ppc/pnv: Modify the powerdown notifier to get the PowerNV machine
  ppc/pnv: Introduce a "system-memory" property
  ppc/pnv: Introduce a "xics" property alias under the PSI model
  ppc/pnv: Introduce a "xics" property under the POWER8 chip

Greg Kurz (6):
  spapr/xive: Use device_class_set_parent_realize()
  pnv/xive: Use device_class_set_parent_realize()
  spapr, pnv, xive: Add a "xive-fabric" link to the XIVE router
  xive: Use the XIVE fabric link under the XIVE router
  ppc/pnv: Add an "nr-threads" property to the base chip class
  ppc/pnv: Add a "pnor" const link property to the BMC internal
    simulator

 include/hw/ppc/pnv.h        |  7 +++-
 include/hw/ppc/pnv_psi.h    |  1 +
 include/hw/ppc/pnv_xive.h   | 12 ++++++
 include/hw/ppc/spapr_xive.h | 10 +++++
 include/hw/ppc/xive.h       |  5 ++-
 hw/intc/pnv_xive.c          | 15 +++++++-
 hw/intc/spapr_xive.c        | 12 +++++-
 hw/intc/xive.c              | 22 +++++++++--
 hw/ppc/pnv.c                | 75 ++++++++++++++++++++++++++++---------
 hw/ppc/pnv_bmc.c            |  8 ++--
 hw/ppc/pnv_psi.c            | 22 +++++------
 hw/ppc/spapr_irq.c          |  2 +
 12 files changed, 151 insertions(+), 40 deletions(-)

--=20
2.21.0


