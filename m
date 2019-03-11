Received: from eggs.gnu.org ([209.51.188.92]:47855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3J4Q-000632-23
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3It5-0000eX-N5
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:14:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h3It5-0000dp-GT
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:14:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id f65so3989979wma.2
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 04:14:31 -0700 (PDT)
References: <20190310235351.1863-1-philmd@redhat.com>
	<20190310235351.1863-3-philmd@redhat.com>
	<cfb987fd-8190-c100-80b9-657c060eb20f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <57ccad1d-3e6a-6356-fbbd-c048e27988e0@redhat.com>
Date: Mon, 11 Mar 2019 12:14:28 +0100
MIME-Version: 1.0
In-Reply-To: <cfb987fd-8190-c100-80b9-657c060eb20f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/8] hw/input: Add 8042 PS/2 Keyboard
 Controller to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 3/11/19 7:47 AM, Thomas Huth wrote:
> On 11/03/2019 00.53, Philippe Mathieu-Daudé wrote:
>> The Intel 8042 chipset also includes some functions unrelated to
>> the keyboard, such the A20-Gate.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/input/Kconfig | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/input/Kconfig b/hw/input/Kconfig
>> index e2e66f0858..83e4546a28 100644
>> --- a/hw/input/Kconfig
>> +++ b/hw/input/Kconfig
>> @@ -10,6 +10,10 @@ config PCKBD
>>      default y
>>      depends on ISA_BUS
>>  
>> +config I8042
>> +    bool
>> +    select PCKBD
> 
> I fail to see why you need this config switch. There is a "select I8042"
> in a later patch, but that's it - you never use this switch to decide
> anything (like including a file in the Makefiles or toggle other
> switches), so this seems to be just a defunc switch to me. Or do I miss
> something?

The PIIX3 emulates a 8042 when the USB Legacy Support is enabled.

Oh now I see, I first understood the hw/input/pckbd.c file was
modeling the 8042 and other things, but no, it is simply it.

So please disregard this patch, I'll respin renaming PCKBD -> I8042.

Thanks!

Phil.
