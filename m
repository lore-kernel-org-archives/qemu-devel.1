Received: from eggs.gnu.org ([2001:4830:134:3::10]:54401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbSJQ-000064-Hq
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbSJP-0003kl-Ij
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:06:20 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbSJP-0003kV-D6
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:06:19 -0400
Received: by mail-oi0-x242.google.com with SMTP id y207-v6so24025808oie.13
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 08:06:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180705222115.17013-2-jusual@mail.ru>
References: <20180705222115.17013-1-jusual@mail.ru>
	<20180705222115.17013-2-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 16:05:58 +0100
Message-ID: <CAFEAcA_7N7odPF1DCw2gq=OufUxzSkyBqMTqgNbM=vpYsXeTdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/2] nvic: Handle ARMv6-M SCS reserved
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 5 July 2018 at 23:21, Julia Suvorova <jusual@mail.ru> wrote:
> Handle SCS reserved registers listed in ARMv6-M ARM D3.6.1.
> All reserved registers are RAZ/WI. ARM_FEATURE_M_MAIN is used for the
> checks, because these registers are reserved in ARMv8-M Baseline too.
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  hw/intc/armv7m_nvic.c | 51 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I've applied this patch (but not the 2nd one in this series)
to target-arm.for-3.1.

thanks
-- PMM
