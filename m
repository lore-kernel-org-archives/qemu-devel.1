Received: from eggs.gnu.org ([209.51.188.92]:59319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gopSN-0000Rg-Aq
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gopSM-00067Y-HW
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:59:07 -0500
Date: Wed, 30 Jan 2019 12:59:03 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190130125903.bewxhjvlyud5mdqh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190130030207.6770-1-richardw.yang@linux.intel.com>
	<3e847da2-8ced-fefd-b566-30093d9fe331@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e847da2-8ced-fefd-b566-30093d9fe331@redhat.com>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, imammedo@redhat.com, mst@redhat.com

On Wed, Jan 30, 2019 at 12:15:57PM +0100, Philippe Mathieu-Daudé wrote:
>On 1/30/19 4:02 AM, Wei Yang wrote:
>> The second argument of build_facs() is not used, just remove it.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
>> 

-- 
Wei Yang
Help you, Help me
