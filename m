Received: from eggs.gnu.org ([2001:4830:134:3::10]:60715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faZKu-0004yN-3O
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 00:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faZKq-0006zh-OJ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 00:24:12 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:39278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faZKq-0006zJ-JW
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 00:24:08 -0400
Received: by mail-qt0-x242.google.com with SMTP id q12-v6so3558507qtp.6
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 21:24:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1530047900.git.balaton@eik.bme.hu>
	<alpine.BSF.2.21.1806302231400.45338@zero.eik.bme.hu>
	<CAFEAcA_ymngY5i5BWQ6-xAveCWjs0QKrORSAy9nH1A8m9672Fg@mail.gmail.com>
	<20180703002815.GF3422@umbus.fritz.box>
	<CAFEAcA9qTxmHPffpjvZ=bgyaAYZivJd--3wEWFxk+UdABkyt3g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7b8b2df2-8d19-4bab-5692-8c9745db99a3@amsat.org>
Date: Wed, 4 Jul 2018 01:24:03 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9qTxmHPffpjvZ=bgyaAYZivJd--3wEWFxk+UdABkyt3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi David, I'll reply to you using Peter mail :)

On 07/03/2018 06:13 AM, Peter Maydell wrote:
> On 3 July 2018 at 01:28, David Gibson <david@gibson.dropbear.id.au> wrote:
>> On Mon, Jul 02, 2018 at 10:42:07AM +0100, Peter Maydell wrote:
>>> I can have a look, but really I think these should go via the
>>> ppc tree -- the device is used in a ppc machine and an sh4 one,
>>> and the ppc tree is much more active than sh4.
>>
>> Hm, well, if you like.  Although the gradual creep of my
>> maintainership scope into things I know less and less about makes me
>> rather nervous.  I tried to convince Balaton Zoltan to become sm501
>> maintainer, but he didn't bite.
> 
> It's not like I know anything more about the sm501 than you do :-)
> 
> The arm parts of the tree have a lot of board and device code
> I'm not familiar with either. Generally the approach I use is:
>  * eyeball the code to see if it's doing anything that looks
>    "obviously wrong", failing to use correct QEMU APIs, etc

Gerd Hoffmann did a review for the graphic code,
then commented "all look sane":
http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg06493.html

I don't have a serious understanding of QEMU graphic internals, but
looked at those patches and didn't find anything "obviously wrong".

>  * anything that touches 'core' code or code common to multiple
>    machines gets closer scrutiny

The only SH4 tests I run are using Aurelien Debian:
https://people.debian.org/~aurel32/qemu/sh4/

>  * I might check the data sheet if I'm feeling enthusastic or
>    if the code looks like it's doing weird things, but often
>    not, especially if the code has had review from somebody else

I did a review of the I2C/DDC patch with the specs at hand.

>  * if I have a test image to hand I'll do a smoke test, but often
>    I don't have a test image

Neither do I.

> Basically I think the important thing is to make sure the
> codebase stays maintainable and generally the quality bar
> in terms of using the right APIs and design approaches
> tends to ratchet up rather than down. If our implementation
> of an obscure device isn't actually right, that doesn't
> really affect very many users, so I worry less about that
> side of things.

Zoltan used few deprecated API but said updating "could be done in
separate clean up", which I agree :)
http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg06911.html

FWIW and using Peter's criteria I think this series is good to go.

Regards,

Phil.
