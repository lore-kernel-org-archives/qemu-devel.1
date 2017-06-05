Received: from eggs.gnu.org ([2001:4830:134:3::10]:56386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHoIS-0007YH-J6
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHoIP-0007OL-DN
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:27:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHoIP-0007O5-7b
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:27:33 -0400
References: <20170418191817.10430-1-bobby.prani@gmail.com>
	<CAFEAcA-M6etMjBBY1GyDHA9AhM+O=1NWKRn6QwRsHhNgofYxPw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a13b0042-a7ae-739d-7a5f-6c3e94a5db39@redhat.com>
Date: Mon, 5 Jun 2017 11:27:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-M6etMjBBY1GyDHA9AhM+O=1NWKRn6QwRsHhNgofYxPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] timer.h: Provide better monotonic time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Pranith Kumar <bobby.prani@gmail.com>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>



On 02/06/2017 14:24, Peter Maydell wrote:
> On 18 April 2017 at 20:18, Pranith Kumar <bobby.prani@gmail.com> wrote:
>> Tested and confirmed that the stretch i386 debian qcow2 image on a
>> raspberry pi 2 works.
>>
>> Fixes: LP#: 893208 <https://bugs.launchpad.net/qemu/+bug/893208/>
>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>> ---
>>  include/qemu/timer.h | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
>> index 8a1eb74839..1b518bca30 100644
>> --- a/include/qemu/timer.h
>> +++ b/include/qemu/timer.h
>> @@ -1020,10 +1020,9 @@ static inline int64_t cpu_get_host_ticks(void)
>>  /* The host CPU doesn't have an easily accessible cycle counter.
>>     Just return a monotonically increasing value.  This will be
>>     totally wrong, but hopefully better than nothing.  */
>> -static inline int64_t cpu_get_host_ticks (void)
>> +static inline int64_t cpu_get_host_ticks(void)
>>  {
>> -    static int64_t ticks = 0;
>> -    return ticks++;
>> +    return get_clock();
>>  }
>>  #endif
> 
> Hmm, it looks like this patch got lost. Paolo, did you want to
> give it a reviewed-by? From the discussion on v1 it sounded
> like you had the best grip on the timer code ;-)

Sure:

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> (Does the comment on the function need updating ?)

Apart from "totally", it's still pretty correct. :)

Thanks,

Paolo
