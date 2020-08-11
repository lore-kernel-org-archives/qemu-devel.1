Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056D4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 20:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CD82076C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 20:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="K0fUew25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CD82076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5b0E-00065J-SM
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 16:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.kononenko@yadro.com>)
 id 1k5azQ-0005Kl-S7; Tue, 11 Aug 2020 16:35:20 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:60470 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.kononenko@yadro.com>)
 id 1k5azP-0006wS-3q; Tue, 11 Aug 2020 16:35:20 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 559444C899;
 Tue, 11 Aug 2020 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:mime-version:x-mailer:message-id:date
 :date:subject:subject:from:from:received:received:received; s=
 mta-01; t=1597178114; x=1598992515; bh=2S8L47xmP1QTMKP6oDgMRdO+8
 w/28vsSYTIholTvuus=; b=K0fUew25cxKZfbfprlCoCkl2Bz5GjFkFQumLwyTvx
 UMLTCvCtdrDezdMM9AI6JCygPLg3utqJdnrpt5ShmjrMtV7drxmCF8XxFSHNG+0i
 V+X6PFrDQm5+6OeJmLjKxseIDvh/FCCQikc17kFeWo6cxOE3lY6SMG1fjjS1JDKl
 r0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wRtTSxSaDhHe; Tue, 11 Aug 2020 23:35:14 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 1AB424C878;
 Tue, 11 Aug 2020 23:35:12 +0300 (MSK)
Received: from ik-ThinkPad-T490.yadro.com (10.199.0.82) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 11 Aug 2020 23:35:12 +0300
From: Igor Kononenko <i.kononenko@yadro.com>
To: 
Subject: [PATCH] arm: aspeed: add strap define `25HZ` of AST2500
Date: Tue, 11 Aug 2020 23:35:01 +0300
Message-ID: <20200811203502.20382-1-i.kononenko@yadro.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.199.0.82]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=i.kononenko@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 16:35:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Kononenko <i.kononenko@yadro.com>, Andrew Jeffery <andrew@aj.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide a definition for the "25Hz reference clock input mode" strap

Signed-off-by: Igor Kononenko <i.kononenko@yadro.com>
---
 include/hw/misc/aspeed_scu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index a6739bb846..9cd530afa2 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -286,6 +286,7 @@ uint32_t aspeed_scu_get_apb_freq(AspeedSCUState *s);
 #define SCU_AST2500_HW_STRAP_ESPI_FLASH_ENABLE     (0x1 << 26)
 #define SCU_AST2500_HW_STRAP_ESPI_ENABLE           (0x1 << 25)
 #define SCU_AST2500_HW_STRAP_DDR4_ENABLE           (0x1 << 24)
+#define SCU_AST2500_HW_STRAP_25HZ_CLOCK_MODE       (0x1 << 23)
 
 #define SCU_AST2500_HW_STRAP_ACPI_ENABLE           (0x1 << 19)
 #define SCU_AST2500_HW_STRAP_USBCKI_FREQ           (0x1 << 18)
-- 
2.17.1


