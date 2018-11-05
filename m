Received: from eggs.gnu.org ([2001:4830:134:3::10]:50305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gJf9U-0006Hp-Mo
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gJete-0001fY-5G
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:26:27 -0500
References: <1539944335-19556-1-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-MD7aE1phES3RPEH2mk5USfKv0j1tGtbrOnid3hLQmXw@mail.gmail.com>
	<CAHmQWvDfvOJcEdco7xx+g9oTG9=Vmor9CE+p8dpg+ou5zK7Skw@mail.gmail.com>
	<CAHmQWvAb7pyKY92=q0cKbJpZtAtr9upb0CEEezgBQkd1Li9Z3Q@mail.gmail.com>
	<CAHmQWvBqUaEGdRt+QVJkq=D8_wc=aVNqiGbrTr=X4yAH4Cvkgw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5f1373d9-7f43-a481-3f12-44ed0ff2e311@redhat.com>
Date: Mon, 5 Nov 2018 14:26:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAHmQWvBqUaEGdRt+QVJkq=D8_wc=aVNqiGbrTr=X4yAH4Cvkgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: remove unused header files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Hongbo,

On 10/23/18 12:21 PM, Hongbo Zhang wrote:
> Well, after checking manually, the header files
> "hw/arm/primecell.h"
> "qapi/visitor.h"
> "hw/arm/smmuv3.h"
> are really not used in virt.c, still can be removed.
> 
> On 22 October 2018 at 18:17, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>> On 22 October 2018 at 09:37, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>>> On 19 October 2018 at 19:59, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>> On 19 October 2018 at 11:18, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>>>>> Remove the unused herder files, 'virt' can be compiled and run without
>>>>> including them.
>>>>>
>>>>> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
>>>>> ---
>>>>>  hw/arm/virt.c | 8 --------
>>>>>  1 file changed, 8 deletions(-)
>>>>>
>>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>>>> index 9f67782..f0066cb 100644
>>>>> --- a/hw/arm/virt.c
>>>>> +++ b/hw/arm/virt.c
>>>>> @@ -30,9 +30,6 @@
>>>>>
>>>>>  #include "qemu/osdep.h"
>>>>>  #include "qapi/error.h"
>>>>> -#include "hw/sysbus.h"
>>>>> -#include "hw/arm/arm.h"
>>>>> -#include "hw/arm/primecell.h"
>>>>
>>>> Dropping primecell.h makes sense, we don't use what it provides.
>>>> But I suspect the others are "unused" only because some other
>>>> header we include drags them in implicitly. I think it's better
>>>> to explicitly include what we need, in case that other header
>>>> changes in future.
>>>>
>> I think at least another "hw/arm/smmuv3.h" can be removed too, even if
>> we want to explicit including.
Yes I think you can safely remove this one.

Thanks

Eric
>> Will check others one by one.
>>
>>>> How did you determine which #includes to drop here?
>>>>
>>> Well, while I was working on the 'sbsa-ref' machine, I believed I
>>> could remove some header files because I deleted some functions for
>>> that platform, so I did.
>>> And later, I thought I can try to test to remove part of what I did
>>> for 'sbsa-ref' for 'virt' too, tests showed me that 'virt'  can be
>>> compiled and run without them.
>>>
>>>> thanks
>>>> -- PMM
> 
