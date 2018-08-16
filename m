Received: from eggs.gnu.org ([2001:4830:134:3::10]:37631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqLZD-0001O9-MH
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqLZC-0007SL-OM
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:56:11 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqLZC-0007RX-Cy
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:56:10 -0400
Received: by mail-oi0-x244.google.com with SMTP id b16-v6so9221684oic.9
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:56:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1534341354-11956-1-git-send-email-hans-erik.floryd@rt-labs.com>
References: <1534341354-11956-1-git-send-email-hans-erik.floryd@rt-labs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 17:55:49 +0100
Message-ID: <CAFEAcA9DdtZ6+vrX9e30DX-9-68oFo5+FBeVq-B7QQsiQRM7BA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] imx_serial: Generate interrupt on receive
 data ready if enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "open list:i.MX31" <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 15 August 2018 at 14:55, Hans-Erik Floryd
<hans-erik.floryd@rt-labs.com> wrote:
> Generate an interrupt if USR2_RDR and UCR4_DREN are both set.
>
> Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
> ---
>  hw/char/imx_serial.c         | 3 ++-
>  include/hw/char/imx_serial.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)



Applied to target-arm.next, thanks.

-- PMM
