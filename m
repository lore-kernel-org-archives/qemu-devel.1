Received: from eggs.gnu.org ([209.51.188.92]:33702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYIU-0000qD-As
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYIT-0007Z0-BL
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:32:18 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:35532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYIT-0007Wq-5g
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:32:17 -0400
Received: by mail-oi1-x229.google.com with SMTP id w197so4435089oia.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 06:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190503022958.1394-1-joel@jms.id.au>
In-Reply-To: <20190503022958.1394-1-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 14:32:04 +0100
Message-ID: <CAFEAcA_yYvV-WmeicEo_EYBFp=0987fFORaqcv3tucX=Db=Hbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] arm: aspeed: Set SDRAM size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 3 May 2019 at 03:30, Joel Stanley <joel@jms.id.au> wrote:
>
> We currently use Qemu's default of 128MB. As we know how much ram each
> machine ships with, make it easier on users by setting a default.
>
> It can still be overridden with -m on the command line.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM
