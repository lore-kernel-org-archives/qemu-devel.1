Received: from eggs.gnu.org ([208.118.235.92]:57270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gdi4M-0005W2-Qi
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 15:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gdi4M-00066b-1l
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 15:52:22 -0500
Received: from mail-yw1-xc32.google.com ([2607:f8b0:4864:20::c32]:45961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makren67@gmail.com>) id 1gdi4L-00065d-Tc
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 15:52:21 -0500
Received: by mail-yw1-xc32.google.com with SMTP id d190so10040942ywd.12
	for <qemu-devel@nongnu.org>; Sun, 30 Dec 2018 12:52:21 -0800 (PST)
MIME-Version: 1.0
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
	<945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
	<CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
	<b4cdc06a-8114-48d2-2c0a-9fea876fee4a@linaro.org>
	<CAObpvQmejWBh+RNz2vhk16-kcY_QveM_pSmM5ZeWqWv1d8AJzQ@mail.gmail.com>
	<aeeb8c50-0293-e37b-9f9f-5d392b7e10f6@linaro.org>
In-Reply-To: <aeeb8c50-0293-e37b-9f9f-5d392b7e10f6@linaro.org>
From: Nick Renieris <makren67@gmail.com>
Date: Sun, 30 Dec 2018 22:51:55 +0200
Message-ID: <CAObpvQkjXLmXjB61w0Ecu8QfbA4+qBxLUVMjnDUD4dchOp+duA@mail.gmail.com>
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

=CE=A3=CF=84=CE=B9=CF=82 =CE=A3=CE=AC=CE=B2, 29 =CE=94=CE=B5=CE=BA 2018 =CF=
=83=CF=84=CE=B9=CF=82 10:24 =CE=BC.=CE=BC., =CE=BF/=CE=B7 Richard Henderson
<richard.henderson@linaro.org> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
> I did have a beginner in mind when guessing 4 months.  Don't take that as=
 a
> fully speced out answer, but it may well be that full avx2 support cannot=
 be
> done within the 3 months of gsoc.  I would certainly expect avx512 to tak=
e even
> longer.

Right, that's ok.
Bit of context, the reason I'm interested in this feature (other than
GSoC potential and general interest) is Orbital, a Sony PlayStation 4
emulator that implements a QEMU fork. Normally we use virtualization
as anything else would be too slow, but TCG would help with debugging
and such.
The PS4's APU doesn't support AVX2 or AVX-512 so I'd be fine if I
didn't have enough time to implement them.

> The tcg-op-gvec.h infrastructure allows for the different modes that avx+=
mmx
> allows:
>
> (1) 64-bit operations,
> (2) 128-bit operations, modifying only the low 128 bits,
> (3) 128-bit operations, zeroing bits beyond the first 128,
> (4) N*128-bit operations, zeroing bits beyond the first N*128.

I assume you mean 256-bit ops on (2) and (3), and N*256 on (4)? Low
128 bits of a 128-bit number is just the number.

> so we should not need a great proliferation of helper functions, merely a
> re-organization of what we have now.

So, I would need to implement every SSE instruction that isn't
SSE_SPECIAL at the moment, using tcg-op-gvec.h? Or more instructions
than that?

Assuming I do this for SSE and AVX, I would not need to touch anything
else like the TCG back-end, as every gvec/vec op is already
implemented for i386, correct?

PS: I'm 'vel0city' on IRC, if that'd be more convenient.
