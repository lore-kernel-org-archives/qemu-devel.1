Received: from eggs.gnu.org ([2001:4830:134:3::10]:35135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8Wtk-0007uN-HJ
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8Wtj-0005Gq-DH
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:08:16 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:42045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8Wtj-0005C5-5X
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:08:15 -0400
Received: by mail-oi0-x22c.google.com with SMTP id t27-v6so2556283oij.9
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 13:08:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <19b7bccd-2282-5c94-fe7c-68f72ccbaba7@amsat.org>
References: <20180416181844.7851-1-marcandre.lureau@redhat.com>
	<CAFEAcA8sX8e9VHdOjhV9VabuVKW=HKiF-bHz3XhCEkRNEyjnDQ@mail.gmail.com>
	<20180416184406.GC14488@redhat.com>
	<CAFEAcA_uS7f-uf+-OkcskdHG3=eTgr92Mw46nk430q27-wve4g@mail.gmail.com>
	<19b7bccd-2282-5c94-fe7c-68f72ccbaba7@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 21:07:54 +0100
Message-ID: <CAFEAcA9dOpr4-78f+N0S4AyeLJzCzUL9G2kyqSs4pUtyRkqDWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] mux: fix ctrl-a b again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 17 April 2018 at 19:36, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> Hi,
>
>>>> Opinions welcome on whether this is a regression fix worth
>>>> putting into rc4.
>>>
>>> It is a regression, but a long standing one - we've been broken for qui=
te
>>> a while since 2.9.0 or even before.
>>>
>>> If we're doing an rc4 anyway I'd suggest including it, but not the end =
of
>>> the world if it has to go in via -stable given how long we've been brok=
en
>>> for.
>>>
>>
>> Thanks for the clarification; I've applied this to master.
>
> Since this commit, the console on the Malta board stay black...

Thanks for catching that. Since as Dan says the send-break
feature wasn't a regression from 2.11, we're best off reverting
this patch for now, and then we can look at what's happening
for 2.13.

-- PMM
