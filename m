Received: from eggs.gnu.org ([2001:4830:134:3::10]:34342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@jedlik.phy.bme.hu>) id 1faesq-0001Zo-79
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 06:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@jedlik.phy.bme.hu>) id 1faesn-0004lO-1c
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 06:19:36 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83]:55844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@jedlik.phy.bme.hu>)
	id 1faesm-0004kQ-Op
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 06:19:32 -0400
Date: Wed, 4 Jul 2018 12:12:09 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <7b8b2df2-8d19-4bab-5692-8c9745db99a3@amsat.org>
Message-ID: <alpine.LMD.2.03.1807041202010.30946@eik.bme.hu>
References: <cover.1530047900.git.balaton@eik.bme.hu>
	<alpine.BSF.2.21.1806302231400.45338@zero.eik.bme.hu>
	<CAFEAcA_ymngY5i5BWQ6-xAveCWjs0QKrORSAy9nH1A8m9672Fg@mail.gmail.com>
	<20180703002815.GF3422@umbus.fritz.box>
	<CAFEAcA9qTxmHPffpjvZ=bgyaAYZivJd--3wEWFxk+UdABkyt3g@mail.gmail.com>
	<7b8b2df2-8d19-4bab-5692-8c9745db99a3@amsat.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

On Wed, 4 Jul 2018, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi David, I'll reply to you using Peter mail :)

Thanks a lot for this summary and your review spotting an error. I forgot=
=20
about Gerd's OK as he did not send formal Reviewed or Acked but you're=20
right that's also counts to show that the series should be sane.

I did not want to become maintainer of sm501 for at least two reasons:

1. Because it was part of SH and thus it should already have a maintainer=
=20
or if it doesn't any more then I can't take that either as I don't know SH

2. I'm not familiar with the tasks a maintainer has to do and don't have=20
enough time now to do that

But if it's only a question of responsibility I don't ask you to take=20
that, only ask David or Peter to help in merging this. I take=20
responsibility for problems it causes and will try to fix it or I'm OK to=
=20
have it removed if I fail to do that. Hope that's acceptable at least for=
=20
now, then we can discuss about what to do with the sam460ex and related=20
parts for the future.

Thank you,
BALATON Zoltan

> On 07/03/2018 06:13 AM, Peter Maydell wrote:
>> On 3 July 2018 at 01:28, David Gibson <david@gibson.dropbear.id.au> wrot=
e:
>>> On Mon, Jul 02, 2018 at 10:42:07AM +0100, Peter Maydell wrote:
>>>> I can have a look, but really I think these should go via the
>>>> ppc tree -- the device is used in a ppc machine and an sh4 one,
>>>> and the ppc tree is much more active than sh4.
>>>
>>> Hm, well, if you like.  Although the gradual creep of my
>>> maintainership scope into things I know less and less about makes me
>>> rather nervous.  I tried to convince Balaton Zoltan to become sm501
>>> maintainer, but he didn't bite.
>>
>> It's not like I know anything more about the sm501 than you do :-)
>>
>> The arm parts of the tree have a lot of board and device code
>> I'm not familiar with either. Generally the approach I use is:
>>  * eyeball the code to see if it's doing anything that looks
>>    "obviously wrong", failing to use correct QEMU APIs, etc
>
> Gerd Hoffmann did a review for the graphic code,
> then commented "all look sane":
> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg06493.html
>
> I don't have a serious understanding of QEMU graphic internals, but
> looked at those patches and didn't find anything "obviously wrong".
>
>>  * anything that touches 'core' code or code common to multiple
>>    machines gets closer scrutiny
>
> The only SH4 tests I run are using Aurelien Debian:
> https://people.debian.org/~aurel32/qemu/sh4/
>
>>  * I might check the data sheet if I'm feeling enthusastic or
>>    if the code looks like it's doing weird things, but often
>>    not, especially if the code has had review from somebody else
>
> I did a review of the I2C/DDC patch with the specs at hand.
>
>>  * if I have a test image to hand I'll do a smoke test, but often
>>    I don't have a test image
>
> Neither do I.
>
>> Basically I think the important thing is to make sure the
>> codebase stays maintainable and generally the quality bar
>> in terms of using the right APIs and design approaches
>> tends to ratchet up rather than down. If our implementation
>> of an obscure device isn't actually right, that doesn't
>> really affect very many users, so I worry less about that
>> side of things.
>
> Zoltan used few deprecated API but said updating "could be done in
> separate clean up", which I agree :)
> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg06911.html
>
> FWIW and using Peter's criteria I think this series is good to go.
>
> Regards,
>
> Phil.
>
>
