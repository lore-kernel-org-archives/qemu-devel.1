Received: from eggs.gnu.org ([209.51.188.92]:55230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2Cmt-0006ch-S9
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2Cmr-0002lg-W5
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:31:35 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:46496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2Cmr-0002kK-Pn
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:31:33 -0500
Received: by mail-oi1-x233.google.com with SMTP id j10so15455035oij.13
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 02:31:32 -0800 (PST)
MIME-Version: 1.0
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
	<20190308064743.xe4govhrfdsrzns3@sirius.home.kraxel.org>
In-Reply-To: <20190308064743.xe4govhrfdsrzns3@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 10:31:20 +0000
Message-ID: <CAFEAcA_nb_s-DGQTf3GRMcN+9ke8XKyzf_n9QfpeCcKCoA439A@mail.gmail.com>
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

On Fri, 8 Mar 2019 at 06:47, Gerd Hoffmann <kraxel@redhat.com> wrote:
> I stopped using in-tree builds years ago.  When test-building different
> configurations using an build/$cfgname out-of-tree build directory is
> the only sane approach.

Yes. The other big advantage for me is being able to blow away
the whole build tree and recreate it if necessary.

>  And IIRC I've managed to break in-tree builds
> because of that.

I think in fact I have just broken in-tree builds with the
Sphinx support patchset :-/

thanks
-- PMM
