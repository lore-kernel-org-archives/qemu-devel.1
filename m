Received: from eggs.gnu.org ([2001:4830:134:3::10]:43865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9Dgq-0000RP-9F
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9Dgn-0004GL-2Z
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:49:48 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9Dgm-0004Fh-RF
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:49:45 -0400
Received: by mail-wr0-x241.google.com with SMTP id q13-v6so16286753wre.3
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 10:49:44 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-32-alex.bennee@linaro.org>
	<8ccf1143-5895-ca8b-eea5-c7d96c992455@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8ccf1143-5895-ca8b-eea5-c7d96c992455@amsat.org>
Date: Thu, 19 Apr 2018 18:49:42 +0100
Message-ID: <87vacn9jd5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 31/43] tests/tcg: enable building for
 MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 04/19/2018 10:58 AM, Alex Benn=C3=A9e wrote:
>> This doesn't add any additional tests but enables building the
>> multiarch tests for MIPS using docker cross compilers. We don't have a
>> cross compiler for mips64 big endian though.
>
> Oh we have one, using CFLAGS+=3D-EB
>
> we don't have cross libraries although.

Yeah I thought the same with the ARM compilers (-mbig-endian) but it's
the libraries that let us down. If, as you say, newlib gets this right I
suspect we should use that to build the compilers not supported out of
the box by Debian.

>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/mips/Makefile.include | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>  create mode 100644 tests/tcg/mips/Makefile.include
>>
>> diff --git a/tests/tcg/mips/Makefile.include b/tests/tcg/mips/Makefile.i=
nclude
>> new file mode 100644
>> index 0000000000..a9beceb623
>> --- /dev/null
>> +++ b/tests/tcg/mips/Makefile.include
>> @@ -0,0 +1,17 @@
>> +#
>> +# Makefile.include for all MIPs targets
>> +#
>> +# As Debian doesn't support mip64 in big endian mode the only way to
>> +# build BE is to pass a working cross compiler to ./configure
>> +#
>> +
>> +ifeq ($(TARGET_NAME),mips64el)
>> +DOCKER_IMAGE=3Ddebian-mips64el-cross
>> +DOCKER_CROSS_COMPILER=3Dmips64el-linux-gnuabi64-gcc
>> +else ifeq ($(TARGET_NAME),mipsel)
>> +DOCKER_IMAGE=3Ddebian-mipsel-cross
>> +DOCKER_CROSS_COMPILER=3Dmipsel-linux-gnu-gcc
>> +else ifeq ($(TARGET_NAME),mips)
>> +DOCKER_IMAGE=3Ddebian-mips-cross
>> +DOCKER_CROSS_COMPILER=3Dmips-linux-gnu-gcc
>> +endif
>>


--
Alex Benn=C3=A9e
