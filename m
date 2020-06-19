Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C15C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E05E208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oub3hitl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E05E208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKn3-0000ih-Rz
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUc-0001M2-9q
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUa-0004Pk-EZ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586487; x=1624122487;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YgHV8IgDygqAPja2o6Anh1ZZN76opAAD7h7m5VTQjuM=;
 b=oub3hitlXHc392ULyuYxypvr10Z2o33ALlu4d9yXTOOKHJRwPiFTgojB
 xFA8wlb7dIngzo18KmAoEevkkaQ6DbyKFHfpR92+C5Dn83RxnI7aIML4u
 +ZzlGcl7fcHjK5hzpZguQmgQJOenf/fqi8YANh7P1xHXDzaXe4sXhfx02
 BrjaZc+AfgUV8bODTAg2tlYh/Fn+CFjNLQPM6hp+e6JA2b8NwqpTlqJDI
 j6SV4dY5EoRBwsjH5oWku5oGjSrrH3xcCmHzO9xkRfeoM2m700uwudV4z
 txGo/LV72rCquZFgURmVBzUjrJpZLAMiHrh8oxVzMxwv4ILPEq0BVe8wg A==;
IronPort-SDR: nQoK3gu3H0ad085IDV6LScN35LcPRJPAcOgW9jo1cVtr/0yVBiD/6Hx1B40bKyfcC7/kraU9up
 5ySnzwCaF9eAd2wRWrEHsqTi6WLJNabMoxOxng9BkNwIwQUTPa429+ltIKQZkvMBuyFBwzrsJz
 gGdZi+HmJv8jg7LsJz+1Pur+nu4QzRlQgheChPb5H7ApG3DhUW43dW6UOSsE2UJJAbiaI/+Ekw
 zQyzB58OG9+SwJ2yGygaf5ouaSJUEr1HgwczDhyEA6NiIJBTZptfk146Uh94kWmV2c+GhG9nhX
 Bwg=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="243417016"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:29 +0800
IronPort-SDR: d8AhczbrTEBRxSKb28ssFGiD0CIFLldYF9MsyzMax3Gty7FbxHP8d3BRyMqo2vRr/QJ0avRZie
 6mE05X46gcXt81oj3f5tRKqRhz4DkWbCo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:04 -0700
IronPort-SDR: pH4TmANHb9en0o7TqnaM46rqBg/7X/3xYXElVfCoJ7B6d0VHtsjP346PhYrLBLshIkWqR4jLPq
 S6Ig4YqjJvbQ==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:28 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 26/32] hw/riscv: sifive_u: Rename serial property get/set
 functions to a generic name
Date: Fri, 19 Jun 2020 09:58:11 -0700
Message-Id: <20200619165817.4144200-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:24
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
index b9d2185c04..6dac662910 100644
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


