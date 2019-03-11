Received: from eggs.gnu.org ([209.51.188.92]:47739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3J4K-00061P-3E
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3Ixd-0004up-TS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:19:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h3Ixd-0004u6-MV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:19:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id o9so4607985wrv.9
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 04:19:13 -0700 (PDT)
References: <20190311005618.19007-1-philmd@redhat.com>
	<20190311005618.19007-4-philmd@redhat.com>
	<bbd425da-0cb9-40d6-5d24-7ef7e0dec097@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <17989bbc-08a3-1ec1-b1c7-5aefc032a29b@redhat.com>
Date: Mon, 11 Mar 2019 12:19:11 +0100
MIME-Version: 1.0
In-Reply-To: <bbd425da-0cb9-40d6-5d24-7ef7e0dec097@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/7] hw/mips: Express dependencies of
 the r4k platform with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: James Hogan <jhogan@kernel.org>, Yang Zhong <yang.zhong@intel.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 3/11/19 7:58 AM, Thomas Huth wrote:
> On 11/03/2019 01.56, Philippe Mathieu-Daudé wrote:
>> This platform use standard PC devices connected to an ISA bus.
>> Networking is provided by a ne2000 chipset.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> v3: remove CONFIG_NE2000_ISA (Thomas)
>>     add PFLASH_CFI01
>> ---
>>  default-configs/mips-softmmu-common.mak |  1 -
>>  hw/mips/Kconfig                         | 11 +++++++++++
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
>> index caebafd416..2ca57bfee1 100644
>> --- a/default-configs/mips-softmmu-common.mak
>> +++ b/default-configs/mips-softmmu-common.mak
>> @@ -24,7 +24,6 @@ CONFIG_I8257=y
>>  CONFIG_PIIX4=y
>>  CONFIG_IDE_ISA=y
>>  CONFIG_IDE_PIIX=y
>> -CONFIG_NE2000_ISA=y
>>  CONFIG_PFLASH_CFI01=y
>>  CONFIG_I8259=y
>>  CONFIG_MC146818RTC=y
>> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
>> index ab006477c7..5678c9cf15 100644
>> --- a/hw/mips/Kconfig
>> +++ b/hw/mips/Kconfig
>> @@ -1,5 +1,16 @@
>>  config R4K
>>      bool
>> +    select ISA_BUS
>> +    select SERIAL_ISA
>> +    select I8259
>> +    select I8254
>> +    select MC146818RTC
>> +    select VGA_ISA
>> +    select NE2000_ISA
> 
> Since Paolo now also introduced the "imply" keyword, I think you should
> use "imply" instead of "select" for both, VGA_ISA and NE2000_ISA, since
> the r4k machine can work without both when you specify -vga none and
> -net none.

OK I'll use "imply", thanks.

> 
>  Thomas
> 
