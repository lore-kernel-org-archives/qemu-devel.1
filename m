Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C8CC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 11:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00DD028136
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 11:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DD028136
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33351 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXl6T-0005XV-8R
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 07:26:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hXl2c-0002jP-7W
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 07:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hXl29-0000kb-5O
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 07:21:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hXl29-0000X7-08
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 07:21:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBD66C04FFF1;
	Mon,  3 Jun 2019 11:21:35 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6D18367262;
	Mon,  3 Jun 2019 11:21:28 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 13:22:07 +0200
Message-Id: <1559560929-260254-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 03 Jun 2019 11:21:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 0/2] tests: acpi: ARM testing  support
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
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changelog:
  - from v4:
     * uefi support has been merged already, but only ARM part wasn't due=
 to
       test failing on ARM 32 bit host. It turned out that's aarch64 TCG =
issue
       on 32-bit ARM host. Blacklist aarch64 test on 32 bit ARM host for =
now.

Series adds reference tables and a ACPI test case for arm/virt machine

CC: Laszlo Ersek <lersek@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Gonglei <arei.gonglei@huawei.com>
CC: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
CC: Shannon Zhao <shannon.zhaosl@gmail.com>
CC: Wei Yang <richardw.yang@linux.intel.com>
CC: Andrew Jones <drjones@redhat.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: Ben Warren <ben@skyportsystems.com>

Igor Mammedov (2):
  tests: add expected ACPI tables for arm/virt board
  tests: acpi: add simple arm/virt testcase

 tests/Makefile.include                  |   4 ++++
 tests/bios-tables-test.c                |  18 ++++++++++++++++++
 tests/data/acpi/rebuild-expected-aml.sh |   2 +-
 tests/data/acpi/virt/APIC               | Bin 0 -> 168 bytes
 tests/data/acpi/virt/DSDT               | Bin 0 -> 18476 bytes
 tests/data/acpi/virt/FACP               | Bin 0 -> 268 bytes
 tests/data/acpi/virt/GTDT               | Bin 0 -> 96 bytes
 tests/data/acpi/virt/MCFG               | Bin 0 -> 60 bytes
 tests/data/acpi/virt/SPCR               | Bin 0 -> 80 bytes
 9 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 tests/data/acpi/virt/APIC
 create mode 100644 tests/data/acpi/virt/DSDT
 create mode 100644 tests/data/acpi/virt/FACP
 create mode 100644 tests/data/acpi/virt/GTDT
 create mode 100644 tests/data/acpi/virt/MCFG
 create mode 100644 tests/data/acpi/virt/SPCR

--=20
2.7.4


