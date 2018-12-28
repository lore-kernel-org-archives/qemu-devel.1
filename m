Received: from eggs.gnu.org ([208.118.235.92]:51152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gctDF-0005jr-UX
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 09:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gct9P-0001iL-B8
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 09:30:12 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:37014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gcstG-0001Sy-27
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 09:13:30 -0500
Received: by mail-ot1-x331.google.com with SMTP id 40so18729754oth.4
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 06:13:27 -0800 (PST)
MIME-Version: 1.0
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
	<945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
	<CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
	<b4cdc06a-8114-48d2-2c0a-9fea876fee4a@linaro.org>
	<CAObpvQmejWBh+RNz2vhk16-kcY_QveM_pSmM5ZeWqWv1d8AJzQ@mail.gmail.com>
In-Reply-To: <CAObpvQmejWBh+RNz2vhk16-kcY_QveM_pSmM5ZeWqWv1d8AJzQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Dec 2018 14:13:13 +0000
Message-ID: <CAFEAcA-9McUUWsG2o_o6fm1S1k-PpMyo54=dmoN9vMwpxfsu0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] AVX support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nick Renieris <makren67@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 28 Dec 2018 at 13:45, Nick Renieris <makren67@gmail.com> wrote:
> Also, I hope you meant four months for me, not for you - I'm
> completely new to the QEMU codebase. I expect it will take me weeks
> just to understand x86's 'translate.c' (who thought it'd be a good
> idea to put all this stuff in _one_ file?).

x86 suffers from being one of the first and oldest frontends,
and on top of that from not having had a great deal of active
attention. So it has a lot of remnants from older styles of
implementation, as well as the kind of "one big function in
one huge file" that organic growth of a codebase tends to give you.
It doesn't make that much difference whether you have one file
or several, though -- target/arm/translate-a64.c is pretty
well structured and easy (IMHO) to comprehend, but it's
5000 lines longer than target/i386/translate.c. The comprehensibility
improvements come from better breakdown into separate functions
and much clearer commenting of the extent of the decode at any
particular point (plus not having any legacy baggage to deal with).

thanks
-- PMM
