Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038A7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C069620870
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nxj534JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C069620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP4o-0001Ci-VD
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxG-0004uZ-39
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:26 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxE-0005gY-7u
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:25 -0400
Received: by mail-wr1-x436.google.com with SMTP id a6so33423433wrm.4
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9kAWMFDfNy8onp4hyShw/LbQqFC+n+LfYN6Nfvd1C+w=;
 b=nxj534JXbR27vnm+DlOtxxQznGjecqPPL+NlrG23Mm/6o5KOKbK7IJyShJ6h436n49
 3vsB3MWMLLTvn14P5k3tMqyn1WIwkIR5XDwJxvFXykF5TLmOX2dKqXtQCXAy24CWXXPO
 aNYE7WMOJwWEPaTeTDvlQfpt61dhcHiMGfGaV4395pKfIRrUzBmGXMrQMrttaEQmc9dT
 6Q1H12vVHfwx5gPLcjFZ6V6/RNu3cxTWdb70dskYtEzOLY8JCrDL9kaZdWVQwRXqhumx
 GIzYpLUvJz3lCoosEbXRsZiE5Ow4g3L2dOiPQRpzR67hO149sndNBawIly7bw/pj+7+9
 JCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9kAWMFDfNy8onp4hyShw/LbQqFC+n+LfYN6Nfvd1C+w=;
 b=qcKm3MkVpXpFgZlJ8xSFCtj7K0a05n6GMKB3c1MA/HyRLy5BPz9VIL+RsQZTjWAr+D
 Wn+cZDKAKHT7KKku+74tCdVPlY5Qq9ZCA4eUm6GlyvrKPuUuZdyXxSdDQq8Su4h7eAVX
 Ik81M7pUswuYLYz00HOye2pQI2Tq8VyfJUZPZjj9W6xpCZY8/mbF+DRSWUH0SwI5tG1S
 UeO3hdaMT6cVXGAg0g2LE8KVnW1vNrvyXu0TxtLkpkhN7mMzZWfEJVnKBD/wGemecTjm
 0uAONaPvYz4dDR3eECNcPjYH6t1N3DCaqZZuqYdESf2GNL7ApVqWcFAx8OF519t4174l
 70Xw==
X-Gm-Message-State: AOAM530J+l0DdDiP/B/ehTEhgC5lSBh8ds3PecSXaJWsHaFEET3Dn93m
 /mQKC4QRuREfEW4JHPeRPvooGVAhpSPm0A==
X-Google-Smtp-Source: ABdhPJyUH4G4r+drWeKO3f19KSD/zb5+BIRBXcxmGfI9jLDJAWN60n+jMkfv32zceVZMYmiyTe+c/w==
X-Received: by 2002:adf:fa81:: with SMTP id h1mr37889569wrr.266.1593795262550; 
 Fri, 03 Jul 2020 09:54:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/34] tests/acpi: virt: update golden masters for DSDT
Date: Fri,  3 Jul 2020 17:53:45 +0100
Message-Id: <20200703165405.17672-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jones <drjones@redhat.com>

Differences between disassembled ASL files for DSDT:

@@ -5,13 +5,13 @@
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of a, Mon Jun 29 09:50:01 2020
+ * Disassembly of b, Mon Jun 29 09:50:03 2020
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000014BB (5307)
+ *     Length           0x00001455 (5205)
  *     Revision         0x02
- *     Checksum         0xD1
+ *     Checksum         0xE1
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPCDSDT"
  *     OEM Revision     0x00000001 (1)
@@ -45,32 +45,6 @@
             })
         }

-        Device (FLS0)
-        {
-            Name (_HID, "LNRO0015")  // _HID: Hardware ID
-            Name (_UID, Zero)  // _UID: Unique ID
-            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
-            {
-                Memory32Fixed (ReadWrite,
-                    0x00000000,         // Address Base
-                    0x04000000,         // Address Length
-                    )
-            })
-        }
-
-        Device (FLS1)
-        {
-            Name (_HID, "LNRO0015")  // _HID: Hardware ID
-            Name (_UID, One)  // _UID: Unique ID
-            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
-            {
-                Memory32Fixed (ReadWrite,
-                    0x04000000,         // Address Base
-                    0x04000000,         // Address Length
-                    )
-            })
-        }
-
         Device (FWCF)
         {
             Name (_HID, "QEMU0002")  // _HID: Hardware ID

The other two binaries have the same changes (the removal of the
flash devices).

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-id: 20200629140938.17566-5-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   3 ---
 tests/data/acpi/virt/DSDT                   | Bin 5307 -> 5205 bytes
 tests/data/acpi/virt/DSDT.memhp             | Bin 6668 -> 6566 bytes
 tests/data/acpi/virt/DSDT.numamem           | Bin 5307 -> 5205 bytes
 4 files changed, 3 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 32a401ae35f..dfb8523c8bf 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,4 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/virt/DSDT",
-"tests/data/acpi/virt/DSDT.memhp",
-"tests/data/acpi/virt/DSDT.numamem",
diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
index d6f5c617881c4247f55d4dcd06581f9693916b2f..e669508d175f1e3ddf355f8a9b0d419266cac8aa 100644
GIT binary patch
delta 28
kcmdn3c~yhUCD<h-RD^+n>ET2!X{H9}iRuX(-<}f&0DgxFc>n+a

delta 156
zcmcbrv0IbNCD<iow+I6R)5VEg(oAih6V(&y4c&Z#4LIUGJY9Hw{DS-q3=B;fIO0P+
zU4W!>P_UpN7hfAE10w?juv9WcH-WSmV$;Hiu7w4t3#`S$E!^1+q9xGPH`KtuzzAr5
LaERl^1zUvy_;n(J

diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSDT.memhp
index 730e95a46d2cce0af011ffc051d7342beb8f1328..4cb81f692d73526542493a0c4da9c9793cc8366e 100644
GIT binary patch
delta 28
kcmeA%S!T@T66_MPOp<|tiD@F2G*jb@iRuX(-^xn@0CHUjRR910

delta 156
zcmZ2x++)J!66_MfBgMeL^l>7WG*kP$iRuaUhHgH=1|0Doo-VvTenI{Q28N~#9Py!^
zE<n;bC|FRCi?5B7fsp|MSSlH!n?PC&v1wsM*TMqS1=eEW7Vhi@(GuwD8){%+U<5Qj
LIK*+|0yaqism~!^

diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/virt/DSDT.numamem
index d6f5c617881c4247f55d4dcd06581f9693916b2f..e669508d175f1e3ddf355f8a9b0d419266cac8aa 100644
GIT binary patch
delta 28
kcmdn3c~yhUCD<h-RD^+n>ET2!X{H9}iRuX(-<}f&0DgxFc>n+a

delta 156
zcmcbrv0IbNCD<iow+I6R)5VEg(oAih6V(&y4c&Z#4LIUGJY9Hw{DS-q3=B;fIO0P+
zU4W!>P_UpN7hfAE10w?juv9WcH-WSmV$;Hiu7w4t3#`S$E!^1+q9xGPH`KtuzzAr5
LaERl^1zUvy_;n(J

-- 
2.20.1


