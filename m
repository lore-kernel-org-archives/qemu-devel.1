Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCB8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C893D2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fKkRzlkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C893D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmAsW-0001xT-4E
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAcI-0006JE-OT
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:35:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAcH-00028a-3o
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592548509; x=1624084509;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8hSwtxjUfxldsdMd7WDTe487tEnsxgJ6ThhQBiT5NEM=;
 b=fKkRzlkWQ4a7tJrVbuD+45zrRbIzvHfaavrIYP7CGUn3gAlUPjCiS0GO
 3bS7LTrljI2gyfu1aNqmfSobtOj+yyDn1WySWGes1V4RO0v2gUliQENXG
 s7lhEZIn1sI+DotwrvRgspzQtGAqSEDWEUW6aaVuh2dSgW4mkywhQrWE8
 tRBIfiygaxnqn1CbHrx85NyoagJ11L4LnbcbpnZt3MitYSLtv/tDNQh94
 b0Wyy1jxujWJQogzPsDyG/MFyyFbtWG1DEAjmDYnWFD2NNUe/KCIpgpCG
 MGs5yK6A0XnkZOy/ngf0cAIDjOELdVxf163cVvpCFcSC5Cjl9dAc1vTQe g==;
IronPort-SDR: Qv5yt+Q5bds9KyDrWMR5ioe4BiN1KfXqWZYu7dXNgEOdjogwWKCpnM9BTcF6a/wqyTUb4aoh/n
 PrucKjkxEK6brP5LR88rMIj5xOJLwwo2bJVc9/3j+/HygIgCE1JCyG4Ma5Bx1ztqkGRV+jsjz3
 pkYmFumIpM8qY/ua9slxSuc8s1WZ0VbkU5TlBlTwqO30U/RMkdpj/pYq6jwzrEYjEfZq9xa1XH
 fuN0+NX30R+uxFd9HU9cldhGSzLUz2ZhN8XvEEO7dQFVCjBPFShLShbGAmqraELuyIqRYqwEAr
 BIs=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="141781946"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:34:33 +0800
IronPort-SDR: rVCf9MVokfUGowOKi88mFvCktwx+A0k42Y7GZQe0NAacAM7sjoZ2prE0HkX2r4SDEly2S4I4JB
 Se9GtyHjazuGSziP9J5p4CvvoLOuwBYYI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 23:23:43 -0700
IronPort-SDR: gkalnGBE5xJSh3ybs1tdFHBA79PFaNPEyCJbnZz+1zRHQ27iGTxM4yUubeIotLdxE8JAd/aw+T
 Oo6LvkTw6zOw==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 23:34:32 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 27/32] hw/riscv: sifive_u: Add a new property msel for MSEL pin
 state
Date: Thu, 18 Jun 2020 23:25:13 -0700
Message-Id: <20200619062518.1718523-28-alistair.francis@wdc.com>
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

On SiFive FU540 SoC, the value stored at physical address 0x1000
stores the MSEL pin state that is used to control the next boot
location that ROM codes jump to.

Add a new property msel to sifive_u machine for this.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1591625864-31494-12-git-send-email-bmeng.cn@gmail.com
Message-Id: <1591625864-31494-12-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/sifive_u.h | 1 +
 hw/riscv/sifive_u.c         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index b1399a90a6..f6d10ebfb6 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -63,6 +63,7 @@ typedef struct SiFiveUState {
     int fdt_size;
 
     bool start_in_flash;
+    uint32_t msel;
     uint32_t serial;
 } SiFiveUState;
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 2f9fbb6aa7..ec5cfdae62 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -504,6 +504,13 @@ static void sifive_u_machine_instance_init(Object *obj)
                                     "Set on to tell QEMU's ROM to jump to "
                                     "flash. Otherwise QEMU will jump to DRAM");
 
+    s->msel = 0;
+    object_property_add(obj, "msel", "uint32",
+                        sifive_u_machine_get_uint32_prop,
+                        sifive_u_machine_set_uint32_prop, NULL, &s->msel);
+    object_property_set_description(obj, "msel",
+                                    "Mode Select (MSEL[3:0]) pin state");
+
     s->serial = OTP_SERIAL;
     object_property_add(obj, "serial", "uint32",
                         sifive_u_machine_get_uint32_prop,
-- 
2.27.0


