Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1526C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9608420838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jZ7rQWIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9608420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5wR7-0006AJ-NN
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLQ-0004km-6z; Wed, 12 Aug 2020 15:23:28 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLO-0000Qu-KP; Wed, 12 Aug 2020 15:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597260207; x=1628796207;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vlZ67bAT/zorltvkSQdWj17eSXvrdCgq5WM/GjFmfk0=;
 b=jZ7rQWITShG3OEzbrg3jyIB7CV5r4qoQmiKlpcr+hzOMNbk9q5zyWxhP
 oVf+9lDfy2yqBCDkNaEtegGP9zBwHARRhNJ6tCO3Sqy5n6+FV/k0patXZ
 FEG+U/wKPtj8dvpOHFJP9yesltlZNsrsOmKsUV9lLUQonLoDdGbPyuitr
 0zsNhgcNcKHhFzT5dkicoHDny+ZEjjKZCDsNKq+KJEi5dS/v/adt+EYSx
 lh0pEOfSD9W2MFMvGZIl4EYSkIvDsFHL6zfZRzka9M9tBCTvJmQFCf0na
 TFrrtNa2G5ZUVgHxDoAKuDFoTIWEZmwk0Kcha6S1DeLelIO5zF8khrjFr g==;
IronPort-SDR: jtEWHrE964QuBMTYdz0hGGVvZNDks1JjV061pwKb70n4VV9WIBoIyX3dFK6mmINwQl6qEE0WQ+
 Sx8lbrPvYP9EXUbDO2e6jW5Koj7SQTxjriLr2P/QG4dn7iZcffQax0oNO2x5TqsM4zNAKthBHP
 ecNmneqVq29KvtCLD8Qy2xpa8GjRt36RVvVgWY7r+W3CAnXj6gJwLqA5crZuW/CtsD+pyaehF2
 ct+sAD/5nkrPJ6RHvLyXScjEYMBVheIhfYbM/5Vb6alkPqHX1fOQt8ErpWXOmrbqC0DxXJK/Xt
 pm8=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="146029199"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 03:23:25 +0800
IronPort-SDR: B8tfvx9qqtSwd41Z6+VQlIuW0T/t2lzAw3z7/H+l4LhCZe8HUGkQvqozhPnmw4UW+Z4313Abxw
 NkrFUyqSSPng==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 12:10:33 -0700
IronPort-SDR: uCAvhyDEdLwKm1knfVPyh9OulTeIsU/iG9IGo2QV9P83ql0cYg+LPZsQgDEvYtN0E7dQ6oYmzw
 /MPKnPcmxY3g==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Aug 2020 12:23:26 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 04/13] target/riscv: Don't allow guest to write to htinst
Date: Wed, 12 Aug 2020 12:13:25 -0700
Message-Id: <ca5359fec6b2aff851eef3b3bc4b53cb5d4ad194.1597259519.git.alistair.francis@wdc.com>
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
 target/riscv/csr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6a96a01b1c..0f035d33b1 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -922,7 +922,6 @@ static int read_htinst(CPURISCVState *env, int csrno, target_ulong *val)
 
 static int write_htinst(CPURISCVState *env, int csrno, target_ulong val)
 {
-    env->htinst = val;
     return 0;
 }
 
-- 
2.27.0


