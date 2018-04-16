Received: from eggs.gnu.org ([2001:4830:134:3::10]:57566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f7zxY-0003mJ-Uw
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f7zxW-0000eY-Ar
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:58:01 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f7zxW-0000dr-4V
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:57:58 -0400
Received: by mail-wr0-x243.google.com with SMTP id u46so23679762wrc.11
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 01:57:57 -0700 (PDT)
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-13-alex.bennee@linaro.org>
	<8223b521-7b6f-4399-19a1-12f6971cd9c7@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8223b521-7b6f-4399-19a1-12f6971cd9c7@amsat.org>
Date: Mon, 16 Apr 2018 09:57:55 +0100
Message-ID: <87a7u3bka4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 12/24] tests/tcg/i386: Build fix for
 hello-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, famz@redhat.com, cota@braap.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Fam, Alex,
>
> On 04/10/2018 04:39 PM, Alex Benn=C3=A9e wrote:
>> From: Fam Zheng <famz@redhat.com>
>>=20
>> We have -Werror=3Dmissing-prototype, add a dummy prototype to avoid that
>> warning.
>>=20
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>>  tests/tcg/i386/hello-i386.c | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/tests/tcg/i386/hello-i386.c b/tests/tcg/i386/hello-i386.c
>> index fa00380de2..cfeb24b2f5 100644
>> --- a/tests/tcg/i386/hello-i386.c
>> +++ b/tests/tcg/i386/hello-i386.c
>> @@ -20,6 +20,7 @@ static inline int write(int fd, const char * buf, int =
len)
>>    return status;
>>  }
>>=20=20
>> +void _start(void);
>
> What about adding that in a common base file include by all tcg tests?
> Such tests/tcg/include/tcg-common.h or better name...

For this I don't think it makes much sense. Not all linux-user tests are
quite so bare bones...

>
>>  void _start(void)
>>  {
>>      write(1, "Hello World\n", 12);
>>=20


--=20
Alex Benn=C3=A9e
