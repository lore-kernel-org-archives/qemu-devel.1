Received: from eggs.gnu.org ([2001:4830:134:3::10]:60391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgXfE-0006jC-GG
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgXfD-0003ar-Ib
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:49:52 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fgXfD-0003ag-Cg
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:49:51 -0400
Received: by mail-oi0-x244.google.com with SMTP id 13-v6so22185749ois.1
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 08:49:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0b589622-ffaf-8ed7-c34b-77ada1d203fb@amsat.org>
References: <20180720153932.8507-1-peter.maydell@linaro.org>
	<0b589622-ffaf-8ed7-c34b-77ada1d203fb@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jul 2018 16:49:29 +0100
Message-ID: <CAFEAcA-Mc7S775QK5dt7+eqaZD0TSZhsNLrZauSNshfbQGx9fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.0 ?] tests/libqtest: Improve
 kill_qemu() assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 20 July 2018 at 16:48, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> On 07/20/2018 12:39 PM, Peter Maydell wrote:
>> In kill_qemu() we have an assert that checks that the QEMU process
>> didn't dump core:
>>             assert(!WCOREDUMP(wstatus));
>>
>> Unfortunately the WCOREDUMP macro here means the resulting message
>> is not very easy to comprehend on at least some systems:
>>
>> ahci-test: tests/libqtest.c:113: kill_qemu: Assertion `!(((__extension__=
 (((union { __typeof(wstatus) __in; int __i; }) { .__in =3D (wstatus) }).__=
i))) & 0x80)' failed.
>>
>> and it doesn't identify what signal the process took.
>>
>> Instead of using a raw assert, print the information in an
>> easier to understand way:
>>
>> /i386/ahci/sanity: libqtest.c: kill_qemu() tried to terminate QEMU proce=
ss but it dumped core with signal 11
>
> Less cryptic, indeed.
>
>> ahci-test: tests/libqtest.c:118: kill_qemu: Assertion `0' failed.
>
> This file:line is not very relevant, ...

> ... what about directly using abort() here?

I did actually start with that, but decided I'd rather have
the file-and-line in there to direct people more quickly
to the immediate point where we asserted.

thanks
-- PMM
