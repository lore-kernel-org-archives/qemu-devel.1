Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E17C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB7520848
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oq4gb43M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB7520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSS6F-00085b-Ur
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 17:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5487bf209=dmitry.fomichev@wdc.com>)
 id 1kSS4C-0005l4-VT; Tue, 13 Oct 2020 17:42:47 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5487bf209=dmitry.fomichev@wdc.com>)
 id 1kSS47-0001lt-Vy; Tue, 13 Oct 2020 17:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602625360; x=1634161360;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fQR5BxQm0BmUBslyj3C9Wad69LMH6turCoV2zcDgCMo=;
 b=oq4gb43MXzzTLckiQqL212AMQPffzBu8H8e+RwP4kU0cqL9Q9+6tkheB
 dQHuZc5vQq1c60fKmCuKR2UMjAvM0p6plYCYi3JIMdVvyU7C3kx29RTyt
 lV7bWBehFtFBFtDv0qX9P7QWjTCbNATM0L1T2rlwDKg2TzIhfmpaOauDK
 YGN4JWMOcn4nxn6EueznT/Nyuchullng0aMXTVCEnnPHky2b+gdXoF+zy
 nGDVTEW/q3r9lu9Mqk4bC+hQR8Hs1ctLw3OqYyNXnV+S8y7gWrWciltg0
 YoxJiWbVWibKGvyQYbF/2wqvUFWFlv68QOTMOVsVZsgmVy+kJmA2FRDN8 w==;
IronPort-SDR: aOHftTMkJbZYLWeQNNaz/xtfPsFqfKYGh/jcwg7CQ0mu7SH5H64VKkQRwTvNk35EAU0PdNE1EJ
 Jw+RkAXnWEfAPtp6AgKFM3VG403U/987PERw2PyByJ2TbyAyLM570/AGVHP8/lmSnbOm//gKTH
 qZwQLgf/7T8ez2F8My70xOOCtPfDX+E4dXPvZ1qgmwzNniyQrYXhKW1AzX3QWwg14FDVNANyRu
 IHqN6pL85kNuRskvCT+Kv3xgm0p41nfaW6iSae0oqG2TOyPL/mfXHsIB0G8ZtQAHQk4j4dnDx8
 moc=
X-IronPort-AV: E=Sophos;i="5.77,371,1596470400"; d="scan'208";a="154185941"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2020 05:42:39 +0800
IronPort-SDR: 53YJsNcf9wMimJoFMZkhefs0C6lJBy0KILikrZhrxvS1iwAnL1Nvs2peusjh3sEDgsxEqZASUi
 dI9SzkNQKmg9EWz1x0Skf3l/0HHiRoZ3FOIfE4oj+S1tqovh5SY8RJPgbEmcc4Zv4Zf7qyPQBB
 UtZrBRg2H71cmVvrRkaKCfzdnvSQ3CnDmUdOS+LmO/PytxsHGlaywkaFH8JuSNZznGGPTOm+fJ
 9jXLB3RPeqA8cveOIlPxb/cXh/OEfal4XOJ1wZJhI0uw1QTgV+ibkJbbcf3YXwGwOvezBh8KkZ
 t62oFgp8fiCyNfBTVlLWhy+E
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 14:29:12 -0700
IronPort-SDR: zWC1z8tx5LBTMpcsVSDvTsN0M8Y0eCkMtsUd86wpo4OxXmizZqT0Ug1N/t3jR3HT/DfYbbxw1P
 lIwLbLbYu32pa2A2uyrIV6gLnRdFTxupBP31ugE6tQ9VTSfAN++hMTEW9HCb7wQJn4C+5j2csJ
 3X7OMIPudJtsbj/X0kl2F53ONsa8fl8D7DbMQ+1qCyf/tiNJHPKEWxtYDvlbRMVuY1L18n14rp
 M7ttE+lLNaLM9ZG2fp/D+LjihkxQOIqa7d/pNCQc2XRF+izeT1hHGUgbxmSTpnrdfoT9eNVcH4
 CgE=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Oct 2020 14:42:37 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v6 09/11] hw/block/nvme: Document zoned parameters in usage
 text
Date: Wed, 14 Oct 2020 06:42:10 +0900
Message-Id: <20201013214212.2152-10-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
References: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=5487bf209=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 17:42:19
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
index 18547722af..41caf35430 100644
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


