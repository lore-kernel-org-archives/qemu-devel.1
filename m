Received: from eggs.gnu.org ([208.118.235.92]:56488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gctcL-0000zL-8s
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 10:00:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gctI3-0001A1-Jh
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 09:39:59 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:43140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gctI3-00019m-EB
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 09:39:07 -0500
Received: by mail-oi1-x232.google.com with SMTP id u18so17429217oie.10
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 06:39:07 -0800 (PST)
MIME-Version: 1.0
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
	<945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
	<CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
	<b4cdc06a-8114-48d2-2c0a-9fea876fee4a@linaro.org>
	<CAObpvQmejWBh+RNz2vhk16-kcY_QveM_pSmM5ZeWqWv1d8AJzQ@mail.gmail.com>
	<CAFEAcA-9McUUWsG2o_o6fm1S1k-PpMyo54=dmoN9vMwpxfsu0A@mail.gmail.com>
	<CAObpvQ=WZ4APrRhCpF8BG1gAeFs3OrJ660kCvGEjNXmZJQj-aQ@mail.gmail.com>
In-Reply-To: <CAObpvQ=WZ4APrRhCpF8BG1gAeFs3OrJ660kCvGEjNXmZJQj-aQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Dec 2018 14:38:55 +0000
Message-ID: <CAFEAcA_OV8=ThCRi_PuqgeqGfXquL13HrXXURX6LuPTF0HG2Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] AVX support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nick Renieris <makren67@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 28 Dec 2018 at 14:28, Nick Renieris <makren67@gmail.com> wrote:
> Right, thanks, that file looks better, though I still think splitting
> to multiple files would absolutely be of value, if only for the
> practicality of being able to have several parts of it open at the
> same in a code editor (instead of having to jump back and forth or
> find workarounds to open the same file multiple times).

If your editor can't show multiple views onto one file with
the same simplicity and UI as it has for multiple different
files then I would suggest getting a better editor :-)
Unless you want to restrict all your files to 100 lines or
shorter then you need to be able to see multiple parts of them
at once -- one 10,000 line file is no worse than 4 2500 line
files for this.

> Of course
> there are more important, code structure related reasons beyond that,
> but let's not digress. I'm guessing current devs are so used to this
> that they wouldn't accept splitting-up changes anyway.

There are definitely improvements that could be made to
the x86 code, and where splitting of files makes conceptual
sense it's certainly worthwhile. The trick is finding the
right logical splitting points.

thanks
-- PMM
