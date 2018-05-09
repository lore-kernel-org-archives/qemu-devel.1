Received: from eggs.gnu.org ([2001:4830:134:3::10]:51254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fGRu9-0004KD-LH
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fGRu6-00062a-5m
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:25:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52134 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fGRu5-00061E-Rd
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:25:22 -0400
References: <20180426135755.GI29865@localhost.localdomain>
	<CAFEAcA_4_K-aGJL4ds3G3p_-Dc1=6OGp9fUaZFuE+PW=UBoSSg@mail.gmail.com>
	<CAHNT7NtRy0PcrnT-=xkX1P7m=L7x6NrXN0r27o6fFHZ3q4vfnQ@mail.gmail.com>
	<87po24vn9c.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6fe42e75-9ee2-faa4-2b0b-135b0e526241@redhat.com>
Date: Wed, 9 May 2018 18:25:16 +0200
MIME-Version: 1.0
In-Reply-To: <87po24vn9c.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Yash Mankad <ymankad@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Palmer Dabbelt <palmer@sifive.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, Andrew Waterman <andrew@sifive.com>

On 09.05.2018 17:53, Alex Benn=C3=A9e wrote:
>=20
> Michael Clark <mjc@sifive.com> writes:
>=20
>> On Fri, Apr 27, 2018 at 2:04 AM, Peter Maydell <peter.maydell@linaro.o=
rg>
>> wrote:
>>
>>> On 26 April 2018 at 14:57, Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
>>>> Peter, do you have additional tests you run before merging a pull
>>>> request?  Additional test sets run before tagging a release?
>>>
>>> I run make && make check, on a variety of hosts, before merging
>>> any pull request. That's the only testing I do, and I don't
>>> do anything more before I do a tag.
>>>
>>
>> This is what I do on riscv, however it is not yet automated:
>>
> <snip>
>>
>> We could bring a snapshot of riscv-tests into the QEMU tree however it
>> would be best if they retained the BSD license so we can share locally
>> added tests with upstream as upstream is adding tests periodically.
>=20
> Certainly it would be worth considering some smoke tests for
> tests/tcg/riscv that at least verify the basics CPU features work as
> expected.

 Hi Michael,

has one of the riscv machine an UART that can be programmed with some
few lines of assembler? In that case we could extend
tests/boot-serial-test.c to also check riscv. That's just a very, very
simple test, but it's better than nothing and indeed helped to find a
couple of bugs in the past already.

 Thomas
