Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BF5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5737206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qF3eBBku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5737206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmAqv-0006fj-5x
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAc9-00069J-Pb
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:35:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAc7-00028T-Fr
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592548500; x=1624084500;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b4Z+vQvmCMOduIrVuJtKpoSIfdG4beuofvjhUpPTYWo=;
 b=qF3eBBkumd51qnEsLdca0F5tfN8HgHVtC6b3GdfBuyE9fsz8sVcHAYvl
 66USwAbJeqynQDfrDx2rlgOerVoCkhzoIkLGzNChQ3m9yUwjVYJb39WEp
 FQT4rXwjSXKuhCt699yokF0DlEM3FWSZ+z0leb3j9jBP9d4xiefmMMTci
 egGan4GdlboVwV86Fp7A+vghfl8wd/SzROqKjlxA9LfpmgJkDzjD147DW
 +/rA1lg5Sma8H0/0iieknXaBq/rrMO2zR2JO8IeLtALb4hyNXEkF1xal8
 Y1L192DNywLBvf7/yI/E3jc47Es94zwWrQNzto5hMR3MoJVdWsZc2l4mo w==;
IronPort-SDR: 3D6px6bw88F9ZAFSv8hb6kU7NXWTocg/jEH2avwKr2J7OJsI0LmRPKuCIkKzV2tntM5jx+/08M
 2TrsfXa2SwEIby0+8GqBLTT7NWN9DESsSDUAWQgDYGfmwRgza5MnxHuQLyBIX+zwrLR8N5/Awk
 +16vAfm0n1dWHLFca7uDqJm21kXm1Zj8oJR8hx8a2CIrZVD3WdsC6L/8b3s1hVFLI37ZdBAwbA
 CtIHqsy07WzfZhxfWYzYDTgn/0STpoAZ7Ebl17oqCdm0I0lZoZpiUX890jzg14xR2YQoWfvLF/
 Z9w=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="141781944"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:34:32 +0800
IronPort-SDR: aOiIhykLcuFroqHICShc2Km3nWnljqYSygXvjHr8lbXVhfDdlxxb2jKhymh9ooJl3Tv6udRpco
 SncSgaQz3oUag01BeT49nkX8qcz9HEJVo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 23:23:43 -0700
IronPort-SDR: j+sowAk0THHDags/35SRnJ0fnnQcLnoh8R35D0SW4H0Ll6qirraznd9wgoZrBU1uvCcsC8m6Z6
 b99UBNhIf9MQ==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 23:34:32 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 26/32] hw/riscv: sifive_u: Rename serial property get/set
 functions to a generic name
Date: Thu, 18 Jun 2020 23:25:12 -0700
Message-Id: <20200619062518.1718523-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619062518.1718523-1-alistair.francis@wdc.com>
References: <20200619062518.1718523-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:34:29
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

In prepration to add more properties to this machine, rename the
existing serial property get/set functions to a generic name.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1591625864-31494-11-git-send-email-bmeng.cn@gmail.com
Message-Id: <1591625864-31494-11-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a0fcef63b1..2f9fbb6aa7 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -478,14 +478,16 @@ static void sifive_u_machine_set_start_in_flash(Object *obj, bool value, Error *
     s->start_in_flash = value;
 }
 
-static void sifive_u_machine_get_serial(Object *obj, Visitor *v, const char *name,
-                                void *opaque, Error **errp)
+static void sifive_u_machine_get_uint32_prop(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
 {
     visit_type_uint32(v, name, (uint32_t *)opaque, errp);
 }
 
-static void sifive_u_machine_set_serial(Object *obj, Visitor *v, const char *name,
-                                void *opaque, Error **errp)
+static void sifive_u_machine_set_uint32_prop(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
 {
     visit_type_uint32(v, name, (uint32_t *)opaque, errp);
 }
@@ -504,8 +506,8 @@ static void sifive_u_machine_instance_init(Object *obj)
 
     s->serial = OTP_SERIAL;
     object_property_add(obj, "serial", "uint32",
-                        sifive_u_machine_get_serial,
-                        sifive_u_machine_set_serial, NULL, &s->serial);
+                        sifive_u_machine_get_uint32_prop,
+                        sifive_u_machine_set_uint32_prop, NULL, &s->serial);
     object_property_set_description(obj, "serial", "Board serial number");
 }
 
-- 
2.27.0


