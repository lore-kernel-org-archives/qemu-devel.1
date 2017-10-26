Received: from eggs.gnu.org ([2001:4830:134:3::10]:51554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7j6p-0005YK-OL
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7j6l-0007Vx-UO
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:26:11 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:43868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e7j6l-0007VD-Ni
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:26:07 -0400
Received: by mail-wm0-x22e.google.com with SMTP id m72so19652465wmc.0
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 07:26:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171026100645.GA24581@redhat.com>
References: <20171025123056.3165-1-richard.henderson@linaro.org>
	<CAFEAcA99zpvcgk2EuXkrcOY+8rHeRkJhH4GqViJkEgQV3bdWFg@mail.gmail.com>
	<CAFEAcA9XdoV0YVw+q7op_vafe9X0JTiQdYmGcmPgqRR3qhUYrQ@mail.gmail.com>
	<20171026070608.GC5847@redhat.com>
	<CAFEAcA8f7jJsM3=4bZG8fE_kTm6jueC-rF6ga0mdUvzMDSpLwQ@mail.gmail.com>
	<20171026100645.GA24581@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Oct 2017 15:25:45 +0100
Message-ID: <CAFEAcA8BiPnA2d0bmjrMd6fJ9NwXnqbFtJt4WBofzpFEMaJ2rA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] Disassembler patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 26 October 2017 at 11:06, Daniel P. Berrange <berrange@redhat.com> wrote:
> Do we really expect make/configure todo the right thing when going
> backwards in time ?  I've always assumed that if you go back in time
> when you need to do a 'git clean -f -x d' and re-run configure from
> scratch. Certainly in the past various makefile changes in QEMU would
> break, or silently not correctly recompile stuff when going backwards
> in time.

Yes. Occasionally we accidentally break this, as you note, and then
git bisection across that kind of boundary requires a painful build
from clean. But almost always bisection (across small spans of history)
works without having to do that, as do things like "check out this
branch I was working on a month ago and do a build without bothering
to clean first".

In this case you broke my standard workflow for rolling back from
an attempted merge that didn't actually build, which IME is a pretty
rare thing to have go wrong.

thanks
-- PMM
