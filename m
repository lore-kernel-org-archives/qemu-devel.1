Received: from eggs.gnu.org ([2001:4830:134:3::10]:51339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1e1aPL-0000ZL-Rg
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1e1aPL-0007Ky-4T
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:55:55 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_3vf8=0VhZVWX=1RQBqshvWNgHn=LrUw8BBtkUtDig0Q@mail.gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-16-andrew.smirnov@gmail.com>
	<CAFEAcA_3vf8=0VhZVWX=1RQBqshvWNgHn=LrUw8BBtkUtDig0Q@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 9 Oct 2017 08:55:51 -0700
Message-ID: <CAHQ1cqEJ6OJHL+gTAtXnNJPKUhu3mbYkMWWC=95fOxK9_VFMWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 15/17] include/qemu: Add sizes.h from Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Fri, Oct 6, 2017 at 7:13 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 18 September 2017 at 20:50, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>> Add sizes.h from Linux to have a more readable way of specifying
>> MemoryRegion sizes.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  include/qemu/sizes.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>>  create mode 100644 include/qemu/sizes.h
>>
>> diff --git a/include/qemu/sizes.h b/include/qemu/sizes.h
>> new file mode 100644
>> index 0000000000..9aedb9f8f6
>> --- /dev/null
>> +++ b/include/qemu/sizes.h
>> @@ -0,0 +1,47 @@
>> +/*
>> + * Copy of include/linux/sizes.h
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>
> Not really convinced of the utility, and it's gpl-2-only, so no thanks.
>

OK, will drop in v2.

Thanks,
Andrey Smironv
