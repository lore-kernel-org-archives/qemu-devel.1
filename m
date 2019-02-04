Received: from eggs.gnu.org ([209.51.188.92]:60478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqkfF-000512-Ln
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqkfC-000766-0M
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:16:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqkfB-00074v-Qb
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:16:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so1334755wmc.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 12:16:17 -0800 (PST)
References: <20190203220744.11734-1-philmd@redhat.com>
	<20190203220744.11734-7-philmd@redhat.com>
	<d6594582-7fea-0c8a-e2a9-7ff90c0c55dc@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <204d006e-269f-63ce-87fb-93f542d4f595@redhat.com>
Date: Mon, 4 Feb 2019 21:16:13 +0100
MIME-Version: 1.0
In-Reply-To: <d6594582-7fea-0c8a-e2a9-7ff90c0c55dc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/6] mips: Express dependencies of the
 Loongson 2E machine with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Huacai Chen <zltjiangshi@gmail.com>
Cc: Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi Thomas,

On 2/4/19 9:46 AM, Thomas Huth wrote:
> On 2019-02-03 23:07, Philippe Mathieu-Daudé wrote:
>> The Loongson 2E uses a Bonito64 system controller as North Bridge and a
>> VT82C686 chipset as South Bridge. The network card chipset is a RTL8139D.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
> [...]
>> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
>> index 2940ff39ab..16b2bdb068 100644
>> --- a/hw/mips/Kconfig
>> +++ b/hw/mips/Kconfig
>> @@ -42,6 +42,11 @@ config JAZZ
>>  
>>  config FULONG
>>      bool
>> +    select PCI_BONITO
>> +    select VT82C686
>> +    select SMBUS_EEPROM
>> +    select RTL8139_PCI
> 
> If I've got the code right, the RTL8139 is optional for this board, i.e.
> when you run with -nodefaults or -net none, then the board is still
> usable. So this is not a hard requirement and thus I think it would be
> nicer to drop the "select RTL8139_PCI" and rely on the "default y if
> PCI_DEVICES" in the hw/net/Kconfig file.

I think since his introduction (051c190bce59) the code wants to deal
with no network backend, but the RTL8139D is always available.
On this picture you can se the chipset soldered on the back of the
board: https://www.linux-mips.org/wiki/Fulong#back
I'll keep the RTL8139_PCI selection and eventually propose a patch to
clean the hw/mips/mips_fulong2e.c.

Thanks for your other reviews!

Phil.
