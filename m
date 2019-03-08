Received: from eggs.gnu.org ([209.51.188.92]:46065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2EEP-0005nf-Ko
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2EEM-0003xO-R6
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:04:04 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:34948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2EEM-0003iO-Ko
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:04:02 -0500
Received: by mail-oi1-x22d.google.com with SMTP id u128so15671549oie.2
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 04:04:00 -0800 (PST)
MIME-Version: 1.0
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
	<20190308064743.xe4govhrfdsrzns3@sirius.home.kraxel.org>
	<CAFEAcA_nb_s-DGQTf3GRMcN+9ke8XKyzf_n9QfpeCcKCoA439A@mail.gmail.com>
	<20190308115810.6f2dq4ub5t55lnih@sirius.home.kraxel.org>
In-Reply-To: <20190308115810.6f2dq4ub5t55lnih@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 12:03:47 +0000
Message-ID: <CAFEAcA-mvCSZMQzx4N9UgbbEYaDkGGXB64dpnaVG4UacL=LKuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Fri, 8 Mar 2019 at 11:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Fri, Mar 08, 2019 at 10:31:20AM +0000, Peter Maydell wrote:
> > I think in fact I have just broken in-tree builds with the
> > Sphinx support patchset :-/
>
> Great opportunity!  Stop supporting in-tree build fixes a bug,
> so this can be merged post soft-freeze.

Joking aside, this is quite tempting, because Sphinx simply
does not support building into the same directory as its
source documentation files. So we need to either:
 * create an ad-hoc build directory (eg docs/built)
   where Sphinx builds the docs to if we're doing an
   in-tree build, and have the 'make install' phase pull
   the docs out of there
 * declare in-tree builds to be no longer supported at all

thanks
-- PMM
