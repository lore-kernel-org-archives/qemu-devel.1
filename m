Received: from eggs.gnu.org ([2001:4830:134:3::10]:55422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTXGe-0000tp-Fd
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTXGd-0000lj-OP
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:42:12 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865801156.17063.15618379976159104550.stgit@frigg.lan>
	<244b5aab-8863-3139-f252-09cc02333eda@twiddle.net>
	<87inj4ebqn.fsf@frigg.lan>
	<c35a41d9-4c9d-3daf-2759-17a784b8711b@twiddle.net>
	<87a84gcfv6.fsf@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9611b022-c352-0191-67f6-716b36c8f1e6@twiddle.net>
Date: Fri, 7 Jul 2017 07:41:49 -1000
MIME-Version: 1.0
In-Reply-To: <87a84gcfv6.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 24/29] target/arm: [tcg,
 a64] Port to translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/07/2017 07:32 AM, Lluís Vilanova wrote:
>> That said, even for AArch32 we know by the TB flags whether or not we're going
>> to be generating arm or thumb code.  I think that these hooks will allow arm and
>> thumb mode to finally be split apart cleanly, instead of the tangle that they
>> are now.
>> 
>> I see arm's gen_intermediate_code eventually looking like
>> 
>>    const TranslatorOps *ops = &arm_translator_ops;
>>    if (ARM_TBFLAG_THUMB(tb->flags)) {
>>      ops = &thumb_translator_ops;
>>    }
>> #ifdef TARGET_AARCH64
>>    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
>>      ops = &aarch64_translator_ops;
>>    }
>> #endif
>>    translator_loop(ops, &dc.base, cpu, tb);
> 
>> There would certainly be some amount of shared code, but it would also allow
>> quite a few of the existing dc->thumb checks to be eliminated.
> 
> Does this really need to be addressed on this series?

No.  It is quite a tangle and it'll take some time to rectify.

>> I suppose you can leave the two hooks separate for now.  It doesn't hurt, and
>> it's kind of a reminder of things that need cleaning up.
> 
> Well, I've sent a (too rushed) v12 that features the merge. Since I'll have to
> send a v13, I can split them again if you want.

Don't go to any extra trouble if no one else has any strong feelings.

> I can restore the NULL approach or add a default empty hook implementation
> (translator_ignored_op?) if there's a strong feeling to change it.

Ok, we can work that out.


r~
