Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42956C468BC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01FF32146E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QVBE/SMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FF32146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53830 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZNKT-0008Js-9H
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48330)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsv-00053A-JY
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMst-0002W0-U9
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5604)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMss-0002I6-Oz; Fri, 07 Jun 2019 17:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944731; x=1591480731;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HGB259F/shx3Q5OuoB23BWIGW02KFgpdAoALdKANFts=;
 b=QVBE/SMxyYpCTtvNlUPtJpJVkpCNHeNSnro2CDKZEHC//A/BGbjPQ87w
 1NFX+GL9+f5sS6u+exDDgWSSajoG6AjsDgFKThSUuVOTh9VF8yg4fAhh0
 7WhcTF2iL0qqEN2VuN6Kuj334tHxcX73kIsluWDxdbu/SSMFLv/f4JOkT
 AlcdWuuSqkM+1nnWJt6LZjZAdN3JUcMaNDumWLWxqAX8QSLjTjt7bC7yN
 rONe+jmGyZZlBgNt8MIRvh28o5sB6MEJwzz8yBOIu5KyEnwtN0Xxxfzw1
 3seYLZEREylJ76N0yNXxQ96bsP4s8VlIh8TwNMKN5aJwYHyFM0X7CEoRK A==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="110059641"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:58:33 +0800
IronPort-SDR: bM4bSW2q5k30+uGKxhBvB8DdKROpy2wBYfg2AT4rZqqIBS0xieHN9Y8u1AlLPnDlFdH3VvNmWg
 eT7BiPNLyVdSJWf/G8I/ViMfXyWnjWqwbKdFz07uqRkSDl5hTu7YqLeDyKHCMg9sV+MKpjopRB
 7Aeq6YoEaQKnBWw0p8gYrE/6sMzDnxOc1qE3qKF4BzVc/h/PI+FUbaYiaSAbploOmqSy69dWeT
 Suy1opLRmlxffp9d2RVKYe2B8AMDMo+bolIg5nHu6UlyLh08Ez76TOue6XjiCkrAkJ34ifL9bM
 w4k2MX/IzMIuioEZClsz6Iqk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 14:35:49 -0700
IronPort-SDR: F089VMV7ip1BOub4O3fwSbnqFVfM7dBEWS3ElFxblB3Zm2u7DN9K6HZy6JO2+WveXsc1O/GNMQ
 mrX9vMXAZqIUVwx3Kj8aecnabNcNA6J8BqWAnOe/A/Ssc+OiXyejyFLyY3nG9AvAAyE72rTaxS
 n9rh590kG6JfTLGE5x/LNR/wiTue/LSfzhOJ2OFSPKUDfMfZeOZlX4+19O8oEk12b3/AAbj+eg
 dVoqSonO1arWCll/fkaXZXOt74j+ojW+JNhEKg+pUz+YU6Q1lXRkxEWfjtlJ8fP015JnqSxMQQ
 358=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 14:58:33 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:56:23 -0700
Message-Id: <3e2a7994e94a981169809531bacac01003c1a156.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v1 20/27] target/riscv: Disable guest FP
 support based on backgrond status
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

When the Hypervisor extension is in use we only enable floating point
support when both status and bsstatus have enabled floating point
support.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d1f73396e4..b009049cc4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -193,6 +193,9 @@ void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
 bool riscv_cpu_fp_enabled(CPURISCVState *env)
 {
     if (env->mstatus & MSTATUS_FS) {
+        if (riscv_cpu_virt_enabled(env) && !(env->bsstatus & MSTATUS_FS)) {
+            return false;
+        }
         return true;
     }
 
-- 
2.21.0


