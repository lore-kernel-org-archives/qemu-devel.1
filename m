Received: from eggs.gnu.org ([2001:4830:134:3::10]:39754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGl6X-0008Ls-Ht
	for qemu-devel@nongnu.org; Thu, 10 May 2018 08:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGl6W-0002hZ-NC
	for qemu-devel@nongnu.org; Thu, 10 May 2018 08:55:29 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:33573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGl6W-0002hA-GE
	for qemu-devel@nongnu.org; Thu, 10 May 2018 08:55:28 -0400
Received: by mail-ot0-x232.google.com with SMTP id l22-v6so2183641otj.0
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 05:55:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180510094206.15354-1-alex.bennee@linaro.org>
References: <20180510094206.15354-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 13:55:07 +0100
Message-ID: <CAFEAcA88-EFYN3y-sU=YbzeT-eXCBk7md-y2rEQfpJtZ+MF-wQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/5] refactor float-to-float and fix AHP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 10 May 2018 at 10:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Hi,
>
> Hi,
>
> I've not included the test case in the series but you can find it in
> my TCG fixup branch:
>
>   https://github.com/stsquad/qemu/blob/testing/tcg-tests-revival-v4/tests=
/tcg/arm/fcvt.c
>
> Some of the ARMv7 versions are commented out as they where not
> supported until later revs. I do have a build that includes that but
> unfortunately the Debian compiler it too old to build it.
>
> : patch 0001/fpu softfloat int_to_float ensure r fully initial.patch need=
s review
> : patch 0004/target arm convert conversion helpers to fpst ahp.patch need=
s review
> : patch 0005/target arm squash FZ16 behaviour for conversions.patch needs=
 review

This still seems to regress the NaN conversion case I mentioned
in review of the previous series:

(3) Here's a NaN case we get wrong now: 64 to IEEE-16 conversion,
input is 0x7ff0000000000001 (an SNaN), we produce
0x7c00 (infinity) but should produce 0x7e00 (a QNaN).

thanks
-- PMM
