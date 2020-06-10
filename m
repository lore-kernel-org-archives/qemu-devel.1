Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0796C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959BC206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UhHufcQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959BC206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj99g-0002Pk-Tq
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4234ccaf3=alistair.francis@wdc.com>)
 id 1jj95u-0004LP-Ge; Wed, 10 Jun 2020 18:21:14 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4234ccaf3=alistair.francis@wdc.com>)
 id 1jj95t-00023G-5A; Wed, 10 Jun 2020 18:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591827672; x=1623363672;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VXvPydcV3oG3Eb03rcTetmZt+5SiUVZX+S5uCVjMvU0=;
 b=UhHufcQbVm8/D5MwY1t+JOVatkOacwUZv+YQfdNK1jdF2setAhSybomj
 Kgxx/gZrHYssZ3PmgLOYw04KwDbrmfNnFBM/IkZxK/7NbogBgzUVP0c7z
 hdkVqdpPk7l1BGeGxemQE6fd7ensv2j31qOkrozpBdfGC8fvGBzMmPtDL
 fMsPO60IuWe4Sdv3Fou+ISF0BrmbDCHinB0cyHFsl8Usy9kuSdwMs+DBf
 mfdYZnm9p81Lqm8twG+otb+d8Q8zKBcv9C8H1Nh2IiTWIV/oEG5OKtVZB
 CDtMU33Dl4XRsdODKu8xpMyX0aq9oQDZMtpmNzzkMT+w/m9lQLEMm2fqS w==;
IronPort-SDR: EATAsk3piwtgSUlEms79f5+neN7EeeYUVqu0mdkIwdDvPCZso7/eg2S21/IU4sttX3nOJJmPTo
 QGgPht37UIFOybIZ7utfSNpOx1xCcL38/Do3Li+Ag6vQGZponKcZXqQz+bSIJRa1Rp0hzU5PXd
 XBqmoC+SEB6tSjaRBGrBz5QAXb3pJT9xfSOhj8MwdlPpjRmChTl1J6ANNKslap5+mK7WcXSFEr
 fuC4/QeOG9hM8AkHtdHjDB6xY4Sk+pkvybLBEROFNbEUJe0TktE9TnPrGm1VFSP/wBiwxWLBB9
 GqE=
X-IronPort-AV: E=Sophos;i="5.73,497,1583164800"; d="scan'208";a="248819307"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2020 06:21:08 +0800
IronPort-SDR: em4gQod2I33wuftNjaByBDw6F0otLSJ83K1BHjnxKG5Eako8NldvC1RhvCbX1v3VmooQmmJDxs
 hkO5ZPmYwg80NLqLjMEL90vov1OdhoCkc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2020 15:10:34 -0700
IronPort-SDR: P6gAm0pnUqwEmpqtCZdhD5DJ+E2EhUL0nCJzbWwK6vFzlwehSZeEr1DwJ4s/ocsFMQbyarnxUA
 c4fgxITEzR9w==
WDCIronportException: Internal
Received: from us4qd5p12.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.34])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Jun 2020 15:21:08 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v6 1/6] riscv/opentitan: Fix the ROM size
Date: Wed, 10 Jun 2020 15:12:11 -0700
Message-Id: <6cb4f31c9b72af4fb81848c233e1be77d1e0e83c.1591827110.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591827110.git.alistair.francis@wdc.com>
References: <cover.1591827110.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=4234ccaf3=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 18:21:06
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reported-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/riscv/opentitan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index b4fb836466..6c7359c190 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -30,7 +30,7 @@ static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } ibex_memmap[] = {
-    [IBEX_ROM] =            {  0x00008000,   0xc000 },
+    [IBEX_ROM] =            {  0x00008000, 16 * KiB },
     [IBEX_RAM] =            {  0x10000000,  0x10000 },
     [IBEX_FLASH] =          {  0x20000000,  0x80000 },
     [IBEX_UART] =           {  0x40000000,  0x10000 },
-- 
2.26.2


