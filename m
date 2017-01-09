Received: from eggs.gnu.org ([2001:4830:134:3::10]:53078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQXdj-0000I7-Rn
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQXdi-0005rK-R1
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:57:23 -0500
Received: from mail-ua0-x22b.google.com ([2607:f8b0:400c:c08::22b]:32808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQXdi-0005qo-DR
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:57:22 -0500
Received: by mail-ua0-x22b.google.com with SMTP id i68so354333613uad.0
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 02:57:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170107111631.24444-1-jcd@tribudubois.net>
References: <20170107111631.24444-1-jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 10:57:01 +0000
Message-ID: <CAFEAcA9ufDKzJkgG7TcxhACf2bUO7JqoBh=MOjNYrEn9ohL+9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] [m25p80] Reset internal state in case
 we overrun the internal data buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marcin_Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>

On 7 January 2017 at 11:16, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
> When we overrun the internal data buffer it is suspected that the SPI
> controler (either Qemu emulator og guest driver) is misbehaving.
>
> Therefore we reset the flash internal state and issue a log.
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
>
> Changes since v1:
> * reset internal state and issue a log instead of aborting.
>
>  hw/block/m25p80.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>



Applied to target-arm.next, thanks.

-- PMM
