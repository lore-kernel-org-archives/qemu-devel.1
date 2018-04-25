Received: from eggs.gnu.org ([2001:4830:134:3::10]:55618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBG1i-0000F9-AM
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBG1e-0006dG-Ao
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:43:46 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fBG1e-0006cV-49
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:43:42 -0400
Received: by mail-wm0-x243.google.com with SMTP id i3so5319825wmf.3
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 01:43:41 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-29-alex.bennee@linaro.org>
	<040568a9-908c-be0b-be87-657220a93f04@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <040568a9-908c-be0b-be87-657220a93f04@amsat.org>
Date: Wed, 25 Apr 2018 09:43:39 +0100
Message-ID: <87k1svllqc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 28/46] tests/tcg/aarch64: add
 Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 04/24/2018 12:23 PM, Alex Benn=C3=A9e wrote:
>> Nothing much here yet.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/aarch64/Makefile.target | 5 +++++
>>  1 file changed, 5 insertions(+)
>>  create mode 100644 tests/tcg/aarch64/Makefile.target
>>
>> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makef=
ile.target
>> new file mode 100644
>> index 0000000000..4ac8fbe73f
>> --- /dev/null
>> +++ b/tests/tcg/aarch64/Makefile.target
>> @@ -0,0 +1,5 @@
>> +# -*- Mode: makefile -*-
>> +#
>> +# AArch64 specific tweaks
>> +
>> +fcvt: LDFLAGS+=3D-lm
>>
>
> You missed tests/tcg/aarch64/Makefile.include with:
>
> DOCKER_IMAGE=3Ddebian-arm64-cross
> DOCKER_CROSS_COMPILER=3Daarch64-linux-gnueabi-gcc

Doh.. of course I was testing with my cross-compiler and forgot about
this ;-)



--
Alex Benn=C3=A9e
