Received: from eggs.gnu.org ([2001:4830:134:3::10]:41465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqyCR-0001Hr-CR
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqyCQ-0006iT-Kq
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:11:15 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:44392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqyCQ-0006iH-GK
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:11:14 -0400
Received: by mail-oi0-x22d.google.com with SMTP id s198-v6so18154390oih.11
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 03:11:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0e358562-7607-9c27-d452-57e3dc32806e@redhat.com>
References: <20180817161404.9420-1-peter.maydell@linaro.org>
	<0e358562-7607-9c27-d452-57e3dc32806e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Aug 2018 11:10:53 +0100
Message-ID: <CAFEAcA9OmzWrn_cZS5me+xYEMygWg1tYvT3dpbLWER1n-EgwmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests/boot-serial-test: Bump timeout to 6
 minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 18 August 2018 at 10:07, Thomas Huth <thuth@redhat.com> wrote:
> 6 minutes is really a lot already. I guess most users will hit CTRL-C
> before waiting so long if there is a realy problem here ... If the
> current tests just takes a little bit more than 1 minute on the Sparc
> machine, maybe 2 or 3 minutes would sufficient, too?

Or maybe not. I don't like tests that run close to their timeout
limits, because that tends to mean that my automated test runs
are flaky when the machine happens to be heavily loaded when
a test is running. I think the purpose of a timeout is to prevent
the test run hanging indefinitely; as you say, console users can
hit ctrl-c if they get bored anyway.

thanks
-- PMM
