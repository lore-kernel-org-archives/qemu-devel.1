Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F36CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E0E21872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BsZRBymx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E0E21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO944-0007sS-TE
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90s-00052o-2h
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90q-0004FX-1Y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:57 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10429)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90o-0004C1-5q; Fri, 25 Oct 2019 19:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046134; x=1603582134;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vgPO13ViDPpWds3HfXGuDWeCANwl/5UkQ1OHMUmW53I=;
 b=BsZRBymx0djYiAaBWCos9mpZ36AMPxaxiSgxDR5cz35eOez9WtvQZsAQ
 JNxrCrKfwSVjd2dQX/0TzXIY3JcYR1OPkmPR1LBjroZE3n7W9ykZ2DE4w
 mTj2Rokv00LYlshR24JkIIE4p7ly1/9seObOA2Hh4GbWZKHn/LAsakLcp
 siPuUNoKtACwgz0I4JQyOu1re8TuTWozl1aUw4neNxDe6trLoeVw5Ph3u
 n8YoUoSQLaU++bAQV8pl0f1BZ///Y7nXM+pAmqLVIlWspk8YOAA9Q+z40
 RTfOrYE588bJj3aZqAIT9t7w7+KiM0iPwUzHGrbRP9H2ipHgqkaysbMbX A==;
IronPort-SDR: BX+EEyk0tC7T8cWmdGE2QcM7dkB7W0x9C2lSsQwoaERfHuXNLW7bVO8YHH8RJmVEoruVKpmhXp
 7ZbNvjBTykmTcoQd3cNZxIjD/fbZ/CNxYD4VKh5s3cLfPvUMcNDud5+i9Rl8I+1PYEhr1Rb7Yr
 HTdz0HRD62eYWOeybpY6NhkcOyrh1gWKRTzKwCRgF4lins3wJev0Mb7UOFe7haF8YKdl3sTVCm
 DIT9TyAQYKNKcEBCzvmXzG67hQBuruDpezVYNiXM1zLxaxl3zvIg3mNE6c11QyhOECOvehsYLa
 yQE=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="228520396"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:28:24 +0800
IronPort-SDR: v+5uTPt0owFb8DM+zBvkGPlbHpwIKZlQGVosxRIqWUHK9/dF31quxd3/RsGDXR0UCuJN1kygTs
 Yv/0dXE3Lf2A3oY55hjMxpq/zzwLodEW2UdyqXVePRU1jliqDN9Zy/Z3dOLpuvHVQXKT7OL56R
 0eJZqWIpntRuSu5PSqL+D/PD7YRk6cp/7DInFFSfgyDDn0tiVsDT9krkdk/WoTP3Hyfuy5Sx7X
 LOPHxWlVCeWRSjmCtMvxsF1O9d80/svGSxLxf3+3RKfHYhvrHcvMPR3Yz8ot6qFYyMoSzPgc06
 kVPGgQyQmSV/vEvCy+KyL88C
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:23:49 -0700
IronPort-SDR: rtNAgrphkr7jqjU8Zfq7G7pMSiHifU+AFX7ztGqT3JYTqgaCamgS5GRC4YaHbZUlsvivFdp3u4
 YFI2CYTW0Q/s4Y29Lze/DhFSUYw822Bhw9wfDvmkRmE/3zERVRrNAGxsAx3ZgBxshUWUW+K8Ua
 8Zjuz96mtHUVEN4QsSjEvZNNMv+Wa1WgrRA2d3ChoMdXQGaHZGad8dyqT+HITrWUFr3wtypSnR
 BF8XOuh1s3vfGOJ86NEG1vgHdR1arQRAAiuA6cnJUz4SXYaBF4T3QQtVzaXApvQPM9eT4GlhUb
 vrk=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Oct 2019 16:28:24 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 06/27] target/riscv: Add the Hypervisor CSRs to CPUState
Date: Fri, 25 Oct 2019 16:23:28 -0700
Message-Id: <1b9ba32053453869847f39afb38b5c5cc53ccb8b.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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

As the MIP CSR is 32-bits to allow atomic_read on 32-bit hosts the vsip
is 32-bit as well.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index bb7a0e27a7..a1625e8af0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -145,6 +145,23 @@ struct CPURISCVState {
     target_ulong mcause;
     target_ulong mtval;  /* since: priv-1.10.0 */
 
+    /* Hypervisor CSRs */
+    target_ulong hstatus;
+    target_ulong hedeleg;
+    target_ulong hideleg;
+    target_ulong hgatp;
+
+    /* Virtual CSRs */
+    target_ulong vsstatus;
+    uint32_t vsip;
+    target_ulong vsie;
+    target_ulong vstvec;
+    target_ulong vsscratch;
+    target_ulong vsepc;
+    target_ulong vscause;
+    target_ulong vstval;
+    target_ulong vsatp;
+
     target_ulong scounteren;
     target_ulong mcounteren;
 
-- 
2.23.0


