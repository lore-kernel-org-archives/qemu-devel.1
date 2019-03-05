Received: from eggs.gnu.org ([209.51.188.92]:43703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1EFt-0006nn-S3
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:53:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1EFq-0003zN-6c
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:53:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1EFp-0003nC-Ik
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:53:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id d17so10464555wre.10
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 09:53:18 -0800 (PST)
References: <20190304194857.9780-1-philmd@redhat.com>
	<20190304194857.9780-5-philmd@redhat.com>
	<97cb7eaa-f3ed-ed66-c57e-e6686be2ce8d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ddf6d59f-36c1-f144-4f78-fefe5112e7d9@redhat.com>
Date: Tue, 5 Mar 2019 18:53:15 +0100
MIME-Version: 1.0
In-Reply-To: <97cb7eaa-f3ed-ed66-c57e-e6686be2ce8d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] pc: Support firmware configuration
 with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Hi Laszlo!

On 3/5/19 6:34 PM, Laszlo Ersek wrote:
> Hi Phil,
> 
> On 03/04/19 20:48, Philippe Mathieu-Daudé wrote:
> 
>> [PMD: rebased on 'pflash: Fixes and cleanups'
>>       replaced CFI_PFLASH01 -> PFLASH_CFI01]
> 
> [...]
> 
>> -#define FLASH_MAP_UNIT_MAX 2
>> +static PFlashCFI01 *pc_pflash_create(const char *name)
>> +{
>> +    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
>> +
>> +    qdev_prop_set_uint64(dev, "sector-length", 4096);
> 
> [...]
> 
>> -static void pc_system_flash_init(MemoryRegion *rom_memory)
>> +static void pc_system_flash_map(PCMachineState *pcms,
>> +                                MemoryRegion *rom_memory)
>>  {
>> -    int unit;
>> -    DriveInfo *pflash_drv;
>> +    hwaddr total_size = 0;
>> +    int i;
>>      BlockBackend *blk;
>>      int64_t size;
>> -    char *fatal_errmsg = NULL;
>> -    hwaddr phys_addr = 0x100000000ULL;
>>      uint32_t sector_size = 4096;
> 
> [...]
> 
>> +        if (size == 0) {
>> +            error_report("system firmware block device %s is empty",
>> +                         blk_name(blk));
>> +            exit(1);
>> +        }
>> +        if (size == 0 || size % sector_size != 0) {
> 
> I think you missed my points (1) and (2), and Markus's followup, here:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07018.html

Actually I missed your whole mail...

I'll let Markus take what he likes from this 'splitting' series, and
apply your comments on top if it :)

Markus: you can also drop patches 3/4 of this series if it makes your
work harder.

Thanks both!

Phil.
