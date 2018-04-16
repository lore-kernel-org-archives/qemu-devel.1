Received: from eggs.gnu.org ([2001:4830:134:3::10]:37312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f8122-0007MY-LU
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f811z-0004B9-ER
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:06:42 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180415234307.28132-1-f4bug@amsat.org>
	<20180415234307.28132-2-f4bug@amsat.org>
	<a2d59a3a-0176-6065-68ae-60fee97c2332@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <50f40271-11e2-96df-a2f1-58f373cfc656@amsat.org>
Date: Mon, 16 Apr 2018 07:06:34 -0300
MIME-Version: 1.0
In-Reply-To: <a2d59a3a-0176-6065-68ae-60fee97c2332@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 01/41] hw: Clean "hw/devices.h" includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org

Hi Thomas,

On 04/16/2018 01:53 AM, Thomas Huth wrote:
> On 16.04.2018 01:42, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/hw/devices.h | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/hw/devices.h b/include/hw/devices.h
>> index 861ddea8af..0e27feb0c2 100644
>> --- a/include/hw/devices.h
>> +++ b/include/hw/devices.h
>> @@ -1,13 +1,10 @@
>>  #ifndef QEMU_DEVICES_H
>>  #define QEMU_DEVICES_H
>>  
>> -#include "hw/irq.h"
>> -
>> -/* ??? Not all users of this file can include cpu-common.h.  */
>> -struct MemoryRegion;
>> -
>>  /* Devices that have nowhere better to go.  */
>>  
>> +#include "hw/hw.h"
>> +
>>  /* smc91c111.c */
>>  void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
> 
> IMHO we should rather get rid of devices.h (in a separate patch series)
> and introduce proper small headers à la smc91c111.h for the single
> sections in here... Just my 0.02 €.

Yes, the idea is to QOM'ify those devices and drop this file.
