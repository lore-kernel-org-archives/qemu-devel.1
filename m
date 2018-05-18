Received: from eggs.gnu.org ([2001:4830:134:3::10]:43087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJhcg-0004Bn-PX
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJhcd-0002S3-JU
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:48:50 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:50278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJhcd-0002RT-Dh
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:48:47 -0400
Received: by mail-wm0-x244.google.com with SMTP id t11-v6so14975476wmt.0
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 08:48:47 -0700 (PDT)
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-28-alex.bennee@linaro.org>
	<13cbc8f7-ed4b-e302-3a6c-b8791a21047b@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <13cbc8f7-ed4b-e302-3a6c-b8791a21047b@amsat.org>
Date: Fri, 18 May 2018 16:48:44 +0100
Message-ID: <87fu2pdkwz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 27/49] tests/tcg: enable building for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 05/17/2018 02:46 PM, Alex Benn=C3=A9e wrote:
>> This allows us to use the docker cross compiler image to build these
>> tests.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/arm/Makefile.include | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>  create mode 100644 tests/tcg/arm/Makefile.include
>>
>> diff --git a/tests/tcg/arm/Makefile.include b/tests/tcg/arm/Makefile.inc=
lude
>> new file mode 100644
>> index 0000000000..8e7eac008f
>> --- /dev/null
>> +++ b/tests/tcg/arm/Makefile.include
>> @@ -0,0 +1,8 @@
>> +# Makefile.include for all ARM targets
>> +#
>> +# We don't have any bigendian build tools so we only use this for armhf
>> +
>> +ifeq ($(TARGET_NAME),arm)
>> +DOCKER_IMAGE=3Ddebian-armhf-cross
>
> [Note for a later series:]
> Since this image comes with ARMv7 libraries, I find clearer to rename as
> arm32v7, following new Docker scheme. This will ease to add arm32v6 (and
> arm32v5 if possible...)

I'm not sure if that is worthwhile. Any linux-user build will be ARMv7
or v8 AArch32 and the compilers can always be set to older CPU types.
Testing that we have correct UNDEF behaviour for older CPUs is probably
better handled by things like RISU?

>
>> +DOCKER_CROSS_COMPILER=3Darm-linux-gnueabihf-gcc
>> +endif
>>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


--
Alex Benn=C3=A9e
