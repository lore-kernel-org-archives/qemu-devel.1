Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6ECC43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 22:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A554F21548
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 22:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M16DQruz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A554F21548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHaI9-0001oK-MN
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 18:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=518fa018e=dmitry.fomichev@wdc.com>)
 id 1kHaGs-00085q-5y; Sun, 13 Sep 2020 18:14:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=518fa018e=dmitry.fomichev@wdc.com>)
 id 1kHaGn-00016w-Rq; Sun, 13 Sep 2020 18:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600035289; x=1631571289;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=96slerFRXvvQ88VtjETXJDLsE1duM+UNRmZQyxlUYxI=;
 b=M16DQruz3wOFTTeF5QJfKphrrvpErMP+mLkoAYzHETbKU4S2pMmU2qJ4
 KQ/hgArPyUHDha4k0JTIqpqPSJiL07KmWU1Cg84fwZ+z2+8Nu9jhvzi7z
 zJJN2eC/Zc0ztGcLbf97+TM8TOmAK8jtaSpD+sp+YEFGbnVfm+Zrw2FY3
 OCXaokBGND1DZGQopK3sujR43QRlHvR+HlxAjENq2Yxf/21gtY44HB8d2
 1gxAhQ/JjsMMnDgZphRRT9Ev762vywHTBSpQqSb4WS8XothtV1qtyuDFh
 VOVDkySJUz5gFvpj9LHuuGMXcvvvXw4jOjunkux88kN4r3HyY90uQ8ydt w==;
IronPort-SDR: E8uYjkxRRC9L81nP7MttE7Pdrrix0JNtTEIG/HIpKsTys7N2+xLp4VM/kqLm82Z6NJWyqDDCSy
 KU/mP1fY3uhJANwa2lRR7tGABx0SsdGgsIdkB/kyOpzaGe/KXIxWWPTCVj3Ctn20eWSB5uSdTx
 KOFWU/mjSiW4cJ7FMdb5T3VoBnnw07z40x4LJmamJc3hoB0+wQi3WopjKjl0e0ikYY1H7CYJan
 lCS8B847XZOP+h1mEmP5eroCvugI61kYDHsWs4ElCoBAC6EG0E6eCN2ekYjkYAOY0h0kNOjkC0
 H24=
X-IronPort-AV: E=Sophos;i="5.76,423,1592841600"; d="scan'208";a="147179043"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 06:14:43 +0800
IronPort-SDR: lL2tplge36mFzS/IA0nNTw7avnbhJsBjqIQdNd3w2k7yqfs+sGamXTcUOSam3++PcO0AodHBK3
 cUsRc44wrBiA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2020 15:01:56 -0700
IronPort-SDR: yMrN0TcO4fkCmO9qBHPV8JcxqLEIvEoih4iiMmI2bJpavKE0SW4BqTptLX1wplVDIj558FjV40
 hoHmq/W/Rxpg==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Sep 2020 15:14:42 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v3 00/15] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Date: Mon, 14 Sep 2020 07:14:21 +0900
Message-Id: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=518fa018e=dmitry.fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 18:14:44
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2 -> v3:

 - Moved nvme_fill_data() function to the NSTypes patch as it is
   now used there to output empty namespace identify structs.
 - Fixed typo in Maxim's email address.

v1 -> v2:

 - Rebased on top of qemu-nvme/next branch.
 - Incorporated feedback from Klaus and Alistair.
 - Dropped "Simulate Zone Active excursions" patch.
   Excursion behavior may depend on the internal controller
   architecture and therefore be vendor-specific.
 - Dropped support for Zone Attributes and zoned AENs for now.
   These features can be added in a future series.
 - NS Types support is extended to handle active/inactive namespaces.
 - Update the write pointer after backing storage I/O completion, not
   before. This makes the emulation to run correctly in case of
   backing device failures.
 - Avoid division in the I/O path if the device zone size is
   a power of two (the most common case). Zone index then can be
   calculated by using bit shift.
 - A few reported bugs have been fixed.
 - Indentation in function definitions has been changed to make it
   the same as the rest of the code.


Zoned Namespace (ZNS) Command Set is a newly introduced command set
published by the NVM Express, Inc. organization as TP 4053. The main
design goals of ZNS are to provide hardware designers the means to
reduce NVMe controller complexity and to allow achieving a better I/O
latency and throughput. SSDs that implement this interface are
commonly known as ZNS SSDs.

This command set is implementing a zoned storage model, similarly to
ZAC/ZBC. As such, there is already support in Linux, allowing one to
perform the majority of tasks needed for managing ZNS SSDs.

The Zoned Namespace Command Set relies on another TP, known as
Namespace Types (NVMe TP 4056), which introduces support for having
multiple command sets per namespace.

Both ZNS and Namespace Types specifications can be downloaded by
visiting the following link -

https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs.zip

This patch series adds Namespace Types support and zoned namespace
emulation capability to the existing NVMe PCI device.

The patchset is organized as follows -

The first several patches are preparatory and are added to allow for
an easier review of the subsequent commits. The group of patches that
follows adds NS Types support with only NVM Command Set being
available. Finally, the last group of commits makes definitions and
adds new code to support Zoned Namespace Command Set.

Based-on: Message-ID: <20200729220638.344477-17-its@irrelevant.dk>

Ajay Joshi (1):
  hw/block/nvme: Define 64 bit cqe.result

Dmitry Fomichev (11):
  hw/block/nvme: Report actual LBA data shift in LBAF
  hw/block/nvme: Add Commands Supported and Effects log
  hw/block/nvme: Define trace events related to NS Types
  hw/block/nvme: Make Zoned NS Command Set definitions
  hw/block/nvme: Define Zoned NS Command Set trace events
  hw/block/nvme: Support Zoned Namespace Command Set
  hw/block/nvme: Introduce max active and open zone limits
  hw/block/nvme: Support Zone Descriptor Extensions
  hw/block/nvme: Add injection of Offline/Read-Only zones
  hw/block/nvme: Use zone metadata file for persistence
  hw/block/nvme: Document zoned parameters in usage text

Niklas Cassel (3):
  hw/block/nvme: Introduce the Namespace Types definitions
  hw/block/nvme: Add support for Namespace Types
  hw/block/nvme: Add support for active/inactive namespaces

 block/nvme.c          |    2 +-
 block/trace-events    |    2 +-
 hw/block/nvme.c       | 1932 ++++++++++++++++++++++++++++++++++++++++-
 hw/block/nvme.h       |  190 ++++
 hw/block/trace-events |   38 +
 include/block/nvme.h  |  210 ++++-
 6 files changed, 2308 insertions(+), 66 deletions(-)

-- 
2.21.0


