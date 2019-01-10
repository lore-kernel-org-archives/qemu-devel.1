Received: from eggs.gnu.org ([209.51.188.92]:36249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghbMU-0004eI-QT
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghbMS-0006LX-UG
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:31:10 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:34507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghbMP-0006Jq-96
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:31:07 -0500
Received: by mail-ot1-x32b.google.com with SMTP id t5so10096680otk.1
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 06:31:04 -0800 (PST)
MIME-Version: 1.0
References: <20190109220942.23822-1-pbonzini@redhat.com>
	<CAFEAcA9v3v3k_cFZCwvD5WD4FmiuFT=0UAjCBHEwpO+LuQWjAw@mail.gmail.com>
	<CAAdtpL5cuJdVgfgoo1oNfEpTZFkybLRn5MWqLna7osTUT=MCbg@mail.gmail.com>
In-Reply-To: <CAAdtpL5cuJdVgfgoo1oNfEpTZFkybLRn5MWqLna7osTUT=MCbg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jan 2019 14:30:52 +0000
Message-ID: <CAFEAcA9huyGyKeOfwX7ZKPc7620DaA6ZP7cUvNFmbxe4AB72fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v6 00/35] Misc patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, 10 Jan 2019 at 14:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Le jeu. 10 janv. 2019 15:21, Peter Maydell <peter.maydell@linaro.org> a =
=C3=A9crit :
>> ...'make check-tcg' fails:

> This should work fine if you retry this PR after having merged
> Fam's PR which contains the fix.

Cool. I will do that and retry.

>> This seems to happen reliably with this pullreq merged
>> in, but master is OK.
>
>
> I guess Travis is using a cached image.

I'm not using travis, this is a local run of the test.
But perhaps my system has a cached image. It seems a bit
odd that it uses that cached image when testing master
but not when testing Paolo's merge, though.

thanks
-- PMM
