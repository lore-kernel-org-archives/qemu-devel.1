Received: from eggs.gnu.org ([209.51.188.92]:59922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gole2-000634-TH
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gole2-00068k-1x
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:54:54 -0500
Date: Wed, 30 Jan 2019 16:54:19 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190130085419.GA10043@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190130030207.6770-1-richardw.yang@linux.intel.com>
	<20190130091650.5c7b5f7e@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130091650.5c7b5f7e@Igors-MacBook-Pro.local>
Subject: Re: [Qemu-devel] [PATCH] i386,
 acpi: cleanup build_facs by removing second unused argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, mst@redhat.com

On Wed, Jan 30, 2019 at 09:16:50AM +0100, Igor Mammedov wrote:
>On Wed, 30 Jan 2019 11:02:07 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>> The second argument of build_facs() is not used, just remove it.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Thanks :-)

>
>> ---
>>  hw/i386/acpi-build.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 236a20eaa8..023729c1f2 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -292,7 +292,7 @@ static void acpi_align_size(GArray *blob, unsigned align)
>>  
>>  /* FACS */
>>  static void
>> -build_facs(GArray *table_data, BIOSLinker *linker)
>> +build_facs(GArray *table_data)
>>  {
>>      AcpiFacsDescriptorRev1 *facs = acpi_data_push(table_data, sizeof *facs);
>>      memcpy(&facs->signature, "FACS", 4);
>> @@ -2643,7 +2643,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>>       * requirements.
>>       */
>>      facs = tables_blob->len;
>> -    build_facs(tables_blob, tables->linker);
>> +    build_facs(tables_blob);
>>  
>>      /* DSDT is pointed to by FADT */
>>      dsdt = tables_blob->len;

-- 
Wei Yang
Help you, Help me
