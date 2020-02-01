Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BF8C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87AF20663
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nBHiHwMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87AF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhWM-00088W-1K
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhI1-0003FJ-Uu
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:09:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhI0-0006Ym-Tc
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:09:37 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhI0-0006KL-Ic; Fri, 31 Jan 2020 20:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519376; x=1612055376;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ER66TK1L3cspbnMDHGiowMFG3fzRSLMcGARP8w8awZY=;
 b=nBHiHwMHZEhW1KzPeFtMRe7z0w6PjPNVgfFWZPXjo8nYKWdItHvG1zmG
 D+YO6Q2mxBt0L8i706XeRZGTfeGHFMW4pNuCYZC030h8cF9mVTam8GraO
 u4qw2JeT8P5leK42/XDyFbjAsq42C5If/emeXvX/S82jIJJZVBea6E+Zg
 k/vDd+uuZlgOxPMnK2KVq+dSr5syIlbxibf6A2Z60f/gpMHn5goWIB5cU
 yUz5QUspq0/AiUBIvlQXbS5fhYs18MC/HQC37NcYrpboow2sOoZEaTxPB
 IHmGDjENSIjb2wncwYWGF5GDe9x95b+YDAQq0zlrxYP/iCv+0GusSLlVJ Q==;
IronPort-SDR: qb2BxEWL60rWB2DzNDDh4nxQ9Hv8tjWUWyRuswO4svLLKnKR+XKai+Fu8G2CMERmDJ434SgAbd
 TeEQDufZRnKKUbwSmattflxvqKUSjUoRsIYBdB+rUCCBBU6L0U0XykeCGJ/O/Gko6M62oM+NrN
 hn1ts1E+yGLDfddQLSlcEX6ZqE5ZSWaYY/xTvIIOWcwIIamERIR3ILZhj9LvSgdfSHaNf1lLsN
 apr64NS9ZUznQ5Z62eyZ/eVI4h/Riny/5pIix3iNfU5dhD4Aerw3HCl+j5NLy5Yn5iq3y3yux6
 yt0=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872474"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:09:04 +0800
IronPort-SDR: inSJJxgg7Wd4GoXFdcgn7oKKKnMKAWsvMPW9snef+Nl+pMs6xCnEZf+IHljtQ9HDTOcsezNQnd
 VvVgP9xCidYReL3mtOS3MDyjEQDG/Wu/3mI6/nGAgdQaFxf6dRRoz76maqB/zElU7HCLZ71yTE
 wNXYWCF6AHYep+0UvLMKAqxNJMq9K3eOZpnEvoV4cSnsyPC89weHpGGvZzEkRmP+rkltg+Cwsa
 C7OCAQKWSGEsqeTuH5+9jDEluF6rVlFw5mPeytFV3JxjFJxKCC6NYgEUS1YOxq0HuPDOY3CSul
 eHbsBP8I4TNUpKp7Q5qAqWy/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:02:13 -0800
IronPort-SDR: 2kld+NC20cnGT14PoDZgdj9dmNNty2ra2a8ktLOV+gbh5Et6CtY27j1EXsTLIIue38b9gfovoG
 5SDhtpnDA9jsKIu3KY/SxnSioShR0uD/g+4dTA1/9PEjwf8pOe7h8KnJ92mS2akafx3BAAq030
 0BuQ97+ZLIWRXi8nsb4jznStKXZsORDmC9IrdpNGMu7/lNSmrrP9TSgiydNaqIPDULLlSGP2UJ
 L5UdrMlQs1uiQje9aDz2b1M5me2y6u06oEpW/9Cxfv7gk9f02dyFVAWIYaWzuCK8vm1UQWbNq8
 THk=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:09:05 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 20/35] target/riscv: Generate illegal instruction on WFI
 when V=1
Date: Fri, 31 Jan 2020 17:02:28 -0800
Message-Id: <f040b883d8e4fb4d9ca8ce2c1f822669e75fc7ed.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/op_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index e87c9115bc..455eb28907 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -130,9 +130,10 @@ void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
 
-    if (env->priv == PRV_S &&
+    if ((env->priv == PRV_S &&
         env->priv_ver >= PRIV_VERSION_1_10_0 &&
-        get_field(env->mstatus, MSTATUS_TW)) {
+        get_field(env->mstatus, MSTATUS_TW)) ||
+        riscv_cpu_virt_enabled(env)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
         cs->halted = 1;
-- 
2.25.0


