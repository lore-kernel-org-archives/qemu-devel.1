Received: from eggs.gnu.org ([209.51.188.92]:60207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMdrI-000621-St
	for qemu-devel@nongnu.org; Fri, 03 May 2019 15:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMdrH-0007dI-U8
	for qemu-devel@nongnu.org; Fri, 03 May 2019 15:28:36 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMdrH-0007bI-M7
	for qemu-devel@nongnu.org; Fri, 03 May 2019 15:28:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id m20so577724wmg.1
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 12:28:34 -0700 (PDT)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<9a538ea2-358a-dc61-b2f3-f8155c1a2283@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <9a538ea2-358a-dc61-b2f3-f8155c1a2283@linaro.org>
Date: Fri, 03 May 2019 20:28:32 +0100
Message-ID: <875zqr49sv.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/15] demacro softmmu (plus
 tests/coverage)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/30/19 9:52 AM, Alex Benn=C3=A9e wrote:
>> I've also moved the existing system memory test and made it multiarch
>> and added the bootstrapping for aarch64 system tests. I would like to
>> add support for Big Endian as well but I didn't want to delay the
>> posting of the series. It would also be nice to exercise the
>> ioread/write paths and other handling but I leave this as an exercise
>> for later.
>
> Somewhere in there you're adding
>
>   -chardev file,path=3Dhello.out,id=3Doutput

It's in the default runner config in tests/tcg/Makefile

> but there's no corresponding use of the chardev.
> Which, somehow doesn't seem to matter to your aarch64
> testcase,

Argh.. it's because -semihosting is different from -serial and doesn't
allow the usual redirection rules you get with a chardev..

> but when I try this for alpha I truly get
> no output at all.  I needed
>
>   -serial chardev:output

or -serial chadev,id=3Doutput?
>
> to populate the file.
>
>
> r~


--
Alex Benn=C3=A9e
