Received: from eggs.gnu.org ([2001:4830:134:3::10]:35833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9r3r-00021K-96
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9r3l-00024f-Ni
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:24:25 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9r3h-00020S-8N
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:24:19 -0400
Received: by mail-wr1-x42e.google.com with SMTP id w5-v6so1607113wrt.2
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 05:24:16 -0700 (PDT)
References: <20181008152059.17503-1-alex.bennee@linaro.org>
	<CAAdtpL7gSaza9RVY4f_e4NbXCC+J1YKiR0AS4TRExgiTauw0kQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAAdtpL7gSaza9RVY4f_e4NbXCC+J1YKiR0AS4TRExgiTauw0kQ@mail.gmail.com>
Date: Tue, 09 Oct 2018 13:24:14 +0100
Message-ID: <87o9c3mhox.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] .travis.yml: split MacOSX builds and
 reduce target list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Alex,
>
> On Mon, Oct 8, 2018 at 5:21 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>> We have reached the point where the MacOSX build was regularly timing
>> out. So as before I've reduced the target list to "major"
>> architectures to try and bring the build time down. I've added an
>> additional MacOSX build with the latest XCode with a minimal list of
>> "most likely" targets on MacOS.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .travis.yml | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 95be6ec59f..13a09facd3 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -107,8 +107,14 @@ matrix:
>>      - env: CONFIG=3D"--disable-tcg"
>>             TEST_CMD=3D""
>>        compiler: gcc
>> -    - env: CONFIG=3D""
>> +    # MacOSX builds
>> +    - env: CONFIG=3D"--target-list=3Daarch64-softmmu,arm-softmmu,i386-s=
oftmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-soft=
mmu,x86_64-softmmu"
>>        os: osx
>> +      osx_image: xcode9.4
>> +      compiler: clang
>> +    - env: CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-sof=
tmmu,m68k-softmmu,x86_64-softmmu"
>> +      os: osx
>> +      osx_image: xcode10
>
> I'd also add another entry with --enable-user.

Ohh, does MacOSX use the bsd-user machinery?

>
>>        compiler: clang
>>      # Python builds
>>      - env: CONFIG=3D"--target-list=3Dx86_64-softmmu"
>> --
>> 2.17.1
>>


--
Alex Benn=C3=A9e
