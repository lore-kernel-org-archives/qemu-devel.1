Received: from eggs.gnu.org ([2001:4830:134:3::10]:57540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faHNN-0001WX-3T
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faHNM-0002hJ-0K
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:13:33 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:42079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faHNL-0002h4-QA
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:13:31 -0400
Received: by mail-oi0-x241.google.com with SMTP id n84-v6so2347568oib.9
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 02:13:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703002815.GF3422@umbus.fritz.box>
References: <cover.1530047900.git.balaton@eik.bme.hu>
	<alpine.BSF.2.21.1806302231400.45338@zero.eik.bme.hu>
	<CAFEAcA_ymngY5i5BWQ6-xAveCWjs0QKrORSAy9nH1A8m9672Fg@mail.gmail.com>
	<20180703002815.GF3422@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Jul 2018 10:13:10 +0100
Message-ID: <CAFEAcA9qTxmHPffpjvZ=bgyaAYZivJd--3wEWFxk+UdABkyt3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, QEMU Developers <qemu-devel@nongnu.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>

On 3 July 2018 at 01:28, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Mon, Jul 02, 2018 at 10:42:07AM +0100, Peter Maydell wrote:
>> I can have a look, but really I think these should go via the
>> ppc tree -- the device is used in a ppc machine and an sh4 one,
>> and the ppc tree is much more active than sh4.
>
> Hm, well, if you like.  Although the gradual creep of my
> maintainership scope into things I know less and less about makes me
> rather nervous.  I tried to convince Balaton Zoltan to become sm501
> maintainer, but he didn't bite.

It's not like I know anything more about the sm501 than you do :-)

The arm parts of the tree have a lot of board and device code
I'm not familiar with either. Generally the approach I use is:
 * eyeball the code to see if it's doing anything that looks
   "obviously wrong", failing to use correct QEMU APIs, etc
 * anything that touches 'core' code or code common to multiple
   machines gets closer scrutiny
 * I might check the data sheet if I'm feeling enthusastic or
   if the code looks like it's doing weird things, but often
   not, especially if the code has had review from somebody else
 * if I have a test image to hand I'll do a smoke test, but often
   I don't have a test image

Basically I think the important thing is to make sure the
codebase stays maintainable and generally the quality bar
in terms of using the right APIs and design approaches
tends to ratchet up rather than down. If our implementation
of an obscure device isn't actually right, that doesn't
really affect very many users, so I worry less about that
side of things.

thanks
-- PMM
