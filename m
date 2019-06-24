Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB70C4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7A420663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bQjID+Dv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7A420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55516 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfYhV-0003Q7-JN
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 19:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51964)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfYe2-0001Fh-Ry
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfYe0-0001Bs-LG
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:45:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37536)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfYdx-00014P-36; Mon, 24 Jun 2019 19:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561419901; x=1592955901;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h7zaR89WFyy7ux44fwC53qsrknXmBIMpm2oNVt0ErFQ=;
 b=bQjID+DvOOu0bVn9XrqIhCgSmiDLDE43F9ig2UJTaYKn1QCLUtd3YriQ
 VrIiWecVQVJZUfNwvRtLRQqkFcZLTlBtJMGkbW7y8QP8XeGMzdOZYIg6C
 pPk4lhwvjOyLZaCTfNdEYxRcwGdEqIbzK2wKAIfyOxquMzNpXfsEu0bWh
 cwrE+AToZhdCH2F1GuUez3f2IDiTwWYMvDM409zAt0yFmqQRVopUCGeco
 XcD3jvwFfZ3eVDDs3w0BED/R16NoCn+a16hjt8a4BTCcV8yS+cc/6n51Z
 0jjAogoFO8xdoNzkA0UWtJPfTF225lUmG3X8HWgp+vf8er0BZb4gVy+xv w==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; d="scan'208";a="116313406"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 07:44:59 +0800
IronPort-SDR: 19viDF/4/A2FeWCXFAdGxuZIBWHEJGrncOGW8mb/OBoUqOLxdL+5E4tosW2c4bEz2i5DMuerTd
 AuAwmMVi4itnyY+FnXaAgLoSwKwaNM3Jlm9L4t76wXdTb7xZFxv36yqYqKvp0k1ml+LUsxB5ox
 5tnTIq6C+v597M7WJVGwsgJv9e7vTlN/FvZz3uSh3IQXzcLfbaFmD6g67HW88zVRK9FQHQGPkv
 Uby3CUnE2ndFE5GBrWtdH9XPfcBUGeL8QspZJfyKm5A/fUXBCbKKjjQOGovJXREce/2XqQyjRV
 4T7MtlDes22mey7r2RGQ+a53
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 24 Jun 2019 16:44:10 -0700
IronPort-SDR: geLq0gwukeT+cchMeHiCDpTotmJz28JrYjg2PdDZ10ATU2nN9z+Mzu845nCKD7RQIZ3bAnMKEy
 Ob+cwqTOT/THmyiafcahpvyOFr7KSUA7BRi/gwqxhTv8zl9xWV0ITGtxZ8dDJ51a78zKkvHFuc
 LtfvpwVVBDsB28ThdivIJab/BI2wbWC2aaykKcHk7VkycXpjAE05covLpGgTjpta4K5yd4YJ6R
 p87njd8p5B1E4W9umvQFFrKghdzQW7s0rs/2Zm4LGbkptSFDE7NLOM7SNGKMkrDXxjhAIOP9h8
 ZWg=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 24 Jun 2019 16:44:57 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 24 Jun 2019 16:42:30 -0700
Message-Id: <af5c5f54900b716e02574e1dacf008cf432d2b6a.1561419713.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1561419713.git.alistair.francis@wdc.com>
References: <cover.1561419713.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v2 1/4] target/riscv: Fix PMP range boundary
 address bug
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

From: Dayeol Lee <dayeol@berkeley.edu>

A wrong address is passed to `pmp_is_in_range` while checking if a
memory access is within a PMP range.
Since the ending address of the pmp range (i.e., pmp_state.addr[i].ea)
is set to the last address in the range (i.e., pmp base + pmp size - 1),
memory accesses containg the last address in the range will always fail.

For example, assume that a PMP range is 4KB from 0x87654000 such that
the last address within the range is 0x87654fff.
1-byte access to 0x87654fff should be considered to be fully inside the
PMP range.
However the access now fails and complains partial inclusion because
pmp_is_in_range(env, i, addr + size) returns 0 whereas
pmp_is_in_range(env, i, addr) returns 1.

Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index fed1c3c030..e0fe206407 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -245,7 +245,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
          from low to high */
     for (i = 0; i < MAX_RISCV_PMPS; i++) {
         s = pmp_is_in_range(env, i, addr);
-        e = pmp_is_in_range(env, i, addr + size);
+        e = pmp_is_in_range(env, i, addr + size - 1);
 
         /* partially inside */
         if ((s + e) == 1) {
-- 
2.22.0


