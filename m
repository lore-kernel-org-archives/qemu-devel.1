Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C673C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 21:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43FE205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 21:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43FE205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxe7j-0000CD-61
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 17:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42002)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hxe1R-0005GZ-Gq
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 17:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hxe1P-0001fF-2W
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 17:08:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:32894 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hxe1J-0001Y5-Uw; Tue, 13 Aug 2019 17:07:54 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id F15B9C2BA4CDCEF09560;
 Wed, 14 Aug 2019 05:07:51 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.94.0) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 14 Aug 2019 05:07:43 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Date: Tue, 13 Aug 2019 22:05:38 +0100
Message-ID: <20190813210539.31164-12-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20190813210539.31164-1-shameerali.kolothum.thodi@huawei.com>
References: <20190813210539.31164-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.94.0]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: [Qemu-devel] [PATCH-for-4.2 v9 11/12] tests: add dummy ACPI tables
 for arm/virt board
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch is in preparation for adding numamem and memhp tests
to arm/virt board so that 'make check' is happy. This may not
be required once the scripts are run and new tables are
generated with ".numamem" and ".memhp" extensions.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
I am not sure this is the right way to do this. But without this, when
the numamem and memhp tests are added, you will get,

Looking for expected file 'tests/data/acpi/virt/SRAT.numamem'
Looking for expected file 'tests/data/acpi/virt/SRAT'
**
ERROR:tests/bios-tables-test.c:327:load_expected_aml: assertion failed: (exp_sdt.aml_file)

---
 tests/data/acpi/virt/SLIT | Bin 0 -> 48 bytes
 tests/data/acpi/virt/SRAT | Bin 0 -> 224 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/data/acpi/virt/SLIT
 create mode 100644 tests/data/acpi/virt/SRAT

diff --git a/tests/data/acpi/virt/SLIT b/tests/data/acpi/virt/SLIT
new file mode 100644
index 0000000000000000000000000000000000000000..74ec3b4b461ffecca36d8537975c202a5f011185
GIT binary patch
literal 48
scmWIc@eDCwU|?X>aq@Te2v%^42yhMtiZKGkKx`1r1jHb~B`V4V0NaKK0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/SRAT b/tests/data/acpi/virt/SRAT
new file mode 100644
index 0000000000000000000000000000000000000000..119922f4973f621602047d1dc160519f810922a3
GIT binary patch
literal 224
zcmWFzatwLEz`(%x)yd!4BUr&HBEUHqD8>jB1F=Cg2*ZH@DxXmUMHZ-x3$7Gd2B8jU
X02q8=hbcr=2NT6lGiu<Mhsgo}c|r;S

literal 0
HcmV?d00001

-- 
2.17.1



