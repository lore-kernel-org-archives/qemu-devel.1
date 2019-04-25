Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83824C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 07:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57FF8217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 07:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FF8217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53285 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJZ2k-0002qq-Ld
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 03:43:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZ1U-00024O-9l
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJYre-0002Lx-77
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:32:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:20163)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJYrd-0002Lh-VX
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:32:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 00:32:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; d="scan'208";a="134226207"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga007.jf.intel.com with ESMTP; 25 Apr 2019 00:32:09 -0700
Date: Thu, 25 Apr 2019 15:31:42 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190425073142.GA24829@richard>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-4-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556170489-131927-4-git-send-email-imammedo@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.88
Subject: Re: [Qemu-devel] [PATCH v3 03/13] tests: acpi: make pointer to RSDP
 64bit
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
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425073142.ARBlazQXU8NGZ1GGBdYoB8U8N5D9q-_7EtERhrH6wwU@z>

On Thu, Apr 25, 2019 at 07:34:39AM +0200, Igor Mammedov wrote:
>In case of UEFI, RSDP doesn't have to be located in lowmem,
>it could be placed at any address. Make sure that test won't
>break if it is placed above the first 4Gb of address space.
>
>PS:
>While at it cleanup some local variables as we don't really
>need them.
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>---
>v2:
>  - s/In case of UEFI/In case of UEFI,/ (Laszlo Ersek <lersek@redhat.com>)
>---
> tests/bios-tables-test.c | 10 ++++------
> 1 file changed, 4 insertions(+), 6 deletions(-)
>
>diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>index 2ee044c..c29dcf4 100644
>--- a/tests/bios-tables-test.c
>+++ b/tests/bios-tables-test.c
>@@ -26,7 +26,7 @@
> typedef struct {
>     const char *machine;
>     const char *variant;
>-    uint32_t rsdp_addr;
>+    uint64_t rsdp_addr;
>     uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
>     GArray *tables;
>     uint32_t smbios_ep_addr;
>@@ -86,13 +86,11 @@ static void test_acpi_rsdp_address(test_data *data)
> 
> static void test_acpi_rsdp_table(test_data *data)
> {
>-    uint8_t *rsdp_table = data->rsdp_table, revision;
>-    uint32_t addr = data->rsdp_addr;
>+    uint8_t *rsdp_table = data->rsdp_table;
> 
>-    acpi_fetch_rsdp_table(data->qts, addr, rsdp_table);
>-    revision = rsdp_table[15 /* Revision offset */];
>+    acpi_fetch_rsdp_table(data->qts, data->rsdp_addr, rsdp_table);

Ok, I think this is the reason you change the second parameter from uint32_t
to uint64_t in 1st patch.

Maybe we need to move that on to this one?

> 
>-    switch (revision) {
>+    switch (rsdp_table[15 /* Revision offset */]) {
>     case 0: /* ACPI 1.0 RSDP */
>         /* With rev 1, checksum is only for the first 20 bytes */
>         g_assert(!acpi_calc_checksum(rsdp_table,  20));
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me

