Received: from eggs.gnu.org ([2001:4830:134:3::10]:43157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gCkyK-00072O-4L
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gCkyG-0007EE-Nu
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:30:43 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:41361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gCkyG-0007BP-AL
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:30:40 -0400
Received: by mail-wr1-x434.google.com with SMTP id q7-v6so1627933wrr.8
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 05:30:38 -0700 (PDT)
References: <20181017090750.4378-1-pbonzini@redhat.com>
	<001f01d465fd$01af8b80$050ea280$@ru>
	<CANzW0ms5DMhjYqBUS3EHfhVRp9Li+Dk=WH9RRpO=jbfOgctkCg@mail.gmail.com>
	<0817e2fe-5a97-a4ed-9ae2-2e8dee6c9a43@redhat.com>
	<004201d4660d$e86ef1e0$b94cd5a0$@ru>
	<a29da0a1-85d7-c57c-5c42-27594a7849ac@redhat.com>
	<004601d4660e$a54a6b00$efdf4100$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <004601d4660e$a54a6b00$efdf4100$@ru>
Date: Wed, 17 Oct 2018 13:30:35 +0100
Message-ID: <87efcooivo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Revert "icount: remove obsolete warp call"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Artem Pisarenko' <artem.k.pisarenko@gmail.com>, 'Clement Deschamps' <clement.deschamps@greensocs.com>, qemu-devel@nongnu.org


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> On 17/10/2018 13:38, Pavel Dovgalyuk wrote:
>> >> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> >> On 17/10/2018 11:53, Artem Pisarenko wrote:
>> >>> See my last comment in bug report. This kind of modification, even
>> >>> adapted to changed function name, doesn't solve issue.
>> >>> I thought long time that it does, but once I catched qemu with a han=
g.
>> >>> And of course, I wasn't able to reproduce it. So it just better hide=
s issue.
>> >>> Take a look at alternative solution from
>> >>> QBox: https://git.greensocs.com/qemu/qbox/commit/a8ed106032e375e715a=
531d6e93e4d9ec295dbdb
>> >>> I didn't catched fail with it (yet).
>> >
>> > Tried to test it, but rr seems to be broken again.
>> > I'll try to bisect now.
>>
>> Can we add a test that runs with "make check" and covers the basics of
>> record/replay's cpus.c bits?
>
> I thought Alex is trying to create some tests.
> Alex, am I right?

Not actively at the moment but we need to get there. As rr only works
with system emulation we need to update the check-tcg machinery to be
able to build some system binaries. A number of the tests/tcg targets
already have some system binaries waiting to be ported to the new make
system.

The next question is what we need to exercise rr? The migration tests
have added some very simple ping-pong type "boot sectors" so perhaps
putting the source for those into check-tcg we can build them and use it
for rr testing?

--
Alex Benn=C3=A9e
