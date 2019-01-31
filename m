Received: from eggs.gnu.org ([209.51.188.92]:38548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gp9Ac-00085n-Jq
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gp9Ab-0006H1-Rv
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:02:06 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:34487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gp9Ab-0006GV-Kn
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:02:05 -0500
Received: by mail-oi1-x232.google.com with SMTP id r62so2263780oie.1
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 02:02:05 -0800 (PST)
MIME-Version: 1.0
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<871s4uobf0.fsf@dusky.pond.sub.org>
	<CAFEAcA_t2707yp5cz+rbMVE3nhLk288iFgK=vUgzFyCw79uX5g@mail.gmail.com>
	<75629302-84bb-ba19-cb2c-5edc34cffadb@redhat.com>
	<CAFEAcA-jp=k5-jHeY_ziMbgYBo5U7-ZKSRtU8nfPyAFh9jYUQg@mail.gmail.com>
	<877eeldx9p.fsf@dusky.pond.sub.org>
In-Reply-To: <877eeldx9p.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 10:01:53 +0000
Message-ID: <CAFEAcA-AYVgigihO5LF3EgfOo5=uaB5Gx3b8Eh3it2QvZkomYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 31 Jan 2019 at 08:52, Markus Armbruster <armbru@redhat.com> wrote:
> Lesson for the future: when we correct something, but don't dare to
> touch (some) existing uses (being not "reasonably sure it doesn't
> actually break guests that used to work"), we should at least have
> enough sense to make "incorrect" opt-in rather than opt-out!  People
> adding new uses will be blissfully unaware of the need to opt-out, and
> the problem will multiply, just like it did here.

The theory was that pflash_cfi01_register() is the legacy
back-compat API, and new board models use new style
"create the device and set its properties longhand", I think.
(This is part of a wider issue that the preferred QOM APIs
tend to be more longwinded than the old obsolete helper
functions.) It's definitely unfortunate that we didn't
at least comment that that function shouldn't be used in
new boards.

The problem hasn't multiplied very much -- almost all the
users of pflash_cfi01_register() predate the change.

I'm not sure what an API that defaulted to 'correct' would
look like here, though.

thanks
-- PMM
