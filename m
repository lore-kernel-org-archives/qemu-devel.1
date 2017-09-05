Received: from eggs.gnu.org ([2001:4830:134:3::10]:49660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpAGI-0003tY-0S
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpAGD-00034k-9b
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:35:14 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:32779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpAGD-00031o-4w
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:35:09 -0400
Received: by mail-qk0-x243.google.com with SMTP id p12so1773256qkl.0
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 02:35:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-4-f4bug@amsat.org>
	<2ad7eaf6-3691-f9f1-4d09-204444adbd19@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4aa4042a-1fa5-958e-6bc9-5666c5e56d3a@amsat.org>
Date: Tue, 5 Sep 2017 06:35:04 -0300
MIME-Version: 1.0
In-Reply-To: <2ad7eaf6-3691-f9f1-4d09-204444adbd19@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

On 05/08/2017 08:56 PM, Eric Blake wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   include/hw/misc/unimp.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
>> index 3462d85836..353ee19abf 100644
>> --- a/include/hw/misc/unimp.h
>> +++ b/include/hw/misc/unimp.h
>> @@ -8,6 +8,9 @@
>>   #ifndef HW_MISC_UNIMP_H
>>   #define HW_MISC_UNIMP_H
>>   
>> +#include "qemu/osdep.h"
> 
> NACK. .h files should not include osdep.h, because the .c file that is
> using the .h file should have already done so.  This is mentioned in
> HACKING.

I'm not sure this kind of mistake happens often enough, but it might 
worth add a such test in checkpatch.pl (easier to say than to implement :p)
