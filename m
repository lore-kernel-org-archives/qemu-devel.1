Received: from eggs.gnu.org ([2001:4830:134:3::10]:46554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQcnX-0004NP-7o
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQcnW-0008Ul-Ho
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:00:07 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:34039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQcnW-0008UO-A7
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:00:06 -0400
Received: by mail-wr0-x235.google.com with SMTP id 77so192692253wrb.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 10:00:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4810736b-7bf7-9494-c1a7-73f246b86cc4@weilnetz.de>
References: <20170629010300.2848-1-f4bug@amsat.org>
	<0e0d7ae6-5c1e-5c54-9d09-ef03e600b87e@redhat.com>
	<98d49899-a2d8-8ecc-70ac-becc5252ae32@redhat.com>
	<dd63346e-e200-c2d1-c109-78dc57fcffc7@redhat.com>
	<db5c43ba-10b1-9fce-30e6-c40368ecc46c@redhat.com>
	<4810736b-7bf7-9494-c1a7-73f246b86cc4@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 17:59:44 +0100
Message-ID: <CAFEAcA_H2+EVKRKLAsfrYXWjgQ4NMMq_HF8=XQ68KuWPU2E4+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 0/8] removal of tci (tcg interpreter)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>

On 29 June 2017 at 17:45, Stefan Weil <sw@weilnetz.de> wrote:
> TCI was never meant to be used for production, so I think
> my approach was acceptable.

I think perhaps this is at the root of some of the difference
in perspective here -- I tend to the view that given that
QEMU is a production codebase, we should not really have
code in it which is neither (a) production-quality nor
(b) intended to be incrementally improved until it reaches
that level of usability; so anything that's in the middle
ground should either be improved, or removed.
I don't know whether I'm in a minority in that general view.

You can make a similar argument regarding the obscure host OS/CPU
either we support the platform well enough that you can
actually use it and we're testing to ensure it remains the
case, or we don't support it, and we should remove the code.
(Ditto, various ancient board models...)

thanks
-- PMM
