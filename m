Received: from eggs.gnu.org ([2001:4830:134:3::10]:57119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLIQ-0004Bb-TE
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLIL-0000Ve-6m
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:21:22 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:42551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLIL-0000Ur-2J
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:21:17 -0400
Received: by mail-vk0-x243.google.com with SMTP id g6so13931239vkb.9
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 07:21:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-29-alex.bennee@linaro.org>
	<040568a9-908c-be0b-be87-657220a93f04@amsat.org>
	<87k1svllqc.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <74eb3163-332d-e4df-f3a6-8acd7aeb4a66@amsat.org>
Date: Wed, 25 Apr 2018 11:21:03 -0300
MIME-Version: 1.0
In-Reply-To: <87k1svllqc.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On 04/25/2018 05:43 AM, Alex Bennée wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>> On 04/24/2018 12:23 PM, Alex Bennée wrote:
>>> Nothing much here yet.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  tests/tcg/aarch64/Makefile.target | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>  create mode 100644 tests/tcg/aarch64/Makefile.target
>>>
>>> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
>>> new file mode 100644
>>> index 0000000000..4ac8fbe73f
>>> --- /dev/null
>>> +++ b/tests/tcg/aarch64/Makefile.target
>>> @@ -0,0 +1,5 @@
>>> +# -*- Mode: makefile -*-
>>> +#
>>> +# AArch64 specific tweaks
>>> +
>>> +fcvt: LDFLAGS+=-lm
>>>
>>
>> You missed tests/tcg/aarch64/Makefile.include with:
>>
>> DOCKER_IMAGE=debian-arm64-cross
>> DOCKER_CROSS_COMPILER=aarch64-linux-gnueabi-gcc

Err this is not gnueabi, the correct line is:

DOCKER_CROSS_COMPILER=aarch64-linux-gnu-gcc

> 
> Doh.. of course I was testing with my cross-compiler and forgot about
> this ;-)
