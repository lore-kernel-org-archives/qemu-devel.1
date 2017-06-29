Received: from eggs.gnu.org ([2001:4830:134:3::10]:55560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQc5F-0007ll-NO
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQc5E-0000wK-Nn
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:14:21 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQc5E-0000vt-GZ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:14:20 -0400
Received: by mail-wm0-x231.google.com with SMTP id b184so20066265wme.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:14:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170629160749.GH32167@redhat.com>
References: <20170629010300.2848-1-f4bug@amsat.org>
	<0e0d7ae6-5c1e-5c54-9d09-ef03e600b87e@redhat.com>
	<98d49899-a2d8-8ecc-70ac-becc5252ae32@redhat.com>
	<dd63346e-e200-c2d1-c109-78dc57fcffc7@redhat.com>
	<20170629160749.GH32167@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 17:13:58 +0100
Message-ID: <CAFEAcA9v+ZaMF1cRSFWSAHXs5Uy0ZiTfu00UN0pOE9m7z2Qwsg@mail.gmail.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>

On 29 June 2017 at 17:07, Daniel P. Berrange <berrange@redhat.com> wrote:
> The flipside is that even if we delete it, if someone does suddenly
> care, the code is still there in git & easy to undelete again. Given
> that we believe there are zero users, it is known broken in many
> ways, and TCG provides a working alternative, I don't see a strong
> reason to not just kill it right away.

"zero users" is quite a strong and hard to prove statement.
I don't really see a reason not to do at least one release
of deprecate-and-warn before we drop it.

(People do occasionally do weird stuff with TCI, eg http://qira.me/
involves a QEMU fork with a very hacked about TCI.)

thanks
-- PMM
