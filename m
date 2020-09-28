Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30FAC4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F8022207
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DH4m6/FC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F8022207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMjD4-000411-Gc
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 22:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj1i-0007nW-MK; Sun, 27 Sep 2020 22:36:32 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj1e-0003Li-QQ; Sun, 27 Sep 2020 22:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601260586; x=1632796586;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CDicpbQlEYirPMv6LJDX+sqlc3u9djdNDeAWD2fg/v8=;
 b=DH4m6/FC4KHJSTn2PHkI6ExZXiLBT4PIYfX4PKZKux5mZ7HsBlkUFpF4
 8GG68sDmVlnqmOYoAW31jLDw36h3F7x5hWNaiGA/iJ7HQ8JH05Vzepp4y
 IliJ83bFfRvDYLcKX8TaIQ7H2JkJhZS49/Dov3BmY+XSlbg0bZ2tj82Uu
 nenU5tpaeEMnwKq6cAxUXfahZUuqVt2YMb8NfcoAqJS8J5unrs8/I6qsR
 PBo9H1GItyMOvjhBo8rLbQbYj2nysF02aNGkxRo8Cg/hKFSG0aoennLyo
 Zno7pjq8HLAi+0+5+BUeFdVLayHHbwpnHYfzUj6GfEDcxA0hPJ2AxMEEE A==;
IronPort-SDR: IXlCPyiBNO9tHZUFGqYKJocM22q5NiEmxaiOqxNmaadflDZPSinpUaWOQ4x0j4GGVKZQFVhGdN
 TiQg2LJQYNP4sYfr3LiTnhNOnmALlqBX3DId4GQR7uFOJUi2KCIdfiokese0n1drKDSNis/axl
 14liZrwyu4QrRArXEIWgnVQHlgQMeCz+myNSH5T/1jieTvjcQuZW06QPoNN+S2dob5aFx/vDKr
 20ovk/2y5MHDHMCLBbn/DubUr5qRa2Hz01prHUJg1SSA2b63LklUb5AVq1jhg88UtMmbV5cz6/
 lFo=
X-IronPort-AV: E=Sophos;i="5.77,312,1596470400"; d="scan'208";a="258125254"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 10:36:05 +0800
IronPort-SDR: v65OiUf2vqV0Y6duojK6o0FPTWAxrrwXA8Nj5eGQsjfewe/XHq5Y+HMvWVREjQGh/uv974yUuV
 aQrecWr7c9Sg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 19:23:01 -0700
IronPort-SDR: fr911q5Yf0OdNrJ/BWd94FydXg2dvERsfQ45ZlwDvtlOxFcw+pNzXfO1p+60DJC9yZYyGvSTJe
 yEGzLL3dgxOQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Sep 2020 19:36:03 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v5 14/14] hw/block/nvme: Document zoned parameters in usage
 text
Date: Mon, 28 Sep 2020 11:35:28 +0900
Message-Id: <20200928023528.15260-15-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=5334b480d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 22:35:35
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
 hw/block/nvme.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ff7d43d38f..34fc6daf9d 100644
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
+ *      -device nvme-ns,drive=<drive_id>,bus=bus_name,nsid=<nsid>, \
+ *              zoned=<true|false[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
@@ -49,6 +50,45 @@
  *   completion when there are no oustanding AERs. When the maximum number of
  *   enqueued events are reached, subsequent events will be dropped.
  *
+ * Setting `zoned` to true selects Zoned Command Set at the namespace.
+ * In this case, the following options are available to configure zoned
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


