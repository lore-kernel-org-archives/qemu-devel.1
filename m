Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782CCC282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3706F206A3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AyM/iUks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3706F206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33725 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUKNP-0005Pp-HF
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:17:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK4A-0005Im-Cf
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJuZ-0004Cr-QE
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:47:44 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJuZ-00046f-EN; Fri, 24 May 2019 19:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741664; x=1590277664;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=BXuqW+Vie67kKzLkoEIoBCOJ2a3oHbLhsnez7FroSYM=;
	b=AyM/iUks8huptKJXEszlYsdbl2yEyzJYNh6//ZinTUuTLs8fttucx5hG
	WxNvAJKFn1pWjh4mxy5OHcEjl7rh7qexEbVfi/u8b7nPwAPEUKBghoWwf
	cRXCXlQRhKzMHwf+iXr4lBz/1PUNC40b7ZRcLjGwacAynKbHOYcC44n8q
	/tLbHEaUTY2PcHriLMD3lXejp+qXVEHv9Q8kX+Hm21wZdL1k4RXlWiODI
	3Xt6DRfh+UznCHiXYzCk4NW47Noz6lUs4sk4fN9UheDvBmbhbO5tMR2te
	XlCZjH6ZLJh1xIuBi6jLKN8SE8KBlZ0hPust+9BS7JNcQDo4Uf5b6PO2Z Q==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="110307761"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
	([199.255.45.15])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:47:44 +0800
IronPort-SDR: XGqGG7BJYF6zheivqY2S8Q7JzmChem+YlFfFQ8yyvD8gtz1Q7wgiUw/NHltU57HK/qY9dpLpEt
	u8VUmCpdzgpgKcQZNCK3ODAkX5OupagfaEV47UKmqODgYoSOdyvwhCrxZu/ItKk8pSLI+DI45f
	6m6vapEcwtM6+rHAmJFZAOWB+PzGk8YDJ6Mt1e0jWWT0VxR5zW48E5AXdNuKFmVHfdK0f3SWbZ
	YMi6HgoCmPHDWgGOeli8jD3E8QFoiT92dPYB23gExgpA1cZ8vVRwlk/KHEHdQED531J+kMWk7q
	I6vBVWpnVItSLtjEHXXbxXwA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep02.wdc.com with ESMTP; 24 May 2019 16:25:22 -0700
IronPort-SDR: 2Xepllq6cPJtavShVtXb79VZyhnrpk50hRDrsGABhBm7ypcsqysbrzcx1ePt7lDPM1UDMbXm7x
	WZPfit96hPR93k9BnHRcMmYjvnnVl/QaMBC6RaO2pDAVp3AhB5vpiFfS/7kPbUM+5v13v0ERAs
	mh4JOEUyPcnUQ9Te4nPsTQim80cVS7MOn/gpBbrrOFE+M5ap392RHzDsObyABAhFFtjerpzKas
	qBn4AWTJ7AChRUvOz6tpV+/BVyki1W7Js+pnJYZPGqmwbrt7jBSdchvQ50awzLPje2p2mQXfrj
	5Rw=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 24 May 2019 16:47:43 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:45:48 -0700
Message-Id: <d839eb40ea15076fd348021031da1cba4e55f9c3.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [RFC v1 05/23] target/riscv: Add the Hypervisor CSRs
 to CPUState
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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
 target/riscv/cpu.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index eeb3756c91..b99d2b7af2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -169,12 +169,29 @@ struct CPURISCVState {
     target_ulong mcause;
     target_ulong mtval;  /* since: priv-1.10.0 */
 
+    /* Hypervisor CSRs */
+    target_ulong hstatus;
+    target_ulong hedeleg;
+    target_ulong hideleg;
+    target_ulong hgatp;
+
     target_ulong scounteren;
     target_ulong mcounteren;
 
     target_ulong sscratch;
     target_ulong mscratch;
 
+    /* Background CSRs */
+    target_ulong bsstatus;
+    target_ulong bsip;
+    target_ulong bsie;
+    target_ulong bstvec;
+    target_ulong bsscratch;
+    target_ulong bsepc;
+    target_ulong bscause;
+    target_ulong bstval;
+    target_ulong bsatp;
+
     /* temporary htif regs */
     uint64_t mfromhost;
     uint64_t mtohost;
-- 
2.21.0


