Received: from eggsout.gnu.org ([209.51.188.92]:57838 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gfYB7-0000iv-Rl
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:42:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gfYB7-0005wR-89
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:42:57 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a]:33457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makren67@gmail.com>) id 1gfYB7-0005wG-4S
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:42:57 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id o73so7415495ybc.0
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 14:42:57 -0800 (PST)
MIME-Version: 1.0
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
	<945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
	<CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
	<b4cdc06a-8114-48d2-2c0a-9fea876fee4a@linaro.org>
	<CAObpvQmejWBh+RNz2vhk16-kcY_QveM_pSmM5ZeWqWv1d8AJzQ@mail.gmail.com>
	<aeeb8c50-0293-e37b-9f9f-5d392b7e10f6@linaro.org>
	<CAObpvQkjXLmXjB61w0Ecu8QfbA4+qBxLUVMjnDUD4dchOp+duA@mail.gmail.com>
	<38b906b7-56a6-a0dc-95f3-365452b59099@linaro.org>
	<CAObpvQmJzCQZzW4pL02KD7HntnTbn9JWUE9eLi5J-6md3_b0yA@mail.gmail.com>
	<dede13a1-d512-1b70-b863-0b71a7e52c30@linaro.org>
	<CAObpvQ=uzvxqFxD0AC=F6kcAysqwAdLwvwUWEGqWGa3mWgVQmQ@mail.gmail.com>
	<85031ff4-cc90-32f7-1ec4-e342a5d52f34@linaro.org>
	<CAObpvQki6FxDT_YvCvFZi-=7RFpRT=hGFJvBpK-9TjKL5=jFjA@mail.gmail.com>
	<ce603f31-e6a9-03aa-5967-c94ca19f7335@linaro.org>
In-Reply-To: <ce603f31-e6a9-03aa-5967-c94ca19f7335@linaro.org>
From: Nick Renieris <makren67@gmail.com>
Date: Sat, 5 Jan 2019 00:42:30 +0200
Message-ID: <CAObpvQ=JaAzbfJ8zFwgAi9-D726wzyCykgwCgX04-M3RgaDYUA@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>

Ohh got it, thanks.

=CE=A3=CF=84=CE=B9=CF=82 =CE=A3=CE=AC=CE=B2, 5 =CE=99=CE=B1=CE=BD 2019 =CF=
=83=CF=84=CE=B9=CF=82 12:38 =CF=80.=CE=BC., =CE=BF/=CE=B7 Richard Henderson
<richard.henderson@linaro.org> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
>
> On 1/5/19 8:33 AM, Nick Renieris wrote:
> > I know host ABI's can differ like that, but I don't understand why
> > that should matter. Everything (TCG compiler included) is compiled
> > with the same way, right? For the host arch.
>
> No, not all of the pieces are compiled the same way.  TCG generates machi=
ne
> instructions to perform a call from generated code into compiler generate=
d
> code.  So TCG needs to know about the host compiler ABI.
>
>
> r~
