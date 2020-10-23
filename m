Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CCBC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345AD2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dYgJBg9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345AD2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzdR-0001tA-1v
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyzH-0004RB-62
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:28:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyzD-0001YB-43
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603466890; x=1635002890;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JRKNZm3JZXoXP8vrq/yexaKtcj6lWAF7ME1cCL7Nrn8=;
 b=dYgJBg9AA8s6emz9tyPzLRSxEH8eLJFfT577Quvn/UVTUM6bLwWHNMuf
 aaNjS1vhQvA6ybHD+Kd5t313DIiR0s6slUzPkQnS2tEyIiJx25Erlh0ft
 a44HdlssyhtWAm0wrDmfGMui8YOC/nQnSlV1FbHvyvALUuv0poo8hcvqP
 sjKa6IgnTM2Cl6D3dhjUdEgTPUK5cPon5+SIrDtXoHRB2mOMdRdz5Ske4
 0SMvMyv2q1p7z5/V17KHUqbsujO6NccbiTggTGdoQscvvUCpdEIVZIzBI
 lk9f4VnDaHGWXwb9eHkrqQvMEe24B9ZCgSrLZ4KCdZTddwBHBOSzP1erP Q==;
IronPort-SDR: UHO4yr4YXC0c6a2vlnNXYg2kSgvjyRmD14Ql/oTaxi9NLELTqhBtfZULZ2Ua7SHubay86U0WaP
 J+7jruDt49TNu0VGSi3AbU793uxmE52TL1X53z2UmLOUjZwTP1pFBlN0YJ5g+cn3V+J0jBz70+
 uCQ4wM8NI7jt3zEywlQ//mwRV8RwCoJJC7dm8XwC5zAh4JyNOjppKXR/n/omYUeMgxWylYwVlP
 8eHL/bkvtnxO1w/l7jV8+RFYZAy5t2W6eyVqQBD7Z7aGaTWMmSBPqrVrgtIzasDwLQC7czpe6w
 jFQ=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150652329"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:27:45 +0800
IronPort-SDR: vGyKT9c4tbCtfyWRh+BZ/cljWnU4xDzo6TCw/goddCkZvWR8NB7RKaMy30zZFM3PwhHes4RkUw
 DQurKe3nn4SzrBfHdoBnkzM6lB091cXq23bKR0wsrCKeYERkmmHBH7HxfIIlQ6BfH1GVf2URk0
 v74oIMX6oAoPGkUp32Tp4Sa6+kiwKNDo0+C2POJg8iPizXuBtvQ4MwnfCJe/RKieV6ScbcY2x/
 O9DS1HMXlG++Li/xvOfvghHz+3Ehy/ffMORZICgSsaw6xifcC8AM2Mbh7ycf8u6dWjHn6mE8kx
 M13oVK2vxW2RHXEf72wkRmuq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:13:00 -0700
IronPort-SDR: +eIxOTGSppOm9GoWaP874wtpFYoRqx2VvVPHjweMCQ+WLg6aXXseVMloL4vglqUQfP2bbbzE3X
 gBRZN3+FgFOKaQDMrnJvOh2QAyt8z5DkIfndwloOE4kmJbIcirel1JqAn8zmw/nrbIMuIu48Q2
 UOsL1+DckO4p2LZmUNcKVlxAJcpq2AGaa+ViiL91/dnX9kV+YyrKiOj2A7+3bX1bsNvNnCXqUj
 t3gfjVk+mFXu8ngCKmdprWK53L4vPzXFrvfon5QC+6Ouus9XjHBShlZUjZ1K2+zNLaMC9itn3b
 MZg=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:27:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 11/12] hw/misc/sifive_u_otp: Add write function and write-once
 protection
Date: Fri, 23 Oct 2020 08:16:18 -0700
Message-Id: <20201023151619.3175155-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023151619.3175155-1-alistair.francis@wdc.com>
References: <20201023151619.3175155-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:27:42
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>, Green Wan <green.wan@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Green Wan <green.wan@sifive.com>

 - Add write operation to update fuse data bit when PWE bit is on.
 - Add array, fuse_wo, to store the 'written' status for all bits
   of OTP to block the write operation.

Signed-off-by: Green Wan <green.wan@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>
Message-id: 20201020033732.12921-2-green.wan@sifive.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/misc/sifive_u_otp.h |  3 +++
 hw/misc/sifive_u_otp.c         | 30 +++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/sifive_u_otp.h b/include/hw/misc/sifive_u_otp.h
index 82c9176c8f..ebffbc1fa5 100644
--- a/include/hw/misc/sifive_u_otp.h
+++ b/include/hw/misc/sifive_u_otp.h
@@ -36,6 +36,8 @@
 #define SIFIVE_U_OTP_PTRIM      0x34
 #define SIFIVE_U_OTP_PWE        0x38
 
+#define SIFIVE_U_OTP_PWE_EN     (1 << 0)
+
 #define SIFIVE_U_OTP_PCE_EN     (1 << 0)
 
 #define SIFIVE_U_OTP_PDSTB_EN   (1 << 0)
@@ -75,6 +77,7 @@ struct SiFiveUOTPState {
     uint32_t ptrim;
     uint32_t pwe;
     uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
+    uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
     /* config */
     uint32_t serial;
 };
diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index c2f3c8e129..b9238d64cb 100644
--- a/hw/misc/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -25,6 +25,14 @@
 #include "qemu/module.h"
 #include "hw/misc/sifive_u_otp.h"
 
+#define WRITTEN_BIT_ON 0x1
+
+#define SET_FUSEARRAY_BIT(map, i, off, bit)    \
+    map[i] = bit ? (map[i] | bit << off) : (map[i] & ~(0x1 << off))
+
+#define GET_FUSEARRAY_BIT(map, i, off)    \
+    ((map[i] >> off) & 0x1)
+
 static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
 {
     SiFiveUOTPState *s = opaque;
@@ -123,7 +131,24 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
         s->ptrim = val32;
         break;
     case SIFIVE_U_OTP_PWE:
-        s->pwe = val32;
+        s->pwe = val32 & SIFIVE_U_OTP_PWE_EN;
+
+        /* PWE is enabled. Ignore PAS=1 (no redundancy cell) */
+        if (s->pwe && !s->pas) {
+            if (GET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "write once error: idx<%u>, bit<%u>\n",
+                              s->pa, s->paio);
+                break;
+            }
+
+            /* write bit data */
+            SET_FUSEARRAY_BIT(s->fuse, s->pa, s->paio, s->pdin);
+
+            /* update written bit */
+            SET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio, WRITTEN_BIT_ON);
+        }
+
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%" HWADDR_PRIx
@@ -165,6 +190,9 @@ static void sifive_u_otp_reset(DeviceState *dev)
     /* Make a valid content of serial number */
     s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
     s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
+
+    /* Initialize write-once map */
+    memset(s->fuse_wo, 0x00, sizeof(s->fuse_wo));
 }
 
 static void sifive_u_otp_class_init(ObjectClass *klass, void *data)
-- 
2.28.0


