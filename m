Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F2BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 03:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B322084D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 03:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B322084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3X35-0000N0-TW
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 23:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1k3X2M-0007Zw-5X
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 23:57:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4225 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1k3X2K-0001RP-8l
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 23:57:49 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5EB811B8F1C5E96A95DB;
 Thu,  6 Aug 2020 11:57:44 +0800 (CST)
Received: from localhost (10.174.185.104) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 6 Aug 2020
 11:57:38 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <mst@redhat.com>
Subject: [PATCH v5 2/2] tests/bios-tables-test: add smbios cpu speed test
Date: Thu, 6 Aug 2020 11:56:34 +0800
Message-ID: <20200806035634.376-3-fangying1@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200806035634.376-1-fangying1@huawei.com>
References: <20200806035634.376-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 23:57:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: lvivier@redhat.com, zhang.zhanghailiang@huawei.com, alex.chen@huawei.com,
 Ying Fang <fangying1@huawei.com>, Heyi Guo <guoheyi@huawei.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add smbios type 4 CPU speed check for we added new options to set
smbios type 4 "max speed" and "current speed". The default value
should be 2000 when no option is specified, just as the old version
did.

We add the test case to one machine of each architecture, though it
doesn't really run on aarch64 platform for smbios test can't run on
uefi only platform yet.

Signed-off-by: Ying Fang <fangying1@huawei.com>
Signed-off-by: Heyi Guo <guoheyi@huawei.com>
---
 tests/bios-tables-test.c | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index a356ac3489..6bd165021b 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -37,6 +37,8 @@ typedef struct {
     GArray *tables;
     uint32_t smbios_ep_addr;
     struct smbios_21_entry_point smbios_ep_table;
+    uint16_t smbios_cpu_max_speed;
+    uint16_t smbios_cpu_curr_speed;
     uint8_t *required_struct_types;
     int required_struct_types_len;
     QTestState *qts;
@@ -516,6 +518,31 @@ static inline bool smbios_single_instance(uint8_t type)
     }
 }
 
+static bool smbios_cpu_test(test_data *data, uint32_t addr)
+{
+    uint16_t expect_speed[2];
+    uint16_t real;
+    int offset[2];
+    int i;
+
+    /* Check CPU speed for backward compatibility */
+    offset[0] = offsetof(struct smbios_type_4, max_speed);
+    offset[1] = offsetof(struct smbios_type_4, current_speed);
+    expect_speed[0] = data->smbios_cpu_max_speed ? : 2000;
+    expect_speed[1] = data->smbios_cpu_curr_speed ? : 2000;
+
+    for (i = 0; i < 2; i++) {
+        real = qtest_readw(data->qts, addr + offset[i]);
+        if (real != expect_speed[i]) {
+            fprintf(stderr, "Unexpected SMBIOS CPU speed: real %u expect %u\n",
+                    real, expect_speed[i]);
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static void test_smbios_structs(test_data *data)
 {
     DECLARE_BITMAP(struct_bitmap, SMBIOS_MAX_TYPE+1) = { 0 };
@@ -538,6 +565,10 @@ static void test_smbios_structs(test_data *data)
         }
         set_bit(type, struct_bitmap);
 
+        if (type == 4) {
+            g_assert(smbios_cpu_test(data, addr));
+        }
+
         /* seek to end of unformatted string area of this struct ("\0\0") */
         prv = crt = 1;
         while (prv || crt) {
@@ -673,6 +704,11 @@ static void test_acpi_q35_tcg(void)
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
     test_acpi_one(NULL, &data);
     free_test_data(&data);
+
+    data.smbios_cpu_max_speed = 3000;
+    data.smbios_cpu_curr_speed = 2600;
+    test_acpi_one("-smbios type=4,max-speed=3000,current-speed=2600", &data);
+    free_test_data(&data);
 }
 
 static void test_acpi_q35_tcg_bridge(void)
@@ -885,6 +921,12 @@ static void test_acpi_virt_tcg(void)
 
     test_acpi_one("-cpu cortex-a57", &data);
     free_test_data(&data);
+
+    data.smbios_cpu_max_speed = 2900;
+    data.smbios_cpu_curr_speed = 2700;
+    test_acpi_one("-cpu cortex-a57 "
+                  "-smbios type=4,max-speed=2900,current-speed=2700", &data);
+    free_test_data(&data);
 }
 
 int main(int argc, char *argv[])
-- 
2.23.0


