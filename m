Received: from eggs.gnu.org ([2001:4830:134:3::10]:37750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ce0vG-0000hG-BC
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ce0vC-0004ZW-Ei
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:51:10 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ce0vC-0004ZA-7J
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:51:06 -0500
Received: by mail-wr0-x232.google.com with SMTP id i10so192777759wrb.0
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 06:51:06 -0800 (PST)
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
	<1486065742-28639-4-git-send-email-peter.maydell@linaro.org>
	<87mvdnvcxx.fsf@linaro.org>
	<CAFEAcA-PFJp_9=NOCFqiQp=xF6Y-TnmE3bfU3zDa6xH7nK2Zfg@mail.gmail.com>
	<87inobv8wg.fsf@linaro.org>
	<CAFEAcA-6QnqGby3gOTgfo=H3SBWYYztmA7b0iEri9D-Q-LUAzQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-6QnqGby3gOTgfo=H3SBWYYztmA7b0iEri9D-Q-LUAzQ@mail.gmail.com>
Date: Wed, 15 Feb 2017 14:51:03 +0000
Message-ID: <87bmu3v76w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Michael Davidsaver <mdavidsaver@gmail.com>, Liviu Ionescu <ilg@livius.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 15 February 2017 at 14:14, Alex Bennée <alex.bennee@linaro.org> wrote:
>> I guess it would be easier to remove the asserts if we had run test
>> cases that explicitly exercised all this code. What are you currently
>> running to test this code?
>
> The cover letter has a pointer to the tests I've been using
> (plus the usual "run a random stellaris image").

Doh, teach me for not reading that. I shall snarf them now ;-)

>
> I think the benefit of the asserts is in warding off future
> bugs; so I think they're worth keeping where we know something
> should never happen but the code is complicated enough that
> perhaps a future patch might put things in a state where the
> impossible does happen.
>
> Also, number of assert()s is to some extent a coding style
> issue, and in this patchset I'm really taking Michael's code
> and doing a review/cleanup pass on it, so I've tried not to
> do too much rework of the "well I wouldn't have put quite this
> many asserts in" flavour.

Sure no problem.

>
> thanks
> -- PMM


--
Alex Bennée
