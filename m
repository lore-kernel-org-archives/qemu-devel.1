Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A02C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FA52074B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fqr9ERIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FA52074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONH7-0000Bl-AW
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kONEl-0007Bk-Ib
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:44:47 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:1722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kONEj-0004NO-Tt
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601653486; x=1633189486;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9VOryBvBSbRHAYC98zyUI3OVpWSYyWm5g5HEkXxfEPQ=;
 b=fqr9ERIzM3ULxcCVNIMX5RTuJjg3Fyz3uLVLNIuN0Tu+L7tvviB32tBG
 JXITpczbxcgM9YpJThiK51CtBcfY2HPtFlyHWJFFDbWyNE92Y7w38sIs8
 CrRoUspLiR5RMp3BEasCh33ttAHmAWgrGFLyUsyblOIt7bCvdP+ecS/56
 oDz8a6eht7hFM6Qfn5RJ0kSRmfZo/nd+gQmJI2jKiRPtbRGlwKASqV7VC
 UejHkJDFvDFo1/+k9lfGt7q7twtElhRdh6yRYvNEYQjmPFd5YUCqABgEp
 YHSsr0ateEQglH16PCh9YnffwPLNKeM9bJfMoEBuHRzkOIPx4qjZhWeTq Q==;
IronPort-SDR: brbvOzxXk8w9Ywc7ygBxGZUU845PLKJkMiCt4dYTOxk8wpwsMxcVDbL/0+m5ZrYNtPYygK+y3Q
 sNhwPg4Ji8vbYS4/rJ9jKXN3tAnuuKj/uGxEAZqwpV2YeQ844j3F1XR1KzXi1Asn03L6B8d7qs
 t2afgyK4xWJYz04LXdj9FNXQK+QWNQvAzBCysf3kqV226MjG8gHe7rUtMbspPc/XKwZU11arKV
 86rrWJJPT3PNU/Bxx9CUHSx1Q8r4cXHQZ7yt9YQ+RDv4DewpnNEm3KGMMXeCd0+IoHPBAf8iny
 EmY=
X-IronPort-AV: E=Sophos;i="5.77,328,1596470400"; d="scan'208";a="153334939"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 23:44:41 +0800
IronPort-SDR: n7RLWeb84gsOcBio/xdybITcDNic2TszKzJt+jYVr63oUmp7R15OBvkHYFooIxOTYZNnZJYaVN
 okBUQPGNsTqg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2020 08:31:30 -0700
IronPort-SDR: NP4YZftUxEe7G1GCLHet9JrsEvNCTgS2t1v+2gXh0kSsX0dR2XKEfFOPtnvveEdp84InhNwPm2
 U756bPndCbAA==
WDCIronportException: Internal
Received: from dbzljc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.174])
 by uls-op-cesaip02.wdc.com with ESMTP; 02 Oct 2020 08:44:40 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	ehabkost@redhat.com
Subject: [PATCH v1 1/1] register: Remove unnecessary NULL check
Date: Fri,  2 Oct 2020 08:33:40 -0700
Message-Id: <00b3ad01ce01027870a036bc4f6adc873bc3f7d7.1601652718.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=537b2d3de=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 11:44:40
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
Cc: peter.maydell@linaro.org, alistair.francis@wdc.com, f4bug@amsat.org,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch fixes CID 1432800 by removing an unnecessary check.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/core/register.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index 31038bd7cc..9ac9bc6bfe 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -258,7 +258,7 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
         int index = rae[i].addr / data_size;
         RegisterInfo *r = &ri[index];
 
-        if (data + data_size * index == 0 || !&rae[i]) {
+        if (!&rae[i]) {
             continue;
         }
 
-- 
2.28.0


