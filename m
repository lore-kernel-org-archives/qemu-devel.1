Received: from eggs.gnu.org ([2001:4830:134:3::10]:54874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX9zv-0008Kw-Mf
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX9zs-0002q6-JC
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:07:39 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX9zs-0002pR-D3
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 12:07:36 -0500
Received: by mail-wm0-x22f.google.com with SMTP id c206so148709849wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 09:07:36 -0800 (PST)
References: <20170127103505.18606-1-alex.bennee@linaro.org>
	<20170127103505.18606-26-alex.bennee@linaro.org>
	<CAJhHMCDAf8UqjO6m5RM3Hasdsf4_1FPnqibtRwYkips48tQCvw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAJhHMCDAf8UqjO6m5RM3Hasdsf4_1FPnqibtRwYkips48tQCvw@mail.gmail.com>
Date: Fri, 27 Jan 2017 17:07:33 +0000
Message-ID: <87k29g8m96.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v8 25/25] tcg: enable MTTCG by
 default for ARM on x86 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani+qemu@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>


Pranith Kumar <bobby.prani+qemu@gmail.com> writes:

> On Fri, Jan 27, 2017 at 5:35 AM, Alex Bennée <alex.bennee@linaro.org> wrote:
>
>> diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
>> index 21d96ec35c..536190f647 100644
>> --- a/tcg/i386/tcg-target.h
>> +++ b/tcg/i386/tcg-target.h
>> @@ -165,4 +165,20 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
>>  {
>>  }
>>
>> +/* This defines the natural memory order supported by this
>> + * architecture before guarantees made by various barrier
>> + * instructions.
>> + *
>> + * The x86 has a pretty strong memory ordering which only really
>> + * allows for some stores to be re-ordered after loads.
>> + */
>> +#include "tcg-mo.h"
>> +
>> +static inline int get_tcg_target_mo(void)
>> +{
>> +    return TCG_MO_ALL & ~TCG_MO_LD_ST;
>> +}
>> +
>
> s/TCG_MO_LD_ST/TCG_MO_ST_LD/?

Doh - sorry I missed that. Will fix this time ;-)

>
> Thanks,


--
Alex Bennée
