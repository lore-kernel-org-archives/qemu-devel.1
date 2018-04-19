Received: from eggs.gnu.org ([2001:4830:134:3::10]:41617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9F9V-0003x2-0Q
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9F9T-0001fo-V6
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:23:28 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:45236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9F9T-0001fC-Lx
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:23:27 -0400
Received: by mail-ot0-x243.google.com with SMTP id w4-v6so7065898ote.12
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 12:23:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7f946713-dd55-622e-6d0d-ee694104ff8e@linaro.org>
References: <20180416135442.30606-1-alex.bennee@linaro.org>
	<20180417190439.GA28717@flamenco>
	<CAFEAcA87BUwn96GY5esyNBtoGQY+myVAX9XoPW02gpaJbqyBzg@mail.gmail.com>
	<20180417212710.GA10948@flamenco>
	<CAFEAcA9PS2FNSq0VFgO652RaemTViGKzOQStiycqFB8DDhy_ig@mail.gmail.com>
	<20180417223837.GA25085@flamenco>
	<cee77754-64f5-e4e2-6462-f70603655e3e@linaro.org>
	<CAFEAcA_2=rYDZ7yVEHrENzWYsdDHf8DFba9ymffsVwHXvVP4ew@mail.gmail.com>
	<CAFEAcA9pOVf1LwMGgwfPWy8KRG8k-EFzscWGmPrUo-9NT7J=QA@mail.gmail.com>
	<7e6e8316-b1fd-76ee-fe1d-1d78d5e1760a@linaro.org>
	<7f946713-dd55-622e-6d0d-ee694104ff8e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Apr 2018 20:23:06 +0100
Message-ID: <CAFEAcA-LEY6tuCkf4Y847K0c4Qurd4FdYVv8xmgL2=Z4KCNtHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] fpu/softfloat: check for Inf / x or 0 / x
 before /0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 19 April 2018 at 20:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 04/19/2018 09:06 AM, Richard Henderson wrote:
>> For ppc64, I believe there's a compiler bug:
>
> Bah.  Apparently one must now use -fsignalling-nans.
> With that option we do generate the conversion insn.

"This option is experimental", the gcc docs say :-)

thanks
-- PMM
