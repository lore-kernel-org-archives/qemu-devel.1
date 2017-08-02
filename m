Received: from eggs.gnu.org ([2001:4830:134:3::10]:59953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dctJu-0003ze-Ld
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dctJq-0002dM-Qd
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:04:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dctJq-0002ch-K7
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:04:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 989D381245
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 13:04:09 +0000 (UTC)
References: <1501515652-33372-1-git-send-email-imammedo@redhat.com>
	<1501515652-33372-5-git-send-email-imammedo@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <0ecddc1b-e958-811c-dbc4-c61dd546d602@redhat.com>
Date: Wed, 2 Aug 2017 16:04:03 +0300
MIME-Version: 1.0
In-Reply-To: <1501515652-33372-5-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 4/5] tests: acpi: add comments to
 fetch_rsdt_referenced_tables/data->tables usage
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
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   tests/bios-tables-test.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index ed32e9a..a2a90d7 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -251,6 +251,8 @@ static void fetch_rsdt_referenced_tables(test_data *data)
>   
>           uint32_t addr = data->rsdt_tables_addr[i + 1]; /* fadt is first */
>           fetch_table(&ssdt_table, addr);
> +
> +        /* Add table to ASL test tables list */
>           g_array_append_val(data->tables, ssdt_table);
>       }
>   }
> @@ -425,6 +427,7 @@ try_again:
>       return exp_tables;
>   }
>   
> +/* test the list of tables in @data->tables against reference tables */
>   static void test_acpi_asl(test_data *data)
>   {
>       int i;
> 


Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
