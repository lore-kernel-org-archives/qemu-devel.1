Received: from eggs.gnu.org ([2001:4830:134:3::10]:43490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fWU8F-0001YI-0I
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 18:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fWU8E-0005Fk-1S
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 18:02:15 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:42776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fWU8D-0005Fa-S3
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 18:02:13 -0400
Received: by mail-yw0-x241.google.com with SMTP id i143-v6so1438315ywc.9
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 15:02:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87efgzur9n.fsf@linaro.org>
References: <20180621184116.910-1-alex.bennee@linaro.org>
	<CAMo8BfJ+Y9didgKKvrWJiuYOd+qUyxpjy75mBaOzspCt5eHZDA@mail.gmail.com>
	<87efgzur9n.fsf@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 22 Jun 2018 15:02:11 -0700
Message-ID: <CAMo8BfJ0sCaGt2Bj8H9aGWBUpCK3qMCDKD8BTtVQp2Y6+eXnPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] blogposts: add post about the new
 check-tcg infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Jun 22, 2018 at 2:03 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> Max Filippov <jcmvbkbc@gmail.com> writes:
>
>> On Thu, Jun 21, 2018 at 11:41 AM, Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg> wrote:
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>  _posts/2018-06-21-tcg-testing.md | 129 +++++++++++++++++++++++++++++++
>>>  1 file changed, 129 insertions(+)
>>>  create mode 100644 _posts/2018-06-21-tcg-testing.md
>>>
>>> diff --git a/_posts/2018-06-21-tcg-testing.md b/_posts/2018-06-21-tcg-t=
esting.md
>>
>> [...]
>>
>>> +The `tests/tcg` directory still contains a number of source files we
>>> +don't build. Notably the cris, lm32, mips, openrisc and xtensa targets=
 have
>>> +a set of tests that need a system emulator. Now we have the
>>> +infrastructure for compiling I hope we can get support for system
>>> +tests added fairly quickly. There will need to be some work to figure
>>> +out a nice common way to pass results back to the build-system. For
>>> +linux-user this is simple as all programs can simply return their exit
>>> +code however for system emulation this is a little more involved.
>>
>> xtensa tests pass exit codes to the build system through semihosting cal=
ls.
>> If any of them fails make check fails as well.
>
> I've re-written that section as:
>
>   The `tests/tcg` directory still contains a number of source files we
>   don't build.
>
>   The cris and openrisc directories contain user-space tests which just
>   need the support of a toolchain and the relevant Makefile plumbing to
>   be added.
>
>   The lm32, mips and xtensa targets have a set of tests that need a
>   system emulator. Aside from adding the compilers as docker images some
>   additional work is needed to handle the differences between plain
>   linux-user tests which can simply return an exit code to getting the
>   results from a qemu-system emulation. Some architectures have
>   semi-hosting support already for this while others report their test
>   status over a simple serial link which will need to be parsed and
>   handled in the `run-%:` test rule.
>
> How is that?

'run-%' goal is only present in xtensa Makefile, other test suites have
explicit loop in the 'check' goal. Otherwise LGTM.

> Any chance you could look into what it would take to package up the
> xtensa toolchain in a docker container?

Can you point me to an example?

> Are they simply tarballs of binaries?

Yes, we have that option:

  https://github.com/foss-xtensa/toolchain/releases

Or they may be built from source.

--=20
Thanks.
-- Max
