Received: from eggs.gnu.org ([2001:4830:134:3::10]:33958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clgTg-0002QT-UM
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clgTd-0002Zx-Qa
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:38:24 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170308181833.32110-1-mreitz@redhat.com>
	<e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0ff7c286-72d8-d1c6-053a-26b6af7376b6@amsat.org>
Date: Wed, 8 Mar 2017 15:38:16 -0300
MIME-Version: 1.0
In-Reply-To: <e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] block/archipelago: Make it compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Chrysostomos Nanakos <chris@include.gr>

On 03/08/2017 03:25 PM, Eric Blake wrote:
> On 03/08/2017 12:18 PM, Max Reitz wrote:
>> In order to use error_setg() and similar functions, we need to include
>> qapi/error.h.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/archipelago.c | 1 +
>>  1 file changed, 1 insertion(+)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>
> Does this mean our automated buildbots aren't building archipelago by
> default?
>
>>
>> diff --git a/block/archipelago.c b/block/archipelago.c
>> index 2449cfc702..01c4ff2f7d 100644
>> --- a/block/archipelago.c
>> +++ b/block/archipelago.c
>> @@ -55,6 +55,7 @@
>>  #include "block/block_int.h"
>>  #include "qemu/error-report.h"
>>  #include "qemu/thread.h"
>> +#include "qapi/error.h"
>>  #include "qapi/qmp/qint.h"
>>  #include "qapi/qmp/qstring.h"
>>  #include "qapi/qmp/qjson.h"
>>
>
