Received: from eggs.gnu.org ([2001:4830:134:3::10]:43598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGRPS-0005t6-Cn
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGRPO-00078V-Eu
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:53:42 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:44961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fGRPO-000777-8e
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:53:38 -0400
Received: by mail-wr0-x241.google.com with SMTP id y15-v6so24368350wrg.11
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 08:53:37 -0700 (PDT)
References: <20180426135755.GI29865@localhost.localdomain>
	<CAFEAcA_4_K-aGJL4ds3G3p_-Dc1=6OGp9fUaZFuE+PW=UBoSSg@mail.gmail.com>
	<CAHNT7NtRy0PcrnT-=xkX1P7m=L7x6NrXN0r27o6fFHZ3q4vfnQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAHNT7NtRy0PcrnT-=xkX1P7m=L7x6NrXN0r27o6fFHZ3q4vfnQ@mail.gmail.com>
Date: Wed, 09 May 2018 16:53:35 +0100
Message-ID: <87po24vn9c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Who is running QEMU automated tests, and when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Yash Mankad <ymankad@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Waterman <andrew@sifive.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Michael Clark <mjc@sifive.com> writes:

> On Fri, Apr 27, 2018 at 2:04 AM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>
>> On 26 April 2018 at 14:57, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> > Peter, do you have additional tests you run before merging a pull
>> > request?  Additional test sets run before tagging a release?
>>
>> I run make && make check, on a variety of hosts, before merging
>> any pull request. That's the only testing I do, and I don't
>> do anything more before I do a tag.
>>
>
> This is what I do on riscv, however it is not yet automated:
>
<snip>
>
> We could bring a snapshot of riscv-tests into the QEMU tree however it
> would be best if they retained the BSD license so we can share locally
> added tests with upstream as upstream is adding tests periodically.

Certainly it would be worth considering some smoke tests for
tests/tcg/riscv that at least verify the basics CPU features work as
expected.

I've got some ideas for packaging more extensive test suites like LTP
and kvm-unit-tests but would like to get simple linux-user stuff up and
running first.

<snip>
>
> We would like to automate all of this and we are working towards that goa=
l.
> One of the dependencies for docker tests are the riscv toolchain packages
> and we are working on this...

I got riscv64 working with the SID toolchain:

  https://github.com/stsquad/qemu/commit/db0a108b9a0efdeeb2f63e670595c5e28e=
236a97

Once I've fixed it up to use snapshots.debian.org it will be in v4 of
the TCG tests.

> Adding port specific tests, like riscv tests to QEMU not only benefits the
> particular port but also exercises a log of generic code such as the TCG,
> the IO system, IO mutex, Virt IO and many other shared code paths.

I agree it would be worthwhile testing.

System tests are a bit more complicated in terms of code required
although we have some for CRIS/MIPS/Xtensa/lm32 which need re-enabling -
although toolchains for the more esoteric architectures is a pain.

--
Alex Benn=C3=A9e
