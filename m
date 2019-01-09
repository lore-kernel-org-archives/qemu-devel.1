Received: from eggs.gnu.org ([209.51.188.92]:46935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghGpl-0005JH-4u
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghGpj-00034S-8w
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:36:01 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghGph-0002xS-Ha
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:35:59 -0500
Received: by mail-oi1-x243.google.com with SMTP id i6so6793052oia.6
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 08:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20190109152430.32359-1-agraf@suse.de> <871s5lx14y.fsf@linaro.org>
In-Reply-To: <871s5lx14y.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Jan 2019 16:35:30 +0000
Message-ID: <CAFEAcA_6022cBFxHFmSuZVKVFvrX8bwFtoG2jaTwaQ5RoQ02cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target/arm: Allow to switch
 from MON->HYP on AArch32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Tom Rini <trini@konsulko.com>, qemu-arm <qemu-arm@nongnu.org>, Michal Simek <michal.simek@xilinx.com>, Stephen Warren <swarren@wwwdotorg.org>

On Wed, 9 Jan 2019 at 16:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Alexander Graf <agraf@suse.de> writes:
>
> > In U-boot, we switch from S-SVC -> MON -> HYP when we want to enter
> > HYP mode. This dance seems to work ok (hence it's there in the code
> > base), but breaks with current QEMU.
>
> What EL is MON in this case? EL3?

Mon is an AArch32 term and EL is really AArch64, but in
practice Mon is always (Secure) EL3. Note that if EL3
is AArch32 then S-SVC is *also* EL3 !

thanks
-- PMM
