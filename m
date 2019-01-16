Received: from eggs.gnu.org ([209.51.188.92]:38594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjoNJ-0003GE-Bt
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjoNI-0004WU-E8
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:49:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjoNG-0004PV-8o
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:49:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so7685709wrs.10
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 08:49:00 -0800 (PST)
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
	<1547566866-129386-4-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fe37f00f-9abd-6420-c90f-225e93012930@redhat.com>
Date: Wed, 16 Jan 2019 17:48:58 +0100
MIME-Version: 1.0
In-Reply-To: <1547566866-129386-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/14] tests: acpi: rename
 acpi_parse_rsdp_table() into acpi_fetch_rsdp_table()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

On 1/15/19 4:40 PM, Igor Mammedov wrote:
> so name would reflect what the function does
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/acpi-utils.h       | 2 +-
>  tests/acpi-utils.c       | 2 +-
>  tests/bios-tables-test.c | 2 +-
>  tests/vmgenid-test.c     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> index 398900c..59fb7d5 100644
> --- a/tests/acpi-utils.h
> +++ b/tests/acpi-utils.h
> @@ -47,7 +47,7 @@ typedef struct {
>  uint8_t acpi_calc_checksum(const uint8_t *data, int len);
>  uint32_t acpi_find_rsdp_address(QTestState *qts);
>  uint64_t uefi_find_rsdp_addr(QTestState *qts, uint64_t start, uint64_t size);
> -void acpi_parse_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table);
> +void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table);
>  void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>                        const uint8_t *addr_ptr, const char *sig,
>                        bool verify_checksum);
> diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
> index 84068a8..dce0fb7 100644
> --- a/tests/acpi-utils.c
> +++ b/tests/acpi-utils.c
> @@ -51,7 +51,7 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
>      return off;
>  }
>  
> -void acpi_parse_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table)
> +void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table)
>  {
>      uint8_t revision;
>  
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 529bfc4..99d7bf8 100644
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
> index 52cdd83..27153a0 100644
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
> 
