Received: from eggs.gnu.org ([2001:4830:134:3::10]:51390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLnPK-0006Sy-6o
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLnPJ-0000wR-9y
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:19:10 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLnPJ-0000wE-3n
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:19:09 -0400
Received: by mail-wm0-x232.google.com with SMTP id x70so20409632wme.0
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 02:19:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c1efba1b-0af9-50a5-e200-a3f74a88d1c1@redhat.com>
References: <CAFEAcA9+HauZoeSxrdXE+cENswUPsjoSOVFJ-wMfboYH5wC2=Q@mail.gmail.com>
	<c1efba1b-0af9-50a5-e200-a3f74a88d1c1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Jun 2017 10:18:47 +0100
Message-ID: <CAFEAcA9ShizMdZRg_EboKK_7kKhakX8rtF32jCgva77e24rnZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU issues on SPARC hosts due to
 more-than-page-alignment requirement for MAP_SHARED|MAP_FIXED...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On 15 June 2017 at 20:13, Laszlo Ersek <lersek@redhat.com> wrote:
> If that's not the case, i.e. Linux on SPARC enforces SHMLBA for all
> kinds of mmap() -- which I would call a POSIX conformance bug --,

I'm pretty sure it does: the intention is to avoid violating
h/w cache aliasing constraints so the code enforces the
16k alignment restriction for any MAP_SHARED mapping.
(This is only awkward for MAP_FIXED since otherwise it can
just pick the address to suit its purposes anyway.)

(As an aside I wonder whether any still-used hardware has
the cache aliasing constraints in question :-))

thanks
-- PMM
