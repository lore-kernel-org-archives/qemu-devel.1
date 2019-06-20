Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B0AC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EF12083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a1zS//7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EF12083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48626 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdyMF-0006XA-7R
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 10:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34752)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=067b53019=alistair.francis@wdc.com>)
 id 1hdyBs-0006bP-7z
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=067b53019=alistair.francis@wdc.com>)
 id 1hdyBp-0000QC-4W
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:37:28 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=067b53019=alistair.francis@wdc.com>)
 id 1hdxiC-0001sn-AO; Thu, 20 Jun 2019 10:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561039608; x=1592575608;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aDFs969XL5AXSdtpm8ovgxOKxL/V+B6FYyv+c9Aerso=;
 b=a1zS//7CRw+PgL/ujH/+w1A5QEt4hJ5ANgNBgGKkpjiy/BavV+Wn2r1P
 eAbRSlt7T4czcODbyxqd1/785PD5rnFrbFFwnV3Rv/Sl1ids2H94YIU+3
 f+2kGNlMwgkVH+xE0BhVNHmF+hM+Xn2hUd+KbzXfkSMcF+qolsT5kM+0D
 Zeg8ivkAGO9rMkRILgPECLadFjrMIfYqyABt9HPuugKqV6UA+erOujwmh
 hJrHMjDQ5zSrOCKr0GoBYb3b7y+sX1XZwg6p2Qjrq7vdnRkFwlqd+SJhb
 apSwHIf0H2oTZhergG5sdqym4qwTbcVcK2EOf7SDG79q6NwuNd3CT1K28 w==;
X-IronPort-AV: E=Sophos;i="5.63,397,1557158400"; d="scan'208";a="111048658"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2019 22:06:43 +0800
IronPort-SDR: /UV2l8Za4dTh9E3IktCR8GW8U7xrg2P6bDcskDFOZHnFZt2XsS145QcCdD+aCozZ3IreDJW6Qa
 HhlD49A5esgjg1Rwz/+8K6aQZI3mW9x/Ne/XjNMMqIZU10Pg6NwzhAvzIzx7QZAax58rjgZ2Dc
 REi75zO0NYvuE098izU2mFqBX7JBGhMZEbg2+/Fj8faqCXq+q8eK7nga2lop5JynLU0Qb7Zh6V
 OLHAyI+NyJtIXUzJ+oGeouRbjeY7IUfkdDyMr1KlAUNIgiGbtrOWFM/kDAioZlqif1lK4wmSf3
 i3o/iV8nttnc/UIFoNTzSxbh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 20 Jun 2019 07:06:09 -0700
IronPort-SDR: 8z8EiX0ctjKBWp4roZLmnd8DfV8yk9j7ySFRwJX0J4JhAacYrYzA9UaJwkIexAO48r6YaR+jUV
 6IvlUEjjdPFlpFjWb/UGOd9n2WtjVlA7WfMcaf9elrKeOsLfhyNaPqMrsAfxF8SGBo0+LTH/Q1
 F7JSwevYgQbkulAxfu/tOzvmDN50KEON0o+PCvkiS/1ilZyYHtvvRqZpyNxOTI+Sv0FNxhFxCr
 GAp+AMl3572sAMsyKnCxfHTCdnSJyT3eQWmZQ5VC3sfTnClyv/2mqeVwokNDvSDpj0K/kxzRg/
 AMo=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 20 Jun 2019 07:06:44 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Thu, 20 Jun 2019 07:04:18 -0700
Message-Id: <79729cc88ca509e08b5c4aa0aa8a52847af70c0f.1561039316.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v1 1/1] tcg/riscv: Fix RISC-VH host build
 failure
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
Cc: alistair23@gmail.com, richard.henderson@linaro.org, palmer@sifive.com,
 alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 269bd5d8 "cpu: Move the softmmu tlb to CPUNegativeOffsetState'
broke the RISC-V host build as there are two variables that are used but
not defined.

This patch renames the undefined variables mask_off and table_off to the
existing (but unused) mask_ofs and table_ofs variables.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tcg/riscv/tcg-target.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 1f0ae64aae..3e76bf5738 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -980,8 +980,8 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg addrl,
     int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
     TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0;
 
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, mask_base, mask_off);
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, table_base, table_off);
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, mask_base, mask_ofs);
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, table_base, table_ofs);
 
     tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP2, addrl,
                     TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
-- 
2.22.0


