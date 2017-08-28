Received: from eggs.gnu.org ([2001:4830:134:3::10]:59409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dmSh2-0002Ks-0h
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 18:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dmSgy-0004eS-0t
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 18:39:40 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170828035327.17146-1-bobby.prani@gmail.com>
	<20170828035327.17146-3-bobby.prani@gmail.com>
	<03c05a60-d697-500b-c2fc-d99b24f3f64c@twiddle.net>
	<CAJhHMCC4Y0Zos+g4M6Rms+vO8cdZ+AOupciRFWTfnbFgpRs9jw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <45959c2a-94c3-7899-eaba-bf13ca85d052@twiddle.net>
Date: Mon, 28 Aug 2017 15:39:31 -0700
MIME-Version: 1.0
In-Reply-To: <CAJhHMCC4Y0Zos+g4M6Rms+vO8cdZ+AOupciRFWTfnbFgpRs9jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] mttcg: Implement implicit ordering
 semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, "open list:AArch64 target" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 08/28/2017 02:41 PM, Pranith Kumar wrote:
> On Mon, Aug 28, 2017 at 1:57 PM, Richard Henderson <rth@twiddle.net> wrote:
>> On 08/27/2017 08:53 PM, Pranith Kumar wrote:
>>> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
>>> index 55a46ac825..b41a248bee 100644
>>> --- a/tcg/aarch64/tcg-target.h
>>> +++ b/tcg/aarch64/tcg-target.h
>>> @@ -117,4 +117,6 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
>>>      __builtin___clear_cache((char *)start, (char *)stop);
>>>  }
>>>
>>> +#define TCG_TARGET_DEFAULT_MO (0)
>>> +
>>>  #endif /* AARCH64_TCG_TARGET_H */
>>
>> Please add all of these in one patch, separate from the tcg-op.c changes.
>> We should also just make this mandatory and remove any related #ifdefs.
> 
> I tried looking up ordering semantics for architectures like ia64 and
> s390. It is not really clear. I think every arch but for x86 can be
> defined as weak, even though archs like sparc can also be configured
> as TSO. Is this right?

s390 has the same memory ordering as i386.

But you're right that the risc chips should generally be 0.

I'll try and figure out when sparc can use PSO (loosest for sparc < 8, and
modern niagara), but leave it 0 for now.


r~
