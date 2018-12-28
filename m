Received: from eggs.gnu.org ([208.118.235.92]:34930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gcvzD-0004kP-BL
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gcvnX-00028W-Lo
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:19:49 -0500
Received: from mail-yw1-xc35.google.com ([2607:f8b0:4864:20::c35]:44367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makren67@gmail.com>) id 1gcvnX-000256-Gu
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:19:47 -0500
Received: by mail-yw1-xc35.google.com with SMTP id b63so7273064ywc.11
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 09:19:46 -0800 (PST)
MIME-Version: 1.0
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
	<945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
	<CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
	<b4cdc06a-8114-48d2-2c0a-9fea876fee4a@linaro.org>
	<CAObpvQmejWBh+RNz2vhk16-kcY_QveM_pSmM5ZeWqWv1d8AJzQ@mail.gmail.com>
	<CAFEAcA-9McUUWsG2o_o6fm1S1k-PpMyo54=dmoN9vMwpxfsu0A@mail.gmail.com>
	<CAObpvQ=WZ4APrRhCpF8BG1gAeFs3OrJ660kCvGEjNXmZJQj-aQ@mail.gmail.com>
	<CAFEAcA_OV8=ThCRi_PuqgeqGfXquL13HrXXURX6LuPTF0HG2Dw@mail.gmail.com>
In-Reply-To: <CAFEAcA_OV8=ThCRi_PuqgeqGfXquL13HrXXURX6LuPTF0HG2Dw@mail.gmail.com>
From: Nick Renieris <makren67@gmail.com>
Date: Fri, 28 Dec 2018 19:19:18 +0200
Message-ID: <CAObpvQkX3Yq_a=zTCKndKF17k+j3nWJ3TdqOFw6KQ2R-WFcCOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] AVX support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

=CE=A3=CF=84=CE=B9=CF=82 =CE=A0=CE=B1=CF=81, 28 =CE=94=CE=B5=CE=BA 2018 =CF=
=83=CF=84=CE=B9=CF=82 4:39 =CE=BC.=CE=BC., =CE=BF/=CE=B7 Peter Maydell
<peter.maydell@linaro.org> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
> If your editor can't show multiple views onto one file with
> the same simplicity and UI as it has for multiple different
> files then I would suggest getting a better editor :-)

Apparently I just didn't know how to use my editor :) In my defense,
I've never had to do this before.

> Unless you want to restrict all your files to 100 lines or
> shorter then you need to be able to see multiple parts of them
> at once -- one 10,000 line file is no worse than 4 2500 line
> files for this.

As you mention below, logical separation is key here, I definitely
didn't mean that there should be arbitrary LoC limits for each file.

> There are definitely improvements that could be made to
> the x86 code, and where splitting of files makes conceptual
> sense it's certainly worthwhile. The trick is finding the
> right logical splitting points.

Agreed, though it's not something I can personally help on, unless I
spend quite a long time getting acquainted with _this_ code first.

I'd like to get some answers to my previous question about estimates
of the total amount of work required before considering diving into
it.
