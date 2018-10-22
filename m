Received: from eggs.gnu.org ([2001:4830:134:3::10]:36479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gEPHC-00009Y-Q7
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 21:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gEPA9-0007Gd-4G
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 21:37:46 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:33053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1gEPA8-0007G2-OQ
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 21:37:45 -0400
Received: by mail-yb1-xb42.google.com with SMTP id m184-v6so4427710ybm.0
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 18:37:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-MD7aE1phES3RPEH2mk5USfKv0j1tGtbrOnid3hLQmXw@mail.gmail.com>
References: <1539944335-19556-1-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-MD7aE1phES3RPEH2mk5USfKv0j1tGtbrOnid3hLQmXw@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Mon, 22 Oct 2018 09:37:42 +0800
Message-ID: <CAHmQWvDfvOJcEdco7xx+g9oTG9=Vmor9CE+p8dpg+ou5zK7Skw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 19 October 2018 at 19:59, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 19 October 2018 at 11:18, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>> Remove the unused herder files, 'virt' can be compiled and run without
>> including them.
>>
>> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
>> ---
>>  hw/arm/virt.c | 8 --------
>>  1 file changed, 8 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 9f67782..f0066cb 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -30,9 +30,6 @@
>>
>>  #include "qemu/osdep.h"
>>  #include "qapi/error.h"
>> -#include "hw/sysbus.h"
>> -#include "hw/arm/arm.h"
>> -#include "hw/arm/primecell.h"
>
> Dropping primecell.h makes sense, we don't use what it provides.
> But I suspect the others are "unused" only because some other
> header we include drags them in implicitly. I think it's better
> to explicitly include what we need, in case that other header
> changes in future.
>
> How did you determine which #includes to drop here?
>
Well, while I was working on the 'sbsa-ref' machine, I believed I
could remove some header files because I deleted some functions for
that platform, so I did.
And later, I thought I can try to test to remove part of what I did
for 'sbsa-ref' for 'virt' too, tests showed me that 'virt'  can be
compiled and run without them.

> thanks
> -- PMM
