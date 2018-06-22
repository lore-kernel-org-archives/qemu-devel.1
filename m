Received: from eggs.gnu.org ([2001:4830:134:3::10]:43971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWOuO-0002Oi-6u
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWOuL-0001x4-1F
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:27:36 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWOuK-0001wy-Py
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:27:32 -0400
Received: by mail-wm0-x242.google.com with SMTP id z6-v6so6753409wma.0
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 09:27:32 -0700 (PDT)
References: <20180622140223.26056-1-f4bug@amsat.org>
	<CAMo8Bf+_bSYrz_grbvHgpFsNmA7pJDOzjLUhLq2YfmV8FdoXkQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAMo8Bf+_bSYrz_grbvHgpFsNmA7pJDOzjLUhLq2YfmV8FdoXkQ@mail.gmail.com>
Date: Fri, 22 Jun 2018 17:27:30 +0100
Message-ID: <878t76vlal.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add fedora-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>


Max Filippov <jcmvbkbc@gmail.com> writes:

> On Fri, Jun 22, 2018 at 7:02 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org> wrote:
>> As of this commit:
>>
>>   $ xtensa-linux-gnu-as -v
>>   GNU assembler version 2.29.1 (xtensa-linux-gnu) using BFD version vers=
ion 2.29.1-1.fc27
>>
>>   $ xtensa-linux-gnu-gcc -v
>>   Target: xtensa-linux-gnu
>>   gcc version 7.2.1 20170915 (Red Hat Cross 7.2.1-1) (GCC)
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  tests/docker/dockerfiles/fedora-xtensa-cross.docker | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>  create mode 100644 tests/docker/dockerfiles/fedora-xtensa-cross.docker
>>
>> diff --git a/tests/docker/dockerfiles/fedora-xtensa-cross.docker b/tests=
/docker/dockerfiles/fedora-xtensa-cross.docker
>> new file mode 100644
>> index 0000000000..6f9521520c
>> --- /dev/null
>> +++ b/tests/docker/dockerfiles/fedora-xtensa-cross.docker
>> @@ -0,0 +1,7 @@
>> +FROM fedora:latest
>> +ENV PACKAGES \
>> +    binutils-xtensa-linux-gnu \
>> +    gcc-xtensa-linux-gnu
>
> Generic binutils and gcc for xtensa only (partially) make sense for
> build testing.

OK

> Built binaries will not work.

Why?

--
Alex Benn=C3=A9e
