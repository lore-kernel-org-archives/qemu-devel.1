Received: from eggs.gnu.org ([2001:4830:134:3::10]:48834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceOfm-0001eF-Dr
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceOfl-0006WY-Ks
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:12:46 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:36174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceOfl-0006Vr-Dj
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:12:45 -0500
Received: by mail-wm0-x22e.google.com with SMTP id c85so70359348wmi.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 08:12:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-PFJp_9=NOCFqiQp=xF6Y-TnmE3bfU3zDa6xH7nK2Zfg@mail.gmail.com>
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
	<1486065742-28639-4-git-send-email-peter.maydell@linaro.org>
	<87mvdnvcxx.fsf@linaro.org>
	<CAFEAcA-PFJp_9=NOCFqiQp=xF6Y-TnmE3bfU3zDa6xH7nK2Zfg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 16:12:23 +0000
Message-ID: <CAFEAcA9zp3uoDkXFJdHu2rRevWMCMrXX6v7uFhVzTSwkb8P0Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/9] armv7m: Rewrite NVIC to not use any
 GIC code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Michael Davidsaver <mdavidsaver@gmail.com>, Liviu Ionescu <ilg@livius.net>

On 15 February 2017 at 13:34, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
> On 15 February 2017 at 12:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> Can we not calculate a vector index rather than abusing the meaning of
>> offset while switching on it?
>
> Yeah, we could. (This is just a case where I thought "I could
> rewrite the code Michael did initially, but it doesn't quite
> reach my threshold for doing that just because it's not the
> way I'd have written it.".)

FWIW, it took me five attempts at rewriting these loops before
I got a version that actually worked. I think I'm going to
take that as justification for my bias towards not rewriting
code that already works :-)

(The change I ended up with just uses a local 'startvec' instead
of modifying 'offset'.)

thanks
-- PMM
