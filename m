Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769FFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6342225A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g2I4UgIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6342225A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUKoe-0005eS-0D
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 22:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=dmitry.fomichev@wdc.com>)
 id 1kUKkG-0008Uj-Ha; Sun, 18 Oct 2020 22:17:56 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=dmitry.fomichev@wdc.com>)
 id 1kUKkE-0004JR-EV; Sun, 18 Oct 2020 22:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603073874; x=1634609874;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Fhgn/f0fIuWoNzgTIkxKels/TGJIM6EgvI+Hvc5k32w=;
 b=g2I4UgIqimfhEL8hI2TwLryGH5qMIpTAWTScDjSrkXQgE6le85JFhrOt
 wfZBgsAP/Nsj8EBYP8pmqSpM1oMxROqRQIZ7pZCA/tRogXxaZXFqhWElX
 eB8hSKNynlO3WZdx4gibY5XFJFDCUpFZxjo0Gylb6t3llM5hZBhJtT131
 G+yZ/YSyM4h0qi5E9v02DkzZX8n/UzD9dgTB6LvVHgUil2y6svHIX1gMG
 P34YLfy8ewuF2/dQTh9uP0KVobMl0JMvDnNju2VqdJyHtqq8UckriUtch
 SnfYotYMw6256jHQ8b15pjeVozvuuAdSZGhi/HxRQMTTGvNBjaQa+0WIQ A==;
IronPort-SDR: AsiOGIzF/MDhQT9TNZR61Prnavanx31LqVyCDAUuZbukJBl9nC5VFS/TQ7KuPsbulalLR79/xX
 lc6odLD5YqrxeE1Jd0izoKrWbbQSIkx91bBz4UVDjTt6VtmmFGzgtr3/2DBiJB3Tty0t1IrwbF
 yEpnNask9NXwNnb+LkxC54ELg1pPaL740DCBVf7cAU2usNqbi1NacCqkg2ojy0cCGG5BOkiXU6
 5dtCLKFhju+S2AeA9PQOYLGZqdZLNz7881ld2fkyf9CBUgkpE8fTnlkJg7IFI6JB4wELqhBlVK
 3aI=
X-IronPort-AV: E=Sophos;i="5.77,393,1596470400"; d="scan'208";a="150207980"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2020 10:17:52 +0800
IronPort-SDR: Q/s5K2Js/xqsphVUyGylsoMTBb1z8BPF7KUsqI8Qlv2oPhgS5yg3Y7j6ysYUHG2o/f2qkAiLic
 nyB545/k1kLi3ZySHARCgjQVxN2OZ8PFENhvmEHTCGvhaFYDtIwsgSot+6MydHQWUCW2xmPgoS
 lhytAk/zXVjaYP40IcNDl4/XSSVRyZxfPADeSqgAb2A/n71CMPawBgtlyXeCjTgh+FTSosdCFe
 cBv924bIDHGncUXAfPIzfcy5Ipz/qP4fH+zZ6agQun5MiL9btAXkDMySfeBAjMtN3hkTxzNYHD
 clWGEJpKChbla9SbTe91z8AP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2020 19:03:29 -0700
IronPort-SDR: BiiDpf5Up/++2AB4PhO6jA3lOft1bv8Zoh5uPDOYuTaEcGLEA4o9qqJ8IYC6mGMivLwXFHGVHH
 ybHU0G1d9/8htnDgtxWvvqZMOlSFr8pEwcNqhwiXwToNHWmBmfRe3KGt6fhz95qUGVLSA2Ftis
 LUtM/vBhVVOARmiiJzC9mdSAfSvt9qMRAxeMEf8Bkit23dtVaZ1C8P3zEzel0JQdL9uRVHr36w
 XAee4M1IXVuSwh/8iT+X2syfPNRc+mqyWTV74OwVyRDFnKYaSJiBqIeeLIJz9wcGd4Er/GyUhC
 /SY=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Oct 2020 19:17:50 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v7 09/11] hw/block/nvme: Document zoned parameters in usage
 text
Date: Mon, 19 Oct 2020 11:17:24 +0900
Message-Id: <20201019021726.12048-10-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=5541069a6=dmitry.fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 22:17:33
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

Added brief descriptions of the new device properties that are
now available to users to configure features of Zoned Namespace
Command Set in the emulator.

This patch is for documentation only, no functionality change.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fbf27a5098..3b9ea326d7 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -9,7 +9,7 @@
  */
 
 /**
- * Reference Specs: http://www.nvmexpress.org, 1.2, 1.1, 1.0e
+ * Reference Specs: http://www.nvmexpress.org, 1.4, 1.3, 1.2, 1.1, 1.0e
  *
  *  https://nvmexpress.org/developers/nvme-specification/
  */
@@ -23,7 +23,8 @@
  *              max_ioqpairs=<N[optional]>, \
  *              aerl=<N[optional]>, aer_max_queued=<N[optional]>, \
  *              mdts=<N[optional]>
- *      -device nvme-ns,drive=<drive_id>,bus=bus_name,nsid=<nsid>
+ *      -device nvme-ns,drive=<drive_id>,bus=<bus_name>,nsid=<nsid>, \
+ *              zoned=<true|false[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
@@ -49,6 +50,42 @@
  *   completion when there are no oustanding AERs. When the maximum number of
  *   enqueued events are reached, subsequent events will be dropped.
  *
+ * Setting `zoned` to true selects Zoned Command Set at the namespace.
+ * In this case, the following options are available to configure zoned
+ * operation:
+ *     zone_size=<zone size in bytes, default: 128MiB>
+ *         The number may be followed by K, M, G as in kilo-, mega- or giga.
+ *
+ *     zone_capacity=<zone capacity in bytes, default: zone_size>
+ *         The value 0 (default) forces zone capacity to be the same as zone
+ *         size. The value of this property may not exceed zone size.
+ *
+ *     zone_descr_ext_size=<zone descriptor extension size, default 0>
+ *         This value needs to be specified in 64B units. If it is zero,
+ *         namespace(s) will not support zone descriptor extensions.
+ *
+ *     max_active=<Maximum Active Resources (zones), default: 0 - no limit>
+ *
+ *     max_open=<Maximum Open Resources (zones), default: 0 - no limit>
+ *
+ *     zone_append_size_limit=<zone append size limit in bytes, default: 128KiB>
+ *         The maximum I/O size that can be supported by Zone Append
+ *         command. Since internally this this value is maintained as
+ *         ZASL = log2(<maximum append size> / <page size>), some
+ *         values assigned to this property may be rounded down and
+ *         result in a lower maximum ZA data size being in effect.
+ *         By setting this property to 0, user can make ZASL to be
+ *         equial to MDTS.
+ *
+ *     offline_zones=<the number of offline zones to inject, default: 0>
+ *
+ *     rdonly_zones=<the number of read-only zones to inject, default: 0>
+ *
+ *     cross_zone_read=<enables Read Across Zone Boundaries, default: true>
+ *
+ *     fill_pattern=<data fill pattern, default: 0x00>
+ *         The byte pattern to return for any portions of unwritten data
+ *         during read.
  */
 
 #include "qemu/osdep.h"
-- 
2.21.0


