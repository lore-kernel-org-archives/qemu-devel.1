Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB90C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8157217BA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HrYlEJ7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8157217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv9BE-0004yD-5M
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 20:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv92J-0006av-FT
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:43:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv92F-0008Or-5b
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594687383; x=1626223383;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+HHTqCSzV+QdHA83xPiOiV+25g9KE7N81V2b9knAj7Y=;
 b=HrYlEJ7vkbkShjUHH5l1TBV2G6TMMSq4uh8O/dtr58aOp/I0w1Gyvp/P
 lJMtUrtXjKmjb8AOZ2SoqQBpdzjYoSb/HYlO8lK1QngEze7rcUGoYYUa/
 nuE4XrWUX+74h3ulGb8YhRhCKqWF4+jI++mSDpAiRqDYxecu0RLqruVpv
 eS9D3KcjtSRhAiBDI06bJrkH4JEcGb/betSchF7AnGeelapYEO8DKvSNn
 j/detWuxaqP8zqgBbKpUBdsNBAYKURoPzYDq2ixhHKUd9EWSwf8mkmB3a
 9nD+vlpIsS+SoDEvINKtNxhFGjTJJQ8KbWTVrXY3gwkcvShopapGDskjY A==;
IronPort-SDR: n7jEOb8ICmbp4IBvzhFwpK1UlN/rZdopqpnP468xteLYHlY7K9jptdb3yDixAlaFgTpRriiUHU
 0EfDTlBKsV0AQyJeHTeZw4bSZhPxnNadrBktWDOx47hniptrq5axjTFMRyCYzhKXB6BTeItp/2
 GfbAiSVBsFVSAbPuZzuvfZc44V+q8cNEuOusKN17C6rWfEEh3pdpYzu5y6rXCqAq02LHvNkvG6
 bwn4Bf+DMdm3OQZ2JD7C3vAp8BYf+yQaxaGu+RcY0LsxLZhXpv3yUwmDLdr9djZDRrhCnq+kJq
 boE=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; d="scan'208";a="142511936"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 08:42:31 +0800
IronPort-SDR: S9/VvU3OwolrZi7oFkKdWfbLXYVGmt6sAksIqoX/700vvKRFRQrS43HXu2BJsPPRT8q/LpyQRU
 If2ud5EDU3jEcwDrtonLg3bvBYXKeruZI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 17:30:59 -0700
IronPort-SDR: dEmQ/PVMvXzZfi/AP0gW6qdUFdjpiyiFBmOMvsHpaodpZueg1NdKwBREAjXaADIGEwFmdQGxHV
 JynfLao+6FbQ==
WDCIronportException: Internal
Received: from usa002626.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.178])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 17:42:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/15] tcg/riscv: Remove superfluous breaks
Date: Mon, 13 Jul 2020 17:32:53 -0700
Message-Id: <20200714003254.4044149-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714003254.4044149-1-alistair.francis@wdc.com>
References: <20200714003254.4044149-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=457b4eeb6=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 20:42:28
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
Cc: Yi Wang <wang.yi59@zte.com.cn>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Remove superfluous breaks, as there is a "return" before them.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1594600421-22942-1-git-send-email-wang.yi59@zte.com.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tcg/riscv/tcg-target.inc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 2bc0ba71f2..3c11ab8b7a 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -502,10 +502,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
         break;
     case R_RISCV_JAL:
         return reloc_jimm20(code_ptr, (tcg_insn_unit *)value);
-        break;
     case R_RISCV_CALL:
         return reloc_call(code_ptr, (tcg_insn_unit *)value);
-        break;
     default:
         tcg_abort();
     }
-- 
2.27.0


