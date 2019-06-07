Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72547C468BC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE63208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y3U9ukP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE63208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53588 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZMxs-0007DR-G7
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47587)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrs-00041o-3w
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrr-0001dZ-0Z
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8436)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrp-0001Ty-ES; Fri, 07 Jun 2019 17:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944666; x=1591480666;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ao9gCKvSoFwU8QM28M/2smcm/7HnPQ04kDU0bSYTT4c=;
 b=Y3U9ukP2mCWUjZiHZPafZugfGp63ExirFKwN7XryEiHjQLuOh/snYfAK
 LFwtnOrxDUft4Y8oDQzp3GpfuKfPug6TMNtEsj2HVfrkr+fqsDzySLY1i
 PNMu+/x3i/lweqd0HspKmrs+6Z3ytMAclAcO8toe7/UnffUJMveYoUdIL
 15Fuz9kJDbD+VxXXyPfjtgmxO9u5jWRps/lb+UYbYRjkxcvLL96LWV5Kp
 oEHhGT3ZWamMsjVbwZBIToj0X9hzeqzMyrWmQn8mpM/Hrsp/z5juYpMq0
 N2DKqYaPGSGJQcb2CU0ktZt2JIhueu8ihhGo3cWNs4imLR9cmGEjfFzGE A==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="115014074"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:57:35 +0800
IronPort-SDR: wNDbZ17nImoEN6JiXEAFRCEp1mLryFaW5Rcvu1F0u7RraM/g5mUXx1VbT5kEDtYbClukBsZlYM
 HI7HuAlMGfgFIkiZtBpAAN/x6Roon3EeX8TSZ2XwVe8YrfUTEdU5ylTOFLw6q8TpWphzwQiypp
 +FziAFTDc7Gg/1oALn5KCsl9IlhSaMiFf2YWgOqQUo0kX2P5pG+dmPHg/eibPzFmXnWG8SZH+B
 G0qZ130mwgYJHXyQhIq3CuEf8QaC3KDOdpnm6FjioIvsgrJNihDg8dD7/mtdeeWIPfIl+9EW3A
 f5Smuwir3JnXVvEh50NXasoO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 14:34:50 -0700
IronPort-SDR: L3+iLm/r5o0XqAWrLkYvg+PLgrcIsCDSYTOmu69AZ03dbRbjwBk4M3Xmg2nKTatU0owbcR4C7p
 Lr8loeVLldljElXEpLz9Az/6GJJ7C2hcHXszxF7WKkIvuI4qCiVoTHQbKn8lacSI+drKMW+PKV
 rg6i6KitewcptUgHu4tCvhRw9TFJ35IfWodcAvK45VMeJVTpTL/Ie+txDaMOOwURu2XA2kUSpb
 JutCMIKlXAl+fnFlJj1K4Bu6jvGp65rb4JqaubjIzvlyMWOZL7VV3KSW2XOIn10JzDo6E6l1v+
 ezA=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 14:57:34 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:55:24 -0700
Message-Id: <76631304f89487485c4b745f601796f1e1f70e41.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 02/27] target/riscv: Add the Hypervisor
 extension
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8937bda918..3337d1aef3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -81,6 +81,7 @@
 #define RVC RV('C')
 #define RVS RV('S')
 #define RVU RV('U')
+#define RVH RV('H')
 
 /* S extension denotes that Supervisor mode exists, however it is possible
    to have a core that support S mode but does not have an MMU and there
-- 
2.21.0


