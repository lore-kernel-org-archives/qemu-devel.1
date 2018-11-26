Received: from eggs.gnu.org ([2001:4830:134:3::10]:55355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRM3l-0002t8-KW
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:56:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRM3k-0005u6-Re
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:56:41 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:34314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gRM3k-0005tz-LK
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:56:40 -0500
Received: by mail-wm1-x32d.google.com with SMTP id y185so13199907wmd.1
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 10:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-24-cota@braap.org>
	<87lg5f51sz.fsf@linaro.org>
	<e1160c9a-454d-5c55-1295-fb1ab977b2a5@linaro.org>
In-Reply-To: <e1160c9a-454d-5c55-1295-fb1ab977b2a5@linaro.org>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Mon, 26 Nov 2018 18:56:31 +0000
Message-ID: <CAHDbmO1NTj0NcXoxM-iPFCECATkcpbf9tcg2SLvm4GYtoPx1PQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 23/48] translator: add plugin_insn argument
 to translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>

On Mon, 26 Nov 2018, 18:27 Richard Henderson <richard.henderson@linaro.org
wrote:

> On 11/26/18 6:52 AM, Alex Benn=C3=A9e wrote:
> > I'm not convinced this is the best way to go about it. We end up having
> > to sprinkle the plugin calls into each decoder rather than keeping all
> > the infrastructure in the common main loop. However the common loop wil=
l
> > need to know the total number of bytes decoded so we could change the
> > declaration to:
> >
> >   int (*translate_insn)(DisasContextBase *db, CPUState *cpu);
> >
> > and return the number of bytes decoded.
>
> Returning the number of bytes is more difficult than simply just
>
>     old_pc =3D db->pc_next;
>     opc->translate_insn(db, cpu);
>     bytes =3D db->pc_next - old_pc;
>
> requiring no target changes at all.
>

If that's always true then great, but what happens with direct branches?

>
> r~
>
