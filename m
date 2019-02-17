Received: from eggs.gnu.org ([209.51.188.92]:52095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQkB-0008Eu-TO
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQk7-0005SS-Bo
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:00:45 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gvQk7-0005R0-0e
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:00:43 -0500
Received: by mail-pg1-x543.google.com with SMTP id w7so7251512pgp.13
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 10:00:42 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5d5b58e8-9fe5-803a-2147-8e0d0d2c5e9a@linaro.org>
Date: Sun, 17 Feb 2019 10:00:38 -0800
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/14] hw/char/pl011: Support all interrupt
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 2/14/19 4:50 AM, Peter Maydell wrote:
> The PL011 UART has six interrupt lines:
>  * RX (receive data)
>  * TX (transmit data)
>  * RT (receive timeout)
>  * MS (modem status)
>  * E (errors)
>  * combined (logical OR of all the above)
> 
> So far we have only emulated the combined interrupt line;
> add support for the others, so that boards that wire them
> up to different interrupt controller inputs can do so.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/char/pl011.h |  2 +-
>  hw/char/pl011.c         | 46 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 45 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
