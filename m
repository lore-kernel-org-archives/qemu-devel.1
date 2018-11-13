Received: from eggs.gnu.org ([2001:4830:134:3::10]:58465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMdE9-0003hp-21
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMd1g-00084D-Fo
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:03:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMd1g-00083g-8z
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:03:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id f10-v6so12869906wme.3
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 10:03:00 -0800 (PST)
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-3-sameo@linux.intel.com>
	<CAFEAcA-R51dyV7gtS+q-eLNn5LBJbSMKtQu4-N3p0c4mJrU8DA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <37b5f17e-50cd-6980-2d42-4e7f4ede2597@redhat.com>
Date: Tue, 13 Nov 2018 19:02:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-R51dyV7gtS+q-eLNn5LBJbSMKtQu4-N3p0c4mJrU8DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/13] target: arm: Remove unused headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On 13/11/18 18:01, Peter Maydell wrote:
> On 13 November 2018 at 16:52, Samuel Ortiz <sameo@linux.intel.com> wrote:
>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Reviewed-by: Robert Bradford <robert.bradford@intel.com>
>> Reviewed-by: Samuel Ortiz <sameo@linux.intel.com>
>> ---
>>   target/arm/helper.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 3d4e9c5c8a..27d9285e1e 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -12,13 +12,10 @@
>>   #include "internals.h"
>>   #include "exec/gdbstub.h"
>>   #include "exec/helper-proto.h"
>> -#include "qemu/host-utils.h"
> 
> This is for muldiv64().

But it is already included by "cpu.h" -> "exec/cpu-defs.h"

> 
>>   #include "sysemu/arch_init.h"
>>   #include "sysemu/sysemu.h"
>> -#include "qemu/bitops.h"

"cpu.h" -> "cpu-qom.h" -> "qom/cpu.h" -> "qemu/bitmap.h"

> 
> This is for extract32() and friends.
> 
>>   #include "qemu/crc32c.h"
>>   #include "exec/exec-all.h"
>> -#include "exec/cpu_ldst.h"
> 
> This is for cpu_stl_data().

Included by "arm_ldst.h"

> 
>>   #include "arm_ldst.h"
>>   #include <zlib.h> /* For crc32 */
>>   #include "exec/semihost.h"

So they are not "unused" but "unnecessary".

I thought this would be better to clean this once, before Samuel split.

Samuel: please drop this patch from your series.

Thanks,

Phil.
