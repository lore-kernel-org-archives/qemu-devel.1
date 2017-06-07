Received: from eggs.gnu.org ([2001:4830:134:3::10]:55594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIdez-0003GR-VK
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIdez-0007dg-46
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:18:17 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIdey-0007dB-Sa
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:18:17 -0400
Received: by mail-wr0-x22f.google.com with SMTP id q97so8348566wrb.2
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 09:18:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87zidjztrt.fsf@frigg.lan>
References: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
	<20170606171320.GA8115@flamenco> <877f0o3vbn.fsf@frigg.lan>
	<CAFEAcA8RBMtfS+5GP=cGeAdV+zgGRg5OPEAu_PY+_hEPcWaJqw@mail.gmail.com>
	<87zidjztrt.fsf@frigg.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2017 17:17:55 +0100
Message-ID: <CAFEAcA-S9Mgc1UbDZJABWvPSuvZWwCmJpFzbLY=Vd9UFnRf0XA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] GSoC 2017 Proposal: TCG performance enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 7 June 2017 at 16:45, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wrote:
> This speed comes at the cost of exposing TCG operations to the instrument=
ation
> library (i.e., the library can inject TCG code; AFAIR, calling out into a
> function in the instrumentation library is slower than PIN).

Mmm, that's awkward. I'm not sure I'd really like to allow arbitrary
user instrumentation to inject TCG code: it's exposing our rather
changeable internals to the user, and it's a more complicated
interface to understand. For user-facing API (as opposed to
instrumentation interfaces within QEMU which we use to implement
something more simplified to present to the user) I would favour
a clean and straightforward API over pure speed.

thanks
-- PMM
