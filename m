Received: from eggs.gnu.org ([209.51.188.92]:58887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIhFT-0003Mu-Sf
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIhFQ-0006qs-It
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:17:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIhFP-0006qC-SB
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:17:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id o12so14137157wrn.2
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 15:17:11 -0700 (PDT)
References: <20190422210448.2488-1-ehabkost@redhat.com>
	<20190422210448.2488-2-ehabkost@redhat.com>
	<edbaa0c1-d7ae-11a7-2ada-e3c5f4ca7c8a@redhat.com>
	<20190422220814.GA25134@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <37c1d38f-06b6-fb8e-2cc1-c4094ae05931@redhat.com>
Date: Tue, 23 Apr 2019 00:17:08 +0200
MIME-Version: 1.0
In-Reply-To: <20190422220814.GA25134@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qtest: Move accel code to accel/qtest.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 4/23/19 12:08 AM, Eduardo Habkost wrote:
> On Mon, Apr 22, 2019 at 11:56:18PM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Eduardo,
>>
>> On 4/22/19 11:04 PM, Eduardo Habkost wrote:
>>> QTest has two parts: the server (-qtest) and the accelerator
>>> (-machine accel=qtest).  The accelerator depends on CONFIG_POSIX
>>> due to its usage of sigwait(), but the server doesn't.
>>>
>>> Move the accel code to accel/qtest.c.  Later we will disable
>>> compilation of accel/qtest.c on non-POSIX systems.
>>>
> [...]
>>> +#include "qemu/module.h"
>>
>> Why include "qemu/module.h"?
>> I guess you don't need it.
> 
> That's where the type_init() macro is defined.

Oh correct...

I tried to remove it/compile and it worked because it is pulled by:

"sysemu/cpus.h"
 -> "qemu/timer.h"
     -> "qemu-common.h"
         -> "qemu/module.h"

Thanks!

>>> +type_init(qtest_type_init);
> [...]
> 
> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Thanks!
> 
