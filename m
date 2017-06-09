Received: from eggs.gnu.org ([2001:4830:134:3::10]:54233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJRSu-0005ud-JW
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 17:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJRSt-0000Gg-Oi
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 17:29:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-7-f4bug@amsat.org>
	<79598bed-714f-7c3b-a806-3bf1a4968fd2@msgid.tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <da9abd44-1f8b-2c1c-e63a-3ca706c95865@amsat.org>
Date: Fri, 9 Jun 2017 18:28:56 -0300
MIME-Version: 1.0
In-Reply-To: <79598bed-714f-7c3b-a806-3bf1a4968fd2@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/11] hw/arm: removed unnecessary include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

On 05/23/2017 11:58 AM, Michael Tokarev wrote:
> 09.05.2017 02:39, Philippe Mathieu-Daudé wrote:
>> "exec/memory.h" already includes it.
>
> I think this sort of include cleanups isn't really necessary.

Some are useful ;)

> For a regular include file, it's better to include it if the
> .c file in question uses definitions from there, no matter if
> other .h files include that header already or not.

Ok. This one was incorrect anyway :( thank for the review!

>
> Thanks,
>
> /mjt
>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/hw/arm/arm.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
>> index a3f79d3379..b9c11d3fb8 100644
>> --- a/include/hw/arm/arm.h
>> +++ b/include/hw/arm/arm.h
>> @@ -14,7 +14,6 @@
>>  #include "exec/memory.h"
>>  #include "target/arm/cpu-qom.h"
>>  #include "hw/irq.h"
>> -#include "qemu/notify.h"
>>
>>  typedef enum {
>>      ARM_ENDIANNESS_UNKNOWN = 0,
>>
>
