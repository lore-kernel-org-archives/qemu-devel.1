Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D013C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 23:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9165520770
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 23:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mnkPSHnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9165520770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHEW8-0007Up-H1
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 19:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=517336518=dmitry.fomichev@wdc.com>)
 id 1kHEQe-0004z1-0k; Sat, 12 Sep 2020 18:55:32 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=517336518=dmitry.fomichev@wdc.com>)
 id 1kHEQb-0005ef-TG; Sat, 12 Sep 2020 18:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599951329; x=1631487329;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e++3QhnRNffa0GIl2+VYyMaBj8dBPJeZ5MT33Nj7yxg=;
 b=mnkPSHnVVW1280DGufkc31jKUqAT+I3M3uR584cb0nfwB+6SOKwpyUZm
 OdqPd8Nyaw8vACdtpXbXAofRIMPBcdKpfT1YLnXN5sbymbLRHTtZoxaHm
 WiN11loFnWJHlYxXpOCq5ezLFmv+icb93vevsBBnFxy3IzTyuD0eOYw0j
 5FHx40S8uuII3PM6csKGbJDTYhFYd1olxNTAGbS9UQDIfReSpNbTHvf2S
 z/Wly94yn7jaXEb+Vrb5UWVjP0iiPS8lrLL65/xRLfRpsmdTTHPY7gmUA
 psV/YxghqgvRr8WCjFWa6EjC4JQnxQhwdRxfI+/H80Vgj7x4iNWsCxLNj g==;
IronPort-SDR: cwAhIacimDfCBJH1RMJcpyJxBewmkJeLjC2G94M/NP3+wgXvZzGeTVZ1maw+6G+xwJM3kaxDCi
 Jg0nPbAVlM2VF37M2HykNNJjptEMqal9Q2Qw+wgKPrwTBfrZOs0CfCow0p9pm53/jz8l09JTbo
 /TYf5Y6GKG3DHwBxs7AjXMHjEBnaRSuTf4YRJLRHzsU3fcpRGNoZ3U7HG8HkKKm7bibJwF3ZsZ
 QK5LUzwycXWELsf/qH5aueycOmd/ecKXWH9x2f+HH+wN3aErn55nAl0/w2pjJABP2SklJFw1FI
 A5E=
X-IronPort-AV: E=Sophos;i="5.76,420,1592841600"; d="scan'208";a="256834874"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2020 06:55:10 +0800
IronPort-SDR: sbwVKPkqKFPXLH4jqwF+0+wIj69Gbxle9GFt0H+ErYGjq/ux1WD3PG1wfiOdCkEGPHxZuLnjvf
 7X2vQrbRa5zw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2020 15:41:30 -0700
IronPort-SDR: 5bPfhaD4gxFT93nNw2ychB66JM48o8fzAT0KxrGRMAcIsRmO6MncNYC2NtiZUPMaHQPYiUjtKw
 1RRCddvonNiA==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Sep 2020 15:55:09 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 15/15] hw/block/nvme: Document zoned parameters in usage
 text
Date: Sun, 13 Sep 2020 07:54:30 +0900
Message-Id: <20200912225430.1772-16-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
References: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=517336518=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 18:54:38
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
 hw/block/nvme.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 3e8e6e1472..9b1d80a204 100644
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
@@ -22,7 +22,7 @@
  *              [pmrdev=<mem_backend_file_id>,] \
  *              max_ioqpairs=<N[optional]>, \
  *              aerl=<N[optional]>, aer_max_queued=<N[optional]>, \
- *              mdts=<N[optional]>
+ *              mdts=<N[optional]>, zoned=<true|false[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
@@ -48,6 +48,45 @@
  *   completion when there are no oustanding AERs. When the maximum number of
  *   enqueued events are reached, subsequent events will be dropped.
  *
+ * Setting `zoned` to true makes the device to support zoned namespaces.
+ * In this case, of the following options are available to configure zoned
+ * operation:
+ *     zone_size=<zone size in MiB, default: 128MiB>
+ *
+ *     zone_capacity=<zone capacity in MiB, default: zone_size>
+ *         The value 0 (default) forces zone capacity to be the same as zone
+ *         size. The value of this property may not exceed zone size.
+ *
+ *     zone_file=<zone metadata file name, default: none>
+ *         Zone metadata file, if specified, allows zone information
+ *         to be persistent across shutdowns and restarts.
+ *
+ *     zone_descr_ext_size=<zone descriptor extension size, default 0>
+ *         This value needs to be specified in 64B units. If it is zero,
+ *         namespace(s) will not support zone descriptor extensions.
+ *
+ *     max_active=<Maximum Active Resources (zones), default: 0 - no limit>
+ *
+ *     max_open=<Maximum Open Resources (zones), default: 0 - no limit>
+ *
+ *     zone_append_size_limit=<zone append size limit, in KiB, default: MDTS>
+ *         The maximum I/O size that can be supported by Zone Append
+ *         command. Since internally this this value is maintained as
+ *         ZASL = log2(<maximum append size> / <page size>), some
+ *         values assigned to this property may be rounded down and
+ *         result in a lower maximum ZA data size being in effect.
+ *         If MDTS property is not assigned, the default value of 128KiB is
+ *         used as ZASL.
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


