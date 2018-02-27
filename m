Received: from eggs.gnu.org ([2001:4830:134:3::10]:42604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqjjf-0001zS-Ll
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqjje-0005Up-Nb
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:12:19 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:33647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqjje-0005Ty-IE
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:12:18 -0500
Received: by mail-ot0-x232.google.com with SMTP id y11so4668326otg.0
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 10:12:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180227143852.11175-1-alex.bennee@linaro.org>
References: <20180227143852.11175-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 18:11:57 +0000
Message-ID: <CAFEAcA8LEG=bzXrj3etTdf_q3-AcMVfCCqSGQ2OkXUPGBHkMBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 00/31] Add ARMv8.2
 half-precision functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 27 February 2018 at 14:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> A few minor fixes and a chunk of Richard's r-b tags. Now all that is
> left is:
>
>   patch 0014/arm translate a64 add FP16 FMULX MLS FMLA to simd.patch need=
s review
>
> Otherwise see comments bellow --- for other changes
>

Thanks -- applied to target-arm.next. Some caveats:

(1) we can fix the nit RTH noted about FMULX later

(2) I notice that there's no patch here that adds the linux-user/elfload.c
code to set a hwcap for the guest program to indicate FP16 presence.
Presumably there is such a hwcap?

(3) Is this complete fp16 support or are there still more pieces to come?
I'm assuming it's all done...

(4) I've split the "add new ARM_V8_FP16 feature bit to the enum"
and "enable the feature on the 'any' CPU" parts of patch 2, so
we can do the latter at the end. If there is still missing parts
to fp16 then we can drop the enable-feature half of that
for the moment.

thanks
-- PMM
