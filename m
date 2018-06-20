Received: from eggs.gnu.org ([2001:4830:134:3::10]:44506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVkHh-0007Su-4J
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 17:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVkHd-0001et-4w
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 17:04:57 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVkHc-0001eZ-Sg
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 17:04:53 -0400
Received: by mail-wm0-x243.google.com with SMTP id r15-v6so1689377wmc.1
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 14:04:52 -0700 (PDT)
References: <20180620132032.12952-1-alex.bennee@linaro.org>
	<20180620132032.12952-4-alex.bennee@linaro.org>
	<35e2278a-2d4e-6b82-d58c-001ad50d8ff9@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <35e2278a-2d4e-6b82-d58c-001ad50d8ff9@amsat.org>
Date: Wed, 20 Jun 2018 22:04:50 +0100
Message-ID: <87o9g5uq31.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/5] .travis.yml: add gcovr summary for
 GCOV build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 06/20/2018 10:20 AM, Alex Benn=C3=A9e wrote:
>> This gives a more useful summary, sorted by descending % coverage,
>> after the tests have run. The final numbers will give an idea if our
>> coverage is getting better or worse.
>>
>> As quite a lot of lines don't get covered at all we filter out all the
>> 0% lines. If the file doesn't appear it is not being exercised.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .travis.yml | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index fabfe9ec34..83e0577464 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -38,6 +38,7 @@ addons:
>>        - libvte-2.90-dev
>>        - sparse
>>        - uuid-dev
>> +      - gcovr
>>
>>  # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
>>  # to prevent IRC notifications from forks. This was created using:
>> @@ -81,6 +82,8 @@ matrix:
>>        compiler: clang
>>      # gprof/gcov are GCC features
>>      - env: CONFIG=3D"--enable-gprof --enable-gcov --disable-pie --targe=
t-list=3Daarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softm=
mu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
>
> I just noticed the linux-user tests are not covered.

I did try and calculate coverage of a risu run through SVE and didn't
get any gcda files so I think there is something else that needs adding
first.

>
> I'd duplicate this entry and use --disable-system --disable-bsd-user.
>
>> +      after_success:
>> +        - gcovr -p  | grep -v "0%" | sed s/[0-9]\*[,-]//g
>>        compiler: gcc
>>      # We manually include builds which we disable "make check" for
>>      - env: CONFIG=3D"--enable-debug --enable-tcg-interpreter"
>>


--
Alex Benn=C3=A9e
