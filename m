Received: from eggs.gnu.org ([208.118.235.92]:50255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYDDO-0000cl-67
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYDDN-0007dR-Cv
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:18:10 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYDDN-0007ce-6S
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:18:09 -0400
Received: by mail-wm0-x22b.google.com with SMTP id w126so27330630wme.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:18:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 16:17:46 +0100
Message-ID: <CAFEAcA-EkJq0Gx98+xhvK9_ssFXhYiA80SKF8_us=Of4+OsT5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 00/23] Implementing FP16 for
 ARMv8.2 using SoftFloat2a and 3c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 20 July 2017 at 16:04, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> So while any review is gratefully accepted my main interest is if this
> sort of duel approach is worth it?
>
> I think the long term aim would be to move fully over to the newer
> library if we can but I appreciate a not inconsiderable amount of work
> has gone into the existing 2a code. Having said that as long as the
> testing is good we are likely to pick up bugs in both implementations.
> While its nice to have a more modern SoftFloat library it still lags
> somewhat on QEMUs general requirements claiming only direct support
> for IEEE754 1985 whereas most modern CPUs are closer to the 2008
> revision of the specification.

I'm definitely not a fan of having two different implementations
of softfloat in the codebase, except perhaps for some well defined
*short* transition period. Otherwise we'll end up carrying both
of them around forever, given our past history at success in
transitioning things to new APIs.

I don't have a strong view about whether we're better off
moving to softfloat3c and forward porting any bugfixes and
improvements, or backporting 16-bit fp code from 3c to our
current codebase.

thanks
-- PMM
