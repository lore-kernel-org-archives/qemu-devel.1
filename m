Received: from eggs.gnu.org ([2001:4830:134:3::10]:47646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1Ki-00055E-UL
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1Ki-0001I4-3j
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:37:36 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:33979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1Kh-0001Ht-VA
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:37:36 -0400
Received: by mail-it0-x243.google.com with SMTP id t78so24306ita.1
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 14:37:35 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <95ac9aa9-5969-674b-929a-095cc75f52c3@amsat.org>
References: <20170802201512.29142-1-crosa@redhat.com>
	<20170802201512.29142-4-crosa@redhat.com>
	<95ac9aa9-5969-674b-929a-095cc75f52c3@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 2 Aug 2017 18:37:33 -0300
Message-ID: <CAAdtpL7i7H75e-gER5Q8UgV3ExuazqcG-0VjA4M2LjnZB_xB9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] tests/tcg/linux-test.c: include
 definitions for getrusage()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Aug 2, 2017 at 6:28 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Hi Cleber,
>
> On 08/02/2017 05:15 PM, Cleber Rosa wrote:
>>
>> A include for <sys/resources.h> is missing, and prevents
>> tests/tcg/linux-test from compiling.
>
>
> getrusage() I presume, don't know if worth adding in commit message.

Sorry I missed it from the commit subject :/

>
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>
>> ---
>>   tests/tcg/linux-test.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/tcg/linux-test.c b/tests/tcg/linux-test.c
>> index 1c6c013..15c9d7f 100644
>> --- a/tests/tcg/linux-test.c
>> +++ b/tests/tcg/linux-test.c
>> @@ -39,6 +39,7 @@
>>   #include <dirent.h>
>>   #include <setjmp.h>
>>   #include <sys/shm.h>
>> +#include <sys/resource.h>
>>     #define TESTPATH "/tmp/linux-test.tmp"
>>   #define TESTPORT 7654
>>
>
