Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32531C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 06:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E855520724
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 06:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E855520724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jESYE-0001AG-1q
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 02:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1jESXC-0000Gq-Ql
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 02:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1jESXB-0005nP-LO
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 02:50:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60410 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1jESXB-0004x8-97
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 02:50:33 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 9D82CAEB364FF751143C;
 Wed, 18 Mar 2020 14:50:26 +0800 (CST)
Received: from linux-kDCJWP.huawei.com (10.175.104.212) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 18 Mar 2020 14:50:19 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v4 2/2] tests/bios-tables-test: add smbios cpu speed test
Date: Wed, 18 Mar 2020 14:48:20 +0800
Message-ID: <20200318064820.19363-3-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200318064820.19363-1-guoheyi@huawei.com>
References: <20200318064820.19363-1-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com
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

Signed-off-by: Heyi Guo <guoheyi@huawei.com>

---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/bios-tables-test.c | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
index 0a597bbacf..f2d2e97b4a 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -77,6 +77,8 @@ typedef struct {
     GArray *tables;
     uint32_t smbios_ep_addr;
     struct smbios_21_entry_point smbios_ep_table;
+    uint16_t smbios_cpu_max_speed;
+    uint16_t smbios_cpu_curr_speed;
     uint8_t *required_struct_types;
     int required_struct_types_len;
     QTestState *qts;
@@ -560,6 +562,31 @@ static inline bool smbios_single_instance(uint8_t ty=
pe)
     }
 }
=20
+static bool smbios_cpu_test(test_data *data, uint32_t addr)
+{
+    uint16_t expect_speed[2];
+    uint16_t real;
+    int offset[2];
+    int i;
+
+    /* Check CPU speed for backward compatibility */
+    offset[0] =3D offsetof(struct smbios_type_4, max_speed);
+    offset[1] =3D offsetof(struct smbios_type_4, current_speed);
+    expect_speed[0] =3D data->smbios_cpu_max_speed ? : 2000;
+    expect_speed[1] =3D data->smbios_cpu_curr_speed ? : 2000;
+
+    for (i =3D 0; i < 2; i++) {
+        real =3D qtest_readw(data->qts, addr + offset[i]);
+        if (real !=3D expect_speed[i]) {
+            fprintf(stderr, "Unexpected SMBIOS CPU speed: real %u expect=
 %u\n",
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
     DECLARE_BITMAP(struct_bitmap, SMBIOS_MAX_TYPE+1) =3D { 0 };
@@ -582,6 +609,10 @@ static void test_smbios_structs(test_data *data)
         }
         set_bit(type, struct_bitmap);
=20
+        if (type =3D=3D 4) {
+            g_assert(smbios_cpu_test(data, addr));
+        }
+
         /* seek to end of unformatted string area of this struct ("\0\0"=
) */
         prv =3D crt =3D 1;
         while (prv || crt) {
@@ -716,6 +747,11 @@ static void test_acpi_q35_tcg(void)
     data.required_struct_types_len =3D ARRAY_SIZE(base_required_struct_t=
ypes);
     test_acpi_one(NULL, &data);
     free_test_data(&data);
+
+    data.smbios_cpu_max_speed =3D 3000;
+    data.smbios_cpu_curr_speed =3D 2600;
+    test_acpi_one("-smbios type=3D4,max-speed=3D3000,current-speed=3D260=
0", &data);
+    free_test_data(&data);
 }
=20
 static void test_acpi_q35_tcg_bridge(void)
@@ -1017,6 +1053,12 @@ static void test_acpi_virt_tcg(void)
=20
     test_acpi_one("-cpu cortex-a57", &data);
     free_test_data(&data);
+
+    data.smbios_cpu_max_speed =3D 2900;
+    data.smbios_cpu_curr_speed =3D 2700;
+    test_acpi_one("-cpu cortex-a57 "
+                  "-smbios type=3D4,max-speed=3D2900,current-speed=3D270=
0", &data);
+    free_test_data(&data);
 }
=20
 int main(int argc, char *argv[])
--=20
2.19.1


