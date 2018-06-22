Received: from eggs.gnu.org ([2001:4830:134:3::10]:39133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fWR3Q-0003rD-Jg
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fWR3P-00061b-J9
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:45:04 -0400
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:40661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fWR3P-00061V-De
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:45:03 -0400
Received: by mail-yb0-x244.google.com with SMTP id v17-v6so2897725ybe.7
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 11:45:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <878t76vlal.fsf@linaro.org>
References: <20180622140223.26056-1-f4bug@amsat.org>
	<CAMo8Bf+_bSYrz_grbvHgpFsNmA7pJDOzjLUhLq2YfmV8FdoXkQ@mail.gmail.com>
	<878t76vlal.fsf@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 22 Jun 2018 11:45:02 -0700
Message-ID: <CAMo8Bf+OfMyORPN69vROMBMUDF9ucNVMCOHF7EFfXFO7Qpnr1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Fri, Jun 22, 2018 at 9:27 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> Max Filippov <jcmvbkbc@gmail.com> writes:
>> On Fri, Jun 22, 2018 at 7:02 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
>>> As of this commit:
>>>
>>>   $ xtensa-linux-gnu-as -v
>>>   GNU assembler version 2.29.1 (xtensa-linux-gnu) using BFD version ver=
sion 2.29.1-1.fc27
>>>
>>>   $ xtensa-linux-gnu-gcc -v
>>>   Target: xtensa-linux-gnu
>>>   gcc version 7.2.1 20170915 (Red Hat Cross 7.2.1-1) (GCC)
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  tests/docker/dockerfiles/fedora-xtensa-cross.docker | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>  create mode 100644 tests/docker/dockerfiles/fedora-xtensa-cross.docker
>>>
>>> diff --git a/tests/docker/dockerfiles/fedora-xtensa-cross.docker b/test=
s/docker/dockerfiles/fedora-xtensa-cross.docker
>>> new file mode 100644
>>> index 0000000000..6f9521520c
>>> --- /dev/null
>>> +++ b/tests/docker/dockerfiles/fedora-xtensa-cross.docker
>>> @@ -0,0 +1,7 @@
>>> +FROM fedora:latest
>>> +ENV PACKAGES \
>>> +    binutils-xtensa-linux-gnu \
>>> +    gcc-xtensa-linux-gnu
>>
>> Generic binutils and gcc for xtensa only (partially) make sense for
>> build testing.
>
> OK
>
>> Built binaries will not work.
>
> Why?

The default toolchain does not generate code for any real xtensa CPU
configuration or for any configuration supported by the QEMU.
The xtensa configuration overlay for a specific CPU must be applied
to the toolchain source in order to build a toolchain capable of
producing code that would work on that CPU.
There's FSF xtensa CPU configuration in QEMU that is compatible with
very old (older than 2.19 IIRC) binutils. xtensa TCG tests (at least
some of them) are written for the dc232b xtensa CPU. The configuration
overlay for that CPU is available here:

  https://github.com/jcmvbkbc/xtensa-toolchain-build/blob/master/overlays/x=
tensa_dc232b.tar.gz

The following toolchain may be used to build working tests for xtensa:

  https://github.com/foss-xtensa/toolchain/releases/download/2018.02/x86_64=
-2018.02-xtensa-dc232b-elf.tar.gz

--=20
Thanks.
-- Max
