Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C7CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32AB920795
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aLhUw9PL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32AB920795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaVZh-0003kW-8H
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 22:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVQ5-0000B6-3H; Wed, 04 Nov 2020 21:54:37 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVQ2-0002bI-SG; Wed, 04 Nov 2020 21:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604544874; x=1636080874;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ShM3/qUGG+kjPEUhvFlAby960KhQy1mf+e0l54Ba9bQ=;
 b=aLhUw9PLbD1WMzegrmIqLNFBkhKOjPqc1y3tyZTHMBMLx2A8ne0YHlSv
 17T+5IL7JSEuSYGp8cDZGvlzhB04+4Ia36guGg45YV7L7sXFcDkl8PR2y
 xPcqI5tI5OSiQhs5Z03U64nwloZoYfZjwqPUg1SZNQBksrm3xWK2UUgxJ
 E+pKtsQhDUnYVSC/rTZfX04XK7rM8SAeBH+s5fLJVAedUwFHYwdMdWfdf
 TD2N8g9+4z4CbGdodcLlDwRs7r5aCkXgXZ2ZWOSQ+YoDqswX/qUAQ0ZXC
 8unPgLpJAUHmQdf27+waYiJ6ihK8/9aDhCzItNUgiphp6+1M8lNkoCAMN g==;
IronPort-SDR: QHtxbYx4TZof98ZVxtIZSrjhMVfnNFT1mW0kwZAN699pYI58eNyDHMn91Q85SAYzZ9uWi/Cz12
 6R4mNIHGQY0+gp6/yAkwpOZ8wAgJPRb4eM/Q2YQtZgArds3lTcqi53AUDuuCz5+O6C4F/zYSRj
 GELFbnbRaJiQgznPzYM9A3lwK2/jQ6gS5Y13uHXHqfX8FmFEzl3lCfbvWTkRtalxY9JiV5A4iB
 QLethIWy1s9g3ieUmF3RoeifIhihV/rnKhmHAaYINveEGR3f6/2Vl3797URQhpBczCSCOpxINk
 BOQ=
X-IronPort-AV: E=Sophos;i="5.77,452,1596470400"; d="scan'208";a="156335157"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 10:54:13 +0800
IronPort-SDR: /C0K/Nk2p+fOibA7ks++f+ZAvDHDtOqyoTJpopJDLQLNsNrxT/R8RaP6Ozk2bL45DYMZryTUnh
 R20caTrwP2RYMFR1FZD6aXH0oj/pKC7OThgamWQfzAaCtP8Q2gwYUOzBwDBVbTESXeZWcW1vYe
 iJa4rSv/M1Z5cG8pNMqim5zt+IuAWFfmS5sa/rOFPkD0M2kwxZOntK4oqPNofczsRgBHNjgvNI
 p81b7CxwiArHe0XbkHTPT2p5pETdxZCVMAkHCIf3xn+t7w5yDMOn/vmLZ51woXtE4jj/DNyO6B
 5hyBneWNFqyFj5GMzC7zerTu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2020 18:40:21 -0800
IronPort-SDR: 6bCICRKc6Un5ONgt9aa8mXqOziTPoc3I7y6EB1U9VRQ7qLtvA663hFB7C9onizAQAwM3WUkErg
 7y2D9ZVFKRkdb11qJ7dAy7R2iki4MaL7YAAO2N/uYlJU4ZJCuv39fD8qVaBDiSaazmQlp4S2w8
 B3kjB7WC9iJ8QFCUiQKgIEXzLLoGJ7QgTfkehSaIADkFIjxDx+3+k8x5Kw500anAZW7qpojf5Y
 5PhpbS27cXTPEyYBLHgcOuz28bpUVbyyO88Z5gLWc1qi5qkvqfaMhDAQsdrO3cQJqMC4Sq6xwL
 Fg8=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 18:54:12 -0800
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v9 12/12] hw/block/nvme: Document zoned parameters in usage
 text
Date: Thu,  5 Nov 2020 11:53:42 +0900
Message-Id: <20201105025342.9037-13-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201105025342.9037-1-dmitry.fomichev@wdc.com>
References: <20201105025342.9037-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=571894d84=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 21:53:45
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
Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
---
 hw/block/nvme.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 0db51995cc..8901321317 100644
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
@@ -22,8 +22,9 @@
  *              [pmrdev=<mem_backend_file_id>,] \
  *              max_ioqpairs=<N[optional]>, \
  *              aerl=<N[optional]>, aer_max_queued=<N[optional]>, \
- *              mdts=<N[optional]>
- *      -device nvme-ns,drive=<drive_id>,bus=bus_name,nsid=<nsid>
+ *              mdts=<N[optional]>,zoned.append_size_limit=<N[optional]> \
+ *      -device nvme-ns,drive=<drive_id>,bus=<bus_name>,nsid=<nsid>,\
+ *              zoned=<true|false[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
@@ -41,14 +42,50 @@
  * ~~~~~~~~~~~~~~~~~~~~~~
  * - `aerl`
  *   The Asynchronous Event Request Limit (AERL). Indicates the maximum number
- *   of concurrently outstanding Asynchronous Event Request commands suppoert
+ *   of concurrently outstanding Asynchronous Event Request commands support
  *   by the controller. This is a 0's based value.
  *
  * - `aer_max_queued`
  *   This is the maximum number of events that the device will enqueue for
- *   completion when there are no oustanding AERs. When the maximum number of
+ *   completion when there are no outstanding AERs. When the maximum number of
  *   enqueued events are reached, subsequent events will be dropped.
  *
+ * - `zoned.append_size_limit`
+ *   The maximum I/O size in bytes that is allowed in Zone Append command.
+ *   The default is 128KiB. Since internally this this value is maintained as
+ *   ZASL = log2(<maximum append size> / <page size>), some values assigned
+ *   to this property may be rounded down and result in a lower maximum ZA
+ *   data size being in effect. By setting this property to 0, users can make
+ *   ZASL to be equal to MDTS. This property only affects zoned namespaces.
+ *
+ * Setting `zoned` to true selects Zoned Command Set at the namespace.
+ * In this case, the following namespace properties are available to configure
+ * zoned operation:
+ *     zoned.zsze=<zone size in bytes, default: 128MiB>
+ *         The number may be followed by K, M, G as in kilo-, mega- or giga-.
+ *
+ *     zoned.zcap=<zone capacity in bytes, default: zone size>
+ *         The value 0 (default) forces zone capacity to be the same as zone
+ *         size. The value of this property may not exceed zone size.
+ *
+ *     zoned.descr_ext_size=<zone descriptor extension size, default 0>
+ *         This value needs to be specified in 64B units. If it is zero,
+ *         namespace(s) will not support zone descriptor extensions.
+ *
+ *     zoned.max_active=<Maximum Active Resources (zones), default: 0>
+ *         The default value means there is no limit to the number of
+ *         concurrently active zones.
+ *
+ *     zoned.max_open=<Maximum Open Resources (zones), default: 0>
+ *         The default value means there is no limit to the number of
+ *         concurrently open zones.
+ *
+ *     zoned.offline_zones=<the number of offline zones to inject, default: 0>
+ *
+ *     zoned.rdonly_zones=<the number of read-only zones to inject, default: 0>
+ *
+ *     zoned.cross_zone_read=<enable RAZB, default: false>
+ *         Setting this property to true enables Read Across Zone Boundaries.
  */
 
 #include "qemu/osdep.h"
-- 
2.21.0


