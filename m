Received: from eggs.gnu.org ([2001:4830:134:3::10]:50489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gK2GU-0000Or-9t
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gK2GO-0003mD-OY
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:23:33 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:32808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gK2GO-0003kG-I8
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:23:28 -0500
Received: by mail-wm1-x32c.google.com with SMTP id f19-v6so9057860wmb.0
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 06:23:28 -0800 (PST)
References: <CAFEAcA9J__5kPwE7P4SwHYmOp=V0fzoGq5BzBKeStytb6W3=ug@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA9J__5kPwE7P4SwHYmOp=V0fzoGq5BzBKeStytb6W3=ug@mail.gmail.com>
Date: Tue, 06 Nov 2018 14:23:25 +0000
Message-ID: <87o9b2e142.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] aarch32 acquire/release vs mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Looking through code I noticed that in target/arm/translate.c there
> is the following comment in the decode for the load-acquire/store-release
> instructions:
>
>       /* Since the emulation does not have barriers,
>          the acquire/release semantics need no special
>          handling */
>
> This is out of date now we have MTTCG, isn't it?

Yes

> The equivalent code in translate-a64.c has some calls to tcg_gen_mb()
> to emit barriers...presumably we need to fix the a32 code to do
> the same.

Sounds right. Are they the same semantics as their bigger 64 bit
cousins?

>
> (We haven't noticed this because I think in practice nobody
> much is compiling Armv8-specific AArch32 code.)
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
