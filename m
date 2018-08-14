Received: from eggs.gnu.org ([2001:4830:134:3::10]:33076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpW9h-00021k-Dn
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpW9g-0006x0-I9
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:02:25 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:47060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fpW9g-0006wa-Bp
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:02:24 -0400
Received: by mail-oi0-x243.google.com with SMTP id y207-v6so32446797oie.13
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 03:02:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWxBtpeTt=4wBjemdTjQy_12DS+1PHZUvP2S48LcxWv7g@mail.gmail.com>
References: <20180808210750.3915-1-jusual@mail.ru>
	<20180808210750.3915-2-jusual@mail.ru>
	<CAJSP0QUZERaC=YVe_eWJjtVdMt24Ngi7H5yU6a9anf59n+Zwfw@mail.gmail.com>
	<5a087618-751c-c562-6d41-630a9ced03f4@mail.ru>
	<CAJSP0QWxBtpeTt=4wBjemdTjQy_12DS+1PHZUvP2S48LcxWv7g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 11:02:02 +0100
Message-ID: <CAFEAcA8wJtLxZcyCSjcN6uxBAHz7LywVEGgFs-5=NjGb7pTTDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hw/char: Implement nRF51 SoC UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Julia Suvorova <jusual@mail.ru>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 13 August 2018 at 10:47, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> It's an assumption that on-board devices cannot be hot unplugged and
> that the machine type stays alive until QEMU terminates.
>
> Making this assumption saves 1 call to qemu_chr_fe_set_handlers().
> The cost is that we cannot safely stop the system-on-chip because its
> devices don't clean up properly.
>
> Since cleanup is so trivial here I think it's worthwhile.

I would be more in favour of adding an unrealize function to
random always-present-never-unpluggable devices if we had
better documentation of exactly what the QOM lifecycle is
and what needs to be done in init/realize/unrealize/etc.
As it is, I don't know myself and therefore can't review
whether devices with unrealize methods get it right. And
obviously the code is completely untestable because it can
never run...

thanks
-- PMM
