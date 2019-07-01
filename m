Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F3CC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC3B20881
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC3B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhvWT-0007ew-6R
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57564)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhvSx-0005u8-0x
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhvSv-0002Wr-Ry
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:31:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40194)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhvSs-0002Qd-Vn; Mon, 01 Jul 2019 08:31:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 06CDD307D915;
 Mon,  1 Jul 2019 12:31:20 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AEEB17CC0;
 Mon,  1 Jul 2019 12:31:10 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 14:31:02 +0200
Message-Id: <20190701123108.12493-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 01 Jul 2019 12:31:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/6] hw/arm: Use ARM_CPU_TYPE_NAME() and
 object_initialize_child()
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

First we use ARM_CPU_TYPE_NAME() when we should.

Then is follow up of
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01492.html

  This series looks at Eduardo suggestions from [1]
  and Thomas commit aff39be0ed97 to replace various
  object_initialize + qdev_set_parent_bus calls by
  sysbus_init_child_obj().

Finally, some devices are declared orphean while they have a parent,
let them be together again.

[1] https://patchwork.ozlabs.org/patch/943333/#1953608

Philippe Mathieu-Daud=C3=A9 (6):
  hw/arm: Use ARM_CPU_TYPE_NAME() macro when appropriate
  hw/arm: Use object_initialize_child for correct reference counting
  hw/arm: Use sysbus_init_child_obj for correct reference counting
  hw/arm/fsl-imx: Add the cpu as child of the SoC object
  hw/dma/xilinx_axi: Use object_initialize_child for correct ref.
    counting
  hw/net/xilinx_axi: Use object_initialize_child for correct ref.
    counting

 hw/arm/allwinner-a10.c  |  3 ++-
 hw/arm/cubieboard.c     |  3 ++-
 hw/arm/digic.c          |  3 ++-
 hw/arm/exynos4_boards.c |  4 ++--
 hw/arm/fsl-imx25.c      |  4 +++-
 hw/arm/fsl-imx31.c      |  4 +++-
 hw/arm/fsl-imx6.c       |  3 ++-
 hw/arm/fsl-imx6ul.c     |  3 ++-
 hw/arm/mcimx7d-sabre.c  |  9 ++++-----
 hw/arm/mps2-tz.c        | 15 +++++++--------
 hw/arm/musca.c          |  9 +++++----
 hw/arm/xlnx-zynqmp.c    |  8 ++++----
 hw/dma/xilinx_axidma.c  | 16 ++++++++--------
 hw/net/xilinx_axienet.c | 17 ++++++++---------
 14 files changed, 54 insertions(+), 47 deletions(-)

--=20
2.20.1


