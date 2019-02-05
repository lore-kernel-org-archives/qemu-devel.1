Received: from eggs.gnu.org ([209.51.188.92]:59695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqzap-0005K8-4y
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqzN8-000616-Am
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 06:58:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqzN4-0005uO-IR
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 06:58:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so3327973wmj.1
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 03:58:24 -0800 (PST)
References: <20190204202609.26956-1-philmd@redhat.com>
	<20190204202609.26956-4-philmd@redhat.com>
	<22042877-e949-9afc-4ee9-98d4a87f1bf1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5aceca6a-02c8-2e8d-f6a3-97cb5bac6b18@redhat.com>
Date: Tue, 5 Feb 2019 12:58:21 +0100
MIME-Version: 1.0
In-Reply-To: <22042877-e949-9afc-4ee9-98d4a87f1bf1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/6] mips: Express dependencies of the
 r4k platform with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>

On 2/5/19 5:11 AM, Thomas Huth wrote:
> On 2019-02-04 21:26, Philippe Mathieu-Daudé wrote:
>> This platform use standard PC devices connected to an ISA bus.
>> Networking is provided by a ne2000 chipset.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/mips/Kconfig | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
>> index ab006477c7..ee6290d497 100644
>> --- a/hw/mips/Kconfig
>> +++ b/hw/mips/Kconfig
>> @@ -1,5 +1,15 @@
>>  config R4K
>>      bool
>> +    select ISA_BUS
>> +    select SERIAL_ISA
>> +    select I8259
>> +    select I8254
>> +    select MC146818RTC
>> +    select VGA_ISA
>> +    select NE2000_ISA
>> +    select IDE_ISA
>> +    # I8042
>> +    select PCKBD
> 
> I think you can now also remove "CONFIG_NE2000_ISA=y" from
> default-configs/mips-softmmu-common.mak.

Correct!

Thanks,

Phil.
