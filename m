Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4045C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF022245C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF022245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icwBM-0007n2-8O
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1icw81-0005tg-DB
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1icw7z-0000lu-9c
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:45:29 -0500
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:46185)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1icw7z-0000Zw-1A
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:45:27 -0500
Received: from player158.ha.ovh.net (unknown [10.109.143.109])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 567FE1B617F
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2019 19:45:15 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player158.ha.ovh.net (Postfix) with ESMTPSA id 6D74FCDB14C0;
 Thu,  5 Dec 2019 18:45:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 0/5] ppc/pnv: add a POWER10 PnvChip and a powernv10 machine
Date: Thu,  5 Dec 2019 19:44:49 +0100
Message-Id: <20191205184454.10722-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 5781214549797407718
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekuddguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudehkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.181.248
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

The POWER10 and POWER9 processors are very similar and this series
adds the basic framework for a POWER10 chip and a machine using this
chip. The PSI and LPC models are provided first because there are no
changes. XIVE needs some adaptation and will come later.

Thanks,

C.

C=C3=A9dric Le Goater (5):
  target/ppc: Add POWER10 DD1.0 model information
  ppc/pnv: Introduce a POWER10 PnvChip and a powernv10 machine
  ppc/psi: cleanup definitions
  ppc/pnv: add a PSI bridge model for POWER10
  ppc/pnv: add a LPC Controller model for POWER10

 include/hw/ppc/pnv.h            |  46 +++++++
 include/hw/ppc/pnv_lpc.h        |   6 +-
 include/hw/ppc/pnv_psi.h        |   2 +
 include/hw/ppc/pnv_xscom.h      |  22 ++++
 target/ppc/cpu-models.h         |   3 +
 target/ppc/cpu.h                |   1 +
 hw/ppc/pnv.c                    | 192 ++++++++++++++++++++++++++--
 hw/ppc/pnv_core.c               |  10 ++
 hw/ppc/pnv_lpc.c                |  30 +++--
 hw/ppc/pnv_psi.c                |  32 ++++-
 hw/ppc/pnv_xscom.c              |  23 +++-
 target/ppc/compat.c             |  21 +++-
 target/ppc/cpu-models.c         |   3 +
 target/ppc/translate_init.inc.c | 215 ++++++++++++++++++++++++++++++++
 14 files changed, 576 insertions(+), 30 deletions(-)

--=20
2.21.0


