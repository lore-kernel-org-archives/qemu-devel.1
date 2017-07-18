Received: from eggs.gnu.org ([2001:4830:134:3::10]:57797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQUU-0003jE-3b
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQUP-0001Li-Cr
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:16:34 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:32895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQUP-0001LE-6M
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:16:29 -0400
Received: by mail-wr0-x22c.google.com with SMTP id a10so24615684wrd.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 04:16:29 -0700 (PDT)
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-27-f4bug@amsat.org>
	<CAJ+F1C+WsdUp3Vtx+-FZ9g7URSAQuJWb6h7-w6yJXM+4TKQNjA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAJ+F1C+WsdUp3Vtx+-FZ9g7URSAQuJWb6h7-w6yJXM+4TKQNjA@mail.gmail.com>
Date: Tue, 18 Jul 2017 12:16:25 +0100
Message-ID: <87bmoi806u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 26/29] tests/tcg: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu trival <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>


Marc-André Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Jul 17, 2017 at 11:10 PM, Philippe Mathieu-Daudé
> <f4bug@amsat.org> wrote:
>> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/tcg/alpha/test-cond.c | 2 +-
>>  tests/tcg/alpha/test-ovf.c  | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>
> I think those do not include osdep.h
>
> (sigh, tests/tcg would need some love ;)

Pranith has had a couple of revs at this:

  Subject: [PATCH v5 00/19] Cleanup of TCG tests
  Date: Thu,  1 Dec 2016 00:14:14 -0500
  Message-Id: <20161201051433.17168-1-bobby.prani@gmail.com>

We have the cross-compilers available as a fallback via docker although
not every one can seamlessly use it for building stuff. Is getting a
working cross-compiler setup too much of a hurdle fore those that want
to build cross-arch tests?

>
>> diff --git a/tests/tcg/alpha/test-cond.c b/tests/tcg/alpha/test-cond.c
>> index 74adffaa69..e5596f10b8 100644
>> --- a/tests/tcg/alpha/test-cond.c
>> +++ b/tests/tcg/alpha/test-cond.c
>> @@ -77,7 +77,7 @@ int main (void)
>>  {
>>    int i;
>>
>> -  for (i = 0; i < sizeof (vectors)/sizeof(vectors[0]); i++)
>> +  for (i = 0; i < ARRAY_SIZE(vectors); i++)
>>      if ((*vectors[i].func)(vectors[i].v) != vectors[i].r) {
>>        write(1, "Failed\n", 7);
>>        return 1;
>> diff --git a/tests/tcg/alpha/test-ovf.c b/tests/tcg/alpha/test-ovf.c
>> index 01c80e7525..43fc6ebb2e 100644
>> --- a/tests/tcg/alpha/test-ovf.c
>> +++ b/tests/tcg/alpha/test-ovf.c
>> @@ -20,7 +20,7 @@ int main (void)
>>  {
>>    int i;
>>
>> -  for (i = 0; i < sizeof (vectors)/sizeof(vectors[0]); i++)
>> +  for (i = 0; i < ARRAY_SIZE(vectors); i++)
>>      if ((*vectors[i].func)(vectors[i].a, vectors[i].b) != vectors[i].r) {
>>        write(1, "Failed\n", 7);
>>      }
>> --
>> 2.13.2
>>
>>


--
Alex Bennée
