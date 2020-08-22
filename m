Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049B2C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42922072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jaOPYX6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42922072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9MXy-00058t-2j
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 01:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MR2-0001mL-Sc
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MR0-0000D6-Ts
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598075483; x=1629611483;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rv0GDcqlafIFYgV9LMenPzu9AmIxLKs0BPo/EDXes7w=;
 b=jaOPYX6Fos1/1KJv5aEDZmvh/CXHm/D5IK6bPGZP8PQ3U8GkwC56T6xh
 tTBxeVrHh1Bms8/fdsjyrewsm45nICYpnpSy82hu0OMLjyY4ljr5cbYz+
 g8s7VqigbwaRT3N6vOvlkUewHOxnkCmqrDd3MgwkrlL982QaRbIwod0Kq
 /dN2E0YnYXyacXn3wrJKhz4nup81dKZKZ7RT5/jeqJsybWEzXy4va075m
 zq2fsPcYIeBauV7KobT+2YePKvs7f2PbPVTQp3vvHkMJSkWm7yfir/gzt
 0TOXeyuQhI73/rIyBi2yOSzJZjSZS3nfbrI9i9L2AkPuZkn17PFYvgJBF Q==;
IronPort-SDR: 3EX8V3xI8vOExXXRl0KJ9OXNkjc7kFxPjFRkR+ynCt2Srw5BzWSPWjijwT20owfMYBE4Lt+dEt
 jKBUjIn9Hqzs6FEn4Wr2gZkhaGCm9rHjUVg1Yhv6AAJLVHvniD/c/q3jk16MnmBzL418DcjSF7
 jFv7zBBFQdww+9mW9vURTG5GupJN1TNn6IHacm9HGRLiuca6S49OSnJrqALJPOlsRi6MqQhkZp
 KVXnC4OH/HPUm3xNjpGVrdLCSnNUA3dED6tWMBaKqkPO9fOJFSqVkJY04oMO6QnupaFBeEs4H9
 mdc=
X-IronPort-AV: E=Sophos;i="5.76,339,1592841600"; d="scan'208";a="145571958"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2020 13:51:18 +0800
IronPort-SDR: uLxJYcVu15TuREhYlJ97zKXT1fX01pOSs5X1GcURYG0nQafzSseaM4pQxJ2/2Gj4C67b2wLY1S
 /V0YI7qzGrlw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 22:38:58 -0700
IronPort-SDR: dP4OPfJmMuUwOCbEFw+aeXRjI7d+gwtyJg89A7pat9jW7IO5Hgj6V3EmtA8O+cnRs7glRaIN60
 nHvk2UcQtNcA==
WDCIronportException: Internal
Received: from 5zn13g2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.90])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2020 22:51:19 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 10/20] configure: Create symbolic links for pc-bios/*.elf
 files
Date: Fri, 21 Aug 2020 22:40:51 -0700
Message-Id: <20200822054101.1202175-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822054101.1202175-1-alistair.francis@wdc.com>
References: <20200822054101.1202175-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=49637c5a7=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 01:43:18
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Now we need to ship the OpenSBI fw_dynamic.elf image for the
RISC-V Spike machine, it requires us to create symbolic links
for pc-bios/*.elf files.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1596439832-29238-2-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 4e5fe33211..0a01802637 100755
--- a/configure
+++ b/configure
@@ -8129,6 +8129,7 @@ LINKS="$LINKS tests/qemu-iotests/check"
 LINKS="$LINKS python"
 for bios_file in \
     $source_path/pc-bios/*.bin \
+    $source_path/pc-bios/*.elf \
     $source_path/pc-bios/*.lid \
     $source_path/pc-bios/*.rom \
     $source_path/pc-bios/*.dtb \
-- 
2.28.0


