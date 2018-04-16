Received: from eggs.gnu.org ([2001:4830:134:3::10]:56359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7t1S-0007S0-3G
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7t1O-0007xR-UU
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:33:34 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:44030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7t1O-0007x7-QS
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:33:30 -0400
Received: by mail-qk0-x244.google.com with SMTP id v2so14943482qkh.10
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 18:33:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-20-alex.bennee@linaro.org>
	<b6411179-a33b-e504-1073-c98a8d4a38ae@amsat.org>
Message-ID: <656ceaed-de7b-15ea-e5d8-f2c90722e5f1@amsat.org>
Date: Sun, 15 Apr 2018 22:33:26 -0300
MIME-Version: 1.0
In-Reply-To: <b6411179-a33b-e504-1073-c98a8d4a38ae@amsat.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, Yongbok Kim <yongbok.kim@mips.com>, cota@braap.org, Aurelien Jarno <aurelien@aurel32.net>

On 04/15/2018 10:02 PM, Philippe Mathieu-Daudé wrote:
> On 04/10/2018 04:39 PM, Alex Bennée wrote:
>> These only need to be built for MIPS guests.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/README                  | 11 -----------
>>  tests/tcg/mips/README             |  7 +++++++
>>  tests/tcg/{ => mips}/hello-mips.c |  0
>>  3 files changed, 7 insertions(+), 11 deletions(-)
>>  create mode 100644 tests/tcg/mips/README
>>  rename tests/tcg/{ => mips}/hello-mips.c (100%)
>>
>> diff --git a/tests/tcg/README b/tests/tcg/README
>> index 625f2326e6..a5643d33e7 100644
>> --- a/tests/tcg/README
>> +++ b/tests/tcg/README
>> @@ -3,17 +3,6 @@ regression testing. Tests are either multi-arch, meaning they can be
>>  built for all guest architectures that support linux-user executable,
>>  or they are architecture specific.
>>  
>> -
>> -
>> -MIPS
>> -====
>> -
>> -hello-mips
>> -----------
>> -
>> -hello-mipsel
>> -------------
>> -
>>  CRIS
>>  ====
>>  The testsuite for CRIS is in tests/tcg/cris.  You can run it
>> diff --git a/tests/tcg/mips/README b/tests/tcg/mips/README
>> new file mode 100644
>> index 0000000000..e5bbc58ec5
>> --- /dev/null
>> +++ b/tests/tcg/mips/README
>> @@ -0,0 +1,7 @@
>> +MIPS
>> +====
>> +
>> +hello-mips
>> +----------
>> +
>> +A very simple inline assembly, write syscall based hello world
>> diff --git a/tests/tcg/hello-mips.c b/tests/tcg/mips/hello-mips.c
>> similarity index 100%
>> rename from tests/tcg/hello-mips.c
>> rename to tests/tcg/mips/hello-mips.c
> 
> tested with:
> 
> -- >8 --
> diff --git a/configure b/configure
> index c98eb01c39..aebe928b3c 100755
> --- a/configure
> +++ b/configure
> @@ -455,6 +455,7 @@ docker="no"
>  # cross compilers defaults, can be overridden with --cross-cc-ARCH
>  cross_cc_aarch64="aarch64-linux-gnu-gcc"
>  cross_cc_arm="arm-linux-gnueabihf-gcc"
> +cross_cc_mips="mipsel-linux-gnu-gcc"
>  cross_cc_powerpc="powerpc-linux-gnu-gcc"
>  cross_cc_i386="i386-pc-linux-gnu-gcc"
>  cross_cc_i386_cflags=""
> @@ -6860,6 +6861,7 @@ case "$target_name" in
>    mips|mipsel)
>      TARGET_ARCH=mips
>      echo "TARGET_ABI_MIPSO32=y" >> $config_target_mak
> +    target_compiler=$cross_cc_mips
>    ;;
>    mipsn32|mipsn32el)
>      TARGET_ARCH=mips64
> diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
> new file mode 100644
> index 0000000000..427aafc9e5
> --- /dev/null
> +++ b/tests/tcg/mips/Makefile.target
> @@ -0,0 +1,6 @@
> +# -*- Mode: makefile -*-
> +#
> +# MIPS specific tweaks
> +
> +hello-mips: CFLAGS+=-ffreestanding
> +hello-mips: LDFLAGS+=-nostdlib
> 

oh and tests/tcg/mips/Makefile.include:

-- >8 --
DOCKER_IMAGE=debian-mipsel-cross
DOCKER_CROSS_COMPILER=mipsel-linux-gnu-gcc
--

running "make tcg-tests-mips-linux-user" it works, but "make
tcg-tests-mipsel-linux-user" only build the multiarch tests.

Maybe we need some [mipsel, mips64, mips64el] => "mips" rule somewhere.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
