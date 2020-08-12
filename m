Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B54EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5823520838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cykqkFKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5823520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5wMm-0007JB-J4
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLj-0005M9-LM; Wed, 12 Aug 2020 15:23:47 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLh-0000UE-VG; Wed, 12 Aug 2020 15:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597260226; x=1628796226;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QHW0eRBWKyc4PMGVbAwmtx2J+z/Y/6Gi6d4k1CzZukw=;
 b=cykqkFKtobNAxSwzmu8NE/oKOD0mlcVWkGiiJFl4BUo4yoMcJwT9evHj
 f4kLhBxn9qquUz/srfr7PKizrF476NeLt0vvsaXcL8bCLdcboeFThOoEM
 pi2cPbNrddKB/ooFThp9oKGxk5YzFN4NdY5lpQGJVVjiNhOHC6DIuSx8o
 2lkOdNfuZgFgFAfc7wfbck9vdZj80A51+tF2CpX9tG0D3s7H0bhDJYxx5
 Zi+wUJITI/xn07b+8bljraA7Mgbrwf5bKZZyaiHmLrSKB1bzT8e4eyBb1
 e1DDnElhbjmBVNBImmVPwrtgTEQjeQQrNARymr/8APuyJEEdFsW3gyi0X Q==;
IronPort-SDR: 7wZ/+qpW3jW7Y06zShSKfl0Eo6bwbXj7YHQqZuoAHtLUzikZpYGnBlKJjGKOjIgjAKjSunFd6c
 7Bo2X0YIzKqveyLiWqz63+EGyVobXdyqmQZOkwo22SmMZVViQDRwMr9n5pvyaBL89CgOc4XR0m
 yr636OTOMKlIG8KcmlOawcuiN+D1/FCW5YbDcBzBu44izkctDpjpIA9SP616JrkM89hsQRRfNX
 ryHpNABctnNWdn/0g/F2zgvJf9khczXM4/yowWnIfMWbKUgxUavk8LY/n9sD8BXCy3TkqWLNDe
 2ow=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="146029212"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 03:23:42 +0800
IronPort-SDR: +SV5fci2oawbE7CXequNznC7sVsi2w3SAIA9px65HdpfSlZ7GKJryfIVuh24rC+jhhckDOhXER
 XJQgTYy/uQpQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 12:10:49 -0700
IronPort-SDR: GuQPNRKtWXqGL3IMbkVqT/nBZ6tajQf0j4kiOTnYGCcQq8aFo8NRRUe8tIvgbPwzVcP9d9ixmb
 LFaIelGhOssA==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Aug 2020 12:23:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 10/13] target/riscv: Only support little endian guests
Date: Wed, 12 Aug 2020 12:13:41 -0700
Message-Id: <93e5d4f13eca0d2a588e407187f33c6437aeaaf9.1597259519.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597259519.git.alistair.francis@wdc.com>
References: <cover.1597259519.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 15:23:20
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
Cc: alistair.francis@wdc.com, anup.patel@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 390ef781e4..5e50683c58 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -840,6 +840,8 @@ static int read_hstatus(CPURISCVState *env, int csrno, target_ulong *val)
     /* We only support 64-bit VSXL */
     *val = set_field(*val, HSTATUS_VSXL, 2);
 #endif
+    /* We only support little endian */
+    *val = set_field(*val, HSTATUS_VSBE, 0);
     return 0;
 }
 
@@ -851,6 +853,9 @@ static int write_hstatus(CPURISCVState *env, int csrno, target_ulong val)
         qemu_log_mask(LOG_UNIMP, "QEMU does not support mixed HSXLEN options.");
     }
 #endif
+    if (get_field(val, HSTATUS_VSBE) != 0) {
+        qemu_log_mask(LOG_UNIMP, "QEMU does not support big endian guests.");
+    }
     return 0;
 }
 
-- 
2.27.0


