Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F06BC04AAA
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 01:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A66206DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 01:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A66206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34977 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hN60I-0004OE-E1
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 21:31:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hN5zL-0003VN-9x
	for qemu-devel@nongnu.org; Sat, 04 May 2019 21:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hN5zJ-00062W-BG
	for qemu-devel@nongnu.org; Sat, 04 May 2019 21:30:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:22430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hN5zH-000603-IV
	for qemu-devel@nongnu.org; Sat, 04 May 2019 21:30:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 May 2019 18:30:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,431,1549958400"; d="scan'208";a="148333707"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga003.jf.intel.com with ESMTP; 04 May 2019 18:30:38 -0700
Date: Sun, 5 May 2019 09:30:12 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190505013012.GE20071@richard>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
	<1556808723-226478-15-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556808723-226478-15-git-send-email-imammedo@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.126
Subject: Re: [Qemu-devel] [PATCH v4 14/15] tests: acpi: refactor
 rebuild-expected-aml.sh to dump ACPI tables for a specified list of targets
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	linuxarm@huawei.com, Shannon Zhao <shannon.zhaosl@gmail.com>,
	Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>, xuwei5@huawei.com,
	xuwei5@hisilicon.com,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505013012.B5jdlFzfi3fTV48K9OVxhwCtoIdwNgJ9piSHfmUU_Uc@z>

On Thu, May 02, 2019 at 04:52:02PM +0200, Igor Mammedov wrote:
>Make initial list contain aarch64 and x86_64 targets.
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
>v4:
> * fix typo (Wei Yang <richardw.yang@linux.intel.com>)
>v2:
> * fix up error message (Philippe Mathieu-Daudé <philmd@redhat.com>)
>---
> tests/data/acpi/rebuild-expected-aml.sh | 23 +++++++++++------------
> 1 file changed, 11 insertions(+), 12 deletions(-)
>
>diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
>index abdff70..07f7e3f 100755
>--- a/tests/data/acpi/rebuild-expected-aml.sh
>+++ b/tests/data/acpi/rebuild-expected-aml.sh
>@@ -7,21 +7,12 @@
> #
> # Authors:
> #  Marcel Apfelbaum <marcel.a@redhat.com>
>+#  Igor Mammedov <imammedo@redhat.com>
> #
> # This work is licensed under the terms of the GNU GPLv2.
> # See the COPYING.LIB file in the top-level directory.
> 
>-qemu=
>-
>-if [ -e x86_64-softmmu/qemu-system-x86_64 ]; then
>-    qemu="x86_64-softmmu/qemu-system-x86_64"
>-elif [ -e i386-softmmu/qemu-system-i386 ]; then
>-    qemu="i386-softmmu/qemu-system-i386"
>-else
>-    echo "Run 'make' to build the qemu exectutable!"
>-    echo "Run this script from the build directory."
>-    exit 1;
>-fi
>+qemu_bins="aarch64-softmmu/qemu-system-aarch64 x86_64-softmmu/qemu-system-x86_64"
> 
> if [ ! -e "tests/bios-tables-test" ]; then
>     echo "Test: bios-tables-test is required! Run make check before this script."
>@@ -29,6 +20,14 @@ if [ ! -e "tests/bios-tables-test" ]; then
>     exit 1;
> fi
> 
>-TEST_ACPI_REBUILD_AML=y QTEST_QEMU_BINARY=$qemu tests/bios-tables-test
>+for qemu in $qemu_bins; do
>+    if [ ! -e $qemu ]; then
>+        echo "Run 'make' to build the following QEMU executables: $qemu_bins"
>+        echo "Also, run this script from the build directory."
>+        exit 1;
>+    fi
>+    TEST_ACPI_REBUILD_AML=y QTEST_QEMU_BINARY=$qemu tests/bios-tables-test
>+done
>+
> 
> echo "The files were rebuilt and can be added to git."
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me

