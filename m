Received: from eggs.gnu.org ([2001:4830:134:3::10]:49271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emUpK-0003Pz-BD
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 20:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emUpJ-0000uC-9p
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 20:28:38 -0500
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:39240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emUpJ-0000tw-4u
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 20:28:37 -0500
Received: by mail-yw0-x244.google.com with SMTP id v196so1053233ywc.6
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 17:28:37 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <3edd5d86-1c7c-1a32-4203-5ea4c432ad1f@amsat.org>
References: <20180204222356.14546-1-richard.henderson@linaro.org>
	<20180204222356.14546-3-richard.henderson@linaro.org>
	<3edd5d86-1c7c-1a32-4203-5ea4c432ad1f@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 22:28:35 -0300
Message-ID: <CAAdtpL6x5QsdBLeCc8Vk8+pKCZm5ZeWe3bdfWKgqw-oz+ExskA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 2/3] tests: Enable boot-serial-test for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Feb 15, 2018 at 8:55 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 02/04/2018 07:23 PM, Richard Henderson wrote:
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  tests/boot-serial-test.c | 1 +
>>  tests/Makefile.include   | 2 ++
>>  2 files changed, 3 insertions(+)
>>
>> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
>> index 418c5b92dc..ea87a80be7 100644
>> --- a/tests/boot-serial-test.c
>> +++ b/tests/boot-serial-test.c
>> @@ -87,6 +87,7 @@ static testdef_t tests[] =3D {
>>        sizeof(kernel_plml605), kernel_plml605 },
>>      { "moxie", "moxiesim", "", "TT", sizeof(bios_moxiesim), 0, bios_mox=
iesim },
>>      { "arm", "raspi2", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
>> +    { "hppa", "hppa", "", "SeaBIOS wants SYSTEM HALT" },
>>
>>      { NULL }
>>  };
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index ca82e0c0cc..83def6994c 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -299,6 +299,8 @@ gcov-files-x86_64-y =3D $(subst i386-softmmu/,x86_64=
-softmmu/,$(gcov-files-i386-y)
>>
>>  check-qtest-alpha-y =3D tests/boot-serial-test$(EXESUF)
>>
>> +check-qtest-hppa-y =3D tests/boot-serial-test$(EXESUF)
>> +
>>  check-qtest-m68k-y =3D tests/boot-serial-test$(EXESUF)
>>
>>  check-qtest-microblaze-y =3D tests/boot-serial-test$(EXESUF)
>>
>
> I got this failure in 2 different branches:
>
>   GTESTER check-qtest-hppa
> **
> ERROR:tests/boot-serial-test.c:137:check_guest_output: assertion failed:
> (output_ok)
> GTester: last random seed: R02S55e7df877597841c1b3b62962e410123
> make: *** [check-qtest-hppa] Error 1
> make: *** Waiting for unfinished jobs....
>
> https://travis-ci.org/philmd/qemu/jobs/341959060

which is not always reproducible... rebuilding this job worked.

>   "compiler": "gcc",
>   "env": "CONFIG=3D\"--disable-linux-user\"",
>   "dist": "trusty",
>   "os": "linux"
>
> https://travis-ci.org/philmd/qemu/jobs/341979253
>   "compiler": "gcc",
>   "env": "CONFIG=3D\"--with-coroutine=3Ducontext --disable-linux-user\"",
>   "dist": "trusty",
>   "os": "linux"
