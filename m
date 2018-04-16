Received: from eggs.gnu.org ([2001:4830:134:3::10]:56358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f7zvy-0002Tc-9p
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f7zvx-0007Vo-9q
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:56:22 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f7zvx-0007Us-1d
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:56:21 -0400
Received: by mail-wr0-x243.google.com with SMTP id w3so7029421wrg.2
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 01:56:20 -0700 (PDT)
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-20-alex.bennee@linaro.org>
	<b6411179-a33b-e504-1073-c98a8d4a38ae@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <b6411179-a33b-e504-1073-c98a8d4a38ae@amsat.org>
Date: Mon, 16 Apr 2018 09:56:18 +0100
Message-ID: <87bmejbkct.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, famz@redhat.com, Yongbok Kim <yongbok.kim@mips.com>, cota@braap.org, Aurelien Jarno <aurelien@aurel32.net>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 04/10/2018 04:39 PM, Alex Benn=C3=A9e wrote:
>> These only need to be built for MIPS guests.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/README                  | 11 -----------
>>  tests/tcg/mips/README             |  7 +++++++
>>  tests/tcg/{ =3D> mips}/hello-mips.c |  0
>>  3 files changed, 7 insertions(+), 11 deletions(-)
>>  create mode 100644 tests/tcg/mips/README
>>  rename tests/tcg/{ =3D> mips}/hello-mips.c (100%)
>>=20
>> diff --git a/tests/tcg/README b/tests/tcg/README
>> index 625f2326e6..a5643d33e7 100644
>> --- a/tests/tcg/README
>> +++ b/tests/tcg/README
>> @@ -3,17 +3,6 @@ regression testing. Tests are either multi-arch, meanin=
g they can be
>>  built for all guest architectures that support linux-user executable,
>>  or they are architecture specific.
>>=20=20
>> -
>> -
>> -MIPS
>> -=3D=3D=3D=3D
>> -
>> -hello-mips
>> -----------
>> -
>> -hello-mipsel
>> -------------
>> -
>>  CRIS
>>  =3D=3D=3D=3D
>>  The testsuite for CRIS is in tests/tcg/cris.  You can run it
>> diff --git a/tests/tcg/mips/README b/tests/tcg/mips/README
>> new file mode 100644
>> index 0000000000..e5bbc58ec5
>> --- /dev/null
>> +++ b/tests/tcg/mips/README
>> @@ -0,0 +1,7 @@
>> +MIPS
>> +=3D=3D=3D=3D
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
> @@ -455,6 +455,7 @@ docker=3D"no"
>  # cross compilers defaults, can be overridden with --cross-cc-ARCH
>  cross_cc_aarch64=3D"aarch64-linux-gnu-gcc"
>  cross_cc_arm=3D"arm-linux-gnueabihf-gcc"
> +cross_cc_mips=3D"mipsel-linux-gnu-gcc"
>  cross_cc_powerpc=3D"powerpc-linux-gnu-gcc"
>  cross_cc_i386=3D"i386-pc-linux-gnu-gcc"
>  cross_cc_i386_cflags=3D""
> @@ -6860,6 +6861,7 @@ case "$target_name" in
>    mips|mipsel)
>      TARGET_ARCH=3Dmips
>      echo "TARGET_ABI_MIPSO32=3Dy" >> $config_target_mak
> +    target_compiler=3D$cross_cc_mips
>    ;;
>    mipsn32|mipsn32el)
>      TARGET_ARCH=3Dmips64
> diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.tar=
get
> new file mode 100644
> index 0000000000..427aafc9e5
> --- /dev/null
> +++ b/tests/tcg/mips/Makefile.target
> @@ -0,0 +1,6 @@
> +# -*- Mode: makefile -*-
> +#
> +# MIPS specific tweaks
> +
> +hello-mips: CFLAGS+=3D-ffreestanding
> +hello-mips: LDFLAGS+=3D-nostdlib

I've jiggled things around a bit for v2 to include:

  # The order we include is important. We include multiarch, base arch and =
finally arch
  -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
  -include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.target
  -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
=20
So hopefully I don't have to split up the current MIPS dir and the
tcg/MIPS/Makefile.target will deal with all the variations.

--=20
Alex Benn=C3=A9e
