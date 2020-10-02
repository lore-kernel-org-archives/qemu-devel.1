Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC9EC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90600206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lf6S9nAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90600206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONf9-0005mP-IR
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kONXu-0005wN-Gb
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:04:35 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:62433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kONXq-0007i5-J7
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601655573; x=1633191573;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ykyOHQKd0DnNB+7usZoiN44NfPlbxAfGZT6Ewc/BDLc=;
 b=Lf6S9nAFxy8KQGXGMchCJp0azYzUmCHR4hw5pUDtuzWc6ZzDF7xsuIKb
 nLR+NDS388OPEtUah0GE19s5kl1YBmnO/c2CKZoloTA/Lqww80QCz9B8c
 yCyiFHvm+QkXFesaZy6qS75xVZSSlRIx1DFkaZb+l6nO7Q3q0KNNcHzYK
 EGvcVpjMtNbH5FtMr0TxIYorWxMHqi9FDF10OiiPb7WnKvpXjwVICqxh2
 6wE/B95cUeBn2hAjtFQm3iNybGR9jrmwPc8dn2XWRLjLkp6lEsxodHJCz
 vj1m8j/C4F69b7/I8v4k49VaKT7jkvj5qTVgIhqiZeeHrodMUuClCzGRA Q==;
IronPort-SDR: ht+n7i5i4FCD9QN4rqD/GwV8XS8R8KZuaCM9KqSMdUtuVIuGYh9C7AL8bz9wke6lHKBnqO9uC2
 2fKT10kBuFQTTdsHMrq9+n5VRTj/9RcraRue24lx3lMKR3A6KZ/JirRgx8xck3rJgb+XD4TLU0
 3xPuDzMm4aHQj7ll/E23UhhOD9qK32aGz5trayojGO/rfZfOMU5Dhkk/9+Y+wEeLM5nDJjgP/q
 mgbd/v6pfmsmdHyc0u866JPOuQWS9aAosE2swSRQAh37IJqIcP/pxd+ZcX72By9zoc4Ann3LUK
 c8E=
X-IronPort-AV: E=Sophos;i="5.77,328,1596470400"; d="scan'208";a="252339369"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2020 00:19:29 +0800
IronPort-SDR: Ze0TH+RfBE765+86JvtzdcoBAFMi5DkokvUvWKcKwAGyhXM7o1Xa8YXwTMekJSePtgUflInd6R
 5PvCZzXTqX3A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2020 08:50:23 -0700
IronPort-SDR: /GNh5Xtjgktm1l/dtTntGjN1PcOkMWyKiXwBv8VbcIpmsXcb97wmeSJO85HXKRLguyi82flUDE
 B0N4sZ3TtYuA==
WDCIronportException: Internal
Received: from lpt-park-h.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.178])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Oct 2020 09:04:27 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	ehabkost@redhat.com
Subject: [PATCH v2 1/1] register: Remove unnecessary NULL check
Date: Fri,  2 Oct 2020 08:53:27 -0700
Message-Id: <2d8747944b70d105c7ce320be0151c4c4ec78d24.1601653938.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=537b2d3de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 11:42:05
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, alistair.francis@wdc.com, f4bug@amsat.org,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch fixes CID 1432800 by removing an unnecessary check.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/core/register.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index 31038bd7cc..3600ef5bde 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -258,10 +258,6 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
         int index = rae[i].addr / data_size;
         RegisterInfo *r = &ri[index];
 
-        if (data + data_size * index == 0 || !&rae[i]) {
-            continue;
-        }
-
         /* Init the register, this will zero it. */
         object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
 
-- 
2.28.0


