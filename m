Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23000C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 07:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF37206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 07:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF37206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsjUj-00035z-VH
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 03:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58578)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thuth@redhat.com>) id 1hsjTt-0001fl-QM
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 03:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hsjTs-0007vV-T0
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 03:57:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41066)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hsjTq-0007ti-OP; Wed, 31 Jul 2019 03:57:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D742308FB93;
 Wed, 31 Jul 2019 07:57:01 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7A895C1B5;
 Wed, 31 Jul 2019 07:56:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 09:56:44 +0200
Message-Id: <20190731075652.17053-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 31 Jul 2019 07:57:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.2 v2 0/8] Kconfig switches
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here are some more Kconfig patches that clean up the switches of
existing devices and introduce proper config switches for some
other devices that were always enabled before.

v2:
 - Included Philippe's patches to avoid a conflict with XLNX_ZYNQMP
 - Don't rely on indirect dependencies, always "select XYZ" if it is
   adequate
 - Added patch for the generic loader device

Philippe Mathieu-Daud=C3=A9 (3):
  hw/Kconfig: Move the generic XLNX_ZYNQMP to the root hw/Kconfig
  hw/intc: Only build the xlnx-iomod-intc device for the MicroBlaze PMU
  hw/dma: Do not build the xlnx_dpdma device for the MicroBlaze machines

Thomas Huth (5):
  hw/core: Add a config switch for the "register" device
  hw/core: Add a config switch for the "or-irq" device
  hw/core: Add a config switch for the "split-irq" device
  hw/misc: Add a config switch for the "unimplemented" device
  hw/core: Add a config switch for the generic loader device

 hw/Kconfig            |  4 ++++
 hw/arm/Kconfig        | 15 +++++++++++++++
 hw/core/Kconfig       | 13 +++++++++++++
 hw/core/Makefile.objs |  8 ++++----
 hw/dma/Kconfig        |  1 +
 hw/dma/Makefile.objs  |  1 -
 hw/intc/Makefile.objs |  2 +-
 hw/microblaze/Kconfig |  1 +
 hw/misc/Kconfig       |  3 +++
 hw/misc/Makefile.objs |  2 +-
 hw/pci-host/Kconfig   |  3 ++-
 hw/sparc64/Kconfig    |  1 +
 hw/timer/Kconfig      |  3 ---
 13 files changed, 46 insertions(+), 11 deletions(-)

--=20
2.21.0


