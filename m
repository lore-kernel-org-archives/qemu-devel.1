Received: from eggs.gnu.org ([2001:4830:134:3::10]:55793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtxCl-0005ao-Q4
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtxCk-0005ez-V8
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:39:23 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:47677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dtxCk-0005eN-MD
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:39:22 -0400
Received: by mail-wm0-x231.google.com with SMTP id 13so3349238wmq.2
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 07:39:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1abcfaca-3af0-efcf-d577-c3c5cb39e8fe@amsat.org>
References: <1505494753-10837-1-git-send-email-sundeep.lkml@gmail.com>
	<1505494753-10837-3-git-send-email-sundeep.lkml@gmail.com>
	<2c6a4136-fb80-2000-940c-1df5e718cbf1@amsat.org>
	<CALHRZurRLysJCRwvm+SbJUn8YBAst_Q38RCzJkmT4z=mfnYuiQ@mail.gmail.com>
	<CALHRZurNLqH_6Xbh9SKtCA0fuk-CFEZeqBMwYXV=+UaZB4k1Bg@mail.gmail.com>
	<CAFEAcA-BQ=ognSsb3Kxx5ThJ5Q_GA_sFFFofpKY1=XnRS4-WTA@mail.gmail.com>
	<6947945c-6b04-dce0-9010-b3350df0f151@amsat.org>
	<CAFEAcA8yHmZBgudTbW7S6eoObYE_O=CP3YjfL7g7GGip=wsjaA@mail.gmail.com>
	<1abcfaca-3af0-efcf-d577-c3c5cb39e8fe@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2017 15:39:00 +0100
Message-ID: <CAFEAcA-FqjxRpALbJqhWtdhEBN7YpvV5rG-yMdbv_RCFSoVLYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu devel v9 PATCH 2/5] msf2: Microsemi
 Smartfusion2 System Register block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: sundeep subbaraya <sundeep.lkml@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>

On 18 September 2017 at 15:22, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> On 09/18/2017 11:00 AM, Peter Maydell wrote:
>> There's lots of stuff that can cause the guest to go badly
>> and confusingly wrong if unimplemented. If we print a
>> useful message with LOG_UNIMP then there's an easy clue
>> for what's gone wrong. The guest shouldn't be able to
>> provoke QEMU to exit.
>
>
> I understand. I'm worried about being PITA for an user to figure out what=
's
> happening here, that's why I'm wondering how this should be handled. Anot=
her
> idea I thought about was raising a PREFETCH or BKPT exception, but this
> would also be an incorrect model behavior.
>
> Anyway I'd be happy enough if instead of using LOG_UNIMP/LOG_GUEST_ERROR =
we
> use an unconditional qemu_log("bus remap unimplemented, unpredictable
> behaviour!") warning. Fair enough?

I don't see any reason to handle this any differently to
anything else.

thanks
-- PMM
