Received: from eggs.gnu.org ([2001:4830:134:3::10]:51206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dmRol-0007ZM-Pc
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 17:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dmRok-00044r-Vz
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 17:43:35 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:34294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dmRok-00044l-Ry
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 17:43:34 -0400
Received: by mail-io0-x244.google.com with SMTP id d81so836095ioj.1
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 14:43:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8f6169d2-107c-ef7b-cc6f-1ad40a25365f@linaro.org>
References: <20170828035327.17146-1-bobby.prani@gmail.com>
	<20170828035327.17146-2-bobby.prani@gmail.com>
	<8f6169d2-107c-ef7b-cc6f-1ad40a25365f@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 28 Aug 2017 17:43:03 -0400
Message-ID: <CAJhHMCD-Ti84xKXh=7TCTgDKQ5YhvRtVAqfpO_iVXrU+RjfF1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] cpus-common: Cache allocated work
 items
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Sergey Fedorov <serge.fdrv@gmail.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On Mon, Aug 28, 2017 at 1:47 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 08/27/2017 08:53 PM, Pranith Kumar wrote:
>> Using heaptrack, I found that quite a few of our temporary allocations
>> are coming from allocating work items. Instead of doing this
>> continously, we can cache the allocated items and reuse them instead
>> of freeing them.
>>
>> This reduces the number of allocations by 25% (200000 -> 150000 for
>> ARM64 boot+shutdown test).
>>
>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>
> Why does this list need to record a "last" element?
> It would seem a simple lifo would be sufficient.
>
> (You would also be able to manage the list via cmpxchg without a separate lock,
> but perhaps the difference between the two isn't measurable.)
>

Yes, seems like a better design choice. Will fix in next iteration.

Thanks,
-- 
Pranith
