Received: from eggs.gnu.org ([2001:4830:134:3::10]:53069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIbz0-0003Vf-DK
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIbyz-0005ZP-77
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:30:50 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIbyy-0005Yu-VQ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:30:49 -0400
Received: by mail-wm0-x236.google.com with SMTP id 7so119690459wmo.1
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 07:30:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a13b0042-a7ae-739d-7a5f-6c3e94a5db39@redhat.com>
References: <20170418191817.10430-1-bobby.prani@gmail.com>
	<CAFEAcA-M6etMjBBY1GyDHA9AhM+O=1NWKRn6QwRsHhNgofYxPw@mail.gmail.com>
	<a13b0042-a7ae-739d-7a5f-6c3e94a5db39@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2017 15:30:27 +0100
Message-ID: <CAFEAcA_Fnv=yg3cpz1o=Tor4apc7_a3Y6SoJW1WfFM6uJqYQUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] timer.h: Provide better monotonic time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 5 June 2017 at 10:27, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 02/06/2017 14:24, Peter Maydell wrote:
>> On 18 April 2017 at 20:18, Pranith Kumar <bobby.prani@gmail.com> wrote:
>>> Tested and confirmed that the stretch i386 debian qcow2 image on a
>>> raspberry pi 2 works.
>>>
>>> Fixes: LP#: 893208 <https://bugs.launchpad.net/qemu/+bug/893208/>
>>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>>> ---
>>>  include/qemu/timer.h | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
>>> index 8a1eb74839..1b518bca30 100644
>>> --- a/include/qemu/timer.h
>>> +++ b/include/qemu/timer.h
>>> @@ -1020,10 +1020,9 @@ static inline int64_t cpu_get_host_ticks(void)
>>>  /* The host CPU doesn't have an easily accessible cycle counter.
>>>     Just return a monotonically increasing value.  This will be
>>>     totally wrong, but hopefully better than nothing.  */
>>> -static inline int64_t cpu_get_host_ticks (void)
>>> +static inline int64_t cpu_get_host_ticks(void)
>>>  {
>>> -    static int64_t ticks = 0;
>>> -    return ticks++;
>>> +    return get_clock();
>>>  }
>>>  #endif
>>
>> Hmm, it looks like this patch got lost. Paolo, did you want to
>> give it a reviewed-by? From the discussion on v1 it sounded
>> like you had the best grip on the timer code ;-)
>
> Sure:
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>
>> (Does the comment on the function need updating ?)
>
> Apart from "totally", it's still pretty correct. :)

Thanks. I'll apply this to my arm queue since in practice only
ARM hosts are affected by this change.

-- PMM
