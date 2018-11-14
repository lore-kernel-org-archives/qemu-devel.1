Received: from eggs.gnu.org ([2001:4830:134:3::10]:40640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMtIw-0004yb-9b
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMtIu-00009v-GF
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:25:54 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMtIs-0007xr-Es
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:25:52 -0500
Received: by mail-oi1-x243.google.com with SMTP id r127-v6so13258824oie.3
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 03:25:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAP+75-X9TcSQxtTKvRqp4vAGG--139Qb8tQdmQHwP+Pw3=6UrQ@mail.gmail.com>
References: <20181108134139.31666-1-peter.maydell@linaro.org>
	<CAKmqyKMaW0Ye5E_PMZXpnUpYZRGdwCBEOf9Qr_bzJpPR=-_p2A@mail.gmail.com>
	<CAFEAcA-tct9gOM-mShPXhaZvMK1o14K4dcK-QbNxR5r36_DM2g@mail.gmail.com>
	<CAP+75-X9TcSQxtTKvRqp4vAGG--139Qb8tQdmQHwP+Pw3=6UrQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Nov 2018 11:25:16 +0000
Message-ID: <CAFEAcA9p1mtO6YaP3UgBOEsR_S+rNv6zsQ3+MavGBKKqCXFqbQ@mail.gmail.com>
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Rob Herring <robh@kernel.org>, Thomas Huth <thuth@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Antony Pavlov <antonynpavlov@gmail.com>

On 14 November 2018 at 11:23, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> On Wed, Nov 14, 2018 at 12:13 PM Peter Maydell <peter.maydell@linaro.org>=
 wrote:
>> On 13 November 2018 at 20:10, Alistair Francis <alistair23@gmail.com> wr=
ote:
>> > These two and the Xilinx boards seem a little out of place in this
>> > patch. I agree they probably aren't maintained as well as they should
>> > be, but the patch talks about orphaned boards and these four all have
>> > active QEMU maintainers listed.
>>
>> Yeah, I was planning to improve the commit message,
>> something along the lines of an extra para:
>>
>> "The Xilinx boards are maintained, but patches to
>> them go via the target-arm tree, so add myself as a
>> maintainer there too."
>>
>> Really this is because we're overloading "maintainer"
>> to mean both "this person cares about and is the
>> primary reviewer and yes/no decision for them" and
>> also "this person is responsible for getting the
>> patches into the tree". Perhaps we should instead
>> define a new letter tag for the latter ?
>
> What about changing the 'M:' tag description to the one you just suggeste=
d?

That would leave us without a tag for "this person is
the maintainer, they just don't deal with submitting
pull requests"...

thanks
-- PMM
