Received: from eggs.gnu.org ([2001:4830:134:3::10]:52229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dkfcP-00034h-Ht
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dkfcO-0003x1-OB
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:03:29 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:34016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1dkfcO-0003wp-KG
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:03:28 -0400
Received: by mail-vk0-x243.google.com with SMTP id t126so448687vkb.1
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 17:03:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d76e1ae7-4fdd-4e21-4355-0be96142bce3@amsat.org>
References: <20170823192244.18914-1-anatol.pomozov@gmail.com>
	<d76e1ae7-4fdd-4e21-4355-0be96142bce3@amsat.org>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Wed, 23 Aug 2017 17:03:27 -0700
Message-ID: <CAOMFOmXrRWg4n3mmRmKGy7ekL=7p7YyP3EJ9GGToTOnh2e=X_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] multiboot: make tests work with clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed, Aug 23, 2017 at 4:44 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Hi Anatol,
>
> On 08/23/2017 04:22 PM, Anatol Pomozov wrote:
>>
>>   * explicitly disable SSE as clang enables it by default for 32bit code
>>   * add memset() implementation. Clang complains that the function is
>>     absent, gcc seems provides default built-in.
>> ---
>>   tests/multiboot/Makefile | 2 +-
>>   tests/multiboot/libc.c   | 9 +++++++++
>>   tests/multiboot/libc.h   | 2 ++
>>   3 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/multiboot/Makefile b/tests/multiboot/Makefile
>> index 856e76682a..7fadbca33a 100644
>> --- a/tests/multiboot/Makefile
>> +++ b/tests/multiboot/Makefile
>> @@ -1,5 +1,5 @@
>>   CC=3Dgcc
>> -CCFLAGS=3D-m32 -Wall -Wextra -Werror -fno-stack-protector -nostdinc
>> -fno-builtin
>> +CCFLAGS=3D-m32 -Wall -Wextra -Werror -fno-stack-protector -nostdinc
>> -fno-builtin -mno-sse
>
>
> What about using -march=3Di586 instead? so no need to disable each next
> features clang decide to default enable.
>
> Even cleaner IMHO, use -march=3Dpentium in CFLAGS and add "-cpu pentium" =
in
> run_test.sh so we are sure the generated code matches, what do you think?

It sounds reasonable. Just sent an updated patch. Works with gcc 6.3
and clang 3.8.
