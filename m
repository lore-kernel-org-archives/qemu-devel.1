Received: from eggs.gnu.org ([2001:4830:134:3::10]:40668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz5pb-0004Eg-Kh
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz5pa-00012m-VM
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:52:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-11-f4bug@amsat.org>
	<f5f9272f-e425-6a09-8571-a4454977100e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <13c0af58-7c9e-c0b5-a1c2-62e638146b34@amsat.org>
Date: Mon, 2 Oct 2017 15:52:33 -0300
MIME-Version: 1.0
In-Reply-To: <f5f9272f-e425-6a09-8571-a4454977100e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 33/34] hw/alpha: remove old i386 dependency
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Hi Thomas,

On 09/25/2017 02:38 AM, Thomas Huth wrote:
> On 22.09.2017 18:01, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/alpha/alpha_sys.h | 2 --
>>   hw/alpha/pci.c       | 2 ++
>>   hw/alpha/typhoon.c   | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
>> index b6d8369ed7..ac685c1c46 100644
>> --- a/hw/alpha/alpha_sys.h
>> +++ b/hw/alpha/alpha_sys.h
>> @@ -5,8 +5,6 @@
>>   
>>   #include "target/alpha/cpu-qom.h"
>>   #include "hw/pci/pci.h"
>> -#include "hw/pci/pci_host.h"
>> -#include "hw/ide.h"
>>   #include "hw/i386/pc.h"
> 
> Didn't you want to remove that pc.h line according to the patch description?

Not yet :( This include is still needed for the i8259 PIC. This change 
is done in the part 2 (following series).

That said, I should improve the patch description :)
