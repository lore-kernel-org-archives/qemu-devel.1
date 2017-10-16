Received: from eggs.gnu.org ([2001:4830:134:3::10]:53766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e43mx-0005gj-Du
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e43ms-0008VZ-DF
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:42:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e43ms-0008Ud-78
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:42:26 -0400
From: Thomas Huth <thuth@redhat.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<e73e18c2d124841f63e026e9cbc026321f86aade.1506730372.git.alistair.francis@xilinx.com>
	<99067425-6b33-98f3-f671-6586fe049270@redhat.com>
Message-ID: <8c081174-3748-6041-c961-ea03b9e0cc5a@redhat.com>
Date: Mon, 16 Oct 2017 13:42:22 +0200
MIME-Version: 1.0
In-Reply-To: <99067425-6b33-98f3-f671-6586fe049270@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/47] hw/cris: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com

On 01.10.2017 16:13, Thomas Huth wrote:
> On 30.09.2017 02:15, Alistair Francis wrote:
>> Replace a large number of the fprintf(stderr, "*\n" calls with
>> error_report(). The functions were renamed with these commands and then
>> compiler issues where manually fixed.
> [...]
>> diff --git a/hw/cris/boot.c b/hw/cris/boot.c
>> index f896ed7f86..f199a13a82 100644
>> --- a/hw/cris/boot.c
>> +++ b/hw/cris/boot.c
>> @@ -23,6 +23,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>  #include "qemu-common.h"
>>  #include "cpu.h"
>>  #include "hw/hw.h"
>> @@ -86,14 +87,14 @@ void cris_load_image(CRISCPU *cpu, struct cris_load_info *li)
>>      }
>>  
>>      if (image_size < 0) {
>> -        fprintf(stderr, "qemu: could not load kernel '%s'\n",
>> +        error_report("qemu: could not load kernel '%s'",
>>                  li->image_filename);
> 
> Put it on one line, please.

... and remove the "qemu:" prefix, please.

 Thomas
