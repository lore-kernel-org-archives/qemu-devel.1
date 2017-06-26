Received: from eggs.gnu.org ([2001:4830:134:3::10]:59672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPLvb-0005UZ-36
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 00:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPLva-0000iX-4p
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 00:47:11 -0400
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:37918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPLvZ-0000iH-W3
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 00:47:10 -0400
Received: by mail-it0-x22a.google.com with SMTP id b205so33453564itg.1
	for <qemu-devel@nongnu.org>; Sun, 25 Jun 2017 21:47:09 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <f43b2f92-a76e-945f-9334-2cd9cb71ec95@twiddle.net>
References: <20170620205121.26515-1-laurent@vivier.eu>
	<20170620205121.26515-4-laurent@vivier.eu>
	<b05fb631-4ccb-39fa-adc3-6949a514b9d2@amsat.org>
	<f43b2f92-a76e-945f-9334-2cd9cb71ec95@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 26 Jun 2017 01:47:08 -0300
Message-ID: <CAAdtpL7OkD+xU2gttK4LzzHB5umFUiye=LAnF7yCoBqQGDuOVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/6] target-m68k: use floatx80 internally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>

On Wed, Jun 21, 2017 at 1:37 PM, Richard Henderson <rth@twiddle.net> wrote:
> On 06/21/2017 09:18 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> What an awful name... Anyway checking on "qemu/bswap.h" it seems there i=
s
>> some endianess issue with it if your host is little-endian.
>
>
> There is no endian-ness issue because we do not attempt to read that
> structure from memory as a whole.  Instead, Laurent uses two big-endian
> loads (with appropriate address arithmetic) and stores the result into th=
is
> host structure in host-endian order.  Further, the host routines use the
> structure members by name and do not assume any particular relationship
> between them.

Ok, thank your Richard for this clear explanation.
("Endian-ness" ok, Peter also corrected me, I'll give a try to some speller=
...)

>
>> Do you have a way to run Berkeley TestFloat?
>
>
> As noted in Laurent's cover message, floatx80 isn't quite right -- that i=
s
> the x86 data type, and the proper m68k data type is slightly different.
>
> I would expect the results from using floatx80 to be Just Good Enough to
> produce a working m68k user-land.  It will produce correct results for
> normal numbers in arithmetic such as 1.0 + 10.0.  But I would expect many=
 of
> the edge conditions that TestFloat would attempt (especially de-normals a=
nd
> un-normals) would fail.

Ok. I'm asking thinking about cross unit-tests I can add to our
continuous integration system, this might be a candidate.

Regards,

Phil.
