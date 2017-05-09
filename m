Received: from eggs.gnu.org ([2001:4830:134:3::10]:36773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d88oM-0005wI-Pm
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d88oL-0003Xt-0S
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:20:33 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-4-f4bug@amsat.org>
	<2ad7eaf6-3691-f9f1-4d09-204444adbd19@redhat.com>
	<5b9ad5c0-0bcf-2167-57ba-446d1253cdd1@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bdc0fa6a-a90c-3f7a-a37c-bc901a6022c2@amsat.org>
Date: Tue, 9 May 2017 14:20:23 -0300
MIME-Version: 1.0
In-Reply-To: <5b9ad5c0-0bcf-2167-57ba-446d1253cdd1@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/11] hw/misc: add missing includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Hi Eric,

On 05/08/2017 09:56 PM, Philippe Mathieu-Daudé wrote:
> On 05/08/2017 08:56 PM, Eric Blake wrote:
>> On 05/08/2017 06:39 PM, Philippe Mathieu-Daudé wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  include/hw/misc/unimp.h | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
>>> index 3462d85836..353ee19abf 100644
>>> --- a/include/hw/misc/unimp.h
>>> +++ b/include/hw/misc/unimp.h
>>> @@ -8,6 +8,9 @@
>>>  #ifndef HW_MISC_UNIMP_H
>>>  #define HW_MISC_UNIMP_H
>>>
>>> +#include "qemu/osdep.h"
>>
>> NACK. .h files should not include osdep.h, because the .c file that is
>> using the .h file should have already done so.  This is mentioned in
>> HACKING.
>
> Ok! Indeed my .c doesn't include osdep.h, sorry for the noise.

I attentively read the HACKING after a good night's sleep.

What about the other include, "hw/sysbus.h"?
The inlined function create_unimplemented_device() calls 
sysbus_mmio_map_overlap(). Anyone willing to use "hw/misc/unimp.h" will 
get a compilation failure if he does not include "hw/sysbus.h" and I 
don't think it belongs to "qemu/osdep.h".

Regards,

Phil.
