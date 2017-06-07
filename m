Received: from eggs.gnu.org ([2001:4830:134:3::10]:32949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIZl9-0003lB-Nv
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIZl8-00052h-Kx
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:08:23 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIZl8-00052G-F9
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:08:22 -0400
Received: by mail-wm0-x229.google.com with SMTP id 7so116858117wmo.1
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 05:08:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <877f0o3vbn.fsf@frigg.lan>
References: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
	<20170606171320.GA8115@flamenco> <877f0o3vbn.fsf@frigg.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2017 13:07:59 +0100
Message-ID: <CAFEAcA8RBMtfS+5GP=cGeAdV+zgGRg5OPEAu_PY+_hEPcWaJqw@mail.gmail.com>
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
To: "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 7 June 2017 at 12:12, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wrote:
> My understanding was that adding a public instrumentation interface would=
 add
> too much code maintenance overhead for a feature that is not in QEMU's co=
re
> target.

Well, it depends what you define as our core target :-)
I think we get quite a lot of users that want some useful ability
to see what their guest code is doing, and these days (when
dev board hardware is often very cheap and easily available)
I think that's a lot of the value that emulation can bring to
the table. Obviously we would want to try to do it in a way
that is low-runtime-overhead and is easy to get right for
people adding/maintaining cpu target frontend code...

thanks
-- PMM
