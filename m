Received: from eggs.gnu.org ([2001:4830:134:3::10]:39347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gJyk2-0005iq-1F
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gJyZI-0002jF-W1
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:26:46 -0500
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:37021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1gJyZI-0002dO-Ol
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:26:44 -0500
Received: by mail-yw1-xc44.google.com with SMTP id v77-v6so4931564ywc.4
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 02:26:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5f1373d9-7f43-a481-3f12-44ed0ff2e311@redhat.com>
References: <1539944335-19556-1-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-MD7aE1phES3RPEH2mk5USfKv0j1tGtbrOnid3hLQmXw@mail.gmail.com>
	<CAHmQWvDfvOJcEdco7xx+g9oTG9=Vmor9CE+p8dpg+ou5zK7Skw@mail.gmail.com>
	<CAHmQWvAb7pyKY92=q0cKbJpZtAtr9upb0CEEezgBQkd1Li9Z3Q@mail.gmail.com>
	<CAHmQWvBqUaEGdRt+QVJkq=D8_wc=aVNqiGbrTr=X4yAH4Cvkgw@mail.gmail.com>
	<5f1373d9-7f43-a481-3f12-44ed0ff2e311@redhat.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Tue, 6 Nov 2018 18:26:42 +0800
Message-ID: <CAHmQWvCKA8N=iFPrYRbCR=Vt879SAwZhufNNnsdsKHxdW7sqVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: remove unused header files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 5 November 2018 at 21:26, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Hongbo,
>
> On 10/23/18 12:21 PM, Hongbo Zhang wrote:
>> Well, after checking manually, the header files
>> "hw/arm/primecell.h"
>> "qapi/visitor.h"
>> "hw/arm/smmuv3.h"
>> are really not used in virt.c, still can be removed.
>>
>> On 22 October 2018 at 18:17, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>>> On 22 October 2018 at 09:37, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>>>> On 19 October 2018 at 19:59, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>> On 19 October 2018 at 11:18, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>>>>>> Remove the unused herder files, 'virt' can be compiled and run without
>>>>>> including them.
>>>>>>
>>>>>> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
>>>>>> ---
>>>>>>  hw/arm/virt.c | 8 --------
>>>>>>  1 file changed, 8 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>>>>> index 9f67782..f0066cb 100644
>>>>>> --- a/hw/arm/virt.c
>>>>>> +++ b/hw/arm/virt.c
>>>>>> @@ -30,9 +30,6 @@
>>>>>>
>>>>>>  #include "qemu/osdep.h"
>>>>>>  #include "qapi/error.h"
>>>>>> -#include "hw/sysbus.h"
>>>>>> -#include "hw/arm/arm.h"
>>>>>> -#include "hw/arm/primecell.h"
>>>>>
>>>>> Dropping primecell.h makes sense, we don't use what it provides.
>>>>> But I suspect the others are "unused" only because some other
>>>>> header we include drags them in implicitly. I think it's better
>>>>> to explicitly include what we need, in case that other header
>>>>> changes in future.
>>>>>
>>> I think at least another "hw/arm/smmuv3.h" can be removed too, even if
>>> we want to explicit including.
> Yes I think you can safely remove this one.
>
Thanks.

As my summary, I think these three can be removed,
"hw/arm/primecell.h"
"qapi/visitor.h"
"hw/arm/smmuv3.h"
Peter confirmed the first, Auger confirmed the third, anybody has
comments for the second? so that I can send out a v2 for this.

> Thanks
>
> Eric
>>> Will check others one by one.
>>>
>>>>> How did you determine which #includes to drop here?
>>>>>
>>>> Well, while I was working on the 'sbsa-ref' machine, I believed I
>>>> could remove some header files because I deleted some functions for
>>>> that platform, so I did.
>>>> And later, I thought I can try to test to remove part of what I did
>>>> for 'sbsa-ref' for 'virt' too, tests showed me that 'virt'  can be
>>>> compiled and run without them.
>>>>
>>>>> thanks
>>>>> -- PMM
>>
