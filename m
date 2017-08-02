Received: from eggs.gnu.org ([2001:4830:134:3::10]:50387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dcxkE-0004mG-9f
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dcxkB-0007td-6H
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:47:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dcxkB-0007sO-0Y
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:47:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B80434E4C3
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 17:47:37 +0000 (UTC)
References: <1501515652-33372-1-git-send-email-imammedo@redhat.com>
	<1501515652-33372-6-git-send-email-imammedo@redhat.com>
	<ff17f1ca-afec-763a-50cd-0301224dbba9@redhat.com>
	<20170802161059.71686c8a@nial.brq.redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <bb5f8889-45a9-5758-47c5-7b6feaf0c084@redhat.com>
Date: Wed, 2 Aug 2017 20:47:29 +0300
MIME-Version: 1.0
In-Reply-To: <20170802161059.71686c8a@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 5/5] tests: acpi: fix FADT not
 being compared to reference table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On 02/08/2017 17:10, Igor Mammedov wrote:
> On Wed, 2 Aug 2017 16:15:10 +0300
> Marcel Apfelbaum <marcel@redhat.com> wrote:
> 
>> On 31/07/2017 18:40, Igor Mammedov wrote:
>>> It turns out that FADT isn't actually tested for changes
>>> against reference table, since it happens to be the 1st
>>> table in RSDT which is currently ignored.
>>> Fix it by making sure that all tables from RSDT are added
>>> to test list.
>>>    
>>
>> Hi Igor,
>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>>    tests/bios-tables-test.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>>> index a2a90d7..129ef46 100644
>>> --- a/tests/bios-tables-test.c
>>> +++ b/tests/bios-tables-test.c
>>> @@ -243,13 +243,13 @@ static void test_acpi_dsdt_table(test_data *data)
>>>    /* Load all tables and add to test list directly RSDT referenced tables */
>>>    static void fetch_rsdt_referenced_tables(test_data *data)
>>>    {
>>> -    int tables_nr = data->rsdt_tables_nr - 1; /* fadt is first */
>>> +    int tables_nr = data->rsdt_tables_nr;
>>>        int i;
>>>    
>>>        for (i = 0; i < tables_nr; i++) {
>>>            AcpiSdtTable ssdt_table;
>>>    
>>> -        uint32_t addr = data->rsdt_tables_addr[i + 1]; /* fadt is first */
>>> +        uint32_t addr = data->rsdt_tables_addr[i];
>>>            fetch_table(&ssdt_table, addr);
>>>    
>>>            /* Add table to ASL test tables list */
>>>    
>>
>> For some reason I decided not to test it... strange.
>> Anyway, we should also add the expected file, right?
>> (the rebuild script works only for existent tables, I think)
> they are there see: tests/acpi-test-data/*/FACP
> files obviously stale as they haven't been actually used.
> Michael should update them when he applies this series.
> 

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel

>>
>> Thanks,
>> Marcel
>>
>>
>>
> 
