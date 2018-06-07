Received: from eggs.gnu.org ([2001:4830:134:3::10]:55531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQweK-0007er-Kh
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQweJ-0005ZO-Kc
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:16:28 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:46576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQweJ-0005Yd-57
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:16:27 -0400
Received: by mail-ot0-x243.google.com with SMTP id q1-v6so11935144oth.13
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 08:16:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b5db1ee8-68b1-a41a-be34-eba99ef5565d@amsat.org>
References: <20180603000827.30872-1-f4bug@amsat.org>
	<20180603000827.30872-2-f4bug@amsat.org>
	<CAFEAcA_EDXyOHpdamg05=p35jazqgZsLKP2O+G1tg6BoR4b28g@mail.gmail.com>
	<b5db1ee8-68b1-a41a-be34-eba99ef5565d@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Jun 2018 16:16:05 +0100
Message-ID: <CAFEAcA87m6GYQrvX-tCQLgFMFXBZ_GN=WLh6LxYvXP+OJAJvFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/8] sdcard: Update the Configuration
 Register (SCR) to Spec Version 1.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 7 June 2018 at 16:14, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> The current codebase is a mix of v1 registers and v2 commands (which
> were added slowly without updating all registers).
> As of now v1 is broken (See the lm3s6965evb machine can not use the
> card) and all users are using v2.
> My goal with these series is to also support v3.
>
> It might be more obvious to first enforce the current implementation is
> v2, then restore v1 support and go for v3. I think this is doable by an
> easy rebase of this series (keep v2 and restore v1).
>
> Do you think this is better?

I don't have a strong opinion (you have a better grasp of the specs
than me); I'd just like justification for why we do what we do
in the commit messages and/or comments as appropriate.

thanks
-- PMM
