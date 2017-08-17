Received: from eggs.gnu.org ([2001:4830:134:3::10]:37569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1diIGF-0003kp-5x
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1diIGE-0005Jq-Cd
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:42:47 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1diIGE-0005JV-6S
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:42:46 -0400
Received: by mail-wr0-x236.google.com with SMTP id 49so31199774wrw.2
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 03:42:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9bb3YTVQvK5qoN8jEqEpAsP-a7hoGjSoYeqwTGzs7jng@mail.gmail.com>
References: <20170717133010.12784-1-f4bug@amsat.org>
	<CAFEAcA_rhoCup57nYYW4HN6Qsz3sp-cxY-OwsK-x=fYtfJ31aQ@mail.gmail.com>
	<b48b8728-7cb3-3d6e-745f-1aee5c2038e6@amsat.org>
	<CAFEAcA9bb3YTVQvK5qoN8jEqEpAsP-a7hoGjSoYeqwTGzs7jng@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Aug 2017 11:42:24 +0100
Message-ID: <CAFEAcA8GYUHvOE7wnmETj6peME225rY-4osM1882c-9duriEKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm: use defined type name instead of
 hard-coded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>

On 31 July 2017 at 13:09, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 27 July 2017 at 14:48, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
>> On 07/27/2017 09:36 AM, Peter Maydell wrote:
>>>
>>> On 17 July 2017 at 14:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> ---
>>>>
>>>> Hi Peter, this patch is waiting the IDE queue to enters since it depen=
ds
>>>> of
>>>> commit de09efcc7b67ada3593354711b12a03dea23a9d0 to fix AHCI includes.
>>>
>>>
>>> There's no commit with that hash in master -- do you have
>>> a commit subject or something that I can use to find out
>>> whether it's landed or not?
>>
>>
>> Oops I guess the IDE queue was rebased between this patch and the merge,=
 or
>> I messed my copy/paste :)
>>
>> The dependent commit is 70e2337030f and has how entered /master, do you =
want
>> me to send an v2 with fixed message? Anyway I delayed this patch for 2.1=
1
>> since this is not a bugfix.
>
> You don't need to resend, I'll just keep it on my list of things
> to deal with after 2.11. (Anything below the '---' isn't really
> in the commit message anyway, it gets stripped out when the
> patch is applied.)

Patch now in target-arm.next ready for post-2.11 pullreq.

thanks
-- PMM
