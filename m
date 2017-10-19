Received: from eggs.gnu.org ([2001:4830:134:3::10]:58847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e5GnL-00006k-8P
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e5GnK-0002qW-DW
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:47:55 -0400
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<7f741376b50552aa58c943b710fffa3c24f28b2f.1508390588.git.alistair.francis@xilinx.com>
	<51df0812-0119-412e-6017-935a6c226e3a@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <86f645a2-3640-be98-acff-c37cdaa1d66f@weilnetz.de>
Date: Thu, 19 Oct 2017 21:47:44 +0200
MIME-Version: 1.0
In-Reply-To: <51df0812-0119-412e-6017-935a6c226e3a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 42/46] util: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, alistair23@gmail.com

Am 19.10.2017 um 19:53 schrieb Thomas Huth:
> On 19.10.2017 18:18, Alistair Francis wrote:
>> Replace a large number of the fprintf(stderr, "*\n" calls with
>> error_report(). The functions were renamed with these commands and then
>> compiler issues where manually fixed.
> [...]
>> diff --git a/util/aio-posix.c b/util/aio-posix.c
>> index 5946ac09f0..29fff51fcf 100644
>> --- a/util/aio-posix.c
>> +++ b/util/aio-posix.c
>> @@ -15,6 +15,7 @@
>>  
>>  #include "qemu/osdep.h"
>>  #include "qemu-common.h"
>> +#include "qemu/error-report.h"
>>  #include "block/block.h"
>>  #include "qemu/rcu_queue.h"
>>  #include "qemu/sockets.h"
>> @@ -703,8 +704,8 @@ void aio_context_setup(AioContext *ctx)
>>  {
>>      /* TODO remove this in final patch submission */
>>      if (getenv("QEMU_AIO_POLL_MAX_NS")) {
>> -        fprintf(stderr, "The QEMU_AIO_POLL_MAX_NS environment variable has "
>> -                "been replaced with -object iothread,poll-max-ns=NUM\n");
>> +        error_report("The QEMU_AIO_POLL_MAX_NS environment variable has "
>> +                "been replaced with -object iothread,poll-max-ns=NUM");
>>          exit(1);
>>      }
> 
> The comment in front of this code block indicates that this should
> rather be removed completely. Stefan, do you agree?


I assume you asked the other Stefan, but I think he'll agree as I do,
because it is obvious that such random debug code does not belong
into the QEMU code base.

Stefan
