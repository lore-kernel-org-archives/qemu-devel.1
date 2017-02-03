Received: from eggs.gnu.org ([2001:4830:134:3::10]:38960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cZgDE-00063I-Ue
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cZgDB-0003Qa-BE
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:55:49 -0500
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:34274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cZgDB-0003QL-4s
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:55:45 -0500
Received: by mail-yw0-x242.google.com with SMTP id v73so2048944ywg.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 07:55:44 -0800 (PST)
References: <20170125001041.14029-1-bobby.prani@gmail.com>
	<CAFEAcA-pdY6J_e035PGj5nxYrtN7V0SJMxMuaE0VECNJVKg5iQ@mail.gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
In-reply-to: <CAFEAcA-pdY6J_e035PGj5nxYrtN7V0SJMxMuaE0VECNJVKg5iQ@mail.gmail.com>
Date: Fri, 03 Feb 2017 10:55:42 -0500
Message-ID: <87y3xnp8u9.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH] linux-user: Add signal handling for
 x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Allan Wirth <awirth@akamai.com>, Laurent Vivier <lvivier@redhat.com>


Peter Maydell writes:

> On 25 January 2017 at 00:10, Pranith Kumar <bobby.prani@gmail.com> wrote:
>> Adopted from a previous patch posting:
>> https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg02079.html
>>
>> CC: Allan Wirth <awirth@akamai.com>
>> CC: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>
> Thanks for picking this patch up. A nit about commit message format:
> because this  is mostly Allan's work you need to add his signed-off-by:
> line (which he provided on his original patch posting), and make
> a brief not of what was changed, so it looks like:
>
>   Signed-off-by: Original Author <oa@example.com>
>   [OP: changed X, Y, Z]
>   Signed-off-by: Other Person <other@person.org>
>
> It's also in this kind of situation worth considering whether the
> patch would be better attributed to Allan as the git commit 'author'.
> If I've taken somebody else's work and made mostly minor overhauls
> to it I tend to go for giving them credit in the git commit log.

OK, I'll add these SOB lines and attribute it to Allan as he did most of the work.

>
>> ---
>>  linux-user/signal.c      | 264 ++++++++++++++++++++++++++++++++++++++++-------
>>  target/i386/cpu.h        |   2 +
>>  target/i386/fpu_helper.c |  12 +++
>>  3 files changed, 242 insertions(+), 36 deletions(-)
>>
>> diff --git a/linux-user/signal.c b/linux-user/signal.c
>> index 0a5bb4e26b..0248621d66 100644
>> --- a/linux-user/signal.c
>> +++ b/linux-user/signal.c
>> @@ -253,8 +253,7 @@ int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
>>      return 0;
>>  }
>>
>> -#if !defined(TARGET_OPENRISC) && !defined(TARGET_UNICORE32) && \
>> -    !defined(TARGET_X86_64)
>> +#if !defined(TARGET_OPENRISC) && !defined(TARGET_UNICORE32)
>>  /* Just set the guest's signal mask to the specified value; the
>>   * caller is assumed to have called block_signals() already.
>>   */
>
> There's a minor conflict here with the Nios2 code that's now
> in master (which added another clause to this #if), but it's
> trivial to resolve.

I'll rebase my patch on master and fix up the conflicts and send a v2.

>
> Otherwise:
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks for the review!
-- 
Pranith
