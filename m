Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D37FC04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 18:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C69A2133D
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 18:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C69A2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45975 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPt59-0006vq-GQ
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 14:20:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hPt4A-0006cP-MM
	for qemu-devel@nongnu.org; Sun, 12 May 2019 14:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hPt45-0006TV-Sk
	for qemu-devel@nongnu.org; Sun, 12 May 2019 14:19:18 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hPt45-0006RS-Gs
	for qemu-devel@nongnu.org; Sun, 12 May 2019 14:19:13 -0400
Received: by mail-qk1-f196.google.com with SMTP id a132so6633294qkb.13
	for <qemu-devel@nongnu.org>; Sun, 12 May 2019 11:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to;
	bh=TWmctKK6mBM+WHfp7XxqCOQ7WkFBw5qNAQWPVvVfT+A=;
	b=qVneJYXib+HCbGEi8a0j8ThQ338gpQZq5GszSraG9vUp/S1wyK+LcTag92ZQhg9k4p
	ngM56u+o3O/ZYKQq+S6NdsK5lfV0SdzfXRMHwO7DNkstcRBvp6ESMQ4XOyDHOQVdCaf4
	y2vUr3GOztwNCODGiTtmdNmYEOwzsb+r8WGho+gBpHU3kCfugEp5k4Aq3Z4w3Nu0F9zd
	Nv6yhJ25DRinPN8Cww/48TOEx6oTFWyUg34c93Qz/Z35rkPYhjnpEMVZW3evPoatuwCY
	JZ3qDuKgdq/45w1pwOCOE11+tre2kRBQVxJ1lGw3zA5upsb2XdF9rA1o0zIoksNZOkp+
	8XnQ==
X-Gm-Message-State: APjAAAW3197OE98fkHXEB+sE/qAK3R46zxAcz4BmqZ7VFuXdwjRNStru
	Om6AchpSV/d5QF82eYOoCvBlEw==
X-Google-Smtp-Source: APXvYqxmdA2HJM0sosoipqc9wmSL98iNFeBAc6VzChpeQnTE5f9aMPkKvPWQPdfgsmkCFAczx5YGYA==
X-Received: by 2002:a37:8703:: with SMTP id j3mr18224569qkd.188.1557685152563; 
	Sun, 12 May 2019 11:19:12 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71])
	by smtp.gmail.com with ESMTPSA id o10sm5709443qtg.5.2019.05.12.11.19.10
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 12 May 2019 11:19:11 -0700 (PDT)
Date: Sun, 12 May 2019 14:19:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190512141838-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556808723-226478-16-git-send-email-imammedo@redhat.com>
	<1556808723-226478-15-git-send-email-imammedo@redhat.com>
	<1556808723-226478-14-git-send-email-imammedo@redhat.com>
	<1556808723-226478-13-git-send-email-imammedo@redhat.com>
	<1556808723-226478-12-git-send-email-imammedo@redhat.com>
	<1556808723-226478-11-git-send-email-imammedo@redhat.com>
	<1556808723-226478-10-git-send-email-imammedo@redhat.com>
	<1556808723-226478-9-git-send-email-imammedo@redhat.com>
	<1556808723-226478-8-git-send-email-imammedo@redhat.com>
	<1556808723-226478-7-git-send-email-imammedo@redhat.com>
	<1556808723-226478-6-git-send-email-imammedo@redhat.com>
	<1556808723-226478-5-git-send-email-imammedo@redhat.com>
	<1556808723-226478-4-git-send-email-imammedo@redhat.com>
	<1556808723-226478-3-git-send-email-imammedo@redhat.com>
	<1556808723-226478-2-git-send-email-imammedo@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.196
Subject: Re: [Qemu-devel] [PATCH v4 01/15] tests: acpi: rename
 acpi_parse_rsdp_table() into acpi_fetch_rsdp_table()
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

On Thu, May 02, 2019 at 04:51:49PM +0200, Igor Mammedov wrote:
> so name would reflect what the function does
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
> v4:
>  * make it as the first patch in series
> ---


FYI this trips up git am.
Don't do two --- please: just one is enough,
second is not needed.


>  tests/acpi-utils.h       | 2 +-
>  tests/acpi-utils.c       | 2 +-
>  tests/bios-tables-test.c | 2 +-
>  tests/vmgenid-test.c     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> index ef388bb..4cd5553 100644
> --- a/tests/acpi-utils.h
> +++ b/tests/acpi-utils.h
> @@ -47,7 +47,7 @@ typedef struct {
>  uint8_t acpi_calc_checksum(const uint8_t *data, int len);
>  uint32_t acpi_find_rsdp_address(QTestState *qts);
>  uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
> -void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
> +void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
>  void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>                        const uint8_t *addr_ptr, const char *sig,
>                        bool verify_checksum);
> diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
> index cc33b46..633d8f5 100644
> --- a/tests/acpi-utils.c
> +++ b/tests/acpi-utils.c
> @@ -63,7 +63,7 @@ uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table)
>      return le64_to_cpu(xsdt_physical_address);
>  }
>  
> -void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
> +void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
>  {
>      uint8_t revision;
>  
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index a506dcb..6a678bf 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -89,7 +89,7 @@ static void test_acpi_rsdp_table(test_data *data)
>      uint8_t *rsdp_table = data->rsdp_table, revision;
>      uint32_t addr = data->rsdp_addr;
>  
> -    acpi_parse_rsdp_table(data->qts, addr, rsdp_table);
> +    acpi_fetch_rsdp_table(data->qts, addr, rsdp_table);
>      revision = rsdp_table[15 /* Revision offset */];
>  
>      switch (revision) {
> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> index ae38ee5..f400184 100644
> --- a/tests/vmgenid-test.c
> +++ b/tests/vmgenid-test.c
> @@ -40,7 +40,7 @@ static uint32_t acpi_find_vgia(QTestState *qts)
>      g_assert_cmphex(rsdp_offset, <, RSDP_ADDR_INVALID);
>  
>  
> -    acpi_parse_rsdp_table(qts, rsdp_offset, rsdp_table);
> +    acpi_fetch_rsdp_table(qts, rsdp_offset, rsdp_table);
>      acpi_fetch_table(qts, &rsdt, &rsdt_len, &rsdp_table[16 /* RsdtAddress */],
>                       "RSDT", true);
>  
> -- 
> 2.7.4

On Thu, May 02, 2019 at 04:51:50PM +0200, Igor Mammedov wrote:
> Currently acpi_fetch_table() assumes 32 bit size of table pointer
> in ACPI tables. However X_foo variants are 64 bit, prepare
> acpi_fetch_table() to handle both by adding an argument
> for addr_ptr pointed entry size. Follow up commits will use that
> to read XSDT and X_foo entries in ACPI tables.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/acpi-utils.h       |  2 +-
>  tests/acpi-utils.c       | 10 ++++++----
>  tests/bios-tables-test.c |  8 ++++----
>  tests/vmgenid-test.c     |  4 ++--
>  4 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> index 4cd5553..92285b7 100644
> --- a/tests/acpi-utils.h
> +++ b/tests/acpi-utils.h
> @@ -49,7 +49,7 @@ uint32_t acpi_find_rsdp_address(QTestState *qts);
>  uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
>  void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
>  void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
> -                      const uint8_t *addr_ptr, const char *sig,
> +                      const uint8_t *addr_ptr, int addr_size, const char *sig,
>                        bool verify_checksum);
>  
>  #endif  /* TEST_ACPI_UTILS_H */
> diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
> index 633d8f5..644c87b 100644
> --- a/tests/acpi-utils.c
> +++ b/tests/acpi-utils.c
> @@ -91,13 +91,15 @@ void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
>   *  actual one.
>   */
>  void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
> -                      const uint8_t *addr_ptr, const char *sig,
> +                      const uint8_t *addr_ptr, int addr_size, const char *sig,
>                        bool verify_checksum)
>  {
> -    uint32_t addr, len;
> +    uint32_t len;
> +    uint64_t addr = 0;
>  
> -    memcpy(&addr, addr_ptr , sizeof(addr));
> -    addr = le32_to_cpu(addr);
> +    g_assert(addr_size == 4 || addr_size == 8);
> +    memcpy(&addr, addr_ptr , addr_size);
> +    addr = le64_to_cpu(addr);
>      qtest_memread(qts, addr + 4, &len, 4); /* Length of ACPI table */
>      *aml_len = le32_to_cpu(len);
>      *aml = g_malloc0(*aml_len);
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 6a678bf..86b592c 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -114,14 +114,14 @@ static void test_acpi_rsdt_table(test_data *data)
>  
>      /* read RSDT table */
>      acpi_fetch_table(data->qts, &rsdt.aml, &rsdt.aml_len,
> -                     &data->rsdp_table[16 /* RsdtAddress */], "RSDT", true);
> +                     &data->rsdp_table[16 /* RsdtAddress */], 4, "RSDT", true);
>  
>      /* Load all tables and add to test list directly RSDT referenced tables */
>      ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, 4 /* Entry size */) {
>          AcpiSdtTable ssdt_table = {};
>  
>          acpi_fetch_table(data->qts, &ssdt_table.aml, &ssdt_table.aml_len, ent,
> -                         NULL, true);
> +                         4, NULL, true);
>          /* Add table to ASL test tables list */
>          g_array_append_val(data->tables, ssdt_table);
>      }
> @@ -139,11 +139,11 @@ static void test_acpi_fadt_table(test_data *data)
>  
>      /* Since DSDT/FACS isn't in RSDT, add them to ASL test list manually */
>      acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
> -                     fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
> +                     fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", false);
>      g_array_append_val(data->tables, table);
>  
>      acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
> -                     fadt_aml + 40 /* DSDT */, "DSDT", true);
> +                     fadt_aml + 40 /* DSDT */, 4, "DSDT", true);
>      g_array_append_val(data->tables, table);
>  
>      memset(fadt_aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> index f400184..85d8e64 100644
> --- a/tests/vmgenid-test.c
> +++ b/tests/vmgenid-test.c
> @@ -42,12 +42,12 @@ static uint32_t acpi_find_vgia(QTestState *qts)
>  
>      acpi_fetch_rsdp_table(qts, rsdp_offset, rsdp_table);
>      acpi_fetch_table(qts, &rsdt, &rsdt_len, &rsdp_table[16 /* RsdtAddress */],
> -                     "RSDT", true);
> +                     4, "RSDT", true);
>  
>      ACPI_FOREACH_RSDT_ENTRY(rsdt, rsdt_len, ent, 4 /* Entry size */) {
>          uint8_t *table_aml;
>  
> -        acpi_fetch_table(qts, &table_aml, &table_length, ent, NULL, true);
> +        acpi_fetch_table(qts, &table_aml, &table_length, ent, 4, NULL, true);
>          if (!memcmp(table_aml + 16 /* OEM Table ID */, "VMGENID", 7)) {
>              uint32_t vgia_val;
>              uint8_t *aml = &table_aml[36 /* AML byte-code start */];
> -- 
> 2.7.4

On Thu, May 02, 2019 at 04:51:51PM +0200, Igor Mammedov wrote:
> If RSDP revision is more than 0 fetch table pointed by XSDT
> and fallback to legacy RSDT table otherwise.
> 
> While at it drop unused acpi_get_xsdt_address().
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> PS:
>  it doesn't affect existing pc/q35 machines as they use RSDP.revision == 0
>  but it will be used by followup patch to enable testing arm/virt
>  board which uses provides XSDT table.
> 
> v4:
>  * move out acpi_parse_rsdp_table() hunk to
>    "tests: acpi: make pointer to RSDP  64bit"
>    where it belongs
> ---
>  tests/acpi-utils.h       |  1 -
>  tests/acpi-utils.c       | 12 ------------
>  tests/bios-tables-test.c | 20 ++++++++++++++------
>  3 files changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> index 92285b7..f55ccf9 100644
> --- a/tests/acpi-utils.h
> +++ b/tests/acpi-utils.h
> @@ -46,7 +46,6 @@ typedef struct {
>  
>  uint8_t acpi_calc_checksum(const uint8_t *data, int len);
>  uint32_t acpi_find_rsdp_address(QTestState *qts);
> -uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
>  void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
>  void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>                        const uint8_t *addr_ptr, int addr_size, const char *sig,
> diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
> index 644c87b..a0d49c4 100644
> --- a/tests/acpi-utils.c
> +++ b/tests/acpi-utils.c
> @@ -51,18 +51,6 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
>      return off;
>  }
>  
> -uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table)
> -{
> -    uint64_t xsdt_physical_address;
> -    uint8_t revision = rsdp_table[15 /* Revision offset */];
> -
> -    /* We must have revision 2 if we're looking for an XSDT pointer */
> -    g_assert(revision == 2);
> -
> -    memcpy(&xsdt_physical_address, &rsdp_table[24 /* XsdtAddress offset */], 8);
> -    return le64_to_cpu(xsdt_physical_address);
> -}
> -
>  void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
>  {
>      uint8_t revision;
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 86b592c..d6ab121 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -107,21 +107,29 @@ static void test_acpi_rsdp_table(test_data *data)
>      }
>  }
>  
> -static void test_acpi_rsdt_table(test_data *data)
> +static void test_acpi_rxsdt_table(test_data *data)
>  {
> +    const char *sig = "RSDT";
>      AcpiSdtTable rsdt = {};
> +    int entry_size = 4;
> +    int addr_off = 16 /* RsdtAddress */;
>      uint8_t *ent;
>  
> -    /* read RSDT table */
> +    if (data->rsdp_table[15 /* Revision offset */] != 0) {
> +        addr_off = 24 /* XsdtAddress */;
> +        entry_size = 8;
> +        sig = "XSDT";
> +    }
> +    /* read [RX]SDT table */
>      acpi_fetch_table(data->qts, &rsdt.aml, &rsdt.aml_len,
> -                     &data->rsdp_table[16 /* RsdtAddress */], 4, "RSDT", true);
> +                     &data->rsdp_table[addr_off], entry_size, sig, true);
>  
>      /* Load all tables and add to test list directly RSDT referenced tables */
> -    ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, 4 /* Entry size */) {
> +    ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, entry_size) {
>          AcpiSdtTable ssdt_table = {};
>  
>          acpi_fetch_table(data->qts, &ssdt_table.aml, &ssdt_table.aml_len, ent,
> -                         4, NULL, true);
> +                         entry_size, NULL, true);
>          /* Add table to ASL test tables list */
>          g_array_append_val(data->tables, ssdt_table);
>      }
> @@ -521,7 +529,7 @@ static void test_acpi_one(const char *params, test_data *data)
>      data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
>      test_acpi_rsdp_address(data);
>      test_acpi_rsdp_table(data);
> -    test_acpi_rsdt_table(data);
> +    test_acpi_rxsdt_table(data);
>      test_acpi_fadt_table(data);
>  
>      if (iasl) {
> -- 
> 2.7.4

On Thu, May 02, 2019 at 04:51:52PM +0200, Igor Mammedov wrote:
> In case of UEFI, RSDP doesn't have to be located in lowmem,
> it could be placed at any address. Make sure that test won't
> break if it is placed above the first 4Gb of address space.
> 
> PS:
> While at it cleanup some local variables as we don't really
> need them.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v4:
>  - move acpi_fetch_rsdp_table(s/uint32_t addr/uint64_t addr/) to
>    this patch where it belongs from
>    "tests: acpi: make RSDT test routine handle XSDT"
>    (Wei Yang <richardw.yang@linux.intel.com>)
> v2:
>   - s/In case of UEFI/In case of UEFI,/ (Laszlo Ersek <lersek@redhat.com>)
> ---
>  tests/acpi-utils.h       |  2 +-
>  tests/acpi-utils.c       |  2 +-
>  tests/bios-tables-test.c | 10 ++++------
>  3 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> index f55ccf9..1da6c10 100644
> --- a/tests/acpi-utils.h
> +++ b/tests/acpi-utils.h
> @@ -46,7 +46,7 @@ typedef struct {
>  
>  uint8_t acpi_calc_checksum(const uint8_t *data, int len);
>  uint32_t acpi_find_rsdp_address(QTestState *qts);
> -void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
> +void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table);
>  void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>                        const uint8_t *addr_ptr, int addr_size, const char *sig,
>                        bool verify_checksum);
> diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
> index a0d49c4..c216b9e 100644
> --- a/tests/acpi-utils.c
> +++ b/tests/acpi-utils.c
> @@ -51,7 +51,7 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
>      return off;
>  }
>  
> -void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
> +void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table)
>  {
>      uint8_t revision;
>  
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index d6ab121..a164d27 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -26,7 +26,7 @@
>  typedef struct {
>      const char *machine;
>      const char *variant;
> -    uint32_t rsdp_addr;
> +    uint64_t rsdp_addr;
>      uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
>      GArray *tables;
>      uint32_t smbios_ep_addr;
> @@ -86,13 +86,11 @@ static void test_acpi_rsdp_address(test_data *data)
>  
>  static void test_acpi_rsdp_table(test_data *data)
>  {
> -    uint8_t *rsdp_table = data->rsdp_table, revision;
> -    uint32_t addr = data->rsdp_addr;
> +    uint8_t *rsdp_table = data->rsdp_table;
>  
> -    acpi_fetch_rsdp_table(data->qts, addr, rsdp_table);
> -    revision = rsdp_table[15 /* Revision offset */];
> +    acpi_fetch_rsdp_table(data->qts, data->rsdp_addr, rsdp_table);
>  
> -    switch (revision) {
> +    switch (rsdp_table[15 /* Revision offset */]) {
>      case 0: /* ACPI 1.0 RSDP */
>          /* With rev 1, checksum is only for the first 20 bytes */
>          g_assert(!acpi_calc_checksum(rsdp_table,  20));
> -- 
> 2.7.4

On Thu, May 02, 2019 at 04:51:53PM +0200, Igor Mammedov wrote:
> that way it would be possible to test a DSDT pointed by
> 64bit X_DSDT field in FADT.
> 
> PS:
> it will allow to enable testing arm/virt board, which sets
> only newer X_DSDT field.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v4:
>  * dropping Reviewed-bys due to acpi_fetch_table() change
>    introduced by earlier patch:
>    "tests: acpi: make acpi_fetch_table() take size of fetched table pointer"
> v2:
>   add 'val = le32_to_cpu(val)' even if it doesn't necessary
>   it works as reminder that value copied from table is in
>   little-endian format (Philippe Mathieu-Daudé <philmd@redhat.com>)
> ---
>  tests/bios-tables-test.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index a164d27..d165a1b 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -140,6 +140,9 @@ static void test_acpi_fadt_table(test_data *data)
>      AcpiSdtTable table = g_array_index(data->tables, typeof(table), 0);
>      uint8_t *fadt_aml = table.aml;
>      uint32_t fadt_len = table.aml_len;
> +    uint32_t val;
> +    int dsdt_offset = 40 /* DSDT */;
> +    int dsdt_entry_size = 4;
>  
>      g_assert(compare_signature(&table, "FACP"));
>  
> @@ -148,8 +151,14 @@ static void test_acpi_fadt_table(test_data *data)
>                       fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", false);
>      g_array_append_val(data->tables, table);
>  
> +    memcpy(&val, fadt_aml + dsdt_offset, 4);
> +    val = le32_to_cpu(val);
> +    if (!val) {
> +        dsdt_offset = 140 /* X_DSDT */;
> +        dsdt_entry_size = 8;
> +    }
>      acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
> -                     fadt_aml + 40 /* DSDT */, 4, "DSDT", true);
> +                     fadt_aml + dsdt_offset, dsdt_entry_size, "DSDT", true);
>      g_array_append_val(data->tables, table);
>  
>      memset(fadt_aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
> -- 
> 2.7.4

On Thu, May 02, 2019 at 04:51:54PM +0200, Igor Mammedov wrote:
> If FADT has HW_REDUCED_ACPI flag set, do not attempt to fetch
> FACS as it's not provided by the board.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  tests/bios-tables-test.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index d165a1b..e2fc341 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -147,9 +147,13 @@ static void test_acpi_fadt_table(test_data *data)
>      g_assert(compare_signature(&table, "FACP"));
>  
>      /* Since DSDT/FACS isn't in RSDT, add them to ASL test list manually */
> -    acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
> -                     fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", false);
> -    g_array_append_val(data->tables, table);
> +    memcpy(&val, fadt_aml + 112 /* Flags */, 4);
> +    val = le32_to_cpu(val);
> +    if (!(val & 1UL << 20 /* HW_REDUCED_ACPI */)) {
> +        acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
> +                         fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", false);
> +        g_array_append_val(data->tables, table);
> +    }
>  
>      memcpy(&val, fadt_aml + dsdt_offset, 4);
>      val = le32_to_cpu(val);
> -- 
> 2.7.4

On Thu, May 02, 2019 at 04:51:55PM +0200, Igor Mammedov wrote:
> boot_sector_init() won't be used by arm/virt board, so move it from
> global scope to x86 branch that uses it.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v3:
>   - fix checkpatch errors triggered by moved old code (ident/space/braces)
> ---
>  tests/bios-tables-test.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index e2fc341..4d13a3c 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -788,13 +788,14 @@ int main(int argc, char *argv[])
>      const char *arch = qtest_get_arch();
>      int ret;
>  
> -    ret = boot_sector_init(disk);
> -    if(ret)
> -        return ret;
> -
>      g_test_init(&argc, &argv, NULL);
>  
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> +        ret = boot_sector_init(disk);
> +        if (ret) {
> +            return ret;
> +        }
> +
>          qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
>          qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
>          qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> -- 
> 2.7.4

On Thu, May 02, 2019 at 04:51:56PM +0200, Igor Mammedov wrote:
> introduce UEFI specific counterpart to acpi_find_rsdp_address()
> that will help to find RSDP address when [OA]VMF is used as
> firmware. It requires guest firmware or other guest app to place
> 1Mb aligned UefiTestSupport structure (defined in this patch)
> in RAM with UefiTestSupport::signature_guid set to
> AB87A6B1-2034-BDA0-71BD-375007757785
> For test app details see commit
>   (09a274d82f tests: introduce "uefi-test-tools" with the BiosTablesTest UEFI app)
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
> v4:
>   * update commit message to point to commit which introduced
>    signature_guid value.
> v3:
>   * fix checkpatch error (separate opening brace from values in AcpiTestSupportGuid initializer)
> v2:
>   * Laszlo Ersek <lersek@redhat.com>
>     - s/uefi_find_rsdp_addr/acpi_find_rsdp_address_uefi/
>     - use GUID_SIZE instead of opencodding size
>     - make AcpiTestSupportGuid const
>     - s/TCI/TCG/
> ---
>  tests/acpi-utils.h |  2 ++
>  tests/acpi-utils.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> index 1da6c10..52c529e 100644
> --- a/tests/acpi-utils.h
> +++ b/tests/acpi-utils.h
> @@ -46,6 +46,8 @@ typedef struct {
>  
>  uint8_t acpi_calc_checksum(const uint8_t *data, int len);
>  uint32_t acpi_find_rsdp_address(QTestState *qts);
> +uint64_t acpi_find_rsdp_address_uefi(QTestState *qts, uint64_t start,
> +                                     uint64_t size);
>  void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table);
>  void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>                        const uint8_t *addr_ptr, int addr_size, const char *sig,
> diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
> index c216b9e..d2a202e 100644
> --- a/tests/acpi-utils.c
> +++ b/tests/acpi-utils.c
> @@ -101,3 +101,47 @@ void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>          g_assert(!acpi_calc_checksum(*aml, *aml_len));
>      }
>  }
> +
> +#define GUID_SIZE 16
> +static const uint8_t AcpiTestSupportGuid[GUID_SIZE] = {
> +       0xb1, 0xa6, 0x87, 0xab,
> +       0x34, 0x20,
> +       0xa0, 0xbd,
> +       0x71, 0xbd, 0x37, 0x50, 0x07, 0x75, 0x77, 0x85 };
> +
> +typedef struct {
> +    uint8_t signature_guid[GUID_SIZE];
> +    uint64_t rsdp10;
> +    uint64_t rsdp20;
> +} __attribute__((packed)) UefiTestSupport;
> +
> +/* Wait at most 600 seconds (test is slow with TCG and --enable-debug) */
> +#define TEST_DELAY (1 * G_USEC_PER_SEC / 10)
> +#define TEST_CYCLES MAX((600 * G_USEC_PER_SEC / TEST_DELAY), 1)
> +#define MB 0x100000ULL
> +uint64_t acpi_find_rsdp_address_uefi(QTestState *qts, uint64_t start,
> +                                     uint64_t size)
> +{
> +    int i, j;
> +    uint8_t data[GUID_SIZE];
> +
> +    for (i = 0; i < TEST_CYCLES; ++i) {
> +        for (j = 0; j < size / MB; j++) {
> +            /* look for GUID at every 1Mb block */
> +            uint64_t addr = start + j * MB;
> +
> +            qtest_memread(qts, addr, data, sizeof(data));
> +            if (!memcmp(AcpiTestSupportGuid, data, sizeof(data))) {
> +                UefiTestSupport ret;
> +
> +                qtest_memread(qts, addr, &ret, sizeof(ret));
> +                ret.rsdp10 = le64_to_cpu(ret.rsdp10);
> +                ret.rsdp20 = le64_to_cpu(ret.rsdp20);
> +                return ret.rsdp20 ? ret.rsdp20 : ret.rsdp10;
> +            }
> +        }
> +        g_usleep(TEST_DELAY);
> +    }
> +    g_assert_not_reached();
> +    return 0;
> +}
> -- 
> 2.7.4

On Thu, May 02, 2019 at 04:51:57PM +0200, Igor Mammedov wrote:
> For testcase to use UEFI firmware, one needs to provide and specify
> firmware and varstore blob names in test_data { uefi_fl1, uefi_fl2 }
> fields respectively and RAM start address plus size where to look for
> test structure signature. Additionally testcase should specify
> bootable cdrom image from uefi-boot-images with EFI test utility.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---
> v4:
>   * fixup commit message (typo/spelling) (Wei Yang <richardw.yang@linux.intel.com>)
>   * get rid of test_acpi_rsdp_address()
> v3:
>   * drop data_dir prefix and firmware will come from pc-bios directly
>   * add cdrom option so test could use it for providing boot cdrom image
>   * add TODO comment convert '-drive if=pflash' to new syntax (Laszlo)
> v2:
>   * move RAM start address and size to test_data, as it could differ
>     between boards (and even versions)
> 
> dfd
> ---
>  tests/bios-tables-test.c | 52 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 17 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 4d13a3c..84e1ce2 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -26,6 +26,11 @@
>  typedef struct {
>      const char *machine;
>      const char *variant;
> +    const char *uefi_fl1;
> +    const char *uefi_fl2;
> +    const char *cd;
> +    const uint64_t ram_start;
> +    const uint64_t scan_len;
>      uint64_t rsdp_addr;
>      uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
>      GArray *tables;
> @@ -77,13 +82,6 @@ static void free_test_data(test_data *data)
>      g_array_free(data->tables, true);
>  }
>  
> -static void test_acpi_rsdp_address(test_data *data)
> -{
> -    uint32_t off = acpi_find_rsdp_address(data->qts);
> -    g_assert_cmphex(off, <, 0x100000);
> -    data->rsdp_addr = off;
> -}
> -
>  static void test_acpi_rsdp_table(test_data *data)
>  {
>      uint8_t *rsdp_table = data->rsdp_table;
> @@ -524,21 +522,41 @@ static void test_smbios_structs(test_data *data)
>  static void test_acpi_one(const char *params, test_data *data)
>  {
>      char *args;
> -
> -    /* Disable kernel irqchip to be able to override apic irq0. */
> -    args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
> -                           "-net none -display none %s "
> -                           "-drive id=hd0,if=none,file=%s,format=raw "
> -                           "-device ide-hd,drive=hd0 ",
> -                           data->machine, "kvm:tcg",
> -                           params ? params : "", disk);
> +    bool use_uefi = data->uefi_fl1 && data->uefi_fl2;
> +
> +    if (use_uefi) {
> +        /*
> +         * TODO: convert '-drive if=pflash' to new syntax (see e33763be7cd3)
> +         * when arm/virt boad starts to support it.
> +         */
> +        args = g_strdup_printf("-machine %s,accel=%s -nodefaults -nographic "
> +            "-drive if=pflash,format=raw,file=%s,readonly "
> +            "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
> +            data->machine, "kvm:tcg", data->uefi_fl1, data->uefi_fl2,
> +            data->cd, params ? params : "");
> +
> +    } else {
> +        /* Disable kernel irqchip to be able to override apic irq0. */
> +        args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
> +            "-net none -display none %s "
> +            "-drive id=hd0,if=none,file=%s,format=raw "
> +            "-device ide-hd,drive=hd0 ",
> +             data->machine, "kvm:tcg", params ? params : "", disk);
> +    }
>  
>      data->qts = qtest_init(args);
>  
> -    boot_sector_test(data->qts);
> +    if (use_uefi) {
> +        g_assert(data->scan_len);
> +        data->rsdp_addr = acpi_find_rsdp_address_uefi(data->qts,
> +            data->ram_start, data->scan_len);
> +    } else {
> +        boot_sector_test(data->qts);
> +        data->rsdp_addr = acpi_find_rsdp_address(data->qts);
> +        g_assert_cmphex(data->rsdp_addr, <, 0x100000);
> +    }
>  
>      data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
> -    test_acpi_rsdp_address(data);
>      test_acpi_rsdp_table(data);
>      test_acpi_rxsdt_table(data);
>      test_acpi_fadt_table(data);
> -- 
> 2.7.4

On Thu, May 02, 2019 at 04:51:58PM +0200, Igor Mammedov wrote:
> once FW provides a pointer to SMBIOS entry point like it does for
> RSDP it should be possible to enable this one the same way.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---
> v3:
>   - add ref to a uefi-test-tools feature req into comment (Laszlo)
> ---
>  tests/bios-tables-test.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 84e1ce2..8302ffc 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -569,8 +569,15 @@ static void test_acpi_one(const char *params, test_data *data)
>          }
>      }
>  
> -    test_smbios_entry_point(data);
> -    test_smbios_structs(data);
> +    /*
> +     * TODO: make SMBIOS tests work with UEFI firmware,
> +     * Bug on uefi-test-tools to provide entry point:
> +     * https://bugs.launchpad.net/qemu/+bug/1821884
> +     */
> +    if (!use_uefi) {
> +        test_smbios_entry_point(data);
> +        test_smbios_structs(data);
> +    }
>  
>      assert(!global_qtest);
>      qtest_quit(data->qts);
> -- 
> 2.7.4

On Thu, May 02, 2019 at 04:51:59PM +0200, Igor Mammedov wrote:
> By default test cases were run with 'kvm:tcg' accelerators to speed up
> tests execution. While it works for x86, were change of accelerator
> doesn't affect ACPI tables, the approach doesn't works for ARM usecase
> though.
> 
> In arm/virt case, KVM mode requires using 'host' cpu model, which
> isn't available in TCG mode. That could be worked around with 'max'
> cpu model, which works both for KVM and TCG. However in KVM mode it
> is necessary to specify matching GIC version, which also could use
> 'max' value to automatically pick GIC version suitable for host's CPU.
> Depending on host cpu type, different GIC versions would be used,
> which in turn leads to different ACPI tables (APIC) generated.
> As result while comparing with reference blobs, test would fail if
> host's GIC version won't match the version on the host where
> reference blobs where generated.
> 
> Let's keep testing simple for now and allow ARM tests run in TCG only
> mode. To do so introduce 'accel' parameter in test configuration, so
> test case could override default "kvm:tcg" with accelerator of choice.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/bios-tables-test.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 8302ffc..39c1e24 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -24,6 +24,7 @@
>  #define ACPI_REBUILD_EXPECTED_AML "TEST_ACPI_REBUILD_AML"
>  
>  typedef struct {
> +    const char *accel;
>      const char *machine;
>      const char *variant;
>      const char *uefi_fl1;
> @@ -532,8 +533,8 @@ static void test_acpi_one(const char *params, test_data *data)
>          args = g_strdup_printf("-machine %s,accel=%s -nodefaults -nographic "
>              "-drive if=pflash,format=raw,file=%s,readonly "
>              "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
> -            data->machine, "kvm:tcg", data->uefi_fl1, data->uefi_fl2,
> -            data->cd, params ? params : "");
> +            data->machine, data->accel ? data->accel : "kvm:tcg",
> +            data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : "");
>  
>      } else {
>          /* Disable kernel irqchip to be able to override apic irq0. */
> @@ -541,7 +542,8 @@ static void test_acpi_one(const char *params, test_data *data)
>              "-net none -display none %s "
>              "-drive id=hd0,if=none,file=%s,format=raw "
>              "-device ide-hd,drive=hd0 ",
> -             data->machine, "kvm:tcg", params ? params : "", disk);
> +             data->machine, data->accel ? data->accel : "kvm:tcg",
> +             params ? params : "", disk);
>      }
>  
>      data->qts = qtest_init(args);
> -- 
> 2.7.4

On Thu, May 02, 2019 at 04:52:00PM +0200, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> this patch is ahead fo "tests: acpi: add simple  arm/virt testcase"
> to keep 'make check' working during bisection and not to pollute
> code with binary blobs which are not reviewable.
> ---
>  tests/data/acpi/virt/APIC | Bin 0 -> 168 bytes
>  tests/data/acpi/virt/DSDT | Bin 0 -> 18476 bytes
>  tests/data/acpi/virt/FACP | Bin 0 -> 268 bytes
>  tests/data/acpi/virt/GTDT | Bin 0 -> 96 bytes
>  tests/data/acpi/virt/MCFG | Bin 0 -> 60 bytes
>  tests/data/acpi/virt/SPCR | Bin 0 -> 80 bytes
>  6 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 tests/data/acpi/virt/APIC
>  create mode 100644 tests/data/acpi/virt/DSDT
>  create mode 100644 tests/data/acpi/virt/FACP
>  create mode 100644 tests/data/acpi/virt/GTDT
>  create mode 100644 tests/data/acpi/virt/MCFG
>  create mode 100644 tests/data/acpi/virt/SPCR
> 
> diff --git a/tests/data/acpi/virt/APIC b/tests/data/acpi/virt/APIC
> new file mode 100644
> index 0000000000000000000000000000000000000000..797dfde2841c51b7e72065602e99ce1714347f0d
> GIT binary patch
> literal 168
> zcmZ<^@N{0mz`($~*~#D8BUr&HBEZ=ZD8>jB1F=Cg4Dd+6SPUF6788)c?E~X6Fu>G{
> hBZPn~MyPrgD9sGlkD?67;f3451Xcqw&w(L;0RYV=2>}2A
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
> new file mode 100644
> index 0000000000000000000000000000000000000000..20e85c7f89f645c69935c615c07084e221419960
> GIT binary patch
> literal 18476
> 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
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/data/acpi/virt/FACP b/tests/data/acpi/virt/FACP
> new file mode 100644
> index 0000000000000000000000000000000000000000..27de99f51bfe846b1f8796ace49d83f5b33a1aed
> GIT binary patch
> literal 268
> ycmZ>BbPnKQWME+3?d0$55v<@85#a0w6axw|fY>0Kx<CNcIA#XwTY+i=(L4a*H3tCz
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/data/acpi/virt/GTDT b/tests/data/acpi/virt/GTDT
> new file mode 100644
> index 0000000000000000000000000000000000000000..10107a65e958ff6495bb8c17d63d0539690f59f6
> GIT binary patch
> literal 96
> zcmZ<{aS2IaU|?Xn>E!S15v<@85#a0&6k`O6f!H7#8OTC8azL5|h^3)?DJYFj0RVOU
> B2mt^9
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/data/acpi/virt/MCFG b/tests/data/acpi/virt/MCFG
> new file mode 100644
> index 0000000000000000000000000000000000000000..e8987e1af0ec3829770bf4fe11fab02b06160dd2
> GIT binary patch
> literal 60
> scmeZuc5}C3U|?YMck*}k2v%^42ypfViZKGkKx`0=1Oyx)oc|yS05YNo0RR91
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/data/acpi/virt/SPCR b/tests/data/acpi/virt/SPCR
> new file mode 100644
> index 0000000000000000000000000000000000000000..377271a0e7817cc21a28c02123a89facad63604f
> GIT binary patch
> literal 80
> zcmWFza1IJ!U|?VpcJg=j2v%^42yhMtiZKGkKx`1r48#l^3?L>agsBLmm>C$E7#RKo
> I0Z0r60QF4^0RR91
> 
> literal 0
> HcmV?d00001
> 
> -- 
> 2.7.4

On Thu, May 02, 2019 at 04:52:01PM +0200, Igor Mammedov wrote:
> adds simple arm/virt test case that starts guest with
> bios-tables-test.aarch64.iso.qcow2 boot image which
> initializes UefiTestSupport* structure in RAM once
> guest is booted.
> 
>  * see commit: tests: acpi: add acpi_find_rsdp_address_uefi() helper
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v4:
>   * force test to use TCG accelerator
> v3:
>   * use firmware blobs directly from pc-bios directory
>   * use bios-tables-test.aarch64.iso.qcow2 as test boot image
>   * drop leftover qtest-uefi-images-aarch64 iMakefile rule from
>     previos version (Laszlo)
>   * add Makefile rule to include bios-tables-test into
>     check-qtest-aarch64 target
> v2:
>   * specify in test_data where board's RAM starts and RAM size
> 
> fixup! tests: acpi: add simple arm/virt testcase
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/Makefile.include   |  1 +
>  tests/bios-tables-test.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index e2432d5..983c8b1 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -267,6 +267,7 @@ check-qtest-arm-y += tests/hexloader-test$(EXESUF)
>  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
>  check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
>  check-qtest-aarch64-y += tests/migration-test$(EXESUF)
> +check-qtest-aarch64-y += tests/bios-tables-test$(EXESUF)
>  
>  check-qtest-microblazeel-y += $(check-qtest-microblaze-y)
>  
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 39c1e24..eaa1b0c 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -810,6 +810,22 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
>      test_acpi_tcg_dimm_pxm(MACHINE_PC);
>  }
>  
> +static void test_acpi_virt_tcg(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .accel = "tcg",
> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> +        .ram_start = 0x40000000ULL,
> +        .scan_len = 128ULL * 1024 * 1024,
> +    };
> +
> +    test_acpi_one("-cpu cortex-a57", &data);
> +    free_test_data(&data);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      const char *arch = qtest_get_arch();
> @@ -838,6 +854,8 @@ int main(int argc, char *argv[])
>          qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
>          qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_pxm);
>          qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
> +    } else if (strcmp(arch, "aarch64") == 0) {
> +        qtest_add_func("acpi/virt", test_acpi_virt_tcg);
>      }
>      ret = g_test_run();
>      boot_sector_cleanup(disk);
> -- 
> 2.7.4

On Thu, May 02, 2019 at 04:52:02PM +0200, Igor Mammedov wrote:
> Make initial list contain aarch64 and x86_64 targets.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v4:
>  * fix typo (Wei Yang <richardw.yang@linux.intel.com>)
> v2:
>  * fix up error message (Philippe Mathieu-Daudé <philmd@redhat.com>)
> ---
>  tests/data/acpi/rebuild-expected-aml.sh | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
> index abdff70..07f7e3f 100755
> --- a/tests/data/acpi/rebuild-expected-aml.sh
> +++ b/tests/data/acpi/rebuild-expected-aml.sh
> @@ -7,21 +7,12 @@
>  #
>  # Authors:
>  #  Marcel Apfelbaum <marcel.a@redhat.com>
> +#  Igor Mammedov <imammedo@redhat.com>
>  #
>  # This work is licensed under the terms of the GNU GPLv2.
>  # See the COPYING.LIB file in the top-level directory.
>  
> -qemu=
> -
> -if [ -e x86_64-softmmu/qemu-system-x86_64 ]; then
> -    qemu="x86_64-softmmu/qemu-system-x86_64"
> -elif [ -e i386-softmmu/qemu-system-i386 ]; then
> -    qemu="i386-softmmu/qemu-system-i386"
> -else
> -    echo "Run 'make' to build the qemu exectutable!"
> -    echo "Run this script from the build directory."
> -    exit 1;
> -fi
> +qemu_bins="aarch64-softmmu/qemu-system-aarch64 x86_64-softmmu/qemu-system-x86_64"
>  
>  if [ ! -e "tests/bios-tables-test" ]; then
>      echo "Test: bios-tables-test is required! Run make check before this script."
> @@ -29,6 +20,14 @@ if [ ! -e "tests/bios-tables-test" ]; then
>      exit 1;
>  fi
>  
> -TEST_ACPI_REBUILD_AML=y QTEST_QEMU_BINARY=$qemu tests/bios-tables-test
> +for qemu in $qemu_bins; do
> +    if [ ! -e $qemu ]; then
> +        echo "Run 'make' to build the following QEMU executables: $qemu_bins"
> +        echo "Also, run this script from the build directory."
> +        exit 1;
> +    fi
> +    TEST_ACPI_REBUILD_AML=y QTEST_QEMU_BINARY=$qemu tests/bios-tables-test
> +done
> +
>  
>  echo "The files were rebuilt and can be added to git."
> -- 
> 2.7.4

On Thu, May 02, 2019 at 04:52:03PM +0200, Igor Mammedov wrote:
> Instead of just asserting print the error that lead to assert first.
> While at it move assert into rebuild branch, which removes redundant
> check done in case of !rebuild branch is taken (the later is taken
> care of by g_assert_no_error).
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v4:
>   * fix typo in commit message (Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>)
> ---
>  tests/bios-tables-test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index eaa1b0c..6cb8b16 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -195,11 +195,14 @@ static void dump_aml_files(test_data *data, bool rebuild)
>                                         sdt->aml, ext);
>              fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
>                          S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
> +            if (fd < 0) {
> +                perror(aml_file);
> +            }
> +            g_assert(fd >= 0);
>          } else {
>              fd = g_file_open_tmp("aml-XXXXXX", &sdt->aml_file, &error);
>              g_assert_no_error(error);
>          }
> -        g_assert(fd >= 0);
>  
>          ret = qemu_write_full(fd, sdt->aml, sdt->aml_len);
>          g_assert(ret == sdt->aml_len);
> -- 
> 2.7.4


