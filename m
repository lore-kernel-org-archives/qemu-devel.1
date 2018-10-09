Received: from eggs.gnu.org ([2001:4830:134:3::10]:33810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9uyZ-0006f0-V1
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9uyX-0003fp-5r
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:35:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:39275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9uyV-0003f3-Hl
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:35:12 -0400
Received: by mail-wm1-x333.google.com with SMTP id y144-v6so2678856wmd.4
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 09:35:11 -0700 (PDT)
References: <20181009145933.18925-1-alex.bennee@linaro.org>
	<20181009145933.18925-4-alex.bennee@linaro.org>
	<5bf2d666-d93b-1154-660c-3eab32350b8e@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <5bf2d666-d93b-1154-660c-3eab32350b8e@redhat.com>
Date: Tue, 09 Oct 2018 17:35:08 +0100
Message-ID: <878t37m62r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tests/tcg: disable enterN insn
 tests for test-i386 with clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, f4bug@amsat.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 09/10/2018 16:59, Alex Benn=C3=A9e wrote:
>> The enter[qwl] instructions aren't supported by clang's inline
>> assembler. Apply the hammer to work around it when we re-use our
>> system compiler to build tcg tests.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Do you have a bug for this in llvm?  It doesn't seem to be a good
> idea.

I thought I had an llvm bugzilla login but I can't find the details.
I'll have to a wait until an admin can add me.

>
> Paolo
>
>> ---
>>  tests/tcg/i386/test-i386.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
>> index c5f67000e4..da632c9b67 100644
>> --- a/tests/tcg/i386/test-i386.c
>> +++ b/tests/tcg/i386/test-i386.c
>> @@ -2098,6 +2098,7 @@ long enter_stack[4096];
>>
>>  static void test_enter(void)
>>  {
>> +#if !(defined __clang__)
>>  #if defined(__x86_64__)
>>      TEST_ENTER("q", uint64_t, 0);
>>      TEST_ENTER("q", uint64_t, 1);
>> @@ -2114,6 +2115,7 @@ static void test_enter(void)
>>      TEST_ENTER("w", uint16_t, 1);
>>      TEST_ENTER("w", uint16_t, 2);
>>      TEST_ENTER("w", uint16_t, 31);
>> +#endif
>>  }
>>
>>  #ifdef TEST_SSE
>>


--
Alex Benn=C3=A9e
