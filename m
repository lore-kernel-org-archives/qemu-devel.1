Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEACC43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 22:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F4020717
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 22:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F4020717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36021 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJmwR-0002Ar-Ko
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 18:34:07 -0400
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
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 7F1A7C88580E05882941;
	Fri, 26 Apr 2019 00:52:28 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
	DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server
	id 14.3.439.0; Fri, 26 Apr 2019 00:52:20 +0800
From: x00249684 <xuwei5@huawei.com>
To: <imammedo@redhat.com>, <qemu-devel@nongnu.org>
Date: Fri, 26 Apr 2019 00:51:56 +0800
Message-ID: <1556211116-172721-1-git-send-email-xuwei5@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1556170489-131927-12-git-send-email-imammedo@redhat.com>
References: <1556170489-131927-12-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
X-Mailman-Approved-At: Thu, 25 Apr 2019 18:32:26 -0400
Subject: Re: [Qemu-devel] [PATCH v3 11/13] tests: acpi: add simple arm/virt
 testcase
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: shameerali.kolothum.thodi@huawei.com, xuwei5@huawei.com,
	linuxarm@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425165156.KbR_SDAMqw12SMgYD2nsY9WsI_iW4MhklM5nd_m8pis@z>

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

