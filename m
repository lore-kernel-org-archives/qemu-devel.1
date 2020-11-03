Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F070C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9499520674
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iJKdzq+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9499520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2Ux-0003ve-Ff
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1ka2Te-0003LZ-4M
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:00:22 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:41372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1ka2TZ-0002T1-Uo
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604433617; x=1635969617;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=H3g8UXCzVOhSh+fFjb7cBfvP7RgEX58h3+CsdHSPvKg=;
 b=iJKdzq+1/FI15lAuw9gpvYfgKBL1CTSi5YESV0kEbeO2BOA1v/Kz13II
 G0MkaVuoj0OmgcLlCqe8orXTxE1tS7o69toRiRo7MaQBo5zJtub4C7Peo
 etaSLxB6kXuntapofP2UN4TDhKIsw5RmvoY7oO6kvA45H7qNprgTwa9ON
 EWdhrhaXIMoDOcreUdB+gOe4MfNQ+AfDY5ig08aodLXJ76+PKI2MxXMQ9
 PXPUWoSa6byhBvaqTQsftzGdq5fHAcEne+hAkYDdTZ9ai0fV+bXZUS2B/
 NhXDZ46Z4bTsup/eYbzc1eTz9ka+2eFLkS09fhPG7yAKTHvK4Zr2280G0 A==;
IronPort-SDR: rD7XkZKWXDGZNwa+wgrfD1MWVRIAlZ5Jh1qyFlZ0r9PvyObDv0idnMsmmgdY/HeAJf/OIXojvA
 UfniWq/UOjcbLOOF7s7M4bh8NtqGhLz71Ds/V1OraRqHWbhse/FzvBt/gEszJfINPJU243xfQO
 Eyk6nTKluWGxN1314ljPcxPVMvUPCuvzALZR0L2tudmaSJ5bHTdY6vmuDWpTtPlMYQpHPsv6Ie
 n/ZwaAYCdkqvnGKn5qlWTey/341qVz+nj+H1yz3PZN8DRZcoKNp2BuXt09V+38VE3ak8nGrHVB
 GMg=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="151792545"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2020 04:00:14 +0800
IronPort-SDR: CmoDcSgKpIoAw6civCykElet466O2Og3hgVOk6Yz7OZyWx3R7F8FFVzjSnaEuuAIeaCPFuJT/T
 t3HytlqUeGT3Y9XRZkY9krSayadG8IBKI9cwDGWKLdNW56BxF6kP3DDMJfs2NSWy2Ya1GN2cXn
 YkDlpCEaeh6LTI9evhqzHfyUBvm+1bwRLt88d9r7ap2aMt1mCgXLrqvCt45OwOyD79CUV2SoH/
 RKSboi4SPI2T2Q7ynEnf7aJLA109ohCzhjLnduEmWgZ2jU+P+2u2WW3PuQiChXjKCyrKn1SfS6
 YLyrjBt973L1cXRxf4Kt7UUI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 11:46:23 -0800
IronPort-SDR: 3bMZnyft4cFtFqsGtvD10MwkDncQNyArU3/G3UP53kQqaX+Jj2g26rHivGT5N0FUYuBZiXQwxo
 Qwfy/FV2WLYW+5E4JmvDCaIs+6Ezl4QWL8c1WKnC0GSNv/M8HSbSwLMWgnPL9K9eVNSEd1Fy9s
 Fj6WyvfPdFJOPF2sF0wy26+CajW3f9jy+XpYt+FAotomWlceeSPzrjgf3a5LRy0jhdDKEHD74Y
 JSSZVGsRfHdpfoXb7aB/+FOwpV5SAkJGAatuisSGEPRF/X39a6suBtpav2phd2XnxhqELD33o2
 Nqo=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Nov 2020 12:00:15 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	laurent@vivier.eu
Subject: [PATCH v1 1/1] linux-user/syscall: Fix missing
 target_to_host_timespec64() check
Date: Tue,  3 Nov 2020 11:48:44 -0800
Message-Id: <cad74fae734d2562746b94acd9c34b00081c89bf.1604432881.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 14:48:57
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity pointed out (CID 1432339) that target_to_host_timespec64() can
fail with -TARGET_EFAULT but we never check the return value. This patch
checks the return value and handles the error.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6fef8181e7..3160a9ba06 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7592,7 +7592,9 @@ static int do_futex_time64(target_ulong uaddr, int op, int val, target_ulong tim
     case FUTEX_WAIT_BITSET:
         if (timeout) {
             pts = &ts;
-            target_to_host_timespec64(pts, timeout);
+            if (target_to_host_timespec64(pts, timeout)) {
+                return -TARGET_EFAULT;
+            }
         } else {
             pts = NULL;
         }
-- 
2.28.0


