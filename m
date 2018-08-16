Received: from eggs.gnu.org ([2001:4830:134:3::10]:54836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqJjX-0004KG-5f
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqJjT-00082e-CS
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:58:42 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqJjN-0007z1-3L
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:58:33 -0400
Received: by mail-oi0-x243.google.com with SMTP id w126-v6so8525530oie.7
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 07:58:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180811090836.4024-3-contrib@steffen-goertz.de>
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
	<20180811090836.4024-3-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 15:58:12 +0100
Message-ID: <CAFEAcA933sH19gCXqQq7ycNwpmGRHY+HekbXvHRn4CVZ_DBCwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/7] arm: Move nRF51 machine state to
 dedicated header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

On 11 August 2018 at 10:08, Steffen G=C3=B6rtz <contrib@steffen-goertz.de> =
wrote:
> The machine state will be used to host the SOC
> and board level devices like the LED matrix and
> devices to handle to pushbuttons A and B.
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> ---
>  hw/arm/microbit.c         | 38 ++++++++++++++++++++++++--------------
>  include/hw/arm/microbit.h | 29 +++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 14 deletions(-)
>  create mode 100644 include/hw/arm/microbit.h

These changes should be squashed into Joel's initial
patch creating the machine, as per discussion on that patch.

I don't think we really need a separate header file,
unless there's something I'm missing because I haven't yet
read later patches in the series.

thanks
-- PMM
