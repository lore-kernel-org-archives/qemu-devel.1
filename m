Received: from eggs.gnu.org ([209.51.188.92]:50879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gltV7-0007mr-Mw
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:41:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gltV6-0006pb-Tq
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:41:49 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:41805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gltV6-0006p9-JS
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:41:48 -0500
Received: by mail-oi1-x232.google.com with SMTP id j21so16975534oii.8
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 02:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20190116191950.94110-1-emaste@freefall.freebsd.org>
	<20190118144724.66914-1-emaste@freebsd.org>
	<8def73c9-23e5-9f87-81d1-dda0c7e6f7d9@redhat.com>
	<242e057a-0c35-93b1-1249-93799cdf1196@redhat.com>
	<CAPyFy2BLuGCYx0-GUdy5w8HD0u3hkvH3DGmCV+9OKYjtkr6rew@mail.gmail.com>
	<CAPyFy2DNJvE4GbXxtzFJe8bPiXQm+bOmp+D_zVSCtaJML18vzw@mail.gmail.com>
	<6272e5b7-477c-6a38-97cd-a16b94c209d5@redhat.com>
In-Reply-To: <6272e5b7-477c-6a38-97cd-a16b94c209d5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 10:41:35 +0000
Message-ID: <CAFEAcA-Jft0gQkJeJdr88gY27kyrWBq4i9Ch=2nbvWnAvSHjpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Ed Maste <emaste@freebsd.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 22 Jan 2019 at 10:11, Thomas Huth <thuth@redhat.com> wrote:
> PS: I also removed the V=1 in my tests since otherwise the log was way
> to verbose for my taste ... but that's likely really just a matter of taste.

I tend to run the 'make' step without V, and the 'make check' step
with V=1 -- the compile part is fine at lower verbosity because
the compiler will always emit a useful error message if something
fails, but our test harness and tests are very bad at providing
information about why something failed and so you need all
the clues you can get when you're looking at the logfile for a
failed build.

thanks
-- PMM
