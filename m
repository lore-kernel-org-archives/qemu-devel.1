Received: from eggs.gnu.org ([2001:4830:134:3::10]:45778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgBkl-0001I6-Ue
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgBkl-0004d7-64
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:26:07 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fgBkl-0004cx-00
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:26:07 -0400
Received: by mail-oi0-x244.google.com with SMTP id k12-v6so16041124oiw.8
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 09:26:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180719121637.24576-1-jusual@mail.ru>
References: <20180719121637.24576-1-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jul 2018 17:25:46 +0100
Message-ID: <CAFEAcA8_2hM0J38w0h0jfVMvLMceHnxgKKYeMcY-SO_Ywk0QpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] nvic: Change NVIC to support ARMv6-M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 19 July 2018 at 13:16, Julia Suvorova <jusual@mail.ru> wrote:
> The differences from ARMv7-M NVIC are:
>   * ARMv6-M only supports up to 32 external interrupts
>    (configurable feature already). The ICTR is reserved.
>   * Active Bit Register is reserved.
>   * ARMv6-M supports 4 priority levels against 256 in ARMv7-M.
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
> v2:
>     * Added num_prio_bits field
>     * AIRCR.PRIGROUP is set as RAZ/WI for Baseline

Applied to target-arm.for-3.1, thanks.

-- PMM
