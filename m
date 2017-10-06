Received: from eggs.gnu.org ([2001:4830:134:3::10]:46600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0Rir-0000fl-0k
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0Rim-0005GO-4R
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:27:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-11-f4bug@amsat.org>
	<CAFXwXrnnvn0MStu=bPvtTVJbE7TXX-j9t6qaKGeqQTL7OnCwBg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3ed2a5a2-e30f-d139-d5bf-e145a8480787@amsat.org>
Date: Fri, 6 Oct 2017 09:27:11 -0300
MIME-Version: 1.0
In-Reply-To: <CAFXwXrnnvn0MStu=bPvtTVJbE7TXX-j9t6qaKGeqQTL7OnCwBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 33/34] hw/alpha: remove old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-trivial@nongnu.org, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 10/02/2017 04:03 PM, Richard Henderson wrote:
> 2017-09-22 12:01 GMT-04:00 Philippe Mathieu-Daudé <f4bug@amsat.org>:
> 
>> diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
>> index b6d8369ed7..ac685c1c46 100644
>> --- a/hw/alpha/alpha_sys.h
>> +++ b/hw/alpha/alpha_sys.h
>> @@ -5,8 +5,6 @@
>>
>>  #include "target/alpha/cpu-qom.h"
>>  #include "hw/pci/pci.h"
>> -#include "hw/pci/pci_host.h"
>> -#include "hw/ide.h"
>>
> 
> Why are you deleting pci/pci_host.h here?

Indeed it is required since PCIBus is defined there.

> Alternately, why are you leaving pci/pci.h?
> 
> 
>> diff --git a/hw/alpha/pci.c b/hw/alpha/pci.c
>> index 8dde637bfe..c370762ea6 100644
>> --- a/hw/alpha/pci.c
>> +++ b/hw/alpha/pci.c
>> @@ -8,6 +8,8 @@
>>
>>  #include "qemu/osdep.h"
>>  #include "qemu-common.h"
>> +#include "hw/pci/pci.h"
>> +#include "hw/pci/pci_host.h"
>>
> 
> One way we have a double-include of pci/pci.h here,
> the other way we shouldn't re-include either.

Please ignore this patch.
