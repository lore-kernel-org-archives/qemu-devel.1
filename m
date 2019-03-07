Received: from eggs.gnu.org ([209.51.188.92]:57480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1pci-0001yF-4x
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1pch-0002I6-Em
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:47:32 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1pch-0002HE-8N
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:47:31 -0500
Received: by mail-oi1-x243.google.com with SMTP id g16so12410852oib.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 01:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-2-peter.maydell@linaro.org>
	<20190307000452.imsrx5t4egcpoe4h@localhost.localdomain>
In-Reply-To: <20190307000452.imsrx5t4egcpoe4h@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 09:47:18 +0000
Message-ID: <CAFEAcA90-pKTZrVun1ibQMKMNxcMHNz_b1o5grbN0fO0cTXcZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 01/12] docs/cpu-hotplug.rst: Fix rST
 markup issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Thu, 7 Mar 2019 at 00:04, Cleber Rosa <crosa@redhat.com> wrote:
> But I'm assuming the extended sphinx roles/directives will be used, so
> the only way to check against future breakage would be to build the
> docs.
>
> Do we have strong position in favor or against putting that into the
> "common" `make check` flow?

Assuming the host has sphinx-build, the docs will be built as
part of "make", so actual errors will be caught. We should
add the sphinx-build flag to make warnings into errors in
the same way we use -Werror, but I wanted to get the series
into master first.

thanks
-- PMM
