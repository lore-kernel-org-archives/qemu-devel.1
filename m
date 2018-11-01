Received: from eggs.gnu.org ([2001:4830:134:3::10]:37768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIGhy-0001sL-AO
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIGhx-00025L-Gj
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:24:38 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIGhx-00024f-23
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:24:37 -0400
Received: by mail-oi1-x244.google.com with SMTP id v198-v6so14473798oif.2
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 10:24:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181030193044.25954-1-philmd@redhat.com>
References: <20181030193044.25954-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Nov 2018 17:24:15 +0000
Message-ID: <CAFEAcA-r=d-s0SS4_VDX1A=viaZkS0SxJW-3mVn6Brrx8QHCew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] arm: exynos4: Add dma support for
 smdkc210
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 30 October 2018 at 19:30, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> From: Guenter Roeck <linux@roeck-us.net>
>
> QEMU already supports pl330. Instantiate it for smdkc210.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I don't suppose anybody has the SoC datasheet to crosscheck
the irq/address values (and maybe see if it lists any of
the other pl330 settings) ?

thanks
-- PMM
