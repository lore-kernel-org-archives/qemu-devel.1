Received: from eggs.gnu.org ([2001:4830:134:3::10]:59356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dctIA-0002sW-0v
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dctI5-0001m1-E1
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:02:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dctI5-0001lt-7z
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:02:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7C27C047B60
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 13:02:19 +0000 (UTC)
References: <1501515652-33372-1-git-send-email-imammedo@redhat.com>
	<1501515652-33372-3-git-send-email-imammedo@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <93521d4f-c583-b18d-dba9-219bf2659bae@redhat.com>
Date: Wed, 2 Aug 2017 16:02:12 +0300
MIME-Version: 1.0
In-Reply-To: <1501515652-33372-3-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/5] tests: acpi: init table
 descriptor in test_dst_table()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On 31/07/2017 18:40, Igor Mammedov wrote:
> remove code duplication and make sure that table descriptor
> passed in for initialization is in expected state.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   tests/bios-tables-test.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index b72fa80..adbcc55 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -210,6 +210,7 @@ static void test_dst_table(AcpiSdtTable *sdt_table, uint32_t addr)
>   {
>       uint8_t checksum;
>   
> +    memset(sdt_table, 0, sizeof(*sdt_table));
>       ACPI_READ_TABLE_HEADER(&sdt_table->header, addr);
>   
>       sdt_table->aml_len = sdt_table->header.length - sizeof(AcpiTableHeader);
> @@ -228,8 +229,6 @@ static void test_acpi_dsdt_table(test_data *data)
>       AcpiSdtTable dsdt_table;
>       uint32_t addr = data->fadt_table.dsdt;
>   
> -    memset(&dsdt_table, 0, sizeof(dsdt_table));
> -
>       test_dst_table(&dsdt_table, addr);
>       ACPI_ASSERT_CMP(dsdt_table.header.signature, "DSDT");
>   
> @@ -245,7 +244,6 @@ static void test_acpi_tables(test_data *data)
>       for (i = 0; i < tables_nr; i++) {
>           AcpiSdtTable ssdt_table;
>   
> -        memset(&ssdt_table, 0, sizeof(ssdt_table));
>           uint32_t addr = data->rsdt_tables_addr[i + 1]; /* fadt is first */
>           test_dst_table(&ssdt_table, addr);
>           g_array_append_val(data->tables, ssdt_table);
> 

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
