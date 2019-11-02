Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E63CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 18:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A9920862
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 18:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A9920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQxrr-0002MT-VT
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 14:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iQxoR-0007Ub-QG
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 14:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iQxoQ-0003q1-63
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 14:07:47 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36189)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iQxoP-0003lG-SQ
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 14:07:46 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N5FMB-1hz0pD0UMP-011EIX; Sat, 02 Nov 2019 19:07:38 +0100
Subject: Re: [RFC] q800: fix I/O memory map
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191031100341.3827-1-laurent@vivier.eu>
 <bf1a2cbf-f462-e6df-c7c1-1e2ad26003ad@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <76f6828d-bfd5-334c-770e-1283dc392b0e@vivier.eu>
Date: Sat, 2 Nov 2019 19:07:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <bf1a2cbf-f462-e6df-c7c1-1e2ad26003ad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LwD2bazgYpWyXMCBJGJuiAmB596ePM4KRabJyOc1Gzd8WkNM2r4
 UjoqlifHPC7t4mV35NPEVj0jCFScdoB2kTzEBrSF7c+lY7nHSSy3jAi2H+3YhlDIzU7l63I
 1AVF0WGtFhASYKSDlc82M/7tjyd9CZ8kyi9kuBT7rmn3kum7/V7BrOXDCqWWd7Nion4UT9s
 0ot6vkEfktc0bI3O6CpYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HhmzRRuTm/4=:qyo3QOZj/OezZi3zsQoUKL
 SdKwDzk79OpozSlvwpHsHkNsx+Zo1Z8WUdEUs2kPyTyX7LqnhXhEAiX2uXwrLAKFIbbZn9Xm4
 Yfz3QiKtTbsPkQKkn1gOjd4W3r7bE6IMdPT16JwE27JzAR9KseC4hp3uINrvtS8xunPg33NL8
 E+r3mwTJ4rBb3I6M3YTGWCZYt7JgxgtGzVjPpNNHV4njiKaA+ns6AcjZQNbR2e9dDkGXdl1o7
 ThJavSSTAuk3esgy6ZyG7whNjOq1H5DHBd7A5rmbRX527IYb/pW6ppIJxmo8RRRpVxFb7oBsG
 IP9+uAeOGHIz4X0GyckFip1smJDboULUrZ75pGX1dHKbpjpdqpKswRH2NcEolXR+sNvvthoEc
 46Klpe6DOgtQh7qsIZcajB5VeB0M8lBzL0M5eBFelgVTIZh+qMlkbNjkRuavJn0FfZbCYmYUz
 KZ0fmcRwhipX8c7S0Xjf9nCXyWUDadmNChrEZNAj7eXj+Wk3wG2r/+WjYCS81TAEU7j7WWALF
 c5HTskRbPJVnRETmg8KvxTjKKsWJIsT4OZegL25npD8/QC2ZyzQyq3wh6ndSnyITbbujSdQEp
 IlvxD4+eFpSKQHKg3btwgLZzGR5n/VfE48syIOV+LDU78fKkw2Ave9lGkWWDcSr8P156664nR
 D5JF9R6hmAs7CbxuKO46n9nG8+TtB2XqfzvPxGp1m3tWyTkunJ2nekz8BBbVuH01s3dNaVTUU
 FWWSR196pOEDh7tVzNaShwtibK8TfU4znpP2oIxHVTmMD/r0Vhh4n6zttVv7khSG0y2wkw2h9
 OxEtk1vQ+u8159qvgnE+0pCGtaIltzhcmQDPOAs+9rR1TJrk3lbqnY819L+s8rAkJGHEJzKmG
 ye2CEyuv8Hl3z/cfgu5kme/bczmnYKeFfq5PxGB3k=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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

Le 01/11/2019 à 01:00, Philippe Mathieu-Daudé a écrit :
> On 10/31/19 11:03 AM, Laurent Vivier wrote:
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
>>   hw/m68k/q800.c | 33 +++++++++++++++++++++++++--------
>>   1 file changed, 25 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
>> index 2b4842f8c6..8122e7c612 100644
>> --- a/hw/m68k/q800.c
>> +++ b/hw/m68k/q800.c
>> @@ -60,14 +60,14 @@
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
>> +#define VIA_BASE              0x50000000
>> +#define SONIC_PROM_BASE       0x50008000
>> +#define SONIC_BASE            0x5000a000
>> +#define SCC_BASE              0x5000c020
>> +#define ESP_BASE              0x50010000
>> +#define ESP_PDMA              0x50010100
>> +#define ASC_BASE              0x50014000
>> +#define SWIM_BASE             0x5001E000
>>   #define NUBUS_SUPER_SLOT_BASE 0x60000000
>>   #define NUBUS_SLOT_BASE       0xf0000000
>>   @@ -135,6 +135,7 @@ static void q800_init(MachineState *machine)
>>       int32_t initrd_size;
>>       MemoryRegion *rom;
>>       MemoryRegion *ram;
>> +    int i;
>>       ram_addr_t ram_size = machine->ram_size;
>>       const char *kernel_filename = machine->kernel_filename;
>>       const char *initrd_filename = machine->initrd_filename;
>> @@ -163,10 +164,26 @@ static void q800_init(MachineState *machine)
>>       cpu = M68K_CPU(cpu_create(machine->cpu_type));
>>       qemu_register_reset(main_cpu_reset, cpu);
>>   +    /* RAM */
>>       ram = g_malloc(sizeof(*ram));
>>       memory_region_init_ram(ram, NULL, "m68k_mac.ram", ram_size,
>> &error_abort);
>>       memory_region_add_subregion(get_system_memory(), 0, ram);
>>   +    /*
>> +     * Memory from VIA_BASE to VIA_BASE + 0x40000 is repeated
>> +     * from VIA_BASE + 0x40000 to VIA_BASE + 0x4000000
>> +     */
> 
> Maybe:
> 
>        const size_t via_aliases_count = (0x4000000 / 0x40000) - 1;

good idea.

>        MemoryRegion *via_alias = g_new(MemoryRegion, via_aliases_count);

do we really need to store them?
We will not reuse them or free them.

>        for (size_t i = 0; i < via_aliases_count; i++) {
> 
>            ...
> 
>            memory_region_add_subregion(get_system_memory(),
>                                        VIA_BASE + (i + 1) * 0x40000,
>                                        via_alias[i]);
>            ...
>        }
> 
>> +    for (i = 1; i < 256; i++) {
>> +        MemoryRegion *io = g_malloc(sizeof(*io));
>> +        char *name = g_strdup_printf("mac_m68k.io[%d]", i);
>> +
>> +        memory_region_init_alias(io, NULL, name, get_system_memory(),
>> +                                 VIA_BASE, 0x40000);
>> +        memory_region_add_subregion(get_system_memory(),
>> +                                    VIA_BASE + i * 0x40000, io);
>> +        g_free(name);
>> +    }
> 
> I'm trying to get ride of this pattern, so I plan to refactor this later
> (and will use 256*KiB). Anyway not this patch problem.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
>> +
>>       /* IRQ Glue */
>>         irq = g_new0(GLUEState, 1);
>>

Thanks,
Laurent

