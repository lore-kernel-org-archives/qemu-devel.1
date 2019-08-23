Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903B6C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D119206BA
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DbB7pHq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D119206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JZY-0007gt-5q
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 20:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCK-00013p-34
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCI-0000H7-H3
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38470)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCH-0000G3-3g; Fri, 23 Aug 2019 19:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603742; x=1598139742;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aYADlIrAhjcCUfDyHqGMeqnSX99ip+HPRC6LMPpqQ6k=;
 b=DbB7pHq6eqjWEcGB9deeCHgUVK2tAdkjcb321aT1G/f6ghXxc2vR9WEY
 sP2GmYCCOav8UeAlbRejpOPOJPNnwUPiGeF2p9i/9SOBSYQNZTJyQrz84
 ek61uAsvociYJObL9hJhIc02eurjR96aLnPgvxHC4pmkwMJycErS+1qkU
 2N1nDa9xX+yRPitS8CtUY3ueKme2RtXnmpP5Nti32O64C5bFh2L5bdPub
 8eQpVWIC+pI97rbsl13xeQUnSgqV7zASDWwgWq6lWxeEb4TMOg/LCP2Uj
 HieDodiLOf9boXmDAUnwDw6DuIKbc7LtceMNV4m9B3JKRB3fZ29reIvt4 g==;
IronPort-SDR: miX3t3jt2/YGJvuu7DAp4kWAja1COxdvjG+L/KtCK+yKMnK8+5gDCTwAd8y9Gt19n5S2yqSOzd
 0KLhDNDAKHBHOjeO08QlpekdVUgQENsPXwM9MrWYOfYoI5OWN6u7QqYOm4eEArHqXUX1J2R1po
 phTUhbxIZGhYPuJbmDNnChDDCSWmopmVTV/pyFR+UCr1Md/snLnsp7nqwUAaWj3CMI8F+nVz/2
 sV1iZE6YW52CybIp6xmwgtYM+SaxmGcBySyhqMPx1+gd1sgrr4YPs9UM4kqGj2V/AuhK00Wd0W
 WBc=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="117486903"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:21 +0800
IronPort-SDR: teB/V5ePgE8ElJ1vApUV2YhdrM1IRLyHW0tpO0My5T1Xf4Q8nKucK3uXM+yfDWgPHXG2cbxf25
 sR2HZ0Avs/m2h+RXANi+lj0qR8rauW5UUaREurHEEZljLsbFinbRfltZIWCOgDK3cv6PMcnQZX
 O06mQPHRVeX7iBmZGiWZM3bqRe6E6fldrQIB5UKFsxdNbKcqqBkQ3GVsIbC0RRT889LaqzXFuz
 nnO4zWOCwExoYfJbWw9oKYy+6NDB4Ds6kmITpFnkAbJ9kOC3pHqA4Dvl1+hDOUCRm+Y4EPL9Oh
 aoUm93MsQP4wXMjLmlVO8l1w
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:37 -0700
IronPort-SDR: svtycSDFOK0kNS1Bf4YJlqoSRk7qRAX6gX5FIKE/yAob1cm8hLMGSTT7IGenmkqJg34Snl6S7K
 3nQNY/J8Ft3UL8QstqDSFLCroHmX/sjQk9sAT0lkk3w1NDAN+80Jgu/WFC5XXslh6nFb0XJi1n
 bGJKqq3q4mjHXisEDaaIKmbHxEUFJFuviuT7ULYWPf8Z8C+MnH0WqZ0/G/IQriGWIaoOwz7HZp
 sUb7Ehc6I7kYSEW/tY9DWLjqChLzawF2SiDPCtbMmNfYdJfrTIzJNrpQuiRsjhMZ6duWtoVgr9
 RPw=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 16:42:19 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:39 -0700
Message-Id: <4f1ff6ef5fb2baa3c461d16b5669d3bd829733a0.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 19/28] target/riscv: Disable guest FP
 support based on virtual status
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the Hypervisor extension is in use we only enable floating point
support when both status and vsstatus have enabled floating point
support.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 17eec6217b..098873c83e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -90,6 +90,9 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 bool riscv_cpu_fp_enabled(CPURISCVState *env)
 {
     if (*env->mstatus & MSTATUS_FS) {
+        if (riscv_cpu_virt_enabled(env) && !(env->vsstatus & MSTATUS_FS)) {
+            return false;
+        }
         return true;
     }
 
-- 
2.22.0


