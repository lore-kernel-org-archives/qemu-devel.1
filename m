Received: from eggs.gnu.org ([2001:4830:134:3::10]:36281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7tSD-00083r-5n
	for qemu-devel@nongnu.org; Mon, 08 May 2017 20:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7tSC-0003Ot-9m
	for qemu-devel@nongnu.org; Mon, 08 May 2017 20:56:41 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-4-f4bug@amsat.org>
	<2ad7eaf6-3691-f9f1-4d09-204444adbd19@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5b9ad5c0-0bcf-2167-57ba-446d1253cdd1@amsat.org>
Date: Mon, 8 May 2017 21:56:32 -0300
MIME-Version: 1.0
In-Reply-To: <2ad7eaf6-3691-f9f1-4d09-204444adbd19@redhat.com>
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

On 05/08/2017 08:56 PM, Eric Blake wrote:
> On 05/08/2017 06:39 PM, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/hw/misc/unimp.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
>> index 3462d85836..353ee19abf 100644
>> --- a/include/hw/misc/unimp.h
>> +++ b/include/hw/misc/unimp.h
>> @@ -8,6 +8,9 @@
>>  #ifndef HW_MISC_UNIMP_H
>>  #define HW_MISC_UNIMP_H
>>
>> +#include "qemu/osdep.h"
>
> NACK. .h files should not include osdep.h, because the .c file that is
> using the .h file should have already done so.  This is mentioned in
> HACKING.

Ok! Indeed my .c doesn't include osdep.h, sorry for the noise.
