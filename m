Received: from eggs.gnu.org ([2001:4830:134:3::10]:43296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8Zih-00031K-Bu
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 19:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8Zig-00023p-IX
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 19:09:03 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:45591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8Zig-000222-DV
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 19:09:02 -0400
Received: by mail-oi0-x236.google.com with SMTP id j10-v6so5489148oii.12
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 16:09:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_2=rYDZ7yVEHrENzWYsdDHf8DFba9ymffsVwHXvVP4ew@mail.gmail.com>
References: <20180416135442.30606-1-alex.bennee@linaro.org>
	<20180417190439.GA28717@flamenco>
	<CAFEAcA87BUwn96GY5esyNBtoGQY+myVAX9XoPW02gpaJbqyBzg@mail.gmail.com>
	<20180417212710.GA10948@flamenco>
	<CAFEAcA9PS2FNSq0VFgO652RaemTViGKzOQStiycqFB8DDhy_ig@mail.gmail.com>
	<20180417223837.GA25085@flamenco>
	<cee77754-64f5-e4e2-6462-f70603655e3e@linaro.org>
	<CAFEAcA_2=rYDZ7yVEHrENzWYsdDHf8DFba9ymffsVwHXvVP4ew@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Apr 2018 00:08:41 +0100
Message-ID: <CAFEAcA9pOVf1LwMGgwfPWy8KRG8k-EFzscWGmPrUo-9NT7J=QA@mail.gmail.com>
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

On 18 April 2018 at 00:01, Peter Maydell <peter.maydell@linaro.org> wrote:
> I don't have the original IEEE754 spec to hand though;
> that may have left this unspecified.

Having located a copy of 754-1985 I think that also is
clear enough that float-float conversion is an operation
that must quieten SNaN and raise Invalid.

thanks
-- PMM
