Received: from eggs.gnu.org ([2001:4830:134:3::10]:43757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNENE-0000yi-Gu
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNEND-0004BK-Ic
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:55:44 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNENC-00049P-JO
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:55:43 -0500
Received: by mail-ot1-x344.google.com with SMTP id a11so13861580otr.10
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 01:55:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87lg5ud5xt.fsf@linaro.org>
References: <20181108134139.31666-1-peter.maydell@linaro.org>
	<CAKmqyKMaW0Ye5E_PMZXpnUpYZRGdwCBEOf9Qr_bzJpPR=-_p2A@mail.gmail.com>
	<CAFEAcA-tct9gOM-mShPXhaZvMK1o14K4dcK-QbNxR5r36_DM2g@mail.gmail.com>
	<086b3ab4-6845-3884-bdd8-7c776d2e5d00@gmail.com>
	<87lg5ud5xt.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 09:55:21 +0000
Message-ID: <CAFEAcA_xY_SmL4_JgUfHWdUsEenNfkdrD9ZXK+AXaWNDJkAnZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: list myself as maintainer for
 various Arm boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Rob Herring <robh@kernel.org>, Thomas Huth <thuth@redhat.com>, Patch Tracking <patches@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Antony Pavlov <antonynpavlov@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On 15 November 2018 at 09:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Alistair Francis <alistair23@gmail.com> writes:
>
>> On 14/11/2018 3:12 am, Peter Maydell wrote:
>>> On 13 November 2018 at 20:10, Alistair Francis <alistair23@gmail.com> w=
rote:
>>>> These two and the Xilinx boards seem a little out of place in this
>>>> patch. I agree they probably aren't maintained as well as they should
>>>> be, but the patch talks about orphaned boards and these four all have
>>>> active QEMU maintainers listed.
>>>
>>> Yeah, I was planning to improve the commit message,
>>> something along the lines of an extra para:
>>>
>>> "The Xilinx boards are maintained, but patches to
>>> them go via the target-arm tree, so add myself as a
>>> maintainer there too."
>>>
>>> Really this is because we're overloading "maintainer"
>>> to mean both "this person cares about and is the
>>> primary reviewer and yes/no decision for them" and
>>> also "this person is responsible for getting the
>>> patches into the tree". Perhaps we should instead
>>> define a new letter tag for the latter ?
>>
>> What about adding a "P:" tag for pull request sender?
>
> Don't all pull requests generally come from the relevant T: (tree)?

What relevant tree? There isn't a T: tag for the target-arm
tree (it would not be of much use to quote a git url for
it in MAINTAINERS because I don't expect people to base
work on top of it or indeed generally push it publicly
until I'm doing a pull request from it). Also, a git URL
is not an email that can be cc'd on a patch submission
or ping...

> could either extend that or just state the first M: in the list is the
> person who owns the relevant tree.

I think the first M: should be the actual maintainer of
the code, personally.

thanks
-- PMM
