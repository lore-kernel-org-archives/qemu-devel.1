Received: from eggs.gnu.org ([209.51.188.92]:57250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xuwei5@huawei.com>) id 1hJhc1-0005uW-5U
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xuwei5@huawei.com>) id 1hJhc0-0004ct-DR
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:52:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49898 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xuwei5@huawei.com>) id 1hJhc0-0004Vz-2g
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:52:40 -0400
From: x00249684 <xuwei5@huawei.com>
Date: Fri, 26 Apr 2019 00:51:56 +0800
Message-ID: <1556211116-172721-1-git-send-email-xuwei5@huawei.com>
In-Reply-To: <1556170489-131927-12-git-send-email-imammedo@redhat.com>
References: <1556170489-131927-12-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 11/13] tests: acpi: add simple arm/virt
 testcase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: imammedo@redhat.com, qemu-devel@nongnu.org
Cc: xuwei5@huawei.com, shameerali.kolothum.thodi@huawei.com, linuxarm@huawei.com

Hi Igor,

+static void test_acpi_virt_tcg(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+    };
+
+    test_acpi_one("-cpu cortex-a57 ", &data);

Replaced the cortex-a57 with host and succesfully tested on the hisilicon arm64 
D05 board. Otherwise it failed with "kvm_init_vcpu failed: Invalid argument".
Is it possilbe to set the cpu type like numa-test.c?
Thanks!

Best Regards,
Wei
