Received: from eggs.gnu.org ([209.51.188.92]:47226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLpt7-0005vg-T6
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLpt3-00008y-8L
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:07:09 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:43681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLpt3-00008A-1O
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:07:05 -0400
Received: by mail-pg1-x532.google.com with SMTP id t22so5337176pgi.10
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:07:04 -0700 (PDT)
References: <20190501061827.23080-1-joel@jms.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d1c73e60-d828-4192-24c6-ca2f595a25b3@linaro.org>
Date: Wed, 1 May 2019 07:07:00 -0700
MIME-Version: 1.0
In-Reply-To: <20190501061827.23080-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] arm: aspeed: Set SDRAM size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 4/30/19 11:18 PM, Joel Stanley wrote:
>      mc->no_parallel = 1;
> +    if (board->ram)
> +        mc->default_ram_size = board->ram;

In addition to the braces, for which patchew will have sent you nag mail...

> +        .ram       = 256 << 20,

In <qemu/units.h> there are some defines to make this more readable as

  .ram = 256 * MiB,

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
