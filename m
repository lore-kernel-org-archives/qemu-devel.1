Received: from eggs.gnu.org ([208.118.235.92]:38878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gcsRJ-0007Rv-Q8
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 08:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gcsRD-0002Ge-1V
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 08:44:31 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29]:40409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makren67@gmail.com>) id 1gcsRC-0002Ds-Sr
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 08:44:30 -0500
Received: by mail-yb1-xb29.google.com with SMTP id x201so4559952ybg.7
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 05:44:25 -0800 (PST)
MIME-Version: 1.0
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
	<945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
	<CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
	<b4cdc06a-8114-48d2-2c0a-9fea876fee4a@linaro.org>
In-Reply-To: <b4cdc06a-8114-48d2-2c0a-9fea876fee4a@linaro.org>
From: Nick Renieris <makren67@gmail.com>
Date: Fri, 28 Dec 2018 15:43:59 +0200
Message-ID: <CAObpvQmejWBh+RNz2vhk16-kcY_QveM_pSmM5ZeWqWv1d8AJzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] AVX support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

>> Do you think this could work as a GSoC project? I'm potentially
>> interested in working on it this summer.

>Could be.  My first guess is something like 4 months work for this.

Four months full-time? If so I would say it's not viable for a GSoC
project (it's 3 months), I've done the 12-hours-a-day-crunch thing for
a week or so in GSoC 2017 and it was _not_ fun.
Also, I hope you meant four months for me, not for you - I'm
completely new to the QEMU codebase. I expect it will take me weeks
just to understand x86's 'translate.c' (who thought it'd be a good
idea to put all this stuff in _one_ file?).

Another question, are there existing discussions about this
refactoring effort or specifically AVX? I asked a similar question on
IRC a few days ago and got no answers.

=CE=A3=CF=84=CE=B9=CF=82 =CE=A4=CE=B5=CF=84, 26 =CE=94=CE=B5=CE=BA 2018 =CF=
=83=CF=84=CE=B9=CF=82 4:12 =CF=80.=CE=BC., =CE=BF/=CE=B7 Richard Henderson
<richard.henderson@linaro.org> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
>
> On 12/26/18 12:28 PM, Nick Renieris wrote:
> > Hi Richard,
> >
> > I did know about https://github.com/andikleen/qemu-avx but didn't
> > mention it as it seems abandoned and quite old (also it doesn't use
> > `TCGv_vec`).
>
> Yep.  Mine pre-dates tcg-op-gvec.h as well.
>
> > Do you think this could work as a GSoC project? I'm potentially
> > interested in working on it this summer.
>
> Could be.  My first guess is something like 4 months work for this.
>
>
> r~
