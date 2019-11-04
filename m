Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0404CA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:01:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52752190F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52752190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRYEP-0006jN-Qk
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 04:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iRYDe-0006Ae-Sw
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:00:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iRYDd-0000FC-Jd
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:00:14 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:42461)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iRYDd-00009f-Ac
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:00:13 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MEmEf-1iBIwC07Ct-00GEp4; Mon, 04 Nov 2019 10:00:03 +0100
Subject: Re: [PATCH v2] q800: fix I/O memory map
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191102214209.26058-1-laurent@vivier.eu>
 <6a200cd8-bb8f-d2b1-dc1f-247fb0870396@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cf301d2c-b6b9-c76c-3430-37b2743f5364@vivier.eu>
Date: Mon, 4 Nov 2019 10:00:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <6a200cd8-bb8f-d2b1-dc1f-247fb0870396@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dVmhSmDTriYfZsjRilOqu65+xK9kAHqHamopeCJGQzCWWz8NLWo
 4lca0y6Y7Jo7boGcM3e8z3rvzUGNWPkHnAC0knjRZM6E641XkGAlPsTPm3afQG1O+iSt+X1
 UXXISkVgNsdFeR45yIa79TnW1LV4r31SkaDlqP1z4JvxtgQ9KLzKKE+skwCY2fbPI7oU+ko
 QmrifGVrKRAmloXyec/Wg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g9iRblO4WxA=:OfCOK/Zrf3391tcOulY6AK
 U2dig/EJ9o3Qpl7RvovcIt+aqPyNU++kM4Sr5IujgQ8uZbQmTLuwA8tKsSg742UwovRhQmKCv
 5Z38iGv2vGWdl/cc0dVqCiw366EQ0XPakcq+jDzEGsm/HFrXWenoH5GIWv4YV9vtNlmV/UDLp
 O5aS7lTlN73qsHOpaiiRyMX9Py9Fj15jLt6keo1l3pS9j7HIPXr9CZbZ9wuZ8Qzpzte/ZswnQ
 ZnZ0IGKQkKCzIf6ZUyS/fs9wftcVFoFIENtZ4YNn4QbpwYuafxrVuazSbCQrd9SDq/xkg///0
 xORRGcnpZEfg1YEkQi/qArENKhoFGy5eT3Vz0Miq0DxNAIwi+GoUW18Zo7LH69fvbD5lHqJSt
 2wLYP/SS5P7cKwfED/lkRlJtee0NeNdwCD4FteoSZBe89Tghlglwj0H4jKLYr6tdqrDNdEfFL
 EhB9ac88UFdwrzjCz6/xb1XvDLnlE3OIntHW9K71h0sNTYC3610feb0TScdDIsowdfR+MIi4b
 N7nsdrCtfr62Wy3DcoYFu8jV1YWOslSluaMKdlupIy2lEes6Io+TfKKeiCw0L1NHTgfm8m09M
 3Pszsv0viF0HdKyjHk33VoPybYm4UZsdasYmL27Wco45fcBupo2UhPAc/yEqBHsYcg4m/KtSj
 QlTd8gn1rxiLg4jCKxctyvzZIeh39MNPRfbGkiQ+tVcdR5hlAYPfsrZznh+6Ggh8L9goejahZ
 3NA5TKtcDO6EtqysMX6Cu1gKFrZnHA+0iasctTJnbMjrBjfB7cXFhdRc5zEQnbc2y7WBv0/PE
 FHnt9qvqHwLQJ+FzYx7RoSMrcjl0pm9Zq0tY/5s8PO7nF35L6mRkTJc7KinuX3zd03GRS4f2+
 bW3mYmDPrKoaiEUpZWcur5GznJyNduAQsCxUUgPWE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.24
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/11/2019 à 23:30, Philippe Mathieu-Daudé a écrit :
> On 11/2/19 10:42 PM, Laurent Vivier wrote:
>> Linux kernel 5.4 will introduce a new memory map for SWIM device.
>> (aee6bff1c325 ("m68k: mac: Revisit floppy disc controller base
>> addresses"))
>>
>> Until this release all MMIO are mapped between 0x50f00000 and 0x50f40000,
>> but it appears that for real hardware 0x50f00000 is not the base address:
>> the MMIO region spans 0x50000000 through 0x60000000, and 0x50040000
>> through
>> 0x54000000 is repeated images of 0x50000000 to 0x50040000.
>>
>> Fixed: 04e7ca8d0f ("hw/m68k: define Macintosh Quadra 800")
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>
>> Notes:
>>      v2: add some constant definitions
>>          allocate a bloc of memory to stores all I/O MemoryRegion
>>
>>   hw/m68k/q800.c | 40 ++++++++++++++++++++++++++++++++--------
>>   1 file changed, 32 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
>> index 2b4842f8c6..822bd13d36 100644
>> --- a/hw/m68k/q800.c
>> +++ b/hw/m68k/q800.c
>> @@ -60,14 +60,19 @@
>>   #define MACH_MAC        3
>>   #define Q800_MAC_CPU_ID 2
>>   -#define VIA_BASE              0x50f00000
>> -#define SONIC_PROM_BASE       0x50f08000
>> -#define SONIC_BASE            0x50f0a000
>> -#define SCC_BASE              0x50f0c020
>> -#define ESP_BASE              0x50f10000
>> -#define ESP_PDMA              0x50f10100
>> -#define ASC_BASE              0x50F14000
>> -#define SWIM_BASE             0x50F1E000
>> +#define IO_BASE               0x50000000
>> +#define IO_SLICE              0x00040000
>> +#define IO_SIZE               0x04000000
>> +
>> +#define VIA_BASE              (IO_BASE + 0x00000)
> 
> Good idea.
> 
>> +#define SONIC_PROM_BASE       (IO_BASE + 0x08000)
>> +#define SONIC_BASE            (IO_BASE + 0x0a000)
>> +#define SCC_BASE              (IO_BASE + 0x0c020)
>> +#define ESP_BASE              (IO_BASE + 0x10000)
>> +#define ESP_PDMA              (IO_BASE + 0x10100)
>> +#define ASC_BASE              (IO_BASE + 0x14000)
>> +#define SWIM_BASE             (IO_BASE + 0x1E000)
>> +
>>   #define NUBUS_SUPER_SLOT_BASE 0x60000000
>>   #define NUBUS_SLOT_BASE       0xf0000000
>>   @@ -135,6 +140,9 @@ static void q800_init(MachineState *machine)
>>       int32_t initrd_size;
>>       MemoryRegion *rom;
>>       MemoryRegion *ram;
>> +    MemoryRegion *io;
>> +    const int io_slice_nb = (IO_SIZE / IO_SLICE) - 1;
>> +    int i;
>>       ram_addr_t ram_size = machine->ram_size;
>>       const char *kernel_filename = machine->kernel_filename;
>>       const char *initrd_filename = machine->initrd_filename;
>> @@ -163,10 +171,26 @@ static void q800_init(MachineState *machine)
>>       cpu = M68K_CPU(cpu_create(machine->cpu_type));
>>       qemu_register_reset(main_cpu_reset, cpu);
>>   +    /* RAM */
>>       ram = g_malloc(sizeof(*ram));
>>       memory_region_init_ram(ram, NULL, "m68k_mac.ram", ram_size,
>> &error_abort);
>>       memory_region_add_subregion(get_system_memory(), 0, ram);
>>   +    /*
>> +     * Memory from IO_BASE to IO_BASE + IO_SLICE is repeated
>> +     * from IO_BASE + IO_SLICE to IO_BASE + IO_SIZE
>> +     */
>> +    io = g_new(MemoryRegion, io_slice_nb);
>> +    for (i = 0; i < io_slice_nb; i++) {
>> +        char *name = g_strdup_printf("mac_m68k.io[%d]", i + 1);
>> +
>> +        memory_region_init_alias(io + i, NULL, name,
>> get_system_memory(),
> 
> We usually use &io[i], anyway:

ok, I'll update in this way before adding it to my pull request.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 

Thanks,
Laurent

