Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1E5C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A157206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jxsiTJt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A157206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYKNn-0002Gm-1j
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56530b5a8=dmitry.fomichev@wdc.com>)
 id 1kYKE8-0006TD-Vh; Thu, 29 Oct 2020 22:33:17 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56530b5a8=dmitry.fomichev@wdc.com>)
 id 1kYKE6-0006fl-Gy; Thu, 29 Oct 2020 22:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604025194; x=1635561194;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5nTTmQuD/HiZqHuuk3VyWsaPe9oSQQMKS3teO6XgKiY=;
 b=jxsiTJt0p/wbL705kojZOcQRUbahRmhV+PhByDh8FA21VLm5wV5LjUvW
 TpSa99GTc1npBKedAI4rsHCJXGsDfypoNCuRbqv+mm5WCDmmiLs+cuJse
 /OuoiyI6cyS8BVnTQXnYVG29MnQS4jP4gETF2KrVwUA0lCo9KtuYyT1pY
 Mjm2o61z9pU2DLsDXzRB8FOPu3YN/hQxIZpNSx4TYAYaM6xdxS+/NXZjv
 l7qTtL0X/G6lbrk+wLcyemE0s1tFGolF/JOIZWLsCziFASV6NuJ83HZ8/
 Po/+iBKw5Qu27NS9s6107z2z662AmnqWtwH8NxpIWOSQYq1E22hHYLxpa A==;
IronPort-SDR: 8rJKwJjXxdOevMSSaM8gGdvZzTT+McJ9/T7byov6hOjoh6g04sp9OXZy1OboRp7ZRnjZd4l9lZ
 ZS0tK1Y6TUcfMvuwKE7FeQDKM2VSDDqlviUmIyqVsxcvx0ek2/HwFtkVIzOc7wMM6y2et0QmzG
 1kV0rnRJxZJZFjJefKfQNUMvdmU0ySHFtyDti5A1kMgGcwhmg1RPBP4wQ6wPwa5RWjNiS5Ux4x
 /gLyHIWSUKWpEIvNS3I5JPZWfqKzOizhvPK2DuGIaYy2lA3sPsgtu32ZF8+GhkFeR38xWKpuBP
 grA=
X-IronPort-AV: E=Sophos;i="5.77,431,1596470400"; d="scan'208";a="155748103"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 10:33:12 +0800
IronPort-SDR: M7wNJ2uRU5cokfO9bYf5eLPoD3E7wg+Mtlb37ik8SSsCqPKnztsiSkGsCxSLrTH92c1/qIbB/8
 9OP+JZBjV6o3miCScupey1fYEXcrpmanLnylfKsfiWIpmCiUgMa3ECvRI6TBI+8g2D14VPrTg3
 eM7HLdOt8LhAhRRGCCsi5jrYDy8Q8VBeRYSTX/UhxUkk+ibAlHeda+q5WzLHJrvHr+pmPm0xPU
 /JwceYsiHau8R11qReEOn6yu4jCyEYGibveFNqFd/QumaELgv6OGskFcr2UWcuBiWB9CDOrqnY
 CoJLvTt5aCREY5ky1u4/keCW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 19:18:17 -0700
IronPort-SDR: U82bYWB5Ck8sOnw7gQl/3UkiYBYHDwMhX+CT4NVfAR6KE8jCl8thnXHwRuDL7w0CIIUVj73WWz
 FJdoqiVtl2BWpI9we8E2jfilrzrkO5VUpZUoFZmW80OKA2uEc0bg3Mw3r/I7/zxci8OChBAVz2
 I9rFn1s4DlIMOPKdOrCb7p884T969J4QMHA8j6xZ5WCM2CG5ZRoxp1PsBe9N6fXO+f8EtBWe8G
 ffu+xEMjc1HBZlVAFk4PQR+f9W1bDh7kae4Vk3tVuJzR/nxW1xtnnla8P8hJLuAq8xfI/4IJdm
 Ltg=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 19:33:12 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v8 11/11] hw/block/nvme: Document zoned parameters in usage
 text
Date: Fri, 30 Oct 2020 11:32:42 +0900
Message-Id: <20201030023242.5204-12-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
References: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=56530b5a8=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 22:32:49
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
index 339becd3e2..10f5c752ba 100644
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


