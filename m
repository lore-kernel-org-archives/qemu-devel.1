Received: from eggs.gnu.org ([2001:4830:134:3::10]:45822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f81Ga-0005Ba-EC
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f81GV-0004ZO-LA
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:21:44 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f81GV-0004Z0-GQ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:21:39 -0400
Received: by mail-qt0-x244.google.com with SMTP id a25so8383416qtm.1
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 03:21:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-20-alex.bennee@linaro.org>
	<b6411179-a33b-e504-1073-c98a8d4a38ae@amsat.org>
	<87bmejbkct.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <73805d57-3c77-eba2-c65b-00be8b3dddfe@amsat.org>
Date: Mon, 16 Apr 2018 07:21:35 -0300
MIME-Version: 1.0
In-Reply-To: <87bmejbkct.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 19/24] tests/tcg: move MIPS specific
 tests into subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, famz@redhat.com, Yongbok Kim <yongbok.kim@mips.com>, cota@braap.org, Aurelien Jarno <aurelien@aurel32.net>

On 04/16/2018 05:56 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> On 04/10/2018 04:39 PM, Alex Bennée wrote:
>>> These only need to be built for MIPS guests.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  tests/tcg/README                  | 11 -----------
>>>  tests/tcg/mips/README             |  7 +++++++
>>>  tests/tcg/{ => mips}/hello-mips.c |  0
>>>  3 files changed, 7 insertions(+), 11 deletions(-)
>>>  create mode 100644 tests/tcg/mips/README
>>>  rename tests/tcg/{ => mips}/hello-mips.c (100%)
>>>
>>> diff --git a/tests/tcg/README b/tests/tcg/README
>>> index 625f2326e6..a5643d33e7 100644
>>> --- a/tests/tcg/README
>>> +++ b/tests/tcg/README
>>> @@ -3,17 +3,6 @@ regression testing. Tests are either multi-arch, meaning they can be
>>>  built for all guest architectures that support linux-user executable,
>>>  or they are architecture specific.
>>>  
>>> -
>>> -
>>> -MIPS
>>> -====
>>> -
>>> -hello-mips
>>> -----------
>>> -
>>> -hello-mipsel
>>> -------------
>>> -
>>>  CRIS
>>>  ====
>>>  The testsuite for CRIS is in tests/tcg/cris.  You can run it
>>> diff --git a/tests/tcg/mips/README b/tests/tcg/mips/README
>>> new file mode 100644
>>> index 0000000000..e5bbc58ec5
>>> --- /dev/null
>>> +++ b/tests/tcg/mips/README
>>> @@ -0,0 +1,7 @@
>>> +MIPS
>>> +====
>>> +
>>> +hello-mips
>>> +----------
>>> +
>>> +A very simple inline assembly, write syscall based hello world
>>> diff --git a/tests/tcg/hello-mips.c b/tests/tcg/mips/hello-mips.c
>>> similarity index 100%
>>> rename from tests/tcg/hello-mips.c
>>> rename to tests/tcg/mips/hello-mips.c
>>
>> tested with:
>>
>> -- >8 --
>> diff --git a/configure b/configure
>> index c98eb01c39..aebe928b3c 100755
>> --- a/configure
>> +++ b/configure
>> @@ -455,6 +455,7 @@ docker="no"
>>  # cross compilers defaults, can be overridden with --cross-cc-ARCH
>>  cross_cc_aarch64="aarch64-linux-gnu-gcc"
>>  cross_cc_arm="arm-linux-gnueabihf-gcc"
>> +cross_cc_mips="mipsel-linux-gnu-gcc"
>>  cross_cc_powerpc="powerpc-linux-gnu-gcc"
>>  cross_cc_i386="i386-pc-linux-gnu-gcc"
>>  cross_cc_i386_cflags=""
>> @@ -6860,6 +6861,7 @@ case "$target_name" in
>>    mips|mipsel)
>>      TARGET_ARCH=mips
>>      echo "TARGET_ABI_MIPSO32=y" >> $config_target_mak
>> +    target_compiler=$cross_cc_mips
>>    ;;
>>    mipsn32|mipsn32el)
>>      TARGET_ARCH=mips64
>> diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
>> new file mode 100644
>> index 0000000000..427aafc9e5
>> --- /dev/null
>> +++ b/tests/tcg/mips/Makefile.target
>> @@ -0,0 +1,6 @@
>> +# -*- Mode: makefile -*-
>> +#
>> +# MIPS specific tweaks
>> +
>> +hello-mips: CFLAGS+=-ffreestanding
>> +hello-mips: LDFLAGS+=-nostdlib
> 
> I've jiggled things around a bit for v2 to include:
> 
>   # The order we include is important. We include multiarch, base arch and finally arch
>   -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
>   -include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.target
>   -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
>  
> So hopefully I don't have to split up the current MIPS dir and the
> tcg/MIPS/Makefile.target will deal with all the variations.

Excellent, thanks :)
