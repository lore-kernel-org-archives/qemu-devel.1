Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6B6C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60ED20637
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NMX+qKev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60ED20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNfy-00067V-AK
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNa9-0006U8-Mw
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNa8-00074R-Mr
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:29 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNa8-00073h-Dk; Mon, 09 Dec 2019 13:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915388; x=1607451388;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Dys0PWzpucJXCLJWA35Bq97629MmvwsOaIFCuZq7/+E=;
 b=NMX+qKevn/KSjzpQXyhT4yyf3D6pLvGA3M2T3DaOZLd5wAwtiwU+DBAU
 uLAomQxrkki1ZjitNQYQgCaJhiI3K/3yXub22F8J9oKJanEgEvhFqqW1Q
 if+Vk457INnYMvjm/g/ttEwVGti4/XKXmgzGBMGIabC1tLciUUv3Yc7mX
 3AxI7+o7bn4dJNK6nsWFrTPwEIbU+k8y/zH/N/MqGJSNwA+KWR94cyO8u
 09q2tAqZkvB+m/8jusmRGDHW4ba7hci/wLgWmAAqfAh2DJReg/wwrU2gB
 2OmcvZ6RGhOzV4cxYPwUjJ5THs8LF13X+CRoQmq3KSN+SkUkrHHUXqRoX w==;
IronPort-SDR: lS4q1EtRCmAAX1q/1DjASAMcFYzQKhb6pHUF2OT3Zqb3TZjE/7Lt0cVH3E2MTqKFpAVHZXqTUK
 KHgkbcVf8HiOpA1wmdEt6EgI3mVzbO0tZ1KRZgyGh2xjttwo86vddrwTMJIaf+dqTtH1G8Cf/a
 VIpIepMdit14hN1WC7jj0FlUIseVU0XdUT36zMFwKcPFerK+wzmhLknWrhDZIc5WF7GwXxsy4l
 L7Tz5QmwWQvgB5le/+LpayCewFN7MukRHoMIZpsZ2GtiOKNfK9gTYOzzriYYGqUPcOcGRp0GrW
 jXk=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="129370403"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:16:27 +0800
IronPort-SDR: 6fNXwaX2de/01TFmzEzZmWBAKneFQxGPGCHXJZK1/fON937WN2nXaZX9NXQVNZcAEMqUAsJ1Ba
 0AJR2+tjh4LTXZQBTXUfH5Q5Nv6l7yvddWMZKZ+kMtzKFZZ6PmYDJ4uDlNySUo0kRZYQBi6n01
 o9l2I85FjJ/UUGXHXOp86spm7SZhzeb3MMzRwgrsH8F3F9HIH7ztJTnLyw0Dgjd3OdDN99m/+K
 vy58uuoRNdYpQwQVRVZKGEucVYaWH9bNKIIwmDvT3NoxEAqrQoG+wRjWa9uASJjQd6NRQRnPtf
 2MYl4odTjUshgz4DidHRulBr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:10:43 -0800
IronPort-SDR: 4b6YO3UXNRUxpvvnxQGgMNqQaBHE/hb+43abs8WjXehAAvpL1fYfe9iqBGF7A+ZtQGf+9SK2xU
 2y9iylsqLvexEI3TzK0XWdc24RJZIEOzt4WwSgJBpjg4DfeEapXoF8yAzZ2B68D5eDmAmNzDz1
 vkaK24qBCPPcpxTvofsy9IDOHZRs7e7b13YPr7Yz+Wq2+phZDeTdMoF7JMJbI3cRLWQEod7RQU
 2tf/vCR5kYX1CPaWzDiIUxTxjiEc+5Un62o4vm6S/fmcp0XsHwZRqWnbNARB3IWFGu8qLLYvYj
 1PA=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:16:28 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 02/36] target/riscv: Don't set write permissions on dirty
 PTEs
Date: Mon,  9 Dec 2019 10:10:45 -0800
Message-Id: <6a38e1a02e9a3d38fc311809772a152f0d99fd7a.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.141
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Setting write permission on dirty PTEs results in userspace inside a
Hypervisor guest (VU) becoming corrupted. This appears to be because it
ends up with write permission in the second stage translation in cases
where we aren't doing a store.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 target/riscv/cpu_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 767c8762ac..0de3a468eb 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -344,10 +344,8 @@ restart:
             if ((pte & PTE_X)) {
                 *prot |= PAGE_EXEC;
             }
-            /* add write permission on stores or if the page is already dirty,
-               so that we TLB miss on later writes to update the dirty bit */
-            if ((pte & PTE_W) &&
-                    (access_type == MMU_DATA_STORE || (pte & PTE_D))) {
+            /* add write permission on stores */
+            if ((pte & PTE_W) && (access_type == MMU_DATA_STORE)) {
                 *prot |= PAGE_WRITE;
             }
             return TRANSLATE_SUCCESS;
-- 
2.24.0


