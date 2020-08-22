Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B04C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E9620825
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C8XC/eE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E9620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9MK0-0008DA-5V
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 01:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MJK-0007mH-Jc
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:43:27 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MJH-0007rP-MO
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598075003; x=1629611003;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nGyPybd9keZbcN+cfwiEkKZ6piuP0vqFCvQr6xMlitk=;
 b=C8XC/eE8NYvZ7mQ8451GrjsCXRPUwe931dbXYwMlkc5UVtIcXh4Kyf1y
 fZUdvYDKecU6iMotrHKpVtFQowVIJFn4D2pPi6J5yDOlH56VN5Gxwtp5a
 NQKPZAnGnEcx+tdtL1mvwVA07ckyP7yYgXU0iDpVzyCmGalQw/B6k5KyI
 xq52nTpuuKC08wRRBTVbQvpJkgjeaThdSCLwiMA5yJeGOj57taBNUOtvq
 ptrXFC+s02otujB0fbh1z/7ybTtINTRX8gNN4tLc8oP6hj7aMylwsZ2YP
 NLXZQ3+3RLJDjiuLewWaQy8SGtEC5H5Tj0Z4iaQJx4mH0BiSDbJR/14hI Q==;
IronPort-SDR: HrdFzrnQmik4MACgKLjWpbkDF6P+BHjfT1OxfOFLOJoPYU3wVelczfmFiofAyyJbpoZ4MIEMn3
 1lUzv5jEhuxzoV3c9Tmn38f2YJIt+8bR9vbpnRQGqeHXcySQOKVc2OJHUqD37vFYNLOqU6kA/5
 iHJsjySrMiEbMx1cfm4Xn8FqEOb7NI/M8fTOEyWKPiapYynlClVfZ6S8dinsy8GI+IpdRSgXdk
 EdzSdtukgNGdPYMsSLfKpYoKuulX6OuvAU5Gg0vDtxjuPjDvaDVoryA2XQyF4xJDHjyw+S88aH
 chc=
X-IronPort-AV: E=Sophos;i="5.76,339,1592841600"; d="scan'208";a="145571748"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2020 13:43:18 +0800
IronPort-SDR: xdK/OTXiTT/w/1cIqhEp0BnakYNTeM4CjltkRaVVe4CKoSahHkhqOR74zt5cqWT57Eg9EHs2yO
 d5D1twu/iQ1g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 22:30:58 -0700
IronPort-SDR: A8sFaBLcmzYSWMAePDLY/vRuupvBwvmiYum8Ob2GyXApfhhDOyB9Let/+X23mmXhZx/3dNBi26
 HMCE858l/1Vg==
WDCIronportException: Internal
Received: from 5zn13g2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.90])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2020 22:43:19 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	ehabkost@redhat.comg
Subject: [PATCH v1 1/1] core/register: Specify instance_size in the TypeInfo
Date: Fri, 21 Aug 2020 22:33:06 -0700
Message-Id: <87a2da602785bce972a6a6b4502769f4fee58a2d.1598074333.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=49637c5a7=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 01:43:18
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/core/register.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index ddf91eb445..5e8e8199d0 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -180,11 +180,7 @@ void register_init(RegisterInfo *reg)
 {
     assert(reg);
 
-    if (!reg->data || !reg->access) {
-        return;
-    }
 
-    object_initialize((void *)reg, sizeof(*reg), TYPE_REGISTER);
 }
 
 void register_write_memory(void *opaque, hwaddr addr,
@@ -269,13 +265,20 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
         int index = rae[i].addr / data_size;
         RegisterInfo *r = &ri[index];
 
+        if (data + data_size * index == 0 || !&rae[i]) {
+            continue;
+        }
+
+        /* Init the register, this will zero it. */
+        object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
+
+        /* Set the properties of the register */
         *r = (RegisterInfo) {
             .data = data + data_size * index,
             .data_size = data_size,
             .access = &rae[i],
             .opaque = owner,
         };
-        register_init(r);
 
         r_array->r[i] = r;
     }
@@ -329,6 +332,7 @@ static const TypeInfo register_info = {
     .name  = TYPE_REGISTER,
     .parent = TYPE_DEVICE,
     .class_init = register_class_init,
+    .instance_size = sizeof(RegisterInfo),
 };
 
 static void register_register_types(void)
-- 
2.28.0


