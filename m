Received: from eggs.gnu.org ([2001:4830:134:3::10]:56529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gM82a-0000HG-Jg
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gM82X-0001j0-E8
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:57:52 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gM82V-0001d2-I6
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:57:47 -0500
Received: by mail-yb1-f195.google.com with SMTP id z2-v6so3619304ybj.2
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 00:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-6-f4bug@amsat.org>
	<5caadde7-9a5d-24f8-e75f-7e40aad9e876@linaro.org>
In-Reply-To: <5caadde7-9a5d-24f8-e75f-7e40aad9e876@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 09:57:21 +0100
Message-ID: <CAAdtpL6QZZhNnfhot9RBeKPG7UyQkJDy3Ji2Kbj=ziey3E_afw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 05/11] decodetree: Force Python to
 print unsigned values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, peer.adelt@hni.uni-paderborn.de, Richard Henderson <rth@twiddle.net>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Nov 12, 2018 at 9:20 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 11/12/18 12:36 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Python internal representation is signed, so unsigned values
> > bigger than 31-bit are interpreted as signed (and printed with
> > a '-' signed).
> > Mask out to force unsigned values.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> > TODO: display error encountered:
> >
> >    case 0x-1:
> >        ....
> > ---
> >  scripts/decodetree.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> This must have been from a trivial input file containing only fixed field
> insns?  Not saying it's wrong, but just so we know.  Any chance you can b=
uild a
> tests/decode/ test for this?  I know they're all currently related to par=
sing,
> but...

Yes, it is in my TODO to add this test, I have that failure in an early bra=
nch.
There is no rush with this series for now, this is not 3.2 material.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!

Phil.
