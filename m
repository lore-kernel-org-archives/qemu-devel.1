Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135D5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D6820738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D6820738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbc4U-0005rZ-1L
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 23:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miaoyubo@huawei.com>)
 id 1jbc1u-000272-5n
 for qemu-devel@nongnu.org; Wed, 20 May 2020 23:37:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3768 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miaoyubo@huawei.com>)
 id 1jbc1t-0001tC-1Q
 for qemu-devel@nongnu.org; Wed, 20 May 2020 23:37:57 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id DF8365D1CAF430BAD97D;
 Thu, 21 May 2020 11:37:54 +0800 (CST)
Received: from DESKTOP-D7EVK5B.china.huawei.com (10.173.221.29) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 11:37:46 +0800
From: Yubo Miao <miaoyubo@huawei.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <lersek@redhat.com>
Subject: [PATCH v8 6/8] unit-test: The files changed.
Date: Thu, 21 May 2020 11:36:29 +0800
Message-ID: <20200521033631.1605-7-miaoyubo@huawei.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200521033631.1605-1-miaoyubo@huawei.com>
References: <20200521033631.1605-1-miaoyubo@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.173.221.29]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=miaoyubo@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 23:37:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: berrange@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, miaoyubo@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The unit-test is seperated into three patches:
1. The files changed and list in bios-tables-test-allowed-diff.h
2. The unit-test
3. The binary file and clear bios-tables-test-allowed-diff.h

The ASL diff would also be listed.
Sice there are 1000+lines diff, some changes would be omitted.

  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000014BB (5307)
+ *     Length           0x00001E7A (7802)
  *     Revision         0x02
- *     Checksum         0xD1
+ *     Checksum         0x57
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPCDSDT"
  *     OEM Revision     0x00000001 (1)

+        Device (PC80)
+        {
+            Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
+            Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
+            Name (_ADR, Zero)  // _ADR: Address
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_SEG, Zero)  // _SEG: PCI Segment
+            Name (_BBN, 0x80)  // _BBN: BIOS Bus Number
+            Name (_UID, 0x80)  // _UID: Unique ID
+            Name (_STR, Unicode ("pxb Device"))  // _STR: Description String
+            Name (_PRT, Package (0x80)  // _PRT: PCI Routing Table
+            {
+                Package (0x04)
+                {
+                    0xFFFF,
+                    Zero,
+                    GSI0,
+                    Zero
+                },
+

Packages are omitted.

+                Package (0x04)
+                {
+                    0x001FFFFF,
+                    0x03,
+                    GSI2,
+                    Zero
+                }
+            })
+            Device (GSI0)
+            {
+                Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  // _HID: Hardware ID
+                Name (_UID, Zero)  // _UID: Unique ID
+                Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
+                {
+                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                    {
+                        0x00000023,
+                    }
+                })
+                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+                {
+                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                    {
+                        0x00000023,
+                    }
+                })
+                Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
+                {
+                }
+            }

GSI1,2,3 are omitted.

+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
+                    0x0000,             // Granularity
+                    0x0080,             // Range Minimum
+                    0x0080,             // Range Maximum
+                    0x0000,             // Translation Offset
+                    0x0001,             // Length
+                    ,, )
+            })
+            Name (SUPP, Zero)
+            Name (CTRL, Zero)
+            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
+            {
+                CreateDWordField (Arg3, Zero, CDW1)
+                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
+                {
+                    CreateDWordField (Arg3, 0x04, CDW2)
+                    CreateDWordField (Arg3, 0x08, CDW3)
+                    SUPP = CDW2 /* \_SB_.PC80._OSC.CDW2 */
+                    CTRL = CDW3 /* \_SB_.PC80._OSC.CDW3 */
+                    CTRL &= 0x1F
+                    If ((Arg1 != One))
+                    {
+                        CDW1 |= 0x08
+                    }
+
+                    If ((CDW3 != CTRL))
+                    {
+                        CDW1 |= 0x10
+                    }
+
+                    CDW3 = CTRL /* \_SB_.PC80.CTRL */
+                    Return (Arg3)
+                }
+                Else
+                {
+                    CDW1 |= 0x04
+                    Return (Arg3)
+                }
+            }

DSM is are omitted

         Device (PCI0)
         {
             Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
                     WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                         0x0000,             // Granularity
                         0x0000,             // Range Minimum
-                        0x00FF,             // Range Maximum
+                        0x007F,             // Range Maximum
                         0x0000,             // Translation Offset
-                        0x0100,             // Length
+                        0x0080,             // Length

Signed-off-by: Yubo Miao <miaoyubo@huawei.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..90c53925fc 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/virt/DSDT.pxb",
-- 
2.19.1



