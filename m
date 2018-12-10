Received: from eggs.gnu.org ([2001:4830:134:3::10]:51553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gWRRr-0002Sh-20
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gWRRq-0007JF-9e
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:42:34 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <03506cf0-a204-f619-8ee4-4990a5e69af5@cea.fr>
	<CAAdtpL5BdqUvHpVTpKuJ6R+yEHGi7U6T9rUK2PbL3nwC7F_3jA@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <271fd922-943a-f092-d714-697320e9ea21@twiddle.net>
Date: Mon, 10 Dec 2018 13:42:24 -0600
MIME-Version: 1.0
In-Reply-To: <CAAdtpL5BdqUvHpVTpKuJ6R+yEHGi7U6T9rUK2PbL3nwC7F_3jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] Fixes i386 xchgq test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, fabrice.desclaux@cea.fr, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, camille.mougey@cea.fr

On 12/10/18 1:26 PM, Philippe Mathieu-Daudé wrote:
> Hi Fabrice,
> 
> On Fri, Dec 7, 2018 at 5:06 PM <fabrice.desclaux@cea.fr> wrote:
>>
>> As "xchg" reads and writes both operands, the "+m" is required to avoid
>> undefined behavior on -O2 compilation.
>>
>> Signed-off-by: Fabrice Desclaux <fabrice.desclaux@cea.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


>> ---
>>   tests/tcg/i386/test-i386.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
>> index a29b41e764..18d5609665 100644
>> --- a/tests/tcg/i386/test-i386.c
>> +++ b/tests/tcg/i386/test-i386.c
>> @@ -1137,7 +1137,7 @@ void test_xchg(void)
>>       TEST_XCHG(xchgb, "b", "+q");
>>
>>   #if defined(__x86_64__)
>> -    TEST_XCHG(xchgq, "", "=m");
>> +    TEST_XCHG(xchgq, "", "+m");
>>   #endif
>>       TEST_XCHG(xchgl, "k", "+m");
>>       TEST_XCHG(xchgw, "w", "+m");
>> --
>> 2.19.2
> 
> All QEMU patches has to go via the qemu-devel@nongnu.org list (you
> only sent it to the trivial list).
> I'm also Cc'ing the maintainers:

Thanks, Phil.


r~
